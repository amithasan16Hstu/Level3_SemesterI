CREATE TABLE HSTU (
    ID INT PRIMARY KEY,
    Type ENUM('Building', 'Non-building'),
    Category VARCHAR(100),
    Name VARCHAR(255),
    Location VARCHAR(255)
);

CREATE TABLE Floors (
    Floor_ID INT PRIMARY KEY,
    ID INT,
    Floor_number INT,
    Total_rooms INT,
    FOREIGN KEY (ID) REFERENCES HSTU(ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Multi_purpose_building (
    Floor_ID INT,
    Usage_description VARCHAR(255),
    PRIMARY KEY (Floor_ID),
    FOREIGN KEY (Floor_ID) REFERENCES Floors(Floor_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Rooms (
    Room_ID INT PRIMARY KEY,
    Floor_ID INT,
    Room_number VARCHAR(50),
    Room_type VARCHAR(100),
    Room_size VARCHAR(50),
    FOREIGN KEY (Floor_ID) REFERENCES Floors(Floor_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Query to insert a building into HSTU
INSERT INTO HSTU (ID, Type, Category, Name, Location) VALUES (1, 'Building', 'Academic', 'Dr. Md. Wazed Vhaban', 'Central Campus');

-- Query to insert a non-building into HSTU
INSERT INTO HSTU (ID, Type, Category, Name, Location) VALUES (2, 'Non-building', 'Playground', 'Main Playground', 'North Campus');

-- Query to insert a floor into Floors
INSERT INTO Floors (Floor_ID, ID, Floor_number, Total_rooms) VALUES (1, 1, 1, 10);

-- Query to insert a multi-purpose usage for a floor
INSERT INTO Multi_purpose_building (Floor_ID, Usage_description) VALUES (1, 'TSC: Ground floor, Bank: 1st floor');

-- Query to insert a room into Rooms
INSERT INTO Rooms (Room_ID, Floor_ID, Room_number, Room_type, Room_size) VALUES (1, 1, '101', 'Classroom', '50 sqm');

-- Query to select all buildings from HSTU
SELECT * FROM HSTU WHERE Type = 'Building';

-- Query to select all floors of a specific building
SELECT * FROM Floors WHERE ID = 1;

-- Query to select all rooms in a specific floor
SELECT * FROM Rooms WHERE Floor_ID = 1;

-- Query to find multi-purpose usage of a specific floor
SELECT * FROM Multi_purpose_building WHERE Floor_ID = 1;

-- Query to join HSTU and Floors to get all floors of each building
SELECT H.Name AS Building_Name, F.Floor_number, F.Total_rooms
FROM HSTU H
JOIN Floors F ON H.ID = F.ID;

-- Query to join Floors and Rooms to get all rooms in each floor
SELECT F.Floor_number, R.Room_number, R.Room_type, R.Room_size
FROM Floors F
JOIN Rooms R ON F.Floor_ID = R.Floor_ID;

-- Query to join HSTU, Floors, and Rooms to get complete information about each room in a building
SELECT H.Name AS Building_Name, F.Floor_number, R.Room_number, R.Room_type, R.Room_size
FROM HSTU H
JOIN Floors F ON H.ID = F.ID
JOIN Rooms R ON F.Floor_ID = R.Floor_ID;

-- Query to join Floors and Multi_purpose_building to get usage information of multi-purpose floors
SELECT F.Floor_number, COALESCE(M.Usage_description, 'No Usage Assigned') AS Usage_description
FROM Floors F
LEFT JOIN Multi_purpose_building M ON F.Floor_ID = M.Floor_ID;

