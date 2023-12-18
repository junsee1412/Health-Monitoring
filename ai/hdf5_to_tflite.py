import os
import tensorflow as tf
import argparse

from ml.nn import DeNN

ap = argparse.ArgumentParser()
ap.add_argument("-n", "--name", type=str, required=True,help="Model name")
args = vars(ap.parse_args())

name = args["name"]

model = DeNN.build(500)

model.load_weights(os.path.join('ml/output/models',f'{name}.hdf5'))

converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save the model.
with open(f'ml/output/tflite/{name}.tflite', 'wb') as f:
  f.write(tflite_model)

# os.system(f'xxd -i ml/output/tflite/{name}.tflite > ml/output/tflite/{name}.h')