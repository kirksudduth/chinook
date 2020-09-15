-- #1 get all customers not from USA;
SELECT
    c.CustomerId as Customer_ID,
    c.FirstName,
    c.LastName,
    c.Country
from Customer c
WHERE c.Country != "USA";

-- #2 Get all Brazilian customers
SELECT
    c.CustomerId as Customer_ID,
    c.FirstName,
    c.LastName,
    c.Country
from Customer c
WHERE c.Country = "Brazil";

-- #3 Get all Brazilian customers with their invoices
SELECT
    c.CustomerId as Customer_ID,
    c.FirstName,
    c.LastName,
    i.InvoiceID,
    i.InvoiceDate,
    i.BillingCountry
from Customer c
    join Invoice i on c.CustomerId = i.CustomerId
WHERE i.BillingCountry = "Brazil"
ORDER BY c.LastName;

-- #4 get all employees who are sales agents
SELECT *
FROM Employee e
WHERE e.Title = 'Sales Support Agent';

-- #5 show list of all billing countries from invoice TABLE
SELECT DISTINCT
    i.BillingCountry
FROM Invoice i
ORDER BY i.BillingCountry;

-- #6 show invoices associated with each sales agent
SELECT
    e.FirstName,
    e.LastName,
    i.InvoiceId
FROM Employee e
    JOIN Customer c ON c.SupportRepId = e.EmployeeId
    JOIN Invoice i ON i.CustomerId = c.CustomerId
ORDER BY i.InvoiceId;

-- #7 show invoice total, Customer name, country and sale agent
SELECT
    c.FirstName Customer_FirstName,
    c.LastName Customer_LastName,
    i.BillingCountry,
    i.Total,
    e.FirstName Employee_FirstName,
    e.LastName Employee_LastName
FROM Customer c
    JOIN Invoice i ON i.CustomerId = c.CustomerId
    JOIN Employee e ON e.EmployeeId = c.SupportRepId
ORDER BY Customer_LastName;

-- #8 how many invoices in 2009 and 2011?
SELECT COUNT (i.InvoiceDate)
FROM Invoice i
WHERE i.InvoiceDate
LIKE "%2009%" OR
    i.InvoiceDate LIKE "%2011%";

-- #9 Total sales for both years
    SELECT SUM (i.Total) AS "Totals 2009/2011   "
    FROM Invoice i
    WHERE i.InvoiceDate LIKE "%2009%"
UNION ALL
    SELECT SUM (i.Total)
    FROM Invoice i
    WHERE i.InvoiceDate LIKE "%2011%";

-- #10 Count number of LineItems for InvoiceId 37
SELECT COUNT (InvoiceId)
FROM InvoiceLine iL
WHERE iL.InvoiceId = 37;

--  #11 count for each invoice for line items
SELECT i.InvoiceId, COUNT
(iL.InvoiceLineId) AS "Line Items"
FROM Invoice i
    JOIN InvoiceLine iL ON iL.InvoiceId = i.InvoiceId
GROUP BY i.InvoiceId;

--  #12 Get Track Name for every purchased Line Item in QUERY
SELECT
    iL.InvoiceLineId,
    t.Name "Track Name"
FROM InvoiceLine iL
    JOIN Track t ON t.TrackId = iL.TrackId
ORDER BY iL.InvoiceLineId;

-- #13 Get Track Name and Artist Name for every line item
SELECT
    iL.InvoiceLineId,
    t.Name "Track Name",
    art.Name "Artist Name"
FROM InvoiceLine iL
    JOIN Track t ON t.TrackId = iL.TrackId
    JOIN Album a ON a.AlbumId = t.AlbumId
    JOIN Artist art ON art.ArtistId = a.ArtistId
ORDER BY iL.InvoiceLineId;

-- #14 Number of invoices per country
SELECT i.BillingCountry, COUNT (i.InvoiceId)
FROM Invoice i
GROUP BY i.BillingCountry
ORDER BY COUNT (i.InvoiceId)
DESC;

-- #15 shows total number of tracks in playlist with playlist name
SELECT
    p.PlaylistId,
    p.Name,
    COUNT(t.TrackId) "# of Tracks"
FROM Playlist p
    JOIN PlaylistTrack pt ON pt.PlaylistId = p.PlaylistId
    JOIN Track t ON t.TrackId = pt.TrackId
GROUP BY p.PlaylistId
ORDER BY COUNT
(t.TrackId) DESC;

-- #16 all tracks but no id ||  Genre, Album Name, MediaType
SELECT
    t.Name Track,
    g.Name Genre,
    al.Title "Album Title",
    mt.Name "Media Type"
FROM Track t
    JOIN Genre g ON g.GenreId = t.GenreId
    JOIN Album al ON al.AlbumId = t.AlbumId
    JOIN MediaType mt ON mt.MediaTypeId = t.MediaTypeid;

-- #17 Get invoices with Line items included
SELECT *, COUNT
(iL.InvoiceLineId) "Line Items"
FROM Invoice i
    JOIN InvoiceLine iL ON iL.InvoiceId = i.InvoiceId
GROUP BY i.InvoiceId;

-- #18 Total sales by each sales agent
SELECT
    e.FirstName,
    e.LastName,
    SUM(i.Total) "Total Sales"
FROM Employee e
    JOIN Customer c ON c.SupportRepId = e.EmployeeId
    JOIN Invoice i ON i.CustomerId = c.CustomerId
GROUP BY e.EmployeeId
ORDER BY "Total Sales" DESC;

-- #19 most Sales in 2009
SELECT
    e.FirstName,
    e.LastName,
    SUM(i.Total) Total
FROM Employee e
    JOIN Customer c ON c.SupportRepId = e.EmployeeId
    JOIN Invoice i ON i.CustomerId = c.CustomerId
WHERE Total = (SELECT MAX(Total)
FROM Invoice)
GROUP BY e.EmployeeId;
