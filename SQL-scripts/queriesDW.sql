-- SECTION B --
-- PART A: SHORT ANSWER QUESTIONS --

-- QUESTION 1 --
SELECT
    C.country_iso_code AS "Country ISO Code",
    C.country_name     AS "Country Name",
    SUM(S.amount_sold) AS "SALES"
FROM
         SH.Sales S
    JOIN SH.Customers Q ON S.cust_id = Q.cust_id
    JOIN SH.Countries C ON C.country_id = Q.country_id
GROUP BY
    C.country_name,
    C.country_iso_code
ORDER BY
    SUM(S.amount_sold) DESC
FETCH FIRST 3 ROWS ONLY;


-- QUESTION 2 --
WITH MaxSales AS (
    SELECT
        T.calendar_year,
        P.prod_name,
        SUM(S.quantity_sold) AS TOTAL_QUANTITY,
        ROW_NUMBER()
        OVER(PARTITION BY T.calendar_year
             ORDER BY
                 SUM(S.quantity_sold) DESC
        )                    AS rank
    FROM
             SH.Products P
        JOIN SH.Sales     S ON P.prod_id = S.prod_id
        JOIN SH.Times     T ON S.time_id = T.time_id
        JOIN SH.Customers Q ON Q.cust_id = S.cust_id
        JOIN SH.Countries C ON Q.country_id = C.country_id
    WHERE
        C.country_name = 'United States of America'
    GROUP BY
        T.calendar_year,
        P.prod_name
)
SELECT
    calendar_year,
    prod_name,
    TOTAL_QUANTITY
FROM
    MaxSales
WHERE
    rank = 1
ORDER BY
    calendar_year;



-- QUESTION 3 --
SELECT
    P.prod_id,
    S.channel_id,
    C.channel_desc,
    COUNT(*)             AS num_trans,
    SUM(S.quantity_sold) AS total_quantity
FROM
         SH.Products P
    JOIN SH.Sales    S ON P.prod_id = S.prod_id
    JOIN SH.Times    T ON S.time_id = T.time_id
    JOIN SH.Channels C ON S.channel_id = C.channel_id
WHERE
        T.calendar_year = 2001
    AND P.prod_name = (
        SELECT
            P.prod_name
        FROM
                 SH.Products P
            JOIN SH.Sales S ON P.prod_id = S.prod_id
            JOIN SH.Times T ON S.time_id = T.time_id
        WHERE
            T.calendar_year = 2001
        GROUP BY
            P.prod_name,
            T.calendar_year
        ORDER BY
            SUM(S.amount_sold) DESC
        FETCH FIRST ROW ONLY
    )
GROUP BY
    T.calendar_year,
    P.prod_id,
    S.channel_id,
    C.channel_desc;



-- Question 4 --
SELECT
    C.country_iso_code,
    C.country_name,
    SUM(S.amount_sold) AS "SALE$"
FROM
         SH.Sales S
    JOIN SH.Customers Q ON S.cust_id = Q.cust_id
    JOIN SH.Times     T ON S.time_id = T.time_id
    JOIN SH.Countries C ON Q.country_id = C.country_id
WHERE
    calendar_year = 1998
GROUP BY
    C.country_name,
    T.calendar_year,
    C.country_iso_code
ORDER BY
    SUM(S.amount_sold)
FETCH FIRST 3 ROWS ONLY;



-- QUESTION 5 --
CREATE MATERIALIZED VIEW Promotions_Analysis_mv AS
    SELECT
        R.promo_id,
        P.prod_id,
        SUM(S.amount_sold) AS total_sales
    FROM
             SH.Sales S
        JOIN SH.Promotions R ON S.promo_id = R.promo_id
        JOIN SH.Products   P ON S.prod_id = P.prod_id
    GROUP BY
        R.promo_id,
        P.prod_id;

SELECT
    *
FROM
    Promotions_Analysis_mv;



-- PART B: LONG ANSWER QUESTIONS --

-- QUESTION 6 --
SELECT
    COALESCE(TO_CHAR(promo_id),
             'All Promo IDs')   AS promo_id,
    COALESCE(TO_CHAR(prod_id),
             'All Product IDs') AS prod_id,
    SUM(total_sales)            AS total_sales
FROM
    Promotions_Analysis_mv
GROUP BY
    ROLLUP(promo_id,
           prod_id);



-- QUESTION 7 --
SELECT
    *
FROM
    SH.fweek_pscat_sales_mv;

SELECT
    C.channel_desc,
    SUM(S.Dollars) AS "Sales",
    P.promo_category
FROM
         SH.fweek_pscat_sales_mv S
    JOIN SH.Channels   C ON C.channel_id = S.channel_id
    JOIN SH.Promotions P ON P.promo_id = S.promo_id
GROUP BY
    C.channel_desc,
    P.promo_category
ORDER BY
    SUM(S.DOllars) DESC;