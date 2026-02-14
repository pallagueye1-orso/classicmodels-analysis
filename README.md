Initialisation de la structure du projet SQL-Python (M1 BIDABI)
# classicmodels-analysis Project


Ce projet réalise une analyse complète de la base de données **ClassicModels** à l’aide de **MySQL**, **Python**, **Jupyter Notebook**, **google colab**  et diverses techniques d’analyse avancée (RFM, corrélations, saisonnalité, panier moyen, performance employés).
---

## Structure du projet
database/ (schema/, queries/ avec tous mes scripts SQL, .mwb), 
src/ (database/, analysis/, exports/), 
notebooks/, 
visualizations/, 
docs/, 
reports/, 
config/,
requirements.txt, 
README.md.
---

## Installation
### 1. Cloner le projet
git clone https://github.com/<ton-repo>/classicmodels-analysis.git
cd classicmodels-analysis

### 2. Installer les dépendances
Dans un terminal ou dans Jupyter :
pip install -r requirements.txt

### 3. Lancer Jupyter Notebook
jupyter notebook
---

## Base de données MySQL
Le projet utilise la base **ClassicModels**.

### Connexion utilisée :
- **host** : "localhost"  
- **user** : "root"  
- **password** : "ton_mot_de_passe"  
- **database** : "classicmodels"  
Le fichier Python de connexion se trouve dans :
src/database/partie3_db_connection.py
---

## Analyses réalisées (Partie 4)
Les analyses avancées sont disponibles dans le dossier : notebooks/

### 1. Analyse RFM (Recency, Frequency, Monetary)
- Segmentation des clients : VIP, Réguliers, À risque, Perdus  
- Calcul des scores R, F, M  
- Attribution d’un score global RFM  
- Interprétation métier

### 2. Matrice de corrélation + Heatmap
- Corrélation entre prix, quantités vendues, MSRP, prix moyen  
- Visualisation avec heatmap Seaborn  
- Analyse des relations entre variables

### 3. Analyse temporelle et saisonnalité
- Ventes par jour  
- Ventes mensuelles  
- Ventes trimestrielles  
- Détection des périodes fortes et faibles

### 4. Analyse du panier moyen
- Calcul du panier moyen par commande  
- Identification des produits fréquemment achetés ensemble  
- Analyse de type “market basket”

### 5. Performance des employés
- Chiffre d’affaires généré par employé  
- Nombre de clients gérés  
- Nombre de commandes  
- Panier moyen par employé  
- Graphiques comparatifs
---

## Dépendances (requirements.txt)
mysql-connector-python>=8.0
pandas>=2.0
matplotlib>=3.7
seaborn>=0.13
numpy>=1.24
jupyter
google colab
---

## Rapport final
Le rapport final se trouve dans : reports/rapport_final.pdf
Il contient :
- les analyses SQL  
- les analyses Python  
- les visualisations  
- les interprétations métier  
- les recommandations stratégiques  
---

## Auteur
Projet réalisé par **Gueye Palla**  
Dans le cadre du module **Big Data, Analyse & Business Intelligence**.





