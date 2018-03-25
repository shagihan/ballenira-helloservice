CREATE DATABASE ballerina_demo;

CREATE TABLE MyGuests (
	id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(30) NOT NULL,
	lastname VARCHAR(30) NOT NULL,
	email VARCHAR(50),
	reg_date TIMESTAMP
);


INSERT INTO MyGuests (firstname, lastname, email) VALUES ('John', 'Doe', 'john@example.com');
INSERT INTO MyGuests (firstname, lastname, email) VALUES ('Alen', 'Bass', 'allen@example.com');
INSERT INTO MyGuests (firstname, lastname, email) VALUES ('Paul', 'Walker', 'paul@example.com');
INSERT INTO MyGuests (firstname, lastname, email) VALUES ('Andrew', 'Nathen', 'andrew@example.com');
INSERT INTO MyGuests (firstname, lastname, email) VALUES ('Smith', 'Williams', 'smith@example.com');
INSERT INTO MyGuests (firstname, lastname, email) VALUES ('David', 'van', 'david@example.com');
