-- Хабы (ключевые сущности)
CREATE TABLE HubDiscipline (
    discipline_key UUID PRIMARY KEY, 
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL
);

CREATE TABLE HubPracticalWork (
    practical_work_key UUID PRIMARY KEY,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL
);

CREATE TABLE HubTask (
    task_key UUID PRIMARY KEY, 
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL
);

CREATE TABLE HubStudent (
    student_key UUID PRIMARY KEY,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL
);

-- Линки (связи между хабами)
CREATE TABLE LinkDisciplinePracticalWork (
    discipline_key UUID NOT NULL REFERENCES HubDiscipline(discipline_key),
    practical_work_key UUID NOT NULL REFERENCES HubPracticalWork(practical_work_key),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL,
    PRIMARY KEY (discipline_key, practical_work_key)
);

CREATE TABLE LinkPracticalWorkTask (
    practical_work_key UUID NOT NULL REFERENCES HubPracticalWork(practical_work_key),
    task_key UUID NOT NULL REFERENCES HubTask(task_key),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL,
    PRIMARY KEY (practical_work_key, task_key)
);

CREATE TABLE LinkTaskDependencies (
    task_key UUID NOT NULL REFERENCES HubTask(task_key),
    depends_on_task_key UUID NOT NULL REFERENCES HubTask(task_key),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL,
    PRIMARY KEY (task_key, depends_on_task_key)
);

CREATE TABLE LinkTaskStudent (
    task_key UUID NOT NULL REFERENCES HubTask(task_key),
    student_key UUID NOT NULL REFERENCES HubStudent(student_key),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL,
    PRIMARY KEY (task_key, student_key)
);

-- Сателлиты (атрибуты сущностей)
CREATE TABLE SatDiscipline (
    discipline_key UUID NOT NULL REFERENCES HubDiscipline(discipline_key),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL,
    PRIMARY KEY (discipline_key, load_date)
);

CREATE TABLE SatPracticalWork (
    practical_work_key UUID NOT NULL REFERENCES HubPracticalWork(practical_work_key),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL,
    PRIMARY KEY (practical_work_key, load_date)
);

CREATE TABLE SatTask (
    task_key UUID NOT NULL REFERENCES HubTask(task_key),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    estimated_time INTERVAL,
    order_num INT CHECK (order_num > 0),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL,
    PRIMARY KEY (task_key, load_date)
);

CREATE TABLE SatStudent (
    student_key UUID NOT NULL REFERENCES HubStudent(student_key),
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL,
    PRIMARY KEY (student_key, load_date)
);

CREATE TABLE SatProgress (
    task_key UUID NOT NULL REFERENCES HubTask(task_key),
    student_key UUID NOT NULL REFERENCES HubStudent(student_key),
    status VARCHAR(50) NOT NULL CHECK (status IN ('not started', 'in progress', 'completed')),
    updated_at TIMESTAMP NOT NULL,
    load_date TIMESTAMP NOT NULL,
    record_source VARCHAR(255) NOT NULL,
    PRIMARY KEY (task_key, student_key, load_date)
);
