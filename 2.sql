CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    department_id INT REFERENCES departments(department_id)
);

CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    full_name TEXT NOT NULL,
    birth_date DATE,
    gender BOOLEAN
);

CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL REFERENCES patients(patient_id),
    doctor_id INT REFERENCES doctors(doctor_id),
    visit_time TIMESTAMP NOT NULL,
    complaint TEXT,
    status TEXT
);

CREATE TABLE diagnoses (
    diagnosis_id SERIAL PRIMARY KEY,
    code TEXT NOT NULL,
    description TEXT
);

CREATE TABLE visit_diagnoses (
    visit_id INT REFERENCES visits(visit_id),
    diagnosis_id INT REFERENCES diagnoses(diagnosis_id),
    PRIMARY KEY (visit_id, diagnosis_id)
);

CREATE TABLE procedures (
    procedure_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE visit_procedures (
    visit_id INT REFERENCES visits(visit_id),
    procedure_id INT REFERENCES procedures(procedure_id),
    performed_at TIMESTAMP,
    PRIMARY KEY (visit_id, procedure_id)
);