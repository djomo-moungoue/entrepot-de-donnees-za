# Bien comprendre et implémenter votre Entrepôt de Données de A à Z

## Configuer votre Environnement de Développement

Composants de mon environnement de travail
1. Microsoft Windows 10 Professionnel
2. SQL Server Data Tool for Visual Studio 2017 (SSDT 2017)
3. SQL Server Developper Edition
4. SQL Server Management Studio
5. Git et GitHub

### [Installer SQL Server Data Tool for Visual Studio 2017 (SSDT 2017)](https://en.dirceuresende.com/blog/como-corrigir-erro-na-instalacao-do-sql-server-data-tools-ssdt-2017-setup-failed-incorrect-function-0x80070001/)

Télécharger SSDT 2017 (SSDT-Setup-ENU.exe) ici https://go.microsoft.com/fwlink/?linkid=2169967&WT.mc_id=DP-MVP-5003166

Télécharger (vs_sql.exe) ici https://aka.ms/vs/15/release/vs_sql.exe

Ouvrir l'invite de commande en tant que administrateur

Naviguer dans le dossier où vs_SQL.exe a été téléchargé
~~~sh
cd C:\Users\Admin\Sync\cdnza\data_analysis\entrepot_de_donnees
~~~

Exécuter la commande suivante
~~~sh
vs_SQL.exe --layout C:\SSDT2017\ --lang en-us
~~~

Exécuter la commande suivante et suivant les instruction de l'assisatant pour installer Microsoft Visual Studio 2017
~~~sh
cd C:\SSDT2017\
vs_SQL.exe --NoWeb
~~~

Installer Microsoft SQL Server Data Tools sans oublier de cocher les option SSAS, SSRS, et SSIS lors que l'assistant va démarrer.

### [Installer SQL Server Developer Edition](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
NB: Cocher l'option Integration Services afin que 

### [Installer SQL Server Management Studio (SSMS)](https://learn.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver16)

Sommaire
- Les notions fondamentales
- Expliquer l'architecture d'un entrepôt de données
- Définir les termes techniques usuels
- Etudier un cas pratique à l'aide du jeux de données "Adventure works"
- Modéliser un entrepôt de données
- Implémenter un entrepôt de données
- Extraire Transformer et Charger les données (SSIS)
- Analyser les données (SSAS)
- Planifier les tâches (Power BI)
- Conclure

## Les notions fondamentales

Qu'est ce qu'entrepôt de données?
- Un `entrepôt de données - Data Warehouse (DW)` est un dépôt central de données intégrées provenant d'une ou de plusieurs sources hétéogènes. C'est un composant essentiel d'intelligence économique qui est utilisé pour créer des rapports et analyser les données.
- L'`intelligence économique - Business Intelligence (BI)`est à son tour l'ensemble des stratégies et technologies utilisées par les entreprises pour analyser les données concernant leurs affaires. Les entrepôts de données permettent d'implémenter les solutions pour d'intelligence économique.

Pourquoi avons nous besoins d'un entrepôt de données?
- Pour intégrer plusieurs sources de données différentes
- Pour éviter que les utilisateurs exécutent les rapports directement sur le système opérationnel (ex. site web de la banque), parce que ceci peut créer des problèmes de performance.
- Pour avoir une version unique de la vérité à propos de vos données
- Pour regrouper les données historiques en un seul endroit afin de pouvoir mieux les gérer
- Pour réduire le risque que les utilisateurs du rapport fassent un usage abusif ou corrompent les données de transaction.
- Permettre aux utilisateurs finaux de créer leurs propres rapports sans impliquer un informaticien dans les processus (Self Service BI).
- Parce que c'est l'endroit adéquat pour créer et sauvegarder les métadonnées et les logiques d'entreprises
- Pour améliorer la qualité des données en nettoyant ceux ci lors de l'importation dans l'entrepôt de données
- Parce que c'est une technologie qui a fait ses preuves.

## Expliquer l'architecture d'un entrepôt de données

### L'Architecture conventionnelle
![L'architecture d'un entrepôt de données conventionnel](images/bi_architecture_analytics_with_naqs.png)
Le diagramme ci-dessus illustre l'architecture classique des entrepôts de données dans les entreprises. Partant de la gauche vers la droite, nous avons diverses sources hétéroges qui contiennent les données par rapport aux activités d'une entreprise pendant une période de temps données. Nous utiliserons Microsoft Visual Studio Data Tool for Visual Studio 2017 pour préparer ces données en d'autres termes pour extraire ces données, les transformer en données exploitables par les outils d'analyse et les charger dans une base de données SQL Server 2017 (SQL). Cette étape s'appelle l'intégration des données (ETL / SSIS). Par la suite nous allons construire notre modèle tabulaire (recommandé par microsoft car suffisant pour la majorité des tâches) ou multidimentionnel de ces données dans SQL Server (SSAS). About de la chaine de traitement nous allons donc utiliser Microsoft Power BI pour créer des rapports et des tableaux de bord (DAX) pertinents pour les mettre à disposition de nos utilisateurs finaux qui les consommeront à travers leurs navigateurs web ou leurs smartphone.

