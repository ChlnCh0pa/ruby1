CREATE TABLE IF NOT EXISTS students (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  surname VARCHAR(100) NOT NULL,
  patronymic VARCHAR(100),
  git VARCHAR(255),
  email VARCHAR(255),
  phone VARCHAR(20),
  telegram VARCHAR(50)
);
