CREATE TABLE discipline (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL, 
    description TEXT
);

CREATE TABLE practical_work (
    id SERIAL PRIMARY KEY,
    discipline_id INT NOT NULL REFERENCES discipline(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,
    practical_work_id INT NOT NULL REFERENCES practical_work(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    estimated_time INTERVAL,
    order_num INT NOT NULL CHECK (order_num > 0)
);

CREATE TABLE task_dependencies (
    id SERIAL PRIMARY KEY,
    task_id INT NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
    depends_on_task_id INT NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
    UNIQUE (task_id, depends_on_task_id)
);

CREATE TABLE student (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE progress (
    id SERIAL PRIMARY KEY,
    student_id INT NOT NULL REFERENCES student(id) ON DELETE CASCADE,
    task_id INT NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL CHECK (status IN ('not started', 'in progress', 'completed')),
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
