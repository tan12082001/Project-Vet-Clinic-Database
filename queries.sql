/*Queries that provide answers to the questions from all projects.*/

/* Project - 1: create animals table */

SELECT *
FROM animals
WHERE name LIKE '%mon';

SELECT name
FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name
FROM animals
WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth
FROM animals
WHERE name IN ('Agumon','Pikachu');

SELECT name, escape_attempts
FROM animals
WHERE weight_kg > 10.5;

SELECT *
FROM animals
WHERE neutered = true;

SELECT *
FROM animals
WHERE name NOT IN ('Gabumon');

SELECT *
FROM animals
WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Project - 2: Update the animals table */

BEGIN;
    UPDATE animals SET species = 'unspecified';
    ROLLBACK;

BEGIN;
    UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
    UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
    SELECT name, species
    FROM animals;
    COMMIT;

BEGIN;
    DELETE FROM animals;
    ROLLBACK;

BEGIN;
    DELETE FROM animals WHERE date_of_birth > '2022-01-01';
    SAVEPOINT SP1;

    UPDATE animals SET weight_kg = weight_kg * (-1);
    ROLLBACK
    TO SP1;

    UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
    COMMIT;
    select *
    from animals;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts)
FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/* Project - 3: Create multiple tables */

-- general checking for owner name allocation

SELECT owners.full_name, animals.name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id;

SELECT owners.full_name, animals.name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT species.name, animals.name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT species.name, COUNT(animals.id)
FROM species
INNER JOIN animals
ON species.id = animals.species_id
GROUP BY species.name;

SELECT owners.full_name, species.name, animals.name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
INNER JOIN species
ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT owners.full_name, animals.name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(owners.full_name) AS animals_count
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY animals_count DESC
LIMIT 1;

/* Project - 4: Add join table for vets and species */

SELECT vets.name AS vet_name, animals.name AS animal_name, species.name AS species_name, visits.date_of_visit
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN species ON animals.species_id = species.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- one way to get the records of Stephanie Mendaz animals

SELECT vets.name AS vet_name, animals.name AS animal_name, species.name AS species_name, visits.date_of_visit
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Stephanie Mendez';

-- to get the count

SELECT vets.name, COUNT(DISTINCT animals.id)
FROM visits
INNER JOIN vets
ON visits.vet_id = vets.id
INNER JOIN animals
ON visits.animal_id = animals.id
GROUP BY vets.name
HAVING vets.name = 'Stephanie Mendez';

SELECT vets.name AS vet_name, species.name AS specialty_name
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.species_id = species.id;

SELECT vets.name AS vet_name, animals.name AS animal_name, species.name AS species_name, visits.date_of_visit
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Stephanie Mendez'AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(visits.animal_id)
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY count DESC
LIMIT 1;

SELECT vets.name, MIN(visits.date_of_visit)
FROM visits
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name;

-- to get the animal name aswell
SELECT vets.name, animals.name, MIN(visits.date_of_visit)
FROM visits
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, animals.name
ORDER BY min
LIMIT 1;

SELECT animals.id, animals.name AS animal_name, weight_kg, neutered, escape_attempts, date_of_birth, vets.id, vets.name AS vet_name, vets.age, visits.date_of_visit AS visit_date
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) AS without_specialization
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations
ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.vet_id IS NULL;

-- to check the current list
SELECT vets.name AS vet_name, animals.name AS animal_name, species.name AS species_name
FROM visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith';

-- to get the species
select vets.name, species.name as specialization, count(species.name)
from visits
INNER JOIN animals ON visits.animal_id = animals.id
INNER JOIN vets ON visits.vet_id = vets.id
INNER JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name, vets.name
ORDER BY count DESC
LIMIT 1;