### L'Architecture moderne
![L'architecture d'un entrepôt de données moderne](images/mordern_datawarehouse_architecture_analytics_with_naqs_.png)
Nous constatons ici le flux de tâches à effectuer reste identique entre cette architecture et de la précédente tandis que les outils utilisés diffères. Le traitement des données dans un entrepôt de données moderne se fait essentiellement dans le cloud parce que les sources de données sont aussi stocées dans des espaces cloud.

### Définir les termes techniques usuels

`SQL Server Integration Services (SSIS)` est un sevice d'extraction, transformation et chargement de données ETL (Extract Transform Load) qui permet de se connecter à n'importe quelle source de données (Excel, fichier plat csv, XML, base de données, etc.). Tandis que `ETL (Extract Transform Load)` est utilisé pour les solution d'entrepôts de données dans les locaux de l'entreprise, `ELT (Extract Load Transform)` est utilisé pour les solution de lac des données dans les technologies cloud.
![ETL vs ELT](images/etl_vs_elt.png)

Une `zone de transit - eng. staging` est une zone de stockage intermédiaire utilisée pour le traitement des données au cours du processus d'extraction, de transformation et de chargement (ETL). La zone de mise à disposition des données se situe entre la ou les sources de données et la ou les cibles de données, qui sont souvent des entrepôts de données (DW), des marteaux de données (DM) ou d'autres référentiels de données.

Un `magasin de données opérationnelles - eng. operational data store (ODS)` est une base de données centrale qui fournit un instantané des données les plus récentes provenant de plusieurs systèmes transactionnels pour l'établissement de rapports opérationnels. Un cas pratique est l'architecture master-slave d'une base de données opérationnelle qui permet de repliquer la base de données principale en temps réel afin de permettre aux utilisateurs finaux d'exécuter leurs rapports sur un base de données secondaire de tel sorte que les activités opérationnnelles ne soientt pas perturbées.
![Staging vs ODS](images/etl_vs_elt.png)

`SQL Server Analysis Services (SSAS)` est une composante importante de la suite d'intelligence d'affaires (BI) proposée par Microsoft permettant de créer des cubes OLAP pouvant être exploités par différents outils de forage, d'exploration de données et de tableaux de bord.

Le `traitement des transactions en ligne - eng. Online Transaction Processing (OLTP)` capture, stocke et traite les données des transactions en temps réel, tandis que le `traitement analytique en ligne - eng. Online Analytical Processing (OLAP)` utilise des requêtes complexes pour analyser les données historiques agrégées des systèmes OLTP. Un système OLTP est tabulaire (ex. le visuel tableau dans Powe BI) tandis qu'un système OLAP est cubique (ex. le visuel matrix dans Power BI).

Une `table de faits (ce que vous voulez analyser) - eng. fact table` contient des mesures ainsi que des clés étrangères de référence pour les tables de dimensions. Ces tables sont généralement des tables de transaction du système OLTP. Cependant, une `table de dimension (par laquelle vous voulez analyser)` est une entité commerciale qui possède ses propres attributs et cette table est liée au fait. Il s'agit généralement de tables de référence ou de tables de consultation dans le système OLTP.


`DAX (Data Analysis Expressions)` est le langage utilisé dans Power BI pour créer des formules et ainsi compléter un modèle de données pour répondre à une analyse.

## Etudier un cas pratique à l'aide du jeux de données "Adventure works"
## Modéliser un entrepôt de données
## Implémenter un entrepôt de données
## Extraire Transformer et Charger les données (SSIS)
## Analyser les données (SSAS)
## Planifier les tâches (Power BI)
## Conclure

SSIS - SQL Server Integration Services

SSIS est un outil qui sert lors de la préparation des données à extraire, transformer et charger les données dans les projet d'entrepôts de données, des projets de migration des données ou dans les activités de maintenance des données.


SQL Server Data Tools permet de créer les projets SSIS, SSAS et SSRS.

## Créer un Flux de Données
Migrer les données d'un ficheier CSV dans une base de données SQL Server en utilisant Microsoft Visual Studio (SSDT) et SQL Server Management Service (SSMS)

Processuss chronologique:
- Créer une connection vers la source Flat File afin de connecter un fichier CSV
- Créer une base de données qui servira de destination (SSMS)
- Creéer une connection ver la base de données
- Définir les flux des données de la source vers la destination
- Créer une table à partir des données chargées
- Rafraichir la base de donnée afin de charge la trable vide nouvellement créée (SSMS)
- Exécuter le flux de contrôle afin de charger les données dens la table de la base de données

Liens utiles:
- [SSDT for Visual Studio (VS) 2017 - Intallation Hors Ligne](https://learn.microsoft.com/en-us/sql/ssdt/previous-releases-of-sql-server-data-tools-ssdt-and-ssdt-bi?view=sql-server-ver16#ssdt-for-visual-studio-vs-2017)
- [Intallation Hors Ligne avec images d'illustration](https://en.dirceuresende.com/blog/como-corrigir-erro-na-instalacao-do-sql-server-data-tools-ssdt-2017-setup-failed-incorrect-function-0x80070001/)

