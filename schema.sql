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

/* Project - 3: Create multiple tables */

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(100),
	age INT,
	PRIMARY KEY(id)
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	PRIMARY KEY(id)
);

BEGIN;

ALTER TABLE animals DROP COLUMN species;
-- check the DROP
select * from animals;
-- ADD species_id, owner_id
ALTER TABLE animals
ADD COLUMN species_id INT,
ADD COLUMN owner_id INT;
-- ADD foreign constraints
ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY(species_id)
REFERENCES species(id);

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY(owner_id)
REFERENCES owners(id);

COMMIT;

/* Project - 4: Add join table for vets and species */


