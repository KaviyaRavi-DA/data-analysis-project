Create database Project_Sql;
use Project_Sql;

-- 0 question -------------------------------------------------

SELECT * FROM FactInternet_OldSales
UNION ALL
SELECT * FROM Fact_Internet_Sales_new;

-- 1 question -------------------------------------------------
select P.EnglishProductName as Product_Name ,F.salesamount from dim_product as P
join fact_internet_sales as F
on P.ProductKey = F.ProductKey;

-- 2 question -------------------------------------------------
Select * from dimCustomer;
Select * from FactInternetSales;

select concat(FirstName, " ", LastName) As CustomerFullName, S.Unitprice, S.SalesAmount
from Fact_Internet_Sales as S
Join Dim_Customer as C
on S.CustomerKey = C.CustomerKey;

-- 3 question -------------------------------------------
SELECT 
	DATE_FORMAT(STR_TO_DATE(Datekey, '%Y%m%d'), '%Y-%m-%d') AS DateField,
	YEAR(DateKey) AS Year,                                						-- A. Year
	MONTH(DateKey) AS MonthNo,                           						-- B. Month number (1 to 12)
    MONTHNAME(Datekey) AS MonthFullName,            							-- C. Month full name (January, February, etc.)
	CONCAT('Q',QUARTER(DateKey)) AS Quarter,			  						-- D. Quarter (Q1, Q2, Q3, Q4)
    CONCAT(YEAR(DateKey),'-', LEFT(MONTHNAME(DateKey),3)) AS YearMonth,     	-- E. Year-Month (YYYY-MMM)
    WEEKDAY(DateKey) AS WeekdayNo,               								-- F. Weekday number (1 = Sunday, 2 = Monday, etc. depending on server setting)
    DAYNAME(DateKey) AS WeekdayName,       										-- G. Weekday full name (Monday, Tuesday, etc.)
    CASE 
        WHEN MONTH(DateKey) >= 4 
        THEN MONTH(DateKey) - 3
        ELSE MONTH(DateKey) + 9
    END AS FinancialMonth,								 						-- H. Financial Month (Assuming Financial Year starts in April)
    CASE 
        WHEN MONTH(DateKey) BETWEEN 4 AND 6 THEN 'Q1'
        WHEN MONTH(DateKey) BETWEEN 7 AND 9 THEN 'Q2'
        WHEN MONTH(DateKey) BETWEEN 10 AND 12 THEN 'Q3'
        ELSE 'Q4'
    END AS FinancialQuarter                             						-- I. Financial Quarter (Assuming Financial Year starts in April)
FROM 
    Dim_Date;

-- 4 question -------------------------------------------------------
SELECT 
    UnitPrice,
    OrderQuantity,
    UnitPriceDiscountPct,
    (UnitPrice * OrderQuantity) AS TotalPriceBeforeDiscount,
    ((UnitPrice * OrderQuantity) * (UnitPriceDiscountPct / 100.0)) AS DiscountAmount,
    ((UnitPrice * OrderQuantity) - ((UnitPrice * OrderQuantity) * (UnitPriceDiscountPct / 100.0))) AS SalesAmount
FROM 
Fact_Internet_Sales;

-- OR 

SELECT 
    UnitPrice,
    OrderQuantity,
    UnitPriceDiscountPct,
    (UnitPrice * OrderQuantity * (1 - UnitPriceDiscountPct)) AS SalesAmount
FROM 
    fact_internet_sales;

-- 5 question -------------------------------------------------------
SELECT UnitPrice, OrderQuantity, 
	(TotalProductCost / OrderQuantity) * (OrderQuantity) AS productioncost
FROM Fact_Internet_Sales;


-- 6 question---------------------------------------------------------------

SELECT UnitPrice, OrderQuantity, TotalProductCost, 
       (UnitPrice * OrderQuantity) AS SalesAmount,
	(TotalProductCost / OrderQuantity) * (OrderQuantity) AS productioncost,
       ((UnitPrice * OrderQuantity) - ((TotalProductCost / OrderQuantity) * (OrderQuantity)))
 AS Profit
FROM Fact_Internet_Sales;

-- OR

select SalesAmount - TotalProductCost as Profit from Fact_Internet_Sales;

