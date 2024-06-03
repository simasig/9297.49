USE northwind

SELECT city 
FROM employees
FOR XML AUTO;


 SELECT CompanyName  
FROM Customers   
FOR XML AUTO

---Columns without a Name



SELECT 2+2  
FOR XML PATH  

SELECT CompanyName   
FROM Customers   
FOR XML PATH ;


SELECT CompanyName   
FROM Customers   
FOR XML PATH ('');

 SELECT CompanyName  
FROM Customers   
FOR XML AUTO;

SELECT ','+CompanyName   
FROM Customers   
FOR XML PATH ('');


SELECT LOWER( (SELECT ',' + CompanyName  
				FROM Customers   
				FOR XML PATH (''))
			);

SELECT STUFF( (SELECT ',' + CompanyName  
				FROM Customers   
				FOR XML PATH ('')),1,1,''
			);

DROP TABLE COUNTRIES

SELECT DISTINCT country
INTO countries
FROM customers


SELECT * FROM COUNTRIES;

SELECT COUNTRY
,STUFF( (SELECT ',' + CompanyName  
				FROM Customers
				WHERE customers.country = countries.Country
				FOR XML PATH ('')),1,1,''
			) AS customers
FROM countries



SELECT DISTINCT categoryid,  STUFF(( SELECT ','+productname 
						FROM Products i 
						WHERE I.CategoryID= O.CategoryID
						FOR XML PATH ('')),1,1,'') PRODUCTS
FROM products o

----STRING_AGG
/*
STRING_AGG function allows sorting concatenated expressions in descending or ascending order

--SYNTAX

STRING_AGG ( expression, separator ) [ &lt;order_clause&gt; ]

*/



SELECT CategoryID, STRING_AGG(productname,',') AS prod_list
FROM Products
GROUP BY categoryid 



SELECT CategoryID, STRING_AGG(productname,',') WITHIN GROUP (ORDER BY PRODUCTNAME ) AS prod_list
FROM Products
GROUP BY categoryid 