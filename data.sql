/* Populate database with sample data. */
--DAY 1,
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon','02-03-2020', 0, true, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Gabumon','15-11-2018', 2, true, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Pikachu','07-01-2021', 1, false, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Devimon','12-05-2017', 5, true, 11);

--DAY 2,
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

--DAY 3,
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

--DAY 4,
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('William Tatcher', 45, '23-04-2000');
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Maisy Smith', 26, '17-01-2019');
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Stephanie Mendez', 64, '04-05-1981');
INSERT INTO vets (name, age, date_of_graduation) 
VALUES ('Jack Harkness', 38, '08-06-2008');

INSERT INTO specializations (vets_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name='William Tatcher'), (SELECT id FROM species WHERE name='Pokemon'));
INSERT INTO specializations (vets_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Pokemon'));
INSERT INTO specializations (vets_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name='Stephanie Mendez'), (SELECT id FROM species WHERE name='Digimon'));
INSERT INTO specializations (vets_id, species_id) 
VALUES ((SELECT id FROM vets WHERE name='Jack Harkness'), (SELECT id FROM species WHERE name='Digimon'));

INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Agumon'), (SELECT id FROM vets WHERE name='William Tatcher'), '24-05-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Agumon'), (SELECT id FROM vets WHERE name='Stephanie Mendez'), '22-07-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Gabumon'), (SELECT id FROM vets WHERE name='Jack Harkness'), '02-02-2021');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Pikachu'), (SELECT id FROM vets WHERE name='Maisy Smith'), '05-01-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Pikachu'), (SELECT id FROM vets WHERE name='Maisy Smith'), '08-03-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Pikachu'), (SELECT id FROM vets WHERE name='Maisy Smith'), '14-05-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Devimon'), (SELECT id FROM vets WHERE name='Stephanie Mendez'), '04-05-2021');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Charmander'), (SELECT id FROM vets WHERE name='Jack Harkness'), '24-02-2021');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Plantmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '21-12-2019');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Plantmon'), (SELECT id FROM vets WHERE name='William Tatcher'), '10-08-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Plantmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '07-04-2021');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Squirtle'), (SELECT id FROM vets WHERE name='Stephanie Mendez'), '29-09-2019');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Angemon'), (SELECT id FROM vets WHERE name='Jack Harkness'), '03-10-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Angemon'), (SELECT id FROM vets WHERE name='Jack Harkness'), '04-11-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '24-01-2019');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '15-05-2019');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '27-02-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Boarmon'), (SELECT id FROM vets WHERE name='Maisy Smith'), '03-08-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Blossom'), (SELECT id FROM vets WHERE name='Stephanie Mendez'), '24-05-2020');
INSERT INTO visits (animals_id, vets_id, date_of_visits) 
VALUES ((SELECT id FROM animals WHERE name='Blossom'), (SELECT id FROM vets WHERE name='William Tatcher'), '11-01-2021');
