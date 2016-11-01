
# coding: utf-8

# In[58]:

import pandas as pd
import time
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import cross_val_score


# In[30]:

df = pd.read_csv('sift_features2.csv', header = None)


# In[31]:

df.head()


# In[39]:

df2 = df.iloc[:, 1:5001]


# In[40]:

df2.head()


# In[60]:

x = list(map(list, df2.values))


# In[61]:

df3 = df.loc[:, 5001:]
y = df3.values.tolist()
y = [i for sub in y for i in sub]


# In[62]:

start = time.time()
score = []
for i in range(50):
    clf = RandomForestClassifier(n_estimators=10*(i+1), min_samples_split=2, random_state=0)
    scores = cross_val_score(clf, x, y, cv = 5)
    score.append(scores.mean())
    print(str(i) + ": " + str(scores.mean()))
    print("Time elapsed: " + str(time.time() - start) + "sec.\n")


# In[ ]:

clf = RandomForestClassifier(n_estimators=20, min_samples_split=2, random_state=0)
model = clf.fit(cnt_email, y)
type(model)

