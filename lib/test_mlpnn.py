
# coding: utf-8

# In[1]:

get_ipython().system(' pip install pandas')
get_ipython().system(' pip install sklearn.neural_network')


# In[ ]:

import time
import pandas as pd
from sklearn.neural_network import MLPClassifier


# In[26]:

def test_mlpnn(model, test_data):
    start = time.time()
    df_x = pd.read_csv(test_data)
    x = list(map(list, df_x.values))
    predict = model.predict(x).tolist()
    print("Time for testing: " + str(time.time() - start) + "sec.\n")
    
    return predict

