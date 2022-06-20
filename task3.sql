/*
Task # 3: Query Practice (part 2)

1. Provide a query that includes the track name with each invoice line item.
 */

SELECT i.InvoiceLineId AS invoice_line_id,
       t.Name          AS track_name
  FROM track t
       LEFT JOIN invoiceline i
       ON t.TrackId = i.TrackId
 WHERE InvoiceLineId IS NOT NULL

/*
2.  Provide a query that includes
    the purchased track name
    AND artist name with each invoice line item.
 */

SELECT t.Name,
       a.Name
  FROM artist a
       LEFT JOIN album a2
       ON a.ArtistId = a2.ArtistId
       LEFT JOIN track t
       ON a2.AlbumId = t.AlbumId
       LEFT JOIN invoiceline il
       ON t.TrackId = il.TrackId
 WHERE il.InvoiceLineId IS NOT NULL

/*
3.  Provide a query that shows
    the # of invoices per country.
    HINT: GROUP BY
 */

SELECT i.BillingCountry        AS country,
       COUNT(i.BillingCountry) AS invoices
  FROM invoice i
 GROUP BY i.BillingCountry

/*
4.  Provide a query that shows
    the total number of tracks
    in each playlist.
    The Playlist name should be
    included on the resultant table.
 */

SELECT p.Name            AS play_list,
       COUNT(p2.TrackId) AS quantity_tracks
  FROM playlist p
       LEFT JOIN  playlisttrack p2
       ON p.PlaylistId = p2.PlaylistId
 GROUP BY p.PlaylistId
 ORDER BY p.PlaylistId

/*
5.  Provide a query that shows
    all the Tracks, but displays no IDs.
    The resultant table should include
    the Album name, Media type and Genre.
 */

SELECT t.Name  AS track,
       a.Title AS album_name,
       m.Name  AS media_type,
       g.Name  AS genre
  FROM track t
       LEFT JOIN album a
       ON t.AlbumId = a.AlbumId
       LEFT JOIN mediatype m
       ON t.MediaTypeId = m.MediaTypeId
       LEFT JOIN genre g
       ON t.GenreId = t.GenreId


/*
6.  Provide a query that shows all Invoices
    but includes the # of invoice line items.
 */

SELECT COUNT(il.InvoiceLineId) AS count_invoice_item,
       i.*
  FROM invoiceline il
       LEFT JOIN invoice i
       ON il.InvoiceId = i.InvoiceId
 GROUP BY i.InvoiceId

/*
7.  Provide a query that shows
    total sales made by each sales agent.
*/

SELECT e.EmployeeId AS id,
       e.FirstName,
       e.LastName,
       sum(Total)   AS total
  FROM employee e
       LEFT JOIN customer c
       ON e.EmployeeId = c.SupportRepId
       LEFT JOIN invoice i
       ON c.CustomerId = i.CustomerId
 WHERE e.Title LIKE '%Sales%' '%Agent%'
 GROUP BY e.EmployeeId

/*
8. Which sales agent made the most in sales in 2009?
*/

SELECT e.EmployeeId AS id,
       e.FirstName,
       e.LastName,
       sum(Total) AS total
  FROM employee e
       LEFT JOIN customer c
       ON e.EmployeeId = c.SupportRepId
       LEFT JOIN invoice i
       ON c.CustomerId = i.CustomerId
 WHERE e.Title LIKE '%Sales%' '%Agent%'
   AND YEAR(i.InvoiceDate) IN ('2009')
 GROUP BY e.EmployeeId
 ORDER BY  SUM(Total) DESC LIMIT 1

/*
9. Which sales agent made the most in sales in 2010?
*/

SELECT e.EmployeeId AS id,
       e.FirstName,
       e.LastName,
       sum(Total) AS total
  FROM employee e
       LEFT JOIN customer c
       ON e.EmployeeId = c.SupportRepId
       LEFT JOIN invoice i
       ON c.CustomerId = i.CustomerId
 WHERE e.Title LIKE '%Sales%' '%Agent%'
   AND YEAR(i.InvoiceDate) IN ('2010')
 GROUP BY e.EmployeeId
 ORDER BY  SUM(Total) DESC LIMIT 1

/*
10. Which sales agent made the most in sales over all?
*/

SELECT e.EmployeeId AS id,
       e.FirstName,
       e.LastName,
       SUM(Total) AS total
  FROM employee e
       LEFT JOIN customer c
       ON e.EmployeeId = c.SupportRepId
       LEFT JOIN invoice i
       ON c.CustomerId = i.CustomerId
 WHERE e.Title = "Sales Support Agent"
 GROUP BY e.EmployeeId
 ORDER BY SUM(Total) DESC LIMIT 1

