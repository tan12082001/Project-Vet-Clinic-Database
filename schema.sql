/* Database schema to keep the structure of entire database. */

/* Project - 1: create animals table */

CREATE DATABASE vet_clinic

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL,
	PRIMARY KEY(id)
);

/* Project - 2: query and update animals table */

ALTER TABLE animals
ADD species VARCHAR(100);