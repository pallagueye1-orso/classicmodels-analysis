import mysql.connector
from mysql.connector import pooling
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

# Configuration pour la connexion sécurisée 
db_config = {
    "host": "localhost",
    "user": "root",
    "password": os.environ["MYSQL_PASSWORD"],
    "database": "classicmodels"
}

# Création du pool de connexions 
pool = mysql.connector.pooling.MySQLConnectionPool(
    pool_name="mypool", pool_size=5, **db_config
)

def get_data(query):
    conn = pool.get_connection()
    df = pd.read_sql(query, conn)
    conn.close()
    return df

# Création du dossier de sauvegarde 
if not os.path.exists('visualizations'):
    os.makedirs('visualizations')