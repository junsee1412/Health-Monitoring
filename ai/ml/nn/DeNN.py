from keras.layers import Activation, BatchNormalization, Dense, Dropout, Flatten
from keras.models import Sequential

class DeNN:
    @staticmethod
    def build(length):
        x = 8
        model = Sequential()

        model.add(Dense(x*8, input_dim = length))
        model.add(Activation('relu'))
        model.add(Dense(x*8)) 
        model.add(Activation('relu'))
        model.add(Dropout(0.5))

        model.add(Flatten())
        model.add(Dense(x*4))
        model.add(Activation('relu'))
        model.add(BatchNormalization())
        model.add(Dropout(0.5))
        
        model.add(Dense(2))

        return model