import os ,sys
import numpy as np, tensorflow as tf, keras
train= np.loadtxt(sys.argv[1])
test= np.loadtxt(sys.argv[2])
testlab=test[:,0]
trainlab=train[:,0]
testfeatures=test[:,1:]
trainfeatures=train[:,1:]
from keras import models
from keras import layers
from keras import regularizers

regularizers.l1_l2(l1=0.001, l2=0.001)
model = models.Sequential ()

#model.add(layers.Dense(1000, activation='elu', input_shape=(611, )))
model.add(layers.Dense(1000, activation='elu', input_shape=(int(trainfeatures.shape[1]), )))
model.add(layers.Dense(1000, activation='relu'))
#model.add(layers.Dense(350, activation='elu'))
model.add(layers.Dense(1, activation='sigmoid'))

model.compile(optimizer='adam' , loss = 'binary_crossentropy', metrics = ['accuracy'])
#history = model.fit(trainfeatures, trainlab, epochs=1000, batch_size=50, validation_data=(testfeatures, testlab)) 
history=model.fit(trainfeatures, trainlab, epochs=200, batch_size=100, validation_data=(testfeatures, testlab)) 
scores = model.evaluate(testfeatures, testlab, verbose=0)

model.save(sys.argv[3])



