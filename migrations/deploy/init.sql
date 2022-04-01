-- Deploy c_du_props:init to pg

BEGIN;

CREATE TABLE "user" (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  pseudonym TEXT NOT NULL,
  avatar_img TEXT,
  created_at TIMESTAMPTZ NOW(),
  house_id INT REFERENCES house(id) /* a tester avec et sans*/
);

CREATE TABLE "house" ( 
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  password TEXT DEFAULT FLOOR RANDOM()*(9999999) UNIQUE, /* placer unique avant ? */
  created_at TIMESTAMPTZ NOW(),
  user_id REFERENCES user(id) NOT NULL
);

CREATE TABLE "generic_task" (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  value INT NOT NULL,
  created_at TIMESTAMPTZ NOW()
);


CREATE TABLE "house_task" (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  value INT NOT NULL,
  created_at TIMESTAMPTZ NOW(),
  house_id INT REFERENCES house(id) NOT NULL
);

CREATE TABLE "done_task" (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT NOT NULL,
  value INT NOT NULL,
  created_at TIMESTAMPTZ NOW(),
  house_id INT REFERENCES house(id) NOT NULL, 
  user_id INT REFERENCES user(id) NOT NULL 
);

CREATE TABLE "reward" (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  reward TEXT DEFAULT NULL,
  title TEXT DEFAULT NULL,
  created_at TIMESTAMPTZ NOW(),
  house_id INT REFERENCES house(id) NOT NULL
);

CREATE TABLE "attributed_task" (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  user_id INT REFERENCES user(id),
  house_id INT REFERENCES house(id)
);

COMMIT;