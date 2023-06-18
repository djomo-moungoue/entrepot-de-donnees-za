/*

*/
CREATE PROCEDURE [dbo].[refresh_DimProduct]
AS
BEGIN
SET NOCOUNT ON

INSERT INTO [AWN_DW_Demo].[dbo].[DimProduct]
(
	[ProductAlternateKey]
	,[EnglishProductName]
	,[StandardCost]
	,[Color]
	,[Size]
	--,[SizeRange]
	--,[EnglishDescription]
	--,[FrenchDescription]
	--,[ArabicDescription]
	,[ProductSubcategoryCode]
	,[ProductcategoryCode]
	,[Status]
) 
SELECT [ProductID]
      ,p.[Name]
      ,p.[StandardCost]
      ,p.[Color]
      ,p.[Size]
      ,p.[ProductSubcategoryID]
	  ,psc.[ProductCategoryID]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[ListPrice]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
FROM [AWN_STG_Demo].[erp].[Product] p
LEFT JOIN [AWN_STG_Demo].[erp].[ProductSubCategory] psc
ON p.[ProductSubcategoryID] = psc.[ProductSubcategoryID]


SET NOCOUNT OFF
END
