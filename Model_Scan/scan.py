import os ,sys
import numpy as np, tensorflow as tf, keras
from keras import models
from keras import layers
from keras import regularizers

test= np.loadtxt(sys.argv[1])
testlab=test[:,0]
testfeatures=test[:,1:]

model = keras.models.load_model(sys.argv[2])

model.compile(optimizer='adam' , loss = 'binary_crossentropy', metrics = ['accuracy'])
scores = model.evaluate(testfeatures, testlab, verbose=0)
ynew = model.predict_classes(testfeatures)
prob = model.predict_proba(testfeatures)

for i in range(len(testfeatures)):
	print(float(prob[i]))
