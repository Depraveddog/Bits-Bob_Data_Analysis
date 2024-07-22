SELECT TOP (1000) [Sale_Date]
      ,[Loyalty]
      ,[Reciept_Id]
      ,[Customer_ID]
      ,[Customer_First_Name]
      ,[Customer_Surname]
      ,[Staff_ID]
      ,[Staff_First_Name]
      ,[Staff_Surname]
      ,[Staff_office]
      ,[Office_Location]
      ,[Reciept_Transaction_Row_ID]
      ,[Item_ID]
      ,[Item_Description]
      ,[Item_Quantity]
      ,[Item_Price]
      ,[Row_Total]
  FROM [A1_Dirty].[dbo].[A1_Dirty]


 SELECT DISTINCT [Staff_First_Name] + ' ' + [Staff_Surname] AS [Unique_Staff_Name]
FROM [A1_Dirty].[dbo].[A1_Dirty]

SELECT * 
FROM [A1_Dirty].[dbo].[A1_Dirty]
WHERE [Staff_First_Name] IS NULL OR [Staff_Surname] IS NULL; -- only 13866 is empty 

SELECT * 
FROM [A1_Dirty].[dbo].[A1_Dirty]
WHERE [Customer_First_Name] IS NULL OR [Customer_Surname] IS NULL; -- only 13866 is empty 

SELECT [Item_ID] -- Checking if all unique items have consistent prices <clean> 
FROM [A1_Dirty].[dbo].[A1_Dirty]
GROUP BY [Item_ID]
HAVING COUNT(DISTINCT [Item_Price]) > 1;

SELECT [Item_ID] -- clean 
FROM [A1_Dirty].[dbo].[A1_Dirty]
GROUP BY [Item_ID]
HAVING COUNT(DISTINCT [Item_Description]) > 1;


SELECT [Staff_office], COUNT(DISTINCT [Office_Location]) AS NumberOfOffices -- clean (only 13866 row appears)
FROM [A1_Dirty].[dbo].[A1_Dirty]
GROUP BY [Staff_office];


SELECT [Staff_ID] -- identified molly carter and mel jackson both sharing the same unique staff id 
FROM [A1_Dirty].[dbo].[A1_Dirty]
GROUP BY [Staff_ID]
HAVING COUNT(DISTINCT [Staff_First_Name]) > 1 OR COUNT(DISTINCT [Staff_Surname]) > 1;


SELECT [Customer_ID]
FROM [A1_Dirty].[dbo].[A1_Dirty]
GROUP BY [Customer_ID]
HAVING COUNT(DISTINCT [Customer_First_Name]) > 1 OR COUNT(DISTINCT [Customer_Surname]) > 1;


SELECT [Customer_ID] -- clean no duplicate customer id
FROM [A1_Dirty].[dbo].[A1_Dirty]
GROUP BY [Customer_ID]
HAVING COUNT(DISTINCT [Customer_First_Name] + ' ' + [Customer_Surname]) > 1;

SELECT [Reciept_ID] -- 21009, 21719, 22761, 22912 same receipt id correspond to different customers name <dirty>
FROM [A1_Dirty].[dbo].[A1_Dirty]
GROUP BY [Reciept_ID]
HAVING COUNT(DISTINCT [Customer_ID]) > 1;


SELECT [Reciept_ID] -- every receipt starts with a 1 in transaction row <clean>
FROM [A1_Dirty].[dbo].[A1_Dirty]
GROUP BY [Reciept_ID]
HAVING SUM(CASE WHEN LEFT([Reciept_Transaction_Row_ID], 1) = '1' THEN 1 ELSE 0 END) = 0;


SELECT [Reciept_ID] -- every receipt besides the 21009, 21719, 22761, 22912 have no duplicate receipt transanction row id
FROM [A1_Dirty].[dbo].[A1_Dirty]
GROUP BY [Reciept_ID]
HAVING COUNT(*) <> COUNT(DISTINCT [Reciept_Transaction_Row_ID]);







