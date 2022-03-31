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