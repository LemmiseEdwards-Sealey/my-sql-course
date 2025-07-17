-- standard select / where / order by
SELECT
    ps.PatientId
    , ps.Hospital
    , PS.Ward
    , ps.AdmittedDate
    , ps.DischargeDate
    , DATEDIFF(DAY, ps.AdmittedDate, ps.DischargeDate) AS LengthOfStay
    , DATEADD(WEEK, 2, ps.AdmittedDate) AS ReminderDate
    , ps.Tariff
FROM PatientStay ps
WHERE ps.Hospital IN ('Kingston', 'PRUH')
AND ps.Ward LIKE '%Surgery'
AND ps.AdmittedDate BETWEEN '2024-02-27' AND '2024-03-01'
AND ps.Tariff > 5
ORDER BY
    ps.AdmittedDate DESC,
    ps.PatientId DESC
 SELECT
    ps.PatientId
    ,ps.AdmittedDate
    , ps.Hospital
    ,h.Hospital
    ,h.HospitalSize
FROM PatientStay ps LEFT JOIN DimHospitalBad h ON ps.Hospital = h.Hospital
SELECT
    p.PropertyType
    ,COUNT(*) AS NumberOfSales
FROM
    PricePaidSW12 p
GROUP BY p.PropertyType
ORDER BY NumberOfSales DESC;
SELECT
    YEAR(p.TransactionDate) AS TheYear
    ,COUNT(*) AS NumberOfSales
    , SUM(p.Price) /1000000.0 As MarketValue
FROM
    PricePaidSW12 p
GROUP BY YEAR(p.TransactionDate)
ORDER BY TheYear;
 SELECT
    p.TransactionDate
    ,p.Price
    ,p.Street
    ,p.County
FROM
    PricePaidSW12 p
WHERE
    p.Street in ('Cambray Road','Midmoor Road')
    AND p.Price BETWEEN 400000 and 500000
    AND p.TransactionDate BETWEEN '2018-01-01' AND '2018-12-31'
ORDER BY p.TransactionDate;

Select top 25
P.TransactionDate
,p.price
,p.postcode
,p.paon
from pricepaidsw12 as p
where p.street ='ormeley Road'
order by p.transactiondate

Select* from PropertyTypeLookup

SELECT
    TOP 25
    p.TransactionDate
    ,p.Price
    ,p.PostCode
    ,p.PAON
    , p.PropertyType
    ,case
    when p.PropertyType = 'T' then 'Terraced'
    when p.PropertyType = 'F' then 'Flat'
    else'unknown'
    End as propertytypename,
FROM
    PricePaidSW12 AS p left join PropertyTypeLookup as pt on p.PropertyType = pt.PropertyTypeCode
    WHERE Street = 'Ormeley Road'
ORDER BY TransactionDate DESC

SELECT
    TOP 25
    p.TransactionDate
    ,p.Price
    ,p.PostCode
    ,p.PAON
    , p.PropertyType
    , CASE p.PropertyType  -- simple
        WHEN 'F' THEN 'Flat'
        WHEN 'T' THEN 'Terraced'
        ELSE 'Unknown'
    END AS PropertyTypeNameSimple
    , CASE -- Searched
        WHEN p.PropertyType IN ('D', 'S', 'T') THEN 'Freehold'
        ELSE 'leasohold'
    END AS PropertyDuration
FROM
    PricePaidSW12 AS p
WHERE Street = 'Ormeley Road'  -- a very nice street in Balham
ORDER BY TransactionDate DESC
