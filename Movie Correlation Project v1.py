#!/usr/bin/env python
# coding: utf-8

# In[53]:


# Import Libraries needed for project

import pandas as pd
import numpy as np
import seaborn as sns

import matplotlib.pyplot as plt
import matplotlib.mlab as mlab
import matplotlib
plt.style.use('ggplot')
from matplotlib.pyplot import figure

get_ipython().run_line_magic('matplotlib', 'inline')
matplotlib.rcParams['figure.figsize'] = (12,8) #Adjusts the configuration of the plots we will create


# Read in the data

df = pd.read_csv('/Users/memusi/Downloads/movies.csv')


# In[4]:


# Let's look at the data

df.head()


# In[6]:


# Let's see if there is any missing data

for col in df.columns:
    pct_missing = np.mean(df[col].isnull())
    print('{} - {}%'.format(col, pct_missing))


# In[55]:


# This will drop any rows with null values

df = df.dropna(how='any',axis=0) 


# In[56]:


# This will add the release year column into a separate column with the correct year

df['yearcorrect'] = df['released'].astype(str).str.split(', ').str[-1].astype(str).str[:4]


# In[15]:


# Data types for our columns

df.dtypes


# In[57]:


# Now we'll change the numbers in the following columns to be integers

df['budget'] = df['budget'].astype('int64')

df['gross'] = df['gross'].astype('int64')

df['votes'] = df['votes'].astype('int64')

df['runtime'] = df['runtime'].astype('int64')


# In[21]:


df


# In[58]:


df = df.sort_values(by=['gross'], inplace=False, ascending=False)


# In[23]:


pd.set_option('display.max_rows', None)


# In[25]:


# Drop any duplicates

df['company'].drop_duplicates().sort_values(ascending=False)


# In[26]:


df.head()


# In[27]:


# Prediction: Budget strong positive correlation

# Prediction: Company strong positive correlation


# In[31]:


# Scatter plot with Budget vs Gross

plt.scatter(x=df['budget'], y=df['gross'])

plt.title('Budget vs Gross Earnings')

plt.xlabel('Film Budget')

plt.ylabel('Gross Earnings')

plt.show()


# In[30]:


df.head()


# In[34]:


# Let's plot the Budget vs Gross using seaborn

sns.regplot(x='budget', y='gross', data=df, scatter_kws={"color": "red"}, line_kws={"color": "blue"})


# In[37]:


# Let's plot the Score vs Gross using seaborn

sns.regplot(x='score', y='gross', data=df, scatter_kws={"color": "red"}, line_kws={"color": "blue"})


# In[38]:


# Let's start looking at correlation coefficients to quantify the correlation and compare across variables


# In[43]:


df.corr(method='pearson') # Different types: Pearson(default), Kendall, Spearman


# In[44]:


# There is a strong positive correlation between budget and gross, this confirms my hypothesis

#There is a less strong positive correlation between number of votes and gross, unexpected, but makes sense


# In[46]:



correlation_matrix = df.corr(method='pearson')

sns.heatmap(correlation_matrix, annot=True)

plt.title('Correlation Matrix for Numeric Categories')

plt.xlabel('Movie Features')

plt.ylabel('Movie Features')

plt.show()


# In[47]:


# Let's look at Company

df.head()


# In[50]:


# Let's digitize the Company column

df_digitized = df

for col_name in df_digitized.columns:
    if(df_digitized[col_name].dtype == 'object'): 
        df_digitized[col_name] = df_digitized[col_name].astype('category')
        df_digitized[col_name] = df_digitized[col_name].cat.codes
        
df_digitized


# In[59]:


df


# In[60]:


correlation_matrix = df_digitized.corr(method='pearson')

sns.heatmap(correlation_matrix, annot=True)

plt.title('Correlation Matrix for Numeric Categories')

plt.xlabel('Movie Features')

plt.ylabel('Movie Features')

plt.show()


# In[61]:


df_digitized.corr(method='pearson')


# In[62]:


# Now let's see a list of the correlation coefficients between the categories 

correlation_mat = df_digitized.corr()

corr_pairs = correlation_mat.unstack()

corr_pairs


# In[65]:


# Now let's see the correlation directly between pairs of categories

sorted_pairs = corr_pairs.sort_values()

sorted_pairs


# In[67]:


high_corr = sorted_pairs[0.5 < (sorted_pairs)]

high_corr


# In[68]:


# Votes and Budget have the strongest correlation to gross earnings

#Company name has a weak correlation to gross earnings which debunks my hypothesis


# In[ ]:




