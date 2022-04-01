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

-- Verify 
SELECT * FROM animals;

COMMIT;

-- Deleting all animals
BEGIN;

DELETE FROM animals;

-- Verify 
SELECT * FROM animals;

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
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;


/* What animals belong to melody pond ? */
    SELECT animals.name as animals_name, 
        owners.full_name as owners_name 
    FROM animals 
    JOIN 
        owners 
    ON 
        animals.owner_id = owners.id 
    WHERE 
        owners.full_name 
    LIKE 
        '%Melody Pond%';
/* End */

/* List of all animals that are pokemon ? */
    SELECT animals.name as Animal_Name, 
        species.name as Specie 
    FROM animals 
    JOIN 
        species 
    ON 
        animals.species_id = species.id 
    WHERE 
        species.id = 1;
/* End */

/* List all owners and there animals */
    SELECT 
        owners.full_name as Owner, 
        animals.name as AnimalsName 
    FROM animals 
    RIGHT JOIN 
        owners 
    ON animals.owner_id = owners.id;
/* End */

/* How many animals are there per species? */
    SELECT 
        Count(animals.id) as AnimalCount, 
        species.name from animals 
    JOIN species 
    ON 
        animals.species_id = species.id 
    GROUP BY species.id;
/* END */

/* List all digimon owned by Jennifer Orwell */
 SELECT animals.name as AnimalName, 
        owners.full_name as Owner, 
        species.name as Specie 
 FROM animals 
 JOIN 
    owners ON animals.owner_id = owners.id AND owners.full_name LIKE '%Jennifer Orwell%' 
 JOIN 
    species ON animals.species_id = species.id AND species.name LIKE '%Digimon%';
/* END */

/* List all animals owned by Dean Winchester that havent tried to escape */
  SELECT animals.name as AnimalName, 
        owners.full_name as Owner 
  FROM animals 
  LEFT JOIN 
    owners ON animals.owner_id = owners.id 
  WHERE animals.owner_id = 5 
  AND animals.escape_attempts = 0;
/* END */

/* Who owns the most animals? */
  SELECT owners.id as OwnerId, 
         owners.full_name, 
        Count(animals.owner_id) as numOwned 
  FROM animals 
  JOIN owners 
  ON 
    animals.owner_id = owners.id 
  GROUP BY owners.id 
  Order BY numOwned DESC 
  LIMIT 1;
/* END */
