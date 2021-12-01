/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

CREATE TABLE animals(
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name          VARCHAR(50),
  date_of_birth DATE,
  escape_attempts           INT,
  neutered    BOOLEAN DEFAULT false,
  weight_kg     DECIMAL
);

ALTER TABLE  animals 
ADD COLUMN species VARCHAR(50)