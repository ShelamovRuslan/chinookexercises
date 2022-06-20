/*
Task # 2: Query Practice (part 1)

1. Provide a query showing Customers
   (just their full names, customer ID and country)
   who are not in the US.
*/

SELECT c.CustomerId                            AS id,
       CONCAT_WS(' ', c.FirstName, c.LastName) AS full_names,
       c.Country
  FROM customer c
 WHERE c.Country != "USA"

/*
2. Provide a query only showing the Customers from Brazil.
*/

SELECT *
  FROM customer c
 WHERE c.Country = "Brazil"

/*
3.  Provide a query showing the Invoices of customers who are from Brazil.
    The resultant table should show the customer’s full name,
    Invoice ID, Date of the invoice and billing country.
*/

SELECT CONCAT_WS(' ', c.FirstName, c.LastName) AS full_names,
       i.InvoiceId,
       i.InvoiceDate,
       i.BillingCountry
  FROM customer c
       LEFT JOIN invoice i
       ON c.CustomerId = i.CustomerId
 WHERE c.Country = "Brazil"

/*
4.  Provide a query showing only the Employees who are Sales Agents.
*/

SELECT *
  FROM employee e
 WHERE e.Title = "Sales Support Agent"

/*
5.  Provide a query showing a unique list
    of billing countries from the Invoice table.
*/

SELECT DISTINCT i.BillingCountry
  FROM invoice i

/*
6.  Provide a query that shows
    the invoices associated with each sales agent.
    The resultant table should include
    the Sales Agent’s full name.
*/

SELECT CONCAT_WS(' ', e.FirstName, e.LastName) AS full_names,
       i.*
  FROM employee e
       LEFT JOIN customer c
       ON e.EmployeeId = c.SupportRepId
       LEFT JOIN invoice i
       ON c.CustomerId = i.CustomerId
 WHERE e.Title LIKE '%Sales%' '%Agent%'

/*
7.  Provide a query that shows the Invoice Total,
    Customer name, Country and Sale Agent name for all
    invoices and customers.
*/

SELECT i.Total,
       CONCAT_WS(' ', c.FirstName, c.LastName) AS customer_name,
       c.Country,
       CONCAT_WS(' ', e.FirstName, e.LastName) AS sale_agent
  FROM employee e
       LEFT JOIN customer c
       ON e.EmployeeId = c.SupportRepId
       LEFT JOIN invoice i
       ON c.CustomerId = i.CustomerId
 WHERE e.Title LIKE '%Sales%' '%Agent%'

/*
8.  How many Invoices were there in 2009 and 2011?
    What are the respective total sales
    for each of those years?
*/

SELECT YEAR(i.InvoiceDate) AS "year",
       COUNT(i.InvoiceId)  AS invoices_count,
       SUM(i.Total)        AS total_sales
  FROM invoice i
 WHERE YEAR(i.InvoiceDate) IN ('2009', '2011')
 GROUP BY YEAR(i.InvoiceDate)

/*
9.  Looking at the InvoiceLine table,
    provide a query that COUNTs
    the number of line items for Invoice ID 37.
*/

SELECT COUNT(InvoiceLineId) AS items_count
  FROM invoiceline i
 WHERE i.InvoiceId = "37"

/*
10. Looking at the InvoiceLine table,
    provide a query that COUNTs the number
    of line items for each Invoice.
    HINT: GROUP BY
*/

SELECT i.InvoiceId,
       COUNT(InvoiceLineId) AS items_count
  FROM invoiceline i
 GROUP BY i.InvoiceId
