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
    SELECT productName, SUM(quantityOrdered) as total_vendu
    FROM products p JOIN orderdetails od ON p.productCode = od.productCode
    GROUP BY productName ORDER BY total_vendu DESC LIMIT 10;
    """
    df = pd.read_sql(query, conn)
    conn.close()

    plt.figure(figsize=(12, 6))
    sns.barplot(data=df, x='total_vendu', y='productName', hue='productName', palette='magma', legend=False)
    plt.title("Top 10 des produits les plus vendus")
    plt.tight_layout()
    plt.savefig('visualizations/04_top_produits.png')
    print("✅ Graphique 4 (Top Produits) sauvegardé.")

if __name__ == "__main__":
    run_analysis()