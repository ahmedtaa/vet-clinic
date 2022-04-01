/* animals whose name ends in "mon". */

SELECT * from animals WHERE name LIKE '%mon';

-- name of all animals born between 2016 and 2019.

SELECT name from animals WHERE date_of_birth '2016-01-01' AND '2019-12-31'

-- name of all animals that are neutered and have less than 3 escape attempts.

SELECT name from animals WHERE neutered AND escape_attempts < 3

--  date of birth of all animals named either "Agumon" or "Pikachu".

SELECT name from animals WHERE name = 'Agumon' OR name = 'Pikachu'

--  name and escape attempts of animals that weigh more than 10.5kg

SELECT name,escape_attempts from animals WHERE weight_g > 10.5

-- all animals that are neutered.

SELECT * from animals WHERE neutered

-- all animals not named Gabumon.

SELECT * from animals WHERE name != 'Gabumon'

-- all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)

SELECT * from animals WHERE weight_g >= 10.4 AND weight_g <= 17.3

-- update quaries

-- How many animals are there?
SELECT count(*) from animals;

-- How many animals have never tried to escape?
SELECT count(*) from animals where escape_attempts = 0;

-- What is the average weight of animals?
SELECT avg(weight_kg) from animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species,min(weight_kg), max(weight_kg) FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' And '2000-12-31' GROUP BY species;

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

/* What was the last animal seen by william tacher? */
    SELECT visits.animals_id, 
           animals.name as AnimalName, 
           vets.name as VetName, 
           visits.date_of_visit, 
           species.name as SpecieName 
    FROM visits 
        JOIN animals ON visits.animals_id = animals.id 
        JOIN vets ON visits.vets_id = vets.id 
        JOIN species ON animals.species_id = species.id 
    WHERE vets.name LIKE '%William Tatcher%' 
    ORDER BY visits.date_of_visit DESC LIMIT 1;
/* END */

/* How many different animals did Stephanie Mendes see */
    SELECT 
        COUNT(DISTINCT visits.animals_id) as animalsCount 
    FROM visits 
    JOIN vets ON visits.vets_id = vets.id   
         AND vets.name LIKE '%Stephanie Mendez%';
/* END */

/* List all vets and their specialties, including vets with no specialties */
    SELECT 
        vets.name as VetsName, 
        vets.age, 
        vets.date_of_graduation, 
        species.name as Specialization 
    FROM vets 
    LEFT JOIN specialization ON vets.id = specialization.vet_id 
    LEFT JOIN species ON specialization.species_id = species.id;
/* END */

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */
   SELECT 
        animals.name as Animal, 
        vets.name, 
        visits.date_of_visit 
    FROM animals 
        JOIN visits ON animals.id = visits.animals_id 
        JOIN vets ON visits.vets_id = vets.id 
            AND vets.name LIKE '%Stephanie Mendez%'
    WHERE visits.date_of_visit 
        BETWEEN '2020-04-01' 
            AND '2020-08-30';
/* END */

/* What animal has the most visits to vets */
    SELECT animals.name, COUNT(visits.animals_id) 
        FROM visits 
        JOIN animals ON visits.animals_id = animals.id 
        GROUP BY visits.animals_id, animals.name
        ORDER BY count DESC
        LIMIT 1; 
/* END */

/* Who was Maisy Smith's first visit? */
    SELECT 
        animals.name, visits.date_of_visit 
    FROM visits 
    JOIN animals ON visits.animals_id = animals.id 
    WHERE vets_id = 2 
    ORDER BY date_of_visit 
    ASC LIMIT 1;
/* END */

/* Get details for the most recent visit */

SELECT 
    animals.name as AnimalName, 
    animals.date_of_birth, 
    animals.escape_attempts, 
    animals.neutered, 
    animals.weight_kg, 
    species.name as SpecieType, 
    owners.full_name as OwnersName, 
    vets.name as VetsName, 
    vets.age as VetsAge, 
    vets.date_of_graduation, 
    visits.date_of_visit 
FROM animals 
JOIN 
    species ON animals.species_id = species.id 
JOIN 
    owners ON animals.owner_id = owners.id 
JOIN 
    visits ON animals.id = visits.animals_id 
JOIN 
    vets ON visits.vets_id = vets.id 
ORDER BY 
    visits.date_of_visit 
DESC 
LIMIT 1;  

/* END */

/* How many visits were with a vet that did not specialize in that animal's species? */

    SELECT 
        COUNT(vets.id) 
    from visits 
    JOIN animals ON visits.animals_id = animals.id  
    JOIN vets ON visits.vets_id = vets.id 
    JOIN specialization ON vets.id = specialization.vet_id 
    WHERE animals.species_id != specialization.id;

/* END */

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */
    SELECT 
        COUNT(species.id) as VisitCount, 
        species.name 
    FROM visits 
    JOIN 
        animals ON visits.animals_id = animals.id 
    JOIN 
        species ON animals.species_id = species.id 
    JOIN 
        vets ON visits.vets_id = vets.id 
    WHERE 
        vets.name LIKE '%Maisy Smith%' 
    GROUP BY species.id 
    ORDER BY VisitCount DESC 
    LIMIT 1;
/* END */