DROP DATABASE physics_inventory;

CREATE DATABASE physics_inventory CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE physics_inventory;

CREATE TABLE users (
    username VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password CHAR(64) NOT NULL,
    last_login DATETIME DEFAULT NULL,
    failed_attempts INT NOT NULL DEFAULT 0,
    salt CHAR(15) NOT NULL,
    CONSTRAINT pk_userId PRIMARY KEY (username, email));

CREATE TABLE permissions (
    username VARCHAR(20) NOT NULL,
    permission VARCHAR(255) NOT NULL,
    CONSTRAINT fk_username FOREIGN KEY (username) REFERENCES users(username),
    CONSTRAINT pk_userPermission PRIMARY KEY (username, permission)
);