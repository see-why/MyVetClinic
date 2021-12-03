/*Queries that provide answers to the questions from all projects.*/

--DAY 1,
-- Find all animals whose name ends in "mon".
SELECT * FROM ANIMALS WHERE NAME LIKE '%mon';
-- List the name of all animals born between 2016 and 2019.
SELECT name FROM ANIMALS WHERE EXTRACT(year FROM date_of_birth) BETWEEN 2016 AND 2019;
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM ANIMALS WHERE neutered = true and escape_attempts < 3;
-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM ANIMALS WHERE name in ('Agumon','Pikachu');
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM ANIMALS WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * FROM ANIMALS WHERE neutered = true;
-- Find all animals not named Gabumon.
SELECT * FROM ANIMALS WHERE name <> 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM ANIMALS WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--DAY 2,
--Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that species columns went back to the state before tranasction.
BEGIN;
UPDATE ANIMALS SET species='unspecified';
SELECT * FROM ANIMALS;
ROLLBACK;
SELECT species from ANIMALS;

--Inside a transaction:
BEGIN;
--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
UPDATE ANIMALS SET species='digimon' WHERE name like '%mon';
--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE ANIMALS SET species='pokemon' WHERE species is null;
--Commit the transaction.
COMMIT;
--Verify that change was made and persists after commit.
SELECT * FROM ANIMALS;

--Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM ANIMALS;
SELECT * FROM ANIMALS;
ROLLBACK;
--after the roll back verify if all records in the animals table still exist.
SELECT * FROM ANIMALS;

--Inside a transaction:
BEGIN;
--Delete all animals born after Jan 1st, 2022.
DELETE FROM ANIMALS WHERE date_of_birth > '01-01-2022';
--Create a savepoint for the transaction.
SAVEPOINT SAVEPOINT_ONE;
--Update all animals' weight to be their weight multiplied by -1.
UPDATE ANIMALS set weight_kg = weight_kg * -1;
--Rollback to the savepoint
ROLLBACK TO SAVEPOINT_ONE;
--Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE ANIMALS set weight_kg = weight_kg * -1 WHERE weight_kg < 0;
--Commit transaction
COMMIT;

--How many animals are there?
SELECT COUNT(*) FROM ANIMALS;
--How many animals have never tried to escape?
SELECT COUNT(*) FROM ANIMALS WHERE escape_attempts = 0;
--What is the average weight of animals?
SELECT COUNT(weight_kg) as Average_Weight FROM ANIMALS;
--Who escapes the most, neutered or not neutered animals?
SELECT neutered, number_of_escapes FROM 
(SELECT neutered, sum(escape_attempts) as number_of_escapes FROM ANIMALS GROUP BY neutered) as Result
WHERE number_of_escapes = (SELECT max(number_of_escapes) FROM 
(SELECT neutered, sum(escape_attempts) as number_of_escapes FROM ANIMALS GROUP BY neutered));
--What is the minimum and maximum weight of each type of animal?
SELECT species, max(weight_kg), min(weight_kg) FROM ANIMALS GROUP BY species;
--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, avg(escape_attempts) FROM ANIMALS
WHERE EXTRACT(year FROM date_of_birth) BETWEEN 1990 AND 2000
GROUP BY species;

--DAY 3,
--Write queries (using JOIN) to answer the following questions:
--What animals belong to Melody Pond?
SELECT * FROM ANIMALS a inner join OWNERS o on a.owner_id = o.id WHERE o.full_name = 'Melody Pond';
--List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM ANIMALS a inner join SPECIES s on a.species_id = s.id WHERE s.name = 'Pokemon';
--List all owners and their animals, remember to include those that don't own any animal.
SELECT * FROM ANIMALS a right join OWNERS o on a.owner_id = o.id;
--How many animals are there per species?
SELECT s.name, count(*) FROM ANIMALS a inner join SPECIES s on a.species_id = s.id
GROUP BY s.name;
--List all Digimon owned by Jennifer Orwell.
SELECT a.name as animal_name,s.name as species,o.full_name as owner FROM ANIMALS a 
inner join OWNERS o on a.owner_id = o.id
inner join SPECIES s on a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' and s.name = 'Digimon';
--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name as animal_name, a.escape_attempts, o.full_name as owner FROM ANIMALS a 
inner join OWNERS o on a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' and a.escape_attempts = 0;
--Who owns the most animals?
SELECT owner, count FROM (
SELECT o.full_name as owner, COUNT(*) FROM ANIMALS a 
inner join OWNERS o on a.owner_id = o.id
GROUP BY o.id
) as Result where count = (SELECT max(count) FROM (
SELECT o.full_name as owner, COUNT(*) as count FROM ANIMALS a 
inner join OWNERS o on a.owner_id = o.id
GROUP BY o.id) as Result);

--DAY 4,
--Who was the last animal seen by William Tatcher?
SELECT * FROM ANIMALS WHERE id in 
(SELECT animals_id FROM VISITS vs inner join VETS ve on vs.vets_id = ve.id 
WHERE ve.name='William Tatcher' order by date_of_visits desc LIMIT 1);
--How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT name) FROM ANIMALS WHERE id in 
(SELECT animals_id FROM VISITS vs inner join VETS ve on vs.vets_id = ve.id WHERE ve.name='Stephanie Mendez');
--List all vets and their specialties, including vets with no specialties.
SELECT v.name,sp.name FROM specializations s full join vets v on s.vets_id = v.id 
full join species sp on s.species_id = sp.id;
--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name,vs.date_of_visits FROM VISITS vs inner join animals a on vs.animals_id = a.id 
inner join VETS ve on vs.vets_id = ve.id 
WHERE ve.name='Stephanie Mendez' and vs.date_of_visits BETWEEN '01-04-2020' and '30-08-2020';
--What animal has the most visits to vets?
SELECT name FROM animals WHERE id in 
(SELECT animals_id FROM (SELECT animals_id, COUNT(*) FROM visits GROUP BY animals_id) as Result 
WHERE count = (SELECT max(COUNT) FROM (SELECT animals_id, COUNT(*) FROM visits GROUP BY animals_id) as Result ) );
--Who was Maisy Smith's first visit?
SELECT name FROM ANIMALS WHERE id in 
(SELECT animals_id FROM VISITS vs inner join VETS ve on vs.vets_id = ve.id
WHERE ve.name='Maisy Smith' ORDER BY vs.date_of_visits ASC Limit 1);
--Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, a.date_of_birth, a.escape_attempts, 
a.neutered, a.weight_kg, ve.name AS vet_name, ve.age, ve.date_of_graduation,
vs.date_of_visits FROM VISITS vs inner join animals a on vs.animals_id = a.id 
inner join VETS ve on vs.vets_id = ve.id 
ORDER BY vs.date_of_visits DESC LIMIT 1;
--How many visits were with a vet that did not specialize in that animal's species?
SELECT count(*) FROM VISITS vs inner join animals a on vs.animals_id = a.id 
inner join VETS ve on vs.vets_id = ve.id 
inner join specializations s on ve.id = s.vets_id
WHERE a.species_id != s.species_id;
--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name,count(*) as count FROM VISITS vs inner join animals a on vs.animals_id = a.id 
inner join VETS ve on vs.vets_id = ve.id 
inner join species s on a.species_id = s.id
GROUP BY s.name,ve.name
HAVING ve.name ='Maisy Smith'
ORDER BY count desc Limit 1;
