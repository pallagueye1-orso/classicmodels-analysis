import mysql.connector
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os

# --- 1. CONFIGURATION DE LA CONNEXION ---
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'TON_MOT_DE_PASSE_ICI',  # <--- METS TON MOT DE PASSE MYSQL ICI
    'database': 'classicmodels'
}

# Créer le dossier visualizations s'il n'existe pas
if not os.path.exists('visualizations'):
    os.makedirs('visualizations')

try:
    # Connexion à MySQL
    conn = mysql.connector.connect(**db_config)
    print("✅ Connexion réussie à la base ClassicModels")

    # --- 2. RÉCUPÉRATION DES DÉNOMBREMENTS (Comme en SQL) ---
    # On refait exactement ce que tu as fait dans Workbench
    query_count = """
    SELECT 'Clients' AS Categorie, COUNT(*) AS Total FROM customers
    UNION
    SELECT 'Employes', COUNT(*) FROM employees
    UNION
    SELECT 'Produits', COUNT(*) FROM products
    UNION
    SELECT 'Commandes', COUNT(*) FROM orders;
    """
    df_count = pd.read_sql(query_count, conn)
    print("\n--- Statistiques Globales ---")
    print(df_count)

    # --- 3. GRAPHIQUE 1 : RÉPARTITION PAR PAYS ---
    query_pays = "SELECT country, COUNT(*) as nb_clients FROM customers GROUP BY country ORDER BY nb_clients DESC LIMIT 10;"
    df_pays = pd.read_sql(query_pays, conn)

    plt.figure(figsize=(12, 6))
    sns.set_style("whitegrid")
    sns.barplot(x='nb_clients', y='country', data=df_pays, palette='viridis')
    plt.title('Top 10 des pays par nombre de clients (Analyse Partie 1)')
    plt.xlabel('Nombre de clients')
    plt.ylabel('Pays')
    
    plt.savefig('visualizations/clients_par_pays.png')
    print("\n✅ Graphique des pays sauvegardé dans visualizations/")

    # --- 4. GRAPHIQUE 2 : STATUT DES COMMANDES ---
    query_status = "SELECT status, COUNT(*) as total FROM orders GROUP BY status;"
    df_status = pd.read_sql(query_status, conn)

    plt.figure(figsize=(10, 7))
    plt.pie(df_status['total'], labels=df_status['status'], autopct='%1.1f%%', colors=sns.color_palette('pastel'))
    plt.title('Répartition des commandes par statut')
    
    plt.savefig('visualizations/statut_commandes.png')
    print("✅ Graphique des statuts sauvegardé dans visualizations/")
    
    plt.show()

except mysql.connector.Error as err:
    print(f"❌ Erreur : {err}")
finally:
    if 'conn' in locals() and conn.is_connected():
        conn.close()
        print("\n🔒 Connexion fermée.")