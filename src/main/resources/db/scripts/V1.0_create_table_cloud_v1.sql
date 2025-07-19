-- liquibase formatted SQL

-- changeset fabio.reis:1
CREATE TABLE IF NOT EXISTS cloud (
    id BIGINT NOT NULL AUTO_INCREMENT,
    description VARCHAR(30) NOT NULL,
    PRIMARY KEY(id)
);