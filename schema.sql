/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic

CREATE TABLE animals (
    id              serial PRIMARY KEY,
    name            varchar(100),
    date_of_birth   date,
    escape_attempts INTEGER,
    neutered        boolean,
    weight_g        decimal
);

--Add a column species of type string to your animals table.
ALTER TABLE animals ADD species TEXT;

-- Create a table named owners
CREATE TABLE owners
     (
         id serial PRIMARY KEY,
         full_name TEXT,
         age INTEGER,
     );

-- Create a table named species
CREATE TABLE species
     (
         id serial PRIMARY KEY,
         name TEXT,
    
     );

-- Remove column species
ALTER TABLE animals DROP column species;

-- dd column species_id
ALTER TABLE animals ADD COLUMN species_id INTEGER;

ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id) ON DELETE CASCADE;

-- Add column owner_id 
ALTER TABLE animals ADD COLUMN owner_id INTEGER;

ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id) ON DELETE CASCADE;

-- Create a table named vets
CREATE TABLE vets ( 
        id INTEGER GENERATED ALWAYS AS IDENTITY, 
        name TEXT, 
        age INTEGER, 
        date_of_graduation DATE, 
    PRIMARY KEY(id) 
);

-- Specialization join table 
CREATE TABLE specialization ( 
            id SERIAL PRIMARY KEY, 
            vet_id INTEGER, 
            species_id INTEGER, 
        CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE CASCADE, 
        CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE
    );

-- Visits join table 
CREATE TABLE visits (
            id SERIAL PRIMARY KEY, 
            animal_id INTEGER, 
            vet_id INTEGER, 
            date_of_visit DATE, 
        CONSTRAINT fk_animals FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE, 
        CONSTRAINT fk_vets FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE CASCADE
    );