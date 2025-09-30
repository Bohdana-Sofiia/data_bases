DROP DATABASE IF EXISTS Homework_1;
CREATE DATABASE Homework_1;
USE Homework_1;

-- Creating tables
CREATE TABLE Unicorns (
    unicorn_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    color VARCHAR(30),
    owner VARCHAR(50)
);

CREATE TABLE Dragons (
    dragon_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    fire_strength INT,
    owner VARCHAR(20)
);

CREATE TABLE Wizards (
    wizard_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    spell VARCHAR(50),
    level INT
);

CREATE TABLE Potions (
    potion_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    owner VARCHAR(50),
    price DECIMAL(6,2)
);

CREATE TABLE MagicalPets (
    pet_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    species VARCHAR(30),
    owner VARCHAR(30)
);

-- Inserting data
INSERT INTO Wizards (name, spell, level) VALUES
('Merlin','Fireball',10),
('Gandalf','Lightning',15),
('Dumbledore','Shield',17),
('Harry','Confuse',5),
('Bellatrix','Curse',12);

INSERT INTO Unicorns (name, color, owner) VALUES
('Sparkle','Rainbow','Bellatrix'),
('Pinkie Pie','Pink','Dumbledore'),
('Glitter','Purple','Merlin'),
('RainbowDash','Blue','Harry'),
('Crookshanks','Orange','Gandalf');

INSERT INTO Dragons (name, fire_strength, owner) VALUES
('Fang','100','Harry'),
('Smaug','200','Merlin'),
('Toothless','50','Gandalf'),
('Blaze','150','Dumbledore'),
('Fluffy','20','Bellatrix');

INSERT INTO Potions (name, owner, price) VALUES
('Love Potion','Bellatrix',50.00),
('Invisibility Potion','Gandalf',75.00),
('Healing Potion','Dumbledore',25.00),
('Sleep Potion','Harry',30.00),
('Strength Potion','Merlin',40.00);

INSERT INTO MagicalPets (name, species, owner) VALUES
('Fluffy','Phoenix','Dumbledore'),
('Crookshanks','Cat','Bellatrix'),
('Bubbles','Mermaid','Gandalf'),
('Spark','Dragonling','Merlin'),
('Hedwig','Owl','Harry'),
('Sparkle','Hourse','Merlin'),
('Mike','Mouse', NULL);

-- Joining 5 tables
SELECT 
    w.name AS wizard,
    d.name AS wizard_dragon,
    u.name AS wizard_unicorn,
    p.name AS wizard_poison,
    mp.name AS wizars_pet
FROM Wizards w
JOIN Unicorns u ON u.owner = w.name
JOIN Dragons d ON d.owner = w.name
JOIN Potions p ON p.owner = w.name
JOIN MagicalPets mp ON mp.owner = w.name;


-- Using CTE + Where + Order by + Limit
WITH Super_Cool_Wizards AS(
	SELECT name, level
    FROM Wizards 
    WHERE level > 10
)

SELECT name, level
FROM Super_Cool_Wizards
ORDER BY level DESC
LIMIT 2;

-- Using subquery + where
SELECT name, level
FROM Wizards
WHERE level > (SELECT AVG(level) FROM Wizards); 


-- Group by + having
SELECT owner, COUNT(*) AS pets
FROM MagicalPets
WHERE owner IS NOT NULL
GROUP BY owner
HAVING COUNT(*) >= 1
ORDER BY pets DESC;

-- Union
SELECT name AS wizards_animals
FROM Unicorns
WHERE name IS NOT NULL

UNION

SELECT name AS wizards_animals
FROM MagicalPets
WHERE name IS NOT NULL

UNION

SELECT name AS wizards_animals
FROM Dragons
WHERE name IS NOT NULL;

