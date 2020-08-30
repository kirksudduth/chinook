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

