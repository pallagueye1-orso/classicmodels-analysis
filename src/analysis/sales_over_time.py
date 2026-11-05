import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import os

# Configuration de la connexion
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
    SELECT DATE_FORMAT(orderDate, '%Y-%m') as mois, SUM(priceEach * quantityOrdered) as CA
    FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber
    GROUP BY mois ORDER BY mois;
    """
    df = pd.read_sql(query, conn)
    conn.close()

    plt.figure(figsize=(12, 5))
    plt.plot(df['mois'], df['CA'], marker='o', color='blue')
    plt.title("Évolution mensuelle du CA")
    plt.xticks(rotation=45)
    plt.tight_layout()
    plt.savefig('visualizations/01_evolution_ventes.png')
    print("Graphique 1 sauvegardé.")

if __name__ == "__main__":
    run_analysis()