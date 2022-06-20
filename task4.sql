/*
Task # 4: Query Practice (part 3)

1.  Provide a query that shows
    the # of customers assigned to each sales agent.
*/

SELECT e.FirstName,
       e.LastName,
       count(c.SupportRepId) AS count_customers
  FROM customer c
       LEFT JOIN employee e
       ON c.SupportRepId = e.EmployeeId
 GROUP BY c.SupportRepId

/*
2.   Provide a query that shows the total sales per country.
*/

SELECT i.BillingCountry,
       SUM(Total) AS total
  FROM invoice i
 GROUP BY i.BillingCountry

/*
3.   Which country’s customers spent the most?
*/

SELECT i.BillingCountry,
       SUM(i.Total) AS total
  FROM invoice i
 GROUP BY i.BillingCountry
 ORDER BY SUM(i.Total) DESC LIMIT 1

/*
4.  Provide a query that shows the most
    purchased track of 2013.
*/

SELECT t.*
  FROM invoiceline il
       LEFT JOIN invoice i
       ON i.InvoiceId = il.InvoiceId
       LEFT JOIN track t
       ON il.TrackId = t.TrackId
 WHERE YEAR (i.InvoiceDate) IN ('2013')
 GROUP BY il.TrackId
 ORDER BY COUNT(il.TrackId) DESC LIMIT 1

/*
5.  Provide a query that shows
    the top 5 most purchased tracks over all.
*/

SELECT t.Name
  FROM invoiceline il
       LEFT JOIN track t
       ON il.TrackId = t.TrackId
 GROUP BY il.TrackId
 ORDER BY COUNT(il.TrackId) DESC LIMIT 5

/*
6.  Provide a query that shows
    the top 3 best selling artists.
*/

SELECT a2.Name
  FROM invoiceline il
       LEFT JOIN track t
       ON il.TrackId = t.TrackId
       LEFT JOIN album a
       ON t.AlbumId = a.AlbumId
       LEFT JOIN artist a2
       ON a.ArtistId = a2.ArtistId
 GROUP BY a2.ArtistId
 ORDER BY COUNT(InvoiceLineId) DESC LIMIT 3

/*
7.  Provide a query that shows
    the most purchased Media Type.
*/

SELECT m.Name
  FROM invoiceline il
       LEFT JOIN track t
       ON il.TrackId = t.TrackId
       LEFT JOIN mediatype m
       ON t.MediaTypeId = m.MediaTypeId
 GROUP BY m.Name
 ORDER BY COUNT(il.InvoiceLineId) DESC LIMIT 1

