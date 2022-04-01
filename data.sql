/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_g) VALUES ('Agumon','2020-02-03',0,true,10.23);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_g) VALUES ('Gabumon','2018-11-15',2,true,8);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_g) VALUES ('Pikachu','2021-01-07',1,false,15.04);
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_g) VALUES ('Devimon','2017-05-12',5,true,11);

-- updated data
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Charmander','2020-02-08', 0, FALSE, -11 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Plantmon','2021-11-15', 2, TRUE, -5.7 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Squirtle','1993-04-02', 3, FALSE, -12.13 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Angemon','2005-06-12', 1, TRUE, -45 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Boarmon','2005-06-07', 7, TRUE, 20.4 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Blossom','1998-10-13', 3, TRUE, 17 );
INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg) VALUES ('Ditto','2022-05-14', 4, TRUE, 22 );

-- owners data
INSERT INTO owners (full_name, age) VALUES 
            ('Sam Smith', 34), 
            ('Jennifer Orwell', 19), 
            ('Bob', 44), 
            ('Melody Pond', 77), 
            ('Dean Winchester', 14), 
            ('Jodie Whittaker', 38)

-- Species data
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- modify animals table
-- If the name ends in "mon" it will be Digimon
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

-- All other animals are Pokemon
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

-- modify animals table with owner id
UPDATE animals SET owner_id = 1 WHERE id = 1;
UPDATE animals SET owner_id = 2 WHERE id = 2 OR id = 3;
UPDATE animals SET owner_id = 3 WHERE id = 4 OR id = 6;
UPDATE animals SET owner_id = 4 WHERE id = 5 OR id = 7 OR id = 10;
UPDATE animals SET owner_id = 5 WHERE id = 8 OR id = 9;