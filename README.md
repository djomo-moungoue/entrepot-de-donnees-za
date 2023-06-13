# SSIS - SQL Server Integration Services

SSIS est un outil qui sert lors de la préparation des données à extraire, transformer et charger les données dans les projet d'entrepôts de données, des projets de migration des données ou dans les activités de maintenance des données.
![BI Architecture](images/bi_architecture_analytics_with_naqs.png)

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

[Intallation Hors Ligne](https://learn.microsoft.com/en-us/sql/ssdt/previous-releases-of-sql-server-data-tools-ssdt-and-ssdt-bi?view=sql-server-ver16#ssdt-for-visual-studio-vs-2017)

[[Intallation Hors Ligne avec images d'illustration](https://en.dirceuresende.com/blog/como-corrigir-erro-na-instalacao-do-sql-server-data-tools-ssdt-2017-setup-failed-incorrect-function-0x80070001/)

https://learn.microsoft.com/en-us/sql/ssdt/download-sql-server-data-tools-ssdt?view=sql-server-2017#ssdt-for-vs-2017-standalone-installer&WT.mc_id=DP-MVP-5003166