-- Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS WorkoutDB;
CREATE DATABASE WorkoutDB;
USE WorkoutDB;

-- Create the Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    age INT
);

-- Create the Trainers table (this was causing issues because it was referenced before creation)
CREATE TABLE Trainers (
    trainer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    certification VARCHAR(100)
);

-- Create the Exercises table
CREATE TABLE Exercises (
    exercise_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    category VARCHAR(50)
);

-- Create the Workouts table with foreign key references to Users and Trainers
CREATE TABLE Workouts (
    workout_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    trainer_id INT, -- Added trainer_id column
    date DATETIME,
    duration INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id) -- Added foreign key for trainers
);

-- Create the Workout_Exercises table with foreign key references to Workouts and Exercises
CREATE TABLE Workout_Exercises (
    workout_exercise_id INT PRIMARY KEY AUTO_INCREMENT,
    workout_id INT,
    exercise_id INT,
    sets INT,
    reps INT,
    FOREIGN KEY (workout_id) REFERENCES Workouts(workout_id),
    FOREIGN KEY (exercise_id) REFERENCES Exercises(exercise_id)
);

-- Create the Nutrition table
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

-- Create the Equipment table
CREATE TABLE Equipment (
    equipment_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    description TEXT,
    type VARCHAR(50)
);

-- Create the Goals table with a foreign key reference to Users
CREATE TABLE Goals (
    goal_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    goal_description TEXT,
    target_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Insert data into Users table
INSERT INTO Users (first_name, last_name, email, age) VALUES 
('Alice', 'Smith', 'alice@example.com', 25),
('Bob', 'Johnson', 'bob@example.com', 30),
('Carol', 'Williams', 'carol@example.com', 28),
('David', 'Brown', 'david@example.com', 35),
('Eve', 'Jones', 'eve@example.com', 22),
('Frank', 'Miller', 'frank@example.com', 40);

-- Insert data into Trainers table
INSERT INTO Trainers (first_name, last_name, certification) VALUES
('John', 'Doe', 'Certified Personal Trainer'),
('Jane', 'Doe', 'Certified Strength and Conditioning Specialist'),
('Mike', 'Taylor', 'Certified Yoga Instructor'),
('Emily', 'Davis', 'Certified Nutrition Specialist'),
('Chris', 'Wilson', 'Certified Strength Coach'),
('Sophia', 'Garcia', 'Certified HIIT Instructor');

-- Insert data into Exercises table
INSERT INTO Exercises (name, description, category) VALUES
('Push Up', 'A basic strength exercise targeting the chest.', 'Strength'),
('Running', 'A cardio exercise involving running.', 'Cardio'),
('Squat', 'A lower body strength exercise.', 'Strength');

-- Insert data into Workouts table (now the Workouts table exists)
INSERT INTO Workouts (user_id, trainer_id, date, duration) VALUES
(1, 1, '2024-09-24 10:00:00', 30), -- Alice with Trainer 1
(2, 2, '2024-09-24 11:00:00', 45), -- Bob with Trainer 2
(3, 3, '2024-09-25 09:00:00', 60), -- Carol with Trainer 3
(4, 4, '2024-09-25 10:30:00', 40), -- David with Trainer 4
(5, 5, '2024-09-25 12:00:00', 50), -- Eve with Trainer 5
(6, 6, '2024-09-26 08:30:00', 35); -- Frank with Trainer 6

-- Insert data into Workout_Exercises table
INSERT INTO Workout_Exercises (workout_id, exercise_id, sets, reps) VALUES
(1, 1, 3, 10), -- Alice: Push Ups
(1, 3, 3, 15), -- Alice: Squats
(2, 2, 1, 30); -- Bob: Running

-- Insert data into Nutrition table
INSERT INTO Nutrition (user_id, meal, calories, protein, fat, carbs, date) VALUES
(1, 'Chicken Salad', 400, 30, 15, 35, '2024-09-24 12:30:00'),
(2, 'Protein Shake', 250, 20, 5, 30, '2024-09-24 08:30:00');

-- Insert data into Equipment table
INSERT INTO Equipment (name, description, type) VALUES
('Treadmill', 'Cardio equipment used for running.', 'Cardio'),
('Dumbbell', 'Strength training equipment for resistance exercises.', 'Strength');

-- Insert data into Goals table
INSERT INTO Goals (user_id, goal_description, target_date) VALUES
(1, 'Run 5K in under 30 minutes', '2024-12-31'),
(2, 'Bench press 200 lbs', '2024-10-31');

SELECT 
    w.date AS workout_date,
    w.duration AS workout_duration,
    CONCAT(t.first_name, ' ', t.last_name) AS trainer_name,
    e.name AS exercise_name,
    we.sets,
    we.reps
FROM Workouts w
JOIN Trainers t ON w.trainer_id = t.trainer_id
JOIN Workout_Exercises we ON w.workout_id = we.workout_id
JOIN Exercises e ON we.exercise_id = e.exercise_id
WHERE w.user_id = 1 -- Change this to the specific user's ID
ORDER BY w.date DESC;

SELECT 
    CONCAT(u.first_name, ' ', u.last_name) AS user_name,
    u.email,
    w.date AS workout_date,
    w.duration AS workout_duration
FROM Users u
JOIN Workouts w ON u.user_id = w.user_id
JOIN Trainers t ON w.trainer_id = t.trainer_id
WHERE t.trainer_id = 1 -- Change this to the specific trainer's ID
ORDER BY w.date DESC;

SELECT 
    n.date AS meal_date,
    n.meal,
    n.calories,
    n.protein,
    n.fat,
    n.carbs
FROM Nutrition n
JOIN Users u ON n.user_id = u.user_id
WHERE u.user_id = 1 -- Change this to the specific user's ID
ORDER BY n.date DESC;

