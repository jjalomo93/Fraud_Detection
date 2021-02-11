---How can you isolate (or group) the transactions of each cardholder?
---Count the transactions that are less than $2.00 per cardholder.
CREATE VIEW small_transactions AS
SELECT transaction.id, transaction.date, transaction.amount, transaction.card, credit_card.cardholder_id FROM transaction
INNER JOIN credit_card on transaction.card = credit_card.card
WHERE amount <= 2;

SELECT COUNT(id) AS "number_transactions", cardholder_id FROM small_transactions
GROUP BY cardholder_id;

---What are the top 100 highest transactions made between 7:00 am and 9:00 am?
CREATE VIEW top_100_transactions AS
SELECT * FROM transaction
WHERE CAST(date AS TIME) BETWEEN '7:00' AND '9:00'
ORDER BY amount DESC
LIMIT 100;

SELECT * FROM top_100_transactions;

---Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
CREATE VIEW other_100_transactions AS
SELECT * FROM transaction
WHERE CAST(date AS TIME) NOT BETWEEN '7:00' AND '9:00'
ORDER BY amount DESC
LIMIT 100;

SELECT * FROM other_100_transactions;

---What are the top 5 merchants prone to being hacked using small transactions?
CREATE VIEW small_merch_transactions AS
SELECT transaction.id, transaction.date, transaction.amount, transaction.card, credit_card.cardholder_id, transaction.id_merchant, merchant.name FROM transaction
INNER JOIN credit_card on transaction.card = credit_card.card
INNER JOIN merchant on transaction.id_merchant = merchant.id
WHERE amount <= 2;

SELECT COUNT(id) AS "number_transactions", id_merchant, name FROM small_merch_transactions
GROUP BY id_merchant, name
ORDER BY number_transactions DESC
LIMIT 5;