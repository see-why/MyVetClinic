/* Populate database with sample data. */
DAY 1,
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon','02-03-2020', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Gabumon','15-11-2018', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Pikachu','07-01-2021', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Devimon','12-05-2017', 5, true, 11);

DAY 2,
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Charmander','08-02-2020', 11, false, 0);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Plantmon','15-11-2022', 5.7, true, 2);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Squirtle','02-04-1993', 12.13, false, 3);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Angemon','12-06-2005', 45, true, 1);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Boarmon','07-06-2005', 20.4, true, 7);
INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) 
VALUES ('Blossom','13-10-1998', 17, true, 3);

DAY 3,
INSERT INTO owners (full_name, age) 
VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) 
VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) 
VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) 
VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) 
VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) 
VALUES ('Jodie Whittaker', 38);

INSERT INTO species (name) 
VALUES ('Pokemon');
INSERT INTO species (name)
VALUES ('Digimon');

--Modify your inserted animals so it includes the species_id value
--If the name ends in "mon" it will be Digimon
UPDATE animals set species_id= (SELECT ID FROM species WHERE name='Digimon')
WHERE name like '%mon';
--All other animals are Pokemon
UPDATE animals set species_id= (SELECT ID FROM species WHERE name='Pokemon')
WHERE species_id is null;

--Modify your inserted animals to include owner information (owner_id):
--Sam Smith owns Agumon.
UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Sam Smith')
WHERE name= 'Agumon';
--Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Jennifer Orwell')
WHERE name in ('Gabumon','Pikachu');
--Bob owns Devimon and Plantmon.
UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Bob')
WHERE name in ('Devimon','Plantmon');
--Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Melody Pond')
WHERE name in ('Charmander','Squirtle','Blossom');
--Dean Winchester owns Angemon and Boarmon.
UPDATE animals set owner_id= (SELECT ID FROM owners WHERE full_name='Dean Winchester')
WHERE name in ('Angemon','Boarmon');
