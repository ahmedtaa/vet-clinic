-- setting the species column to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';

-- Verify 
SELECT * FROM animals;

--  roll back 
ROLLBACK;

-- verify 
SELECT * FROM animals;

-- a transcation
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

COMMIT;

-- Verify 
SELECT * FROM animals;


-- Deleting all animals
BEGIN;

DELETE FROM animals;

-- roll back
ROLLBACK;

--verify 
SELECT * FROM animals;

-- a transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022.
DELETE FROM animals WHERE date_of_birth >'2022-01-01';

-- create savepoint
SAVEPOINT save_point1;

--Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;

-- rollback to savepoint
ROLLBACK TO save_point1;

-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;
COMMIT;

