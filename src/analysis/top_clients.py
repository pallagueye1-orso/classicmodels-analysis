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
    SELECT customerName, SUM(priceEach * quantityOrdered) as total_ca
    FROM customers c JOIN orders o ON c.customerNumber = o.customerNumber
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY customerName ORDER BY total_ca DESC;
    """
    df = pd.read_sql(query, conn)
    conn.close()

    # On sépare les 5 premiers du reste pour la visualisation
    top_5 = df.head(5)
    others_val = df.iloc[5:]['total_ca'].sum()
    
    plt.figure(figsize=(10, 6))
    plt.bar(top_5['customerName'], top_5['total_ca'], color='orange')
    plt.title("Chiffre d'Affaires des 5 Meilleurs Clients")
    plt.xticks(rotation=20)
    plt.tight_layout()
    plt.savefig('visualizations/06_ca_clients.png')
    print("✅ Graphique 6 (Clients) sauvegardé.")

if __name__ == "__main__":
    run_analysis()