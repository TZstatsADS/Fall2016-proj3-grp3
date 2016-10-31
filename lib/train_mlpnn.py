
# coding: utf-8

# In[1]:

get_ipython().system(' pip install pandas')
get_ipython().system(' pip install time')
get_ipython().system(' pip install sklearn.neural_network')
get_ipython().system(' pip install sklearn.model_selection')
get_ipython().system(' pip install warnings')


# In[27]:

import time
import pandas as pd
from sklearn.neural_network import MLPClassifier
from sklearn.model_selection import cross_val_score
import warnings
warnings.filterwarnings('ignore')


# In[28]:

def train_mlpnn(data_train, label_train):
    start = time.time()
    df_x = pd.read_csv(data_train)
    x = list(map(list, df_x.values))
    df_y = pd.read_csv(label_train, header = None)
    y = df_y.values.tolist()
    y = [i for sub in y for i in sub]
    score = []
    for i in range(4, 10):
        #start = time.time()
        clf = MLPClassifier(solver='adam', alpha=1e-5, hidden_layer_sizes=(6, 6, i ), random_state=1)
        scores = cross_val_score(clf, x, y, cv = 5)
        score.append(scores.mean())
        print(str(i) + ": " + str(scores.mean()))
    
    index = score.index(max(score))
    par = 4 + index
    clf_final = MLPClassifier(solver='adam', alpha=1e-5, hidden_layer_sizes=(6, 6, par), random_state=1)
    model = clf_final.fit(x, y)
    print("Time for training: " + str(time.time() - start) + "sec.\n")
    
    return model

