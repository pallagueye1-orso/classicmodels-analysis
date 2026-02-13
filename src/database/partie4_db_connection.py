import mysql.connector
import pandas as pd

def query(sql, params=None):
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="oussy",
        database="classicmodels"
    )
    cursor = conn.cursor(dictionary=True)
    cursor.execute(sql, params or ())
    result = cursor.fetchall()
    cursor.close()
    conn.close()
    return result
