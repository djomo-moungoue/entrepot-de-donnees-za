/*1 Cr�er la base de donn�es [NgenmbhiZoneDeTransit] dans la base de donn�es [master]*/
USE [master]
GO
CREATE DATABASE [NgenmbhiZoneDeTransit]

/*Effectuons toutes les op�rations qui suivront sur la base de donn�es [NgenmbhiZoneDeTransit]*/
USE [NgenmbhiZoneDeTransit]
GO

/*Affiche tous les sch�mas du moteur de base donn�es*/
SELECT s.name AS schema_name, 
    s.schema_id,
    u.name AS schema_owner
FROM sys.schemas s
INNER JOIN sys.sysusers u
ON u.uid = s.principal_id
ORDER BY s.name
GO

/*
[dbo] est le sch�ma par d�faut de SQL Server. Nous allons cr�er nos propres sch�mas pour nous permettre de mieux g�rer notre espace de noms d'objets.
[pgi] progiciel de gestion int�gr� (PGI) eng. enterprise ressource planning (ERP) 
[rh] ressources humaines (RH) eng. human ressources (HR)
*/
CREATE SCHEMA [pgi]
GO
CREATE SCHEMA [rh] 
GO

