---DROP TABLE credit_card;
---DROP TABLE merchant;
---DROP TABLE transaction;

CREATE TABLE "card_holder" (
	"id" INT NOT NULL PRIMARY KEY,
	"name" VARCHAR NOT NULL
);
---IMPORT DATA USING IMPORT/EXPORT
---SELECT * FROM card_holder;
CREATE TABLE "credit_card" (
	"card" VARCHAR(20) NOT NULL PRIMARY KEY,
	"cardholder_id" INT NOT NULL,
	FOREIGN KEY (cardholder_id) REFERENCES card_holder(id)
);
---IMPORT DATA USING IMPORT/EXPORT
---SELECT * FROM credit_card;
CREATE TABLE "merchant" (
	"id" INT NOT NULL PRIMARY KEY,
	"name" VARCHAR NOT NULL,
	"id_merchant_category" INT NOT NULL,
	FOREIGN KEY (id_merchant_category) REFERENCES merchant_category(id)
);
---IMPORT DATA USING IMPORT/EXPORT
---SELECT * FROM merchant;
CREATE TABLE "merchant_category" (
	"id" INT NOT NULL PRIMARY KEY,
	"name" VARCHAR NOT NULL
);
---IMPORT DATA USING IMPORT/EXPORT
---SELECT * FROM merchant_category;
CREATE TABLE "transaction" (
	"id" INT NOT NULL PRIMARY KEY,
	"date" TIMESTAMP NOT NULL,
	"amount" FLOAT NOT NULL,
	"card" VARCHAR(20) NOT NULL,
	"id_merchant" INT NOT NULL,
	FOREIGN KEY (card) REFERENCES credit_card(card),
	FOREIGN KEY (id_merchant) REFERENCES merchant(id)
);
---IMPORT DATA USING IMPORT/EXPORT
---SELECT * FROM transaction;