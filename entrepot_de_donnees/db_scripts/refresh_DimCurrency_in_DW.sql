SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
Mettre à jour la base de données en
1) en ajoutant les données supplémentaires de la zone de transit s'il y en a
2) et en actualisant les noms de monnaie qui ont été modifiée dans la zone de transit
*/
CREATE PROCEDURE [dbo].[refresh_DimCurrency]
AS
BEGIN
SET NOCOUNT ON
-- 1)
INSERT INTO [AWN_DW_Demo].[dbo].[DimCurrency]
(
[CurrencyAlternateKey]
,[CurrencyName]
)
SELECT
[CurrencyCode]
,[Name]
FROM [AWN_STG_Demo].[erp].[Currency] stg (NOLOCK)
LEFT JOIN [AWN_DW_Demo].[dbo].[DimCurrency] dw (NOLOCK)
ON stg.CurrencyCode = dw.CurrencyAlternateKey
WHERE dw.CurrencyAlternateKey IS NULL
-- 2)
UPDATE dw
SET [CurrencyName] = [Name]
FROM [AWN_DW_Demo].[dbo].[DimCurrency] dw (NOLOCK)
INNER JOIN [AWN_STG_Demo].[erp].[Currency] stg (NOLOCK)
ON stg.CurrencyCode = dw.CurrencyAlternateKey
WHERE [CurrencyName] <> [Name]

SET NOCOUNT OFF
END

/*SELECT * FROM [AWN_STG_Demo].[erp].[Currency]
UPDATE [AWN_STG_Demo].[erp].[Currency]
SET [Name] = 'Emirati Dirham'
WHERE [CurrencyCode] = 'AED'  
SELECT * FROM [AWN_STG_Demo].[erp].[Currency]

SELECT * FROM [AWN_DW_Demo].[dbo].[DimCurrency]
DELETE FROM [AWN_DW_Demo].[dbo].[DimCurrency]
WHERE CurrencyKey > 100
SELECT * FROM [AWN_DW_Demo].[dbo].[DimCurrency]*/


