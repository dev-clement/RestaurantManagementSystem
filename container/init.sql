CREATE USER owner WITH PASSWORD 'owner';
CREATE DATABASE restaurant;
GRANT ALL PRIVILEGES ON DATABASE restaurant TO owner;

\connect restaurant;

CREATE TYPE placement AS ENUM ('inside', 'outside');

CREATE TABLE dishes (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20),
    quantity NUMERIC NOT NULL
);

CREATE TABLE menu (
    id SERIAL PRIMARY KEY,
    price INT NOT NULL,
    description VARCHAR(50)
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(20)
);

CREATE TABLE menu_dishes (
    id SERIAL PRIMARY KEY,
    menu_id INT NOT NULL,
    dishes_id INT NOT NULL,
    CONSTRAINT fk_menu FOREIGN KEY (menu_id) REFERENCES menu(id),
    CONSTRAINT fk_dishes FOREIGN KEY (dishes_id) REFERENCES dishes(id)
);

CREATE TABLE users_menu (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    menu_id INT NOT NULL,
    eating placement NOT NULL,
    CONSTRAINT fk_menu FOREIGN KEY (menu_id) REFERENCES menu(id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (first_name, last_name, email) VALUES
('John', 'Doe', 'john.doe@email.com'),
('John', 'Dodo', 'john.dodo@email.com'),
('John', 'John', 'john.john@email.com');

INSERT INTO menu (price, description) VALUES
(150, 'Menu original'),
(150, 'Menu super original'),
(150, 'Menu super de la superberie originale');

INSERT INTO dishes (name, quantity) VALUES
('Poulet', 220),
('Pâtes', 300),
('Riz', 150),
('Ratatouilles', 200);

INSERT INTO users_menu (user_id, menu_id, eating) VALUES
(3, 1, 'inside'),
(3, 3, 'inside'),
(2, 3, 'inside'),
(2, 2, 'outside'),
(3, 1, 'outside'),
(3, 3, 'outside');

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO owner;