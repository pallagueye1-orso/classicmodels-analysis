import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
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
    SELECT country, SUM(priceEach * quantityOrdered) as total 
    FROM customers c JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY country ORDER BY total DESC LIMIT 10;
    """
    df = pd.read_sql(query, conn)
    conn.close()

    plt.figure(figsize=(10, 6))
    sns.barplot(data=df, x='total', y='country', palette='viridis')
    plt.title("Top 10 Pays par Chiffre d'Affaires")
    plt.tight_layout()
    plt.savefig('visualizations/02_repartition_geo.png')
    print("✅ Graphique 2 sauvegardé.")

if __name__ == "__main__":
    run_analysis()
