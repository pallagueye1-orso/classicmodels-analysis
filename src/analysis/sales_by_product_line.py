import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import os

db_config = {
    "host": "localhost",
    "user": "root",
    "password": os.environ["MYSQL_PASSWORD"],
    "database": "classicmodels"
}

def run_analysis():
    if not os.path.exists('visualizations'): os.makedirs('visualizations')
    
    conn = mysql.connector.connect(**db_config)
    query = """
    SELECT productLine, SUM(priceEach * quantityOrdered) as total 
    FROM products p JOIN orderdetails od ON p.productCode = od.productCode
    GROUP BY productLine;
    """
    df = pd.read_sql(query, conn)
    conn.close()

    plt.figure(figsize=(8, 8))
    plt.pie(df['total'], labels=df['productLine'], autopct='%1.1f%%')
    plt.title("Répartition du CA par Gamme")
    plt.savefig('visualizations/03_ventes_gammes.png')
    print("✅ Graphique 3 sauvegardé.")

if __name__ == "__main__":
    run_analysis()