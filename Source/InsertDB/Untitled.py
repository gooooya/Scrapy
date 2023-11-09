#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
import os

dir_path = "../Scrapy/scrapeTest/scrapeTest/spiders/output/"
data = pd.read_csv(os.path.join(dir_path, os.listdir(dir_path)[-1])) # 最新のファイルのみDBに格納。TODO:古いファイル消したほうがいいか？
data


# In[2]:


from sqlalchemy import create_engine

# PostgreSQLへの接続設定
# DATABASE_URL = "DM名://ユーザ名:パスワード@アドレス:ポート/DB名"
DATABASE_URL = "postgresql://postgres:postgres@127.0.0.1:5432/suumo"
engine = create_engine(DATABASE_URL)

# DataFrameをPostgreSQLに保存
data.to_sql('data', engine, if_exists='append', index=False)


# In[ ]:


get_ipython().system('jupyter nbconvert --to python Untitled.ipynb')

