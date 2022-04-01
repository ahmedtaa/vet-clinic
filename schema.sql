/* Database schema to keep the structure of entire database. */
CREATE DATABASE vet_clinic

CREATE TABLE animals (
    id              serial PRIMARY KEY,
    name            varchar(100),
    date_of_birth   date,
    escape_attempts int,
    neutered        boolean,
    weight_g        decimal
);

--Add a column species of type string to your animals table.
ALTER TABLE animals ADD species VARCHAR(250);