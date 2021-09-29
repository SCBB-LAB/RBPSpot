import numpy as np
import os ,sys
import xgboost as xgb
import pandas as pd
from sklearn.metrics import confusion_matrix
import pickle

f1=str(sys.argv[1])
f2=str(sys.argv[2])
train= np.loadtxt(f1)
trainfeatures=train[:,1:]
trainlab=train[:,0]
test= np.loadtxt(f1)
testfeatures=test[:,1:]
testlab=test[:,0]

train=[]; test=[]

dt = xgb.DMatrix(trainfeatures,label=trainlab)
dv = xgb.DMatrix(testfeatures,label=testlab)
params = {
    "eta": 0.2,
    "max_depth": 1000,
    "objective": "binary:logistic",
    "silent": 1,
    "base_score": np.mean(trainlab),
    'n_estimators': 1000,
    "eval_metric": "logloss"
}
model = xgb.train(params, dt, 3000, [(dt, "train"),(dv, "valid")], verbose_eval=200)
y_pred = model.predict(dv)
cm = confusion_matrix(testlab, (y_pred>0.5))
print(cm)
predict_accuracy_on_test_set = float((cm[0,0] + cm[1,1]))/float((cm[0,0] + cm[1,1]+cm[1,0] + cm[0,1]))
print(predict_accuracy_on_test_set)
filename = "xgb_model.sav"
pickle.dump(model, open(filename, 'wb'))
