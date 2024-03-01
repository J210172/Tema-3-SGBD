DROP DATABASE IF EXISTS broker;

CREATE DATABASE broker;

USE broker;

CREATE OR REPLACE TABLE ticker (
    id VARCHAR(16) NOT NULL PRIMARY KEY,
    name VARCHAR(64)
);

CREATE OR REPLACE TABLE client (
    id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    name VARCHAR(64) NOT NULL
);

CREATE OR REPLACE TABLE account (
    id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    client_id BIGINT UNSIGNED NOT NULL
);

CREATE OR REPLACE TABLE operation (
    id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
    operation_date DATETIME NOT NULL,
    quantity INT NOT NULL,
    ticker_id VARCHAR(16) NOT NULL,
    account_id BIGINT UNSIGNED NOT NULL
);

CREATE OR REPLACE TABLE a_has_t (
    quantity INT NOT NULL,
    ticker_id VARCHAR(16) NOT NULL,
    account_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY(ticker_id, account_id)
);

ALTER TABLE operation ADD CONSTRAINT fk_ot_1 FOREIGN KEY (ticker_id) REFERENCES ticker(id);
ALTER TABLE operation ADD CONSTRAINT fk_ot_2 FOREIGN KEY (account_id) REFERENCES account(id);
ALTER TABLE account ADD CONSTRAINT fk_ac_1 FOREIGN KEY (client_id) REFERENCES client(id);
ALTER TABLE a_has_t ADD CONSTRAINT fk_at_1 FOREIGN KEY (ticker_id) REFERENCES ticker(id);
ALTER TABLE a_has_t ADD CONSTRAINT fk_at_2 FOREIGN KEY (account_id) REFERENCES account(id);

INSERT INTO client VALUES (1, 'Neils');
INSERT INTO client VALUES (2, 'Ralph');
INSERT INTO client VALUES (3, 'Victoria');
INSERT INTO client VALUES (4, 'Edgar');
INSERT INTO client VALUES (5, 'Sonya');

INSERT INTO account VALUES (1, 5);
INSERT INTO account VALUES (2, 5);
INSERT INTO account VALUES (3, 1);
INSERT INTO account VALUES (4, 2);

INSERT INTO ticker VALUES ('AAPL', 'Apple Inc');
INSERT INTO ticker VALUES ('GOOGL', 'Alphabet Inc Class A');
INSERT INTO ticker VALUES ('META', 'Meta Platforms Inc');
INSERT INTO ticker VALUES ('AMZN', 'Amazon.com Inc');
INSERT INTO ticker VALUES ('GM', NULL);
INSERT INTO ticker VALUES ('PG', 'Procter & Gamble Company');

INSERT INTO operation VALUES (1, '2024-02-04 15:40:28', 250, 'AAPL', 1);
INSERT INTO operation VALUES (2, '2024-02-13 14:21:36', -100, 'AAPL', 1);
INSERT INTO operation VALUES (3, '2024-02-14 16:48:21', 520, 'GOOGL', 1);
INSERT INTO operation VALUES (4, '2024-02-14 17:02:20', 320, 'PG', 3);
INSERT INTO operation VALUES (5, '2024-02-15 09:57:51', 150, 'META', 3);
INSERT INTO operation VALUES (6, '2024-02-16 11:58:31', 210, 'META', 2);

INSERT INTO a_has_t VALUES ( 150, 'AAPL', 1);
INSERT INTO a_has_t VALUES ( 520, 'GOOGL', 1);
INSERT INTO a_has_t VALUES ( 210, 'META', 2);
INSERT INTO a_has_t VALUES ( 320, 'PG', 3);
INSERT INTO a_has_t VALUES ( 150, 'META', 3);
