CREATE DATABASE clinic;

CREATE TABLE patients(
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name          VARCHAR(50),
  date_of_birth DATE
);

CREATE TABLE medical_histories(
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  admitted_at DATE,
  status  VARCHAR(10),
  patient_id INT,

    CONSTRAINT fk_patient_id
      FOREIGN KEY(patient_id) 
	  REFERENCES patients(id)   
);

CREATE TABLE treatments(
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  type          VARCHAR(50),
  name          VARCHAR(50)
);

CREATE TABLE invoices(
  id            INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  type          VARCHAR(50),
  name          VARCHAR(50)
);