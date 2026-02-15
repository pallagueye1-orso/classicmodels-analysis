# Méthodologie d’Analyse – Projet ClassicModels
Ce document présente la méthodologie adoptée pour la réalisation du projet d’analyse SQL et Python sur la base de données ClassicModels. Il décrit les différentes étapes de travail, l’organisation du projet, la structure du code, la gestion des notebooks ainsi que l’approche analytique utilisée pour produire les résultats finaux.
---

## 1. Approche générale du projet
La démarche adoptée repose sur une progression logique allant de l’exploration brute des données à l’analyse avancée et à l’interprétation stratégique. Le projet a été structuré en plusieurs phases successives :

1. Compréhension de la structure de la base ClassicModels  
2. Exploration SQL et extraction des premières statistiques  
3. Développement de requêtes SQL avancées  
4. Visualisation des données avec Python  
5. Analyses avancées (RFM, corrélations, saisonnalité, stocks, performance employés)  
6. Synthèse et formulation de recommandations métier  
7. Rédaction du rapport final
Cette approche permet de garantir une cohérence entre les différentes étapes et d’assurer une analyse complète et rigoureuse.
---

## 2. Organisation du projet
Le projet a été organisé selon une structure professionnelle inspirée des standards de la data science et de la business intelligence. Les dossiers ont été répartis de manière à séparer clairement :

- le code Python (`src/`)
- les notebooks d’analyse (`notebooks/`)
- les visualisations générées (`visualizations/`)
- les requêtes SQL (`database/queries/`)
- la documentation (`docs/`)
- le rapport final (`reports/`)
Cette organisation facilite la lecture du projet, la reproductibilité des analyses et la compréhension globale du travail réalisé.
---

## 3. Structuration du code Python
Le code Python a été structuré en modules afin de séparer les responsabilités :

- un module dédié à la connexion MySQL  
- un module pour les fonctions d’analyse  
- des notebooks pour l’exécution et la visualisation  
La connexion à la base a été centralisée dans un fichier unique afin d’éviter les répétitions et de garantir une maintenance plus simple. Les requêtes SQL ont été exécutées via `mysql-connector-python`, et les résultats ont été transformés en DataFrames pour faciliter les analyses.
---

## 4. Gestion des notebooks
Les notebooks Jupyter ont été utilisés comme espace de travail interactif pour :

- exécuter les requêtes SQL  
- transformer les données  
- produire les visualisations  
- tester les analyses avancées  
Chaque notebook correspond à une partie spécifique du projet (RFM, corrélations, saisonnalité, stocks, performance employés).  
Les cellules ont été organisées de manière logique : importations, connexion, extraction, transformation, visualisation, interprétation.

Les graphiques générés ont été exportés dans le dossier `visualizations/` afin d’être intégrés au rapport final.
---

## 5. Méthodologie d’analyse

### 5.1 Analyse SQL exploratoire  
La première étape a consisté à explorer la base via des requêtes SQL simples : comptages, regroupements, tris, filtrages.  
Cette phase a permis de comprendre la structure des données, d’identifier les variables clés et de repérer les premières tendances.

### 5.2 Requêtes SQL avancées  
Des techniques plus poussées ont ensuite été mobilisées :  
- Window Functions pour analyser les ventes  
- CTE récursifs pour reconstruire la hiérarchie des employés  
- Sous‑requêtes corrélées pour étudier la rétention client  
- Jointures multiples pour identifier les clients VIP  
- PIVOT pour analyser les ventes par gamme et trimestre  
Ces requêtes ont permis d’obtenir une vision plus fine et plus dynamique de l’activité commerciale.

### 5.3 Visualisations Python  
Les données extraites ont été visualisées avec Matplotlib et Seaborn.  
Les graphiques ont servi à illustrer les tendances observées :  
- saisonnalité des ventes  
- répartition géographique  
- performance des gammes  
- top produits  
- analyse des stocks  
La visualisation a joué un rôle essentiel dans l’interprétation des résultats.

### 5.4 Analyses avancées  
Plusieurs analyses approfondies ont été réalisées :

- **Segmentation RFM** pour classer les clients selon leur valeur  
- **Matrice de corrélation** pour étudier les relations entre variables produit  
- **Analyse temporelle** pour détecter les pics saisonniers  
- **Analyse du panier moyen** et des produits achetés ensemble  
- **Performance des employés** pour identifier les meilleurs commerciaux  
Ces analyses ont permis de dégager des insights concrets et exploitables.
---

## 6. Synthèse et rédaction du rapport
Une fois les analyses terminées, les résultats ont été synthétisés dans un rapport structuré comprenant :

- une introduction  
- une présentation de la base  
- les analyses SQL  
- les visualisations Python  
- les analyses avancées  
- les recommandations stratégiques  
- une conclusion académique  
Les graphiques ont été intégrés au rapport pour illustrer les observations et renforcer la compréhension des résultats.
---

## 7. Conclusion sur la méthodologie
La méthodologie adoptée a permis de mener une analyse complète, rigoureuse et structurée de la base ClassicModels.  
La combinaison de SQL, Python et visualisations a offert une compréhension fine des données et a permis de formuler des recommandations pertinentes.  
Cette démarche est représentative des pratiques professionnelles en Business Intelligence et en Data Analytics.