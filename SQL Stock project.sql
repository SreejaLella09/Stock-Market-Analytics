create database stock;

select * from sdtble order by date desc limit 1 ;
select * from stock.sdttble;

use stock;

-- Average Daily Trading Volume :

SELECT Ticker AS "Stock", AVG(Volume) AS "Avg Daily Traded Volume"
FROM sdttble
GROUP BY Ticker
ORDER BY AVG(Volume) desc;

-- Most Volatile Stocks:
SELECT Ticker AS "Stock", ROUND(AVG(Beta), 4) AS "Avg of Beta values"
FROM sdttble
GROUP BY Ticker
ORDER BY AVG(Beta) desc ;

-- Stocks with Highest Dividend and Lowest Dividend:
(
    SELECT Ticker AS "Stock", 
           SUM(`Dividend Amount`) AS "Dividend Amount",
           'Highest' AS "Rank"
    FROM sdttble
    GROUP BY Ticker
    ORDER BY AVG(`Dividend Amount`) DESC
    LIMIT 1
)
UNION ALL
(
    SELECT Ticker AS "Stock", 
           SUM(`Dividend Amount`) AS "Dividend Amount",
           'Lowest' AS "Rank"
    FROM sdttble
    GROUP BY Ticker
    ORDER BY AVG(`Dividend Amount`) ASC
    LIMIT 1
);

-- Highest and Lowest P/E Ratio :

SELECT Ticker AS "Stock", ROUND(AVG(`PE Ratio`), 3) AS "Avg P/E Ratio"
FROM sdttble
GROUP BY Ticker
ORDER BY AVG(`PE Ratio`) DESC;

-- Stocks with Highest Market Cap

SELECT Ticker AS "Stock", 
       CONCAT((ROUND((AVG(`Market Cap`) / 100000000), 1)), " B") AS "Avg Market Capital"
FROM sdttble
GROUP BY Ticker
ORDER BY AVG(`Market Cap`) DESC;

-- Stocks Near 52 Week High/Low:    

SELECT Ticker AS "Stock", 
       ROUND(AVG(`Adjusted Close`), 2) AS "Avg Stock Price",
       MAX(`52 Week High`) AS "52 Week High",
       MIN(`52 Week Low`) AS "52 Week Low",
       ROUND((MAX(`52 Week High`) - AVG(`Adjusted Close`)), 2) AS "Difference"
FROM sdttble
GROUP BY Ticker
ORDER BY Ticker DESC;

-- Stocks with Strong Buy Signals and stocks with Strong Selling Signal:

SELECT TICKER, date, `RSI (14 days)` AS "RSI (14 Days)", MACD,
       (CASE 
           WHEN `RSI (14 days)` <= 45 AND MACD > 0 THEN "BUY"
           WHEN `RSI (14 days)` >= 69 AND MACD < 0 THEN "SELL"
           ELSE "WAIT"
       END) AS "Buy/Wait/Sell"
FROM sdttble;






