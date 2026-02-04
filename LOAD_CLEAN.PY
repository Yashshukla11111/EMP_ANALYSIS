#  complete end to end project

import pandas as pd
import numpy as np 
import matplotlib.pyplot as plt
import mysql.connector
# connection part with sql
conn=mysql.connector.connect(
    host="localhost",
    user ="root",
    password ="2006",
    database="employees_db"
)
query='select * from dirty_data'

data=pd.read_sql(query,conn)

print(data)
#data inspection
print(data.describe())
print(data.info())
print(data.isnull().sum())
print(data.dtypes)


#DATA CLEANING PART
#name cleaning
data['Name'].fillna('unknown',inplace=True)
data['Name']=data["Name"].str.strip().str.title()
# numeric cleaning
data["Age"]=pd.to_numeric(data["Age"],errors="coerce")
data["Age"].fillna(data["Age"].median(),inplace=True)

data["Salary"]=pd.to_numeric(data["Salary"],errors="coerce")
data['Salary'].fillna(data["Salary"].median(),inplace=True)

print(data)

# categorical coloum cleaning
data['Gender'].fillna(data["Gender"].mode()[0],inplace=True)
data['City'].fillna(data["City"].mode()[0],inplace=True)
data["performance"].fillna(data["performance"].mode()[0],inplace=True)

# date time filling 
data["Join_date"]=pd.to_datetime(data['Join_date'],errors="coerce")
data["Join_date"].fillna(data["Join_date"].median(),inplace=True)
print(data)
print(data.isnull().sum())



# ADDING USEFUL COLOUMS

data['join_year']=data["Join_date"].dt.year
data["Join_quarter"]=data["Join_date"].dt.quarter


data["experience_year"]=(pd.Timestamp.today()-data["Join_date"]).dt.days //365
print(data)

from sqlalchemy import create_engine

engine=create_engine(
    "mysql+pymysql://root:2006@localhost:3306/employees_db"
)

data.to_sql(
 name="employees_cleaned",
 con=engine,
 if_exists="replace" ,
 index=False 
)

print("cleaned data succesfully stored to my sql")