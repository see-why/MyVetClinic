/* Database schema to keep the structure of entire database. */
--DAY 1,
CREATE DATABASE vet_clinic;

CREATE TABLE animals(
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name          VARCHAR(50),
  date_of_birth DATE,
  escape_attempts           INT,
  neutered    BOOLEAN DEFAULT false,
  weight_kg     DECIMAL
);

--DAY 2,
ALTER TABLE  animals 
ADD COLUMN species VARCHAR(50)

--DAY 3,
CREATE TABLE owners(
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  full_name          VARCHAR(200),
  age           INT
);

CREATE TABLE species(
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name          VARCHAR(50)
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE  animals 
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT Species_ID 
FOREIGN KEY (species_id) 
REFERENCES species (id);

ALTER TABLE  animals 
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT Owners_ID 
FOREIGN KEY (owner_id) 
REFERENCES owners (id);

--DAY 4,
CREATE TABLE vets (
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name          VARCHAR(200),
  age           INT,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  vets_id          INT,
  species_id           INT,

  CONSTRAINT fk_vets_id
      FOREIGN KEY(vets_id) 
	  REFERENCES vets(id),

  CONSTRAINT fk_species_id
      FOREIGN KEY(species_id) 
	  REFERENCES species(id)      
);

CREATE TABLE visits (
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  vets_id          INT,
  animals_id           INT,
  date_of_visits   DATE,

  CONSTRAINT fk_vets_id
      FOREIGN KEY(vets_id) 
	  REFERENCES vets(id),

  CONSTRAINT fk_animals_id
      FOREIGN KEY(animals_id) 
	  REFERENCES animals(id)      
);
