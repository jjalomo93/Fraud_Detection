# Fraud Detection with SQL

### Database Architecture
---
Below is my ERD structure for the databases created to analyze credit card transaction data.
![ERD](ERD-Image.PNG)

### Data Analysis
#### Part 1:
* Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by cardholders. 

  * How can you isolate (or group) the transactions of each cardholder?

  * Count the transactions that are less than $2.00 per cardholder.

```SQL
CREATE VIEW small_transactions AS
SELECT transaction.id, transaction.date, transaction.amount, transaction.card, credit_card.cardholder_id FROM transaction
INNER JOIN credit_card on transaction.card = credit_card.card
WHERE amount <= 2;

SELECT COUNT(id) AS "number_transactions", cardholder_id FROM small_transactions
GROUP BY cardholder_id;
```

* Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.
    * In my opinion, there is not enough data to determine whether or not the credit card has been hacked. Many people use credit cards for small transactions on a day-to-day basis. In order to determine if there is hacking, there needs to be further analysis into the spending habits based on transaction dates, merchant IDs, etc.

* What are the top 100 highest transactions made between 7:00 am and 9:00 am?

```SQL
CREATE VIEW top_100_transactions AS
SELECT * FROM transaction
WHERE CAST(date AS TIME) BETWEEN '7:00' AND '9:00'
ORDER BY amount DESC
LIMIT 100;

SELECT * FROM top_100_transactions;
```

  * Do you see any anomalous transactions that could be fraudulent?

    * Yes, the top 9 transaction IDs could be fraudulent in this dataset. These values are very high outliers in comparison to the other transations.

  * Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?

  ```SQL
  CREATE VIEW other_100_transactions AS
SELECT * FROM transaction
WHERE CAST(date AS TIME) NOT BETWEEN '7:00' AND '9:00'
ORDER BY amount DESC
LIMIT 100;

SELECT * FROM other_100_transactions;
```
  * Based on analysis of the transactions occurring outside the specific time frame, it seems that there are more higher-risk transactions that fall outside of 7:00 to 9:00. I cannot comment on whether or not this is due to naturally higher spending activity during the day or due to higher fraudulent activity. A more detailed analysis is needed.

  * What are the top 5 merchants prone to being hacked using small transactions?

  ```SQL
CREATE VIEW small_merch_transactions AS
SELECT transaction.id, transaction.date, transaction.amount, transaction.card, credit_card.cardholder_id, transaction.id_merchant, merchant.name FROM transaction
INNER JOIN credit_card on transaction.card = credit_card.card
INNER JOIN merchant on transaction.id_merchant = merchant.id
WHERE amount <= 2;

SELECT COUNT(id) AS "number_transactions", id_merchant, name FROM small_merch_transactions
GROUP BY id_merchant, name
ORDER BY number_transactions DESC
LIMIT 5;
  ```

* The top 5 merchants at highest risk for fraud on small dollar transactions are: Wood-Ramirez, Hood-Phillips, Baker Inc, Atkinson Ltd, and Clark and Sons.


