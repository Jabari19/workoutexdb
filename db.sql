-- Drop and recreate the WorkoutDB database
DROP DATABASE IF EXISTS WorkoutDB;
CREATE DATABASE WorkoutDB;
USE WorkoutDB;

-- Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    age INT
);

-- Exercises table
CREATE TABLE Exercises (
    exercise_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    category VARCHAR(50)
);

-- Workouts table
CREATE TABLE Workouts (
    workout_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    trainer_id INT, -- Added trainer_id column
    date DATETIME,
    duration INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id) -- Added foreign key for trainers
);

-- Workout_Exercises table
CREATE TABLE Workout_Exercises (
    workout_exercise_id INT PRIMARY KEY AUTO_INCREMENT,
    workout_id INT,
    exercise_id INT,
    sets INT,
    reps INT,
    FOREIGN KEY (workout_id) REFERENCES Workouts(workout_id),
    FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
);

-- Nutrition table
CREATE TABLE Nutrition (
    nutrition_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    meal VARCHAR(100),
    calories INT,
    protein INT,
    fat INT,
    carbs INT,
    date DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Equipment table
CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    type VARCHAR(50)
);

-- Goals table
CREATE TABLE Goals (
    goal_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    goal_description TEXT,
    target_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Trainers table
CREATE TABLE Trainers (
    trainer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    certification VARCHAR(100)
);

-- Insert sample data into Users
INSERT INTO Users (first_name, last_name, email, age) VALUES 
('Alice', 'Smith', 'alice@example.com', 25),
('Bob', 'Johnson', 'bob@example.com', 30);

-- Insert sample data into Exercises
INSERT INTO Exercises (name, description, category) VALUES
('Push Up', 'A basic strength exercise targeting the chest.', 'Strength'),
('Running', 'A cardio exercise involving running.', 'Cardio'),
('Squat', 'A lower body strength exercise.', 'Strength');

-- Insert sample data into Workouts
INSERT INTO Workouts (user_id, trainer_id, date, duration) VALUES
(1, 1, '2024-09-24 10:00:00', 30), -- Assigned trainer_id = 1
(2, 2, '2024-09-24 11:00:00', 45); -- Assigned trainer_id = 2

-- Insert sample data into Workout_Exercises
INSERT INTO Workout_Exercises (workout_id, exercise_id, sets, reps) VALUES
(1, 1, 3, 10),
(1, 3, 3, 15),
(2, 2, 1, 30);

-- Insert sample data into Nutrition
INSERT INTO Nutrition (user_id, meal, calories, protein, fat, carbs, date) VALUES
(1, 'Chicken Salad', 400, 30, 15, 35, '2024-09-24 12:30:00'),
(2, 'Protein Shake', 250, 20, 5, 30, '2024-09-24 08:30:00');

-- Insert sample data into Equipment
INSERT INTO Equipment (name, description, type) VALUES
('Treadmill', 'Cardio equipment used for running.', 'Cardio'),
('Dumbbell', 'Strength training equipment for resistance exercises.', 'Strength');

-- Insert sample data into Goals
INSERT INTO Goals (user_id, goal_description, target_date) VALUES
(1, 'Run 5K in under 30 minutes', '2024-12-31'),
(2, 'Bench press 200 lbs', '2024-10-31');

-- Insert sample data into Trainers
INSERT INTO Trainers (first_name, last_name, certification) VALUES
('John', 'Doe', 'Certified Personal Trainer'),
('Jane', 'Doe', 'Certified Strength and Conditioning Specialist');

-- 3 to 5 useful SELECT statements:

-- 1. Retrieve all users and their associated workouts
SELECT U.first_name, U.last_name, W.date, W.duration
FROM Users U
JOIN Workouts W ON U.user_id = W.user_id;

-- 2. View exercises performed in a specific workout (for example workout_id = 1)
SELECT E.name AS exercise, WE.sets, WE.reps
FROM Workout_Exercises WE
JOIN Exercises E ON WE.exercise_id = E.exercise_id
WHERE WE.workout_id = 1;

-- 3. Get nutrition details for a specific user (for example user_id = 1)
SELECT meal, calories, protein, fat, carbs, date
FROM Nutrition
WHERE user_id = 1;

-- 4. List goals for each user
SELECT U.first_name, U.last_name, G.goal_description, G.target_date
FROM Users U
JOIN Goals G ON U.user_id = G.user_id;

-- 5. Show all users who worked with a specific trainer (example trainer_id = 1)
SELECT T.first_name AS trainer_first_name, T.last_name AS trainer_last_name, U.first_name AS user_first_name, U.last_name AS user_last_name
FROM Trainers T
JOIN Workouts W ON T.trainer_id = W.trainer_id
JOIN Users U ON W.user_id = U.user_id
WHERE T.trainer_id = 1;
