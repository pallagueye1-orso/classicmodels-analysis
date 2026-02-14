Initialisation de la structure du projet SQL-Python (M1 BIDABI)
# classicmodels-analysis Project


Ce projet réalise une analyse complète de la base de données **ClassicModels** à l’aide de **MySQL**, **Python**, **Jupyter Notebook**et **google colab**. L’objectif est de produire des insights métier, des visualisations et des recommandations stratégiques.
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
---

## Base de données MySQL
Le projet utilise la base **ClassicModels**. Le téléchargement est via : https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/ et l'importation via MySQL Workbench.

### Connexion utilisée :
- **host** : "localhost"  
- **user** : "root"  
- **password** : "ton_mot_de_passe"  
- **database** : "classicmodels"  
Le fichier Python de connexion se trouve dans :
src/database/partie3_db_connection.py
---
  
## Analyse exploratoire SQL (PARTIE 1)
Objectifs :
- Installer la base ClassicModels
- Créer un diagramme EER (rétro‑ingénierie)
- Explorer les 8 tables
- Répondre aux questions suivantes avec SQL :

### Analyses réalisées :
- Nombre de clients, employés, bureaux, commandes, produits, gammes
- Répartition géographique des clients (par pays)
- Nombre de commandes par statut (shipped, cancelled…)
- Montant total des ventes
- Panier moyen
- Top 10 produits les plus vendus
- Top 5 clients par chiffre d’affaires
- Employé ayant réalisé le plus de ventes
- Gamme de produits la plus rentable

Toutes les requêtes SQL sont dans : database/queries/. Et les visualisations associées sont dans : 
visualizations/partie1_visualisations.png
---

# Requêtes SQL avancées (PARTIE 2)
### Requêtes complexes développées :
1. Analyse des ventes avec **WINDOW FUNCTIONS** (rang, moyennes mobiles, pourcentages)
2. Hiérarchie organisationnelle avec **CTE récursif**
3. Segmentation clients VIP avec **jointures multiples (5+ tables)**
4. Analyse temporelle avec **sous‑requêtes corrélées** (nouveaux clients, rétention)
5. Rapport **PIVOT** ventes par gamme et trimestre

### Objets SQL développés :
- 2 procédures stockées  
- 1 fonction (Customer Lifetime Value)  
- 3 triggers (audit, validation stock, mise à jour statut client)

Tous les scripts SQL sont dans : database/queries/
---

# Visualisations Python (PARTIE 3)
Développement d’un module Python avec connexion MySQL et visualisations :

### Graphiques réalisés :
1. Évolution temporelle des ventes (mois, trimestres)
2. Répartition géographique des clients et ventes par pays
3. Ventes par gamme de produits
4. Top 10 produits les plus vendus
5. Analyse des stocks (ruptures, stocks faibles)
6. Répartition du chiffre d’affaires par clients (top clients vs autres)

Les scripts sont dans : scr/analysis/. Et les graphiques sont dans: scr/exports/.
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

Code Python dans : notebooks/ et src/database/.
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





