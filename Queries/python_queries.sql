---loading data for card holder 2 and 18 from the database
SELECT credit_card.cardholder_id, transaction.date, transaction.amount  FROM transaction
INNER JOIN credit_card ON transaction.card = credit_card.card
WHERE credit_card.cardholder_id IN ('2','18');

---loading data of daily transactions from jan to jun 2018 for card holder 25
SELECT transaction.date, SUM(transaction.amount) AS "amount" FROM transaction
INNER JOIN credit_card ON transaction.card = credit_card.card
WHERE credit_card.cardholder_id = '25' AND transaction.date >= '01/01/2018' AND transaction.date <= '06/30/2018'
GROUP BY transaction.date
ORDER BY transaction.date;