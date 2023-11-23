-- Connect to the AdventureWorks2012 database
use AdventureWorks2012

-- Get customer details like name,last name ,title, addition contact info:
select* from [Person].[Person]

SELECT 
    BusinessEntityID,
    FirstName,
    LastName,
    AdditionalContactInfo
    FROM Person.Person;


-- Get sales made in a particular month
SELECT 
    YEAR(OrderDate) AS Year,
    MONTH(OrderDate) AS Month,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate);

-- Get increase in month-on-month sales WITH MonthlySales AS (
WITH MonthlySales AS (
    SELECT 
        YEAR(OrderDate) AS Year,
        MONTH(OrderDate) AS Month,
        SUM(TotalDue) AS TotalSales
    FROM Sales.SalesOrderHeader
    GROUP BY YEAR(OrderDate), MONTH(OrderDate)
)
SELECT 
    Year,
    Month,
    TotalSales,
    LAG(TotalSales) OVER (ORDER BY Year, Month) AS PreviousMonthSales,
    TotalSales - LAG(TotalSales) OVER (ORDER BY Year, Month) AS Increase
FROM MonthlySales;

--Get the total sales made to the customer with FirstName='Gustavo' and last name='Achong'

SELECT
    c.BusinessEntityID,
    c.FirstName,
    c.LastName,
    SUM(soh.TotalDue) AS TotalSales
FROM
    Person.Person AS c
JOIN
    Sales.SalesOrderHeader AS soh ON c.BusinessEntityID = soh.CustomerID
WHERE
    c.FirstName = 'Gustavo'
    AND c.LastName = 'Achong'
GROUP BY
    c.BusinessEntityID, c.FirstName, c.LastName;

