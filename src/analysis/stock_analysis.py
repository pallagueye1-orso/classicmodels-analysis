import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

db_config = {
    "host": "localhost",
    "user": "root",
    "password": "oussy",
    "database": "classicmodels"
}

def run_analysis():
    if not os.path.exists('visualizations'): os.makedirs('visualizations')
    
    conn = mysql.connector.connect(**db_config)
    # On identifie les produits avec moins de 1000 unités
    query = "SELECT productName, quantityInStock FROM products WHERE quantityInStock < 1000 ORDER BY quantityInStock ASC LIMIT 15;"
    df = pd.read_sql(query, conn)
    conn.close()

    plt.figure(figsize=(10, 6))
    sns.barplot(data=df, x='quantityInStock', y='productName', color='salmon')
    plt.axvline(x=500, color='red', linestyle='--', label='Seuil Critique')
    plt.title("Alerte Stocks Faibles (< 1000 unités)")
    plt.legend()
    plt.tight_layout()
    plt.savefig('visualizations/05_etat_stocks.png')
    print("✅ Graphique 5 (Stocks) sauvegardé.")

if __name__ == "__main__":
    run_analysis()