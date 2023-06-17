/*1 Créer la base de données [NgenmbhiZoneDeTransit] dans la base de données [master]*/
USE [master]
GO
CREATE DATABASE [NgenmbhiZoneDeTransit]

/*Effectuons toutes les opérations qui suivront sur la base de données [NgenmbhiZoneDeTransit]*/
USE [NgenmbhiZoneDeTransit]
GO

/*Affiche tous les schémas du moteur de base données*/
SELECT s.name AS schema_name, 
    s.schema_id,
    u.name AS schema_owner
FROM sys.schemas s
INNER JOIN sys.sysusers u
ON u.uid = s.principal_id
ORDER BY s.name
GO

/*
[dbo] est le schéma par défaut de SQL Server. Nous allons créer nos propres schémas pour nous permettre de mieux gérer notre espace de noms d'objets.
[pgi] progiciel de gestion intégré (PGI) eng. enterprise ressource planning (ERP) 
[rh] ressources humaines (RH) eng. human ressources (HR)
*/
CREATE SCHEMA [pgi]
GO
CREATE SCHEMA [rh] 
GO

