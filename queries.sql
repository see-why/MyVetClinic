/*Queries that provide answers to the questions from all projects.*/

DAY 1,
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

DAY 2,
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
