#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/i2c.h"
#include "hardware/pwm.h"

#include "st7735_80x160/my_lcd.h"
#include "pico_max3010x/max3010x.hpp"

#include "hr_spo2.hpp"

#include <tensorflow/lite/micro/all_ops_resolver.h>
#include "tensorflow/lite/micro/micro_error_reporter.h"
#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/schema/schema_generated.h"
#include "tensorflow/lite/version.h"

#include "DeNN_1.h"

tflite::MicroErrorReporter tflErrorReporter;
tflite::ErrorReporter* error_reporter = &tflErrorReporter;
tflite::AllOpsResolver tflOpsResolver;

const tflite::Model* tflModel = nullptr;
tflite::MicroInterpreter* tflInterpreter = nullptr;
TfLiteTensor* tflInputTensor = nullptr;
TfLiteTensor* tflOutputTensor = nullptr;

const int tensor_arena_size = 8 * 1024;
uint8_t tensor_arena[tensor_arena_size];

#define MAX3010X_ADDRESS	0x57

#define PIN_WIRE_SDA 4
#define PIN_WIRE_SCL 5
#define I2C_PORT i2c0
MAX3010X Sensor(I2C_PORT, PIN_WIRE_SDA, PIN_WIRE_SCL, I2C_SPEED_FAST);

const u8 rotation = 2;
char print_buf[32];

// Max3010x configuration
const uint8_t powerLevel = 0x3C; //0x1F;//0x3C; //Options: 0=Off to 255=50mA
const uint8_t sampleAverage = 0x04; //Options: 1, 2, 4, 8, 16, 32
const uint8_t ledMode = 0x02; //Options: 1 = Red only, 2 = Red + IR, 3 = Red + IR + Green
const int sampleRate = 400; //Options: 50, 100, 200, 400, 800, 1000, 1600, 3200 / per second
const int pulseWidth = 411; //Options: 69, 118, 215, 411
const int adcRange = 4096; //Options: 2048, 4096, 8192, 16384

float sbp = 0, dbp = 0;
int32_t spo2; //SPO2 value
int8_t validSPO2; //indicator to show if the SPO2 calculation is valid
int32_t heartRate; //heart rate value
int8_t validHeartRate; //indicator to show if the heart rate calculation is valid

const uint32_t bufferLength = 500;
const uint32_t hBl = 100;

uint32_t irBuffer[bufferLength]; //infrared LED sensor data
uint32_t redBuffer[bufferLength];  //red LED sensor data 

uint32_t un_ir_mean;
float an_d[bufferLength];
int32_t an_x[bufferLength];

void init_lcd() 
{
    // BackLight PWM (125MHz / 65536 / 4 = 476.84 Hz)
    gpio_set_function(PIN_LCD_BLK, GPIO_FUNC_PWM);
    uint slice_num = pwm_gpio_to_slice_num(PICO_DEFAULT_LED_PIN);
    pwm_config config = pwm_get_default_config();
    pwm_config_set_clkdiv(&config, 4.f);
    pwm_init(slice_num, &config, true);
    int bl_val = 196;
    // Square bl_val to make brightness appear more linear
    pwm_set_gpio_level(PIN_LCD_BLK, bl_val * bl_val);
    LCD_Init();
	LCD_SetRotation(rotation);
	LCD_Clear(BLACK);
	BACK_COLOR=BLACK;
	LCD_ShowString(0,  0*16, (u8 *) "HR: ", WHITE);
	LCD_ShowString(0,  1*16, (u8 *) "SpO2: ", WHITE);
	LCD_ShowString(0,  2*16, (u8 *) "SBP: ", WHITE); //MAX
	LCD_ShowString(0,  3*16, (u8 *) "DBP: ", WHITE); //MIN
}

void lcd_show()
{
	if (validHeartRate) LCD_ShowNum(3*16,  0*16, heartRate, 3, WHITE);
	if (validSPO2) 		LCD_ShowNum(3*16,  1*16, spo2, 3, WHITE);
	LCD_ShowNum1(3*16,  2*16, sbp, 5, WHITE);
	LCD_ShowNum1(3*16,  3*16, dbp, 5, WHITE);
}

void ppg_monitor()
{
    for (uint16_t i = 0; i < bufferLength; i++)
	{
		while (Sensor.available() == false)
			Sensor.check();

		irBuffer[i] = Sensor.getFIFOIR();
		redBuffer[i] = Sensor.getFIFORed();
		Sensor.nextSample();
		if (Sensor.getIR() < 50000)
			break;

		// sprintf(print_buf, "%lu, %lu, 0, 0, 0, 0", irBuffer[i], redBuffer[i]);
		sprintf(print_buf, "%lu, %lu, %d, 0, 0, 0", irBuffer[i], redBuffer[i], an_x[i]);
		printf("%s\n", print_buf);
	}
	maxim_heart_rate_and_oxygen_saturation(irBuffer, bufferLength, redBuffer, &spo2, &validSPO2, &heartRate, &validHeartRate);
}

int main(void) 
{
    stdio_init_all();
	init_lcd();

	tflModel = tflite::GetModel(DeNN_1_tflite);
	if (tflModel->version() != TFLITE_SCHEMA_VERSION) {
		printf("Model provided is schema version %d not equal to supported version %d.\r\n", tflModel->version(), TFLITE_SCHEMA_VERSION);
		LCD_ShowString(0,  3*16, (u8 *) "Model error", WHITE);
	}

	busy_wait_ms(500);
	tflInterpreter = new tflite::MicroInterpreter(tflModel, tflOpsResolver, tensor_arena, tensor_arena_size, &tflErrorReporter);
	tflInterpreter->AllocateTensors();

	busy_wait_ms(500);
	tflInputTensor = tflInterpreter->input(0);
	tflOutputTensor = tflInterpreter->output(0);

    busy_wait_ms(500);
	while (Sensor.begin() != true)
	{
		printf("MAX30102 not connected \r\n");
		busy_wait_ms(500);
	}
    
    Sensor.setup(powerLevel, sampleAverage, ledMode, sampleRate, pulseWidth, adcRange);
   
    while (true) {
        if (Sensor.getIR() > 50000)
        {
			ppg_monitor();

			un_ir_mean =0; 
			for (uint16_t i=0; i<bufferLength; i++ ) {
				un_ir_mean += irBuffer[i];
			}
			un_ir_mean = un_ir_mean/bufferLength;

			for (uint16_t i=0; i<bufferLength; i++ ) {
				an_x[i] = -1 * (irBuffer[i] - un_ir_mean);
				tflInputTensor->data.f[i] = (float) an_x[i]/1000.0;
			}
			TfLiteStatus invoke_status = tflInterpreter->Invoke();
			if (invoke_status != kTfLiteOk) {
				TF_LITE_REPORT_ERROR(error_reporter, "Invoke failed\n");
			}
			sbp = tflOutputTensor->data.f[0];
			dbp = tflOutputTensor->data.f[1];
        }
		lcd_show();
        // busy_wait_ms(500);
    }
    return 0;
}
