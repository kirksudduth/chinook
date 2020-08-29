-- #1 get all customers not from USA;
SELECT
    c.CustomerId as Customer_ID,
    c.FirstName,
    c.LastName,
    c.Country
from Customer c
WHERE c.Country != "USA";