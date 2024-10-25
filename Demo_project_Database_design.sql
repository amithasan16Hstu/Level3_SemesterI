-- Building Table
CREATE TABLE Buildings (
  building_id INT PRIMARY KEY AUTO_INCREMENT,
  building_name VARCHAR(100), -- e.g., Dr. Wazed Building, Sheikh Russel Hall
  building_type VARCHAR(50), -- 'Academic' or 'Dormitory'
  location VARCHAR(100)
);
-- Floors Table
CREATE TABLE Floors (
  floor_id INT PRIMARY KEY AUTO_INCREMENT,
  floor_number INT, -- e.g., 1, 2, 3...
  building_id INT, -- Foreign Key linking to Buildings
  FOREIGN KEY (building_id) REFERENCES Buildings(building_id)
);
-- Rooms Table
CREATE TABLE Rooms (
  room_id INT PRIMARY KEY AUTO_INCREMENT,
  room_name VARCHAR(100), -- e.g., Room 101, Exam Room 203, Bedroom 405
  room_type VARCHAR(50), -- 'Classroom', 'Exam Room', 'Bedroom'
  floor_id INT, -- Foreign Key linking to Floors
  capacity INT, -- Number of people the room can accommodate
  room_suitability VARCHAR(100), -- e.g., 'Classroom', 'Exam Room' for academic rooms
  FOREIGN KEY (floor_id) REFERENCES Floors(floor_id)
);
CREATE TABLE Seats (
  seat_id INT PRIMARY KEY AUTO_INCREMENT,
  seat_number INT, -- Seat number in the room
  room_id INT, -- Foreign Key linking to Rooms (only for bedrooms in dormitories)
  occupant_name VARCHAR(100), -- Name of the student assigned to the seat
  FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);
CREATE TABLE RoomAssignments (
  assignment_id INT PRIMARY KEY AUTO_INCREMENT,
  room_id INT, -- Foreign Key linking to Rooms
  batch VARCHAR(50), -- Batch assigned to this room
  purpose VARCHAR(50), -- e.g., 'Exam', 'Lecture'
  start_time DATETIME, -- Start time of the class or exam
  end_time DATETIME, -- End time
  FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

