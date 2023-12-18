# Set minimum required version of CMake
cmake_minimum_required(VERSION 3.12)

# Include build functions from Pico SDK
include($ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

# Set name of project (as PROJECT_NAME) and C/C   standards
project(bracelet C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Creates a pico-sdk subdirectory in our project for the libraries
pico_sdk_init()

# Tell CMake where to find the executable source file
add_executable(${PROJECT_NAME}
    src/hr_spo2.cpp
    src/main.cpp
)

# Create map/bin/hex/uf2 files
pico_add_extra_outputs(${PROJECT_NAME})

# add_library(hr_spo2 INTERFACE)
# target_sources(hr_spo2 INTERFACE ${CMAKE_CURRENT_LIST_DIR}/src/hr_spo2.cpp)
# target_include_directories(hr_spo2 INTERFACE ${CMAKE_CURRENT_LIST_DIR}/include)

add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/pico_max3010x)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/st7735_80x160)
add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/lib/pico-tflmicro EXCLUDE_FROM_ALL)

# Link to pico_stdlib (gpio, time, etc. functions)
target_link_libraries(${PROJECT_NAME} 
    pico_stdlib
    hardware_pwm
    hardware_i2c
    st7735_80x160
    pico_max3010x
    pico-tflmicro
)

# Enable usb output, disable uart output
pico_enable_stdio_usb(${PROJECT_NAME} 1)
pico_enable_stdio_uart(${PROJECT_NAME} 1)