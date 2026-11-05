Initialisation de la structure du projet SQL-Python (M1 BIDABI)
# classicmodels-analysis Project


Ce projet réalise une analyse complète de la base de données **ClassicModels** à l’aide de **MySQL**, **Python**, **Jupyter Notebook** et **Google Colab**. L’objectif est de produire des insights métier, des visualisations et des recommandations stratégiques.
---

## Structure du projet
database/ (schema/, queries/ avec tous mes scripts SQL, .mwb), 
src/ (database/, analysis/, exports/), 
notebooks/, 
visualizations/, 
docs/, 
reports/, 
config/,
requirements/requirements.txt, 
README.md.
---

## Installation
### 1. Cloner le projet
git clone https://github.com/pallagueye1-orso/classicmodels-analysis.git
cd classicmodels-analysis

### 2. Installer les dépendances
Dans un terminal ou dans Jupyter :
pip install -r requirements/requirements.txt

### 3. Lancer Jupyter Notebook
```bash
jupyter notebook
```
---

## Base de données MySQL
Le projet utilise la base **ClassicModels**. Le téléchargement est via : https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/ et l'importation via MySQL Workbench.

### Connexion utilisée :
- **host** : "localhost"  
- **user** : "root"  
- **password** : lu dans la variable d'environnement `MYSQL_PASSWORD` (jamais écrit dans le code)  
- **database** : "classicmodels"  
Avant de lancer les scripts, définir le mot de passe dans le terminal :
```bash
# Linux / macOS
export MYSQL_PASSWORD="votre_mot_de_passe"
# Windows (PowerShell)
$env:MYSQL_PASSWORD="votre_mot_de_passe"
```

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
visualizations/partie1_visualisations/
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

Les scripts sont dans : src/analysis/. Et les graphiques sont dans: src/exports/.
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

## Résultats
- **Segmentation RFM** : deux clients ressortent comme VIP parmi ceux affichés dans le rapport, Australian Collectors, Co. (monetary 180 585,07 ; score RFM 11) et La Rochelle Gifts (monetary 158 573,12 ; score RFM 12).
- **Produits achetés ensemble** : la paire la plus fréquente est S50_1341 avec S700_1691, achetée ensemble 28 fois.
- **Statut des commandes** : la grande majorité des commandes sont expédiées (Shipped).
- **Saisonnalité** : les ventes montent fortement en fin d'année, avec un pic en novembre 2003 et un quatrième trimestre nettement plus élevé que les trois autres.
- **Gammes de produits** : Classic Cars arrive en tête du chiffre d'affaires.

Le détail des analyses et les graphiques sont dans le rapport final.
---

## Rapport final
Le rapport final se trouve dans : reports/Rapport.pdf
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





