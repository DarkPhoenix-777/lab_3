CREATE TABLE hub_patient (
    patient_hk TEXT PRIMARY KEY,
    patient_id INT,
    load_date TIMESTAMP
);

CREATE TABLE hub_doctor (
    doctor_hk TEXT PRIMARY KEY,
    doctor_id INT,
    load_date TIMESTAMP
);

CREATE TABLE hub_visit (
    visit_hk TEXT PRIMARY KEY,
    visit_id INT,
    load_date TIMESTAMP
);

CREATE TABLE hub_diagnosis (
    diagnosis_hk TEXT PRIMARY KEY,
    diagnosis_code TEXT,
    load_date TIMESTAMP
);

CREATE TABLE hub_procedure (
    procedure_hk TEXT PRIMARY KEY,
    procedure_code TEXT,
    load_date TIMESTAMP
);

CREATE TABLE link_visit_patient (
    link_hk TEXT PRIMARY KEY,
    visit_hk TEXT REFERENCES hub_visit,
    patient_hk TEXT REFERENCES hub_patient,
    load_date TIMESTAMP
);

CREATE TABLE link_visit_doctor (
    link_hk TEXT PRIMARY KEY,
    visit_hk TEXT REFERENCES hub_visit,
    doctor_hk TEXT REFERENCES hub_doctor,
    load_date TIMESTAMP
);

CREATE TABLE link_visit_diagnosis (
    link_hk TEXT PRIMARY KEY,
    visit_hk TEXT REFERENCES hub_visit,
    diagnosis_hk TEXT REFERENCES hub_diagnosis,
    load_date TIMESTAMP
);

CREATE TABLE link_visit_procedure (
    link_hk TEXT PRIMARY KEY,
    visit_hk TEXT REFERENCES hub_visit,
    procedure_hk TEXT REFERENCES hub_procedure,
    load_date TIMESTAMP
);

CREATE TABLE sat_patient (
    patient_hk TEXT REFERENCES hub_patient,
    full_name TEXT,
    birth_date DATE,
    gender BOOLEAN,
    load_date TIMESTAMP,
    end_date TIMESTAMP,
    PRIMARY KEY (patient_hk, load_date)
);

CREATE TABLE sat_doctor (
    doctor_hk TEXT REFERENCES hub_doctor,
    full_name TEXT,
    department TEXT,
    load_date TIMESTAMP,
    end_date TIMESTAMP,
    PRIMARY KEY (doctor_hk, load_date)
);

CREATE TABLE sat_visit (
    visit_hk TEXT REFERENCES hub_visit,
    visit_time TIMESTAMP,
    complaint TEXT,
    status TEXT,
    load_date TIMESTAMP,
    end_date TIMESTAMP,
    PRIMARY KEY (visit_hk, load_date)
);

CREATE TABLE sat_diagnosis (
    diagnosis_hk TEXT REFERENCES hub_diagnosis,
    description TEXT,
    load_date TIMESTAMP,
    end_date TIMESTAMP,
    PRIMARY KEY (diagnosis_hk, load_date)
);

CREATE TABLE sat_procedure (
    procedure_hk TEXT REFERENCES hub_procedure,
    name TEXT,
    load_date TIMESTAMP,
    end_date TIMESTAMP,
    PRIMARY KEY (procedure_hk, load_date)
);

CREATE TABLE sat_visit_procedure_details (
    link_hk TEXT REFERENCES link_visit_procedure,
    performed_at TIMESTAMP,
    load_date TIMESTAMP,
    end_date TIMESTAMP,
    PRIMARY KEY (link_hk, load_date)
);