create database student_menthal_health;

use `student_menthal_health`;

create table student (
	student_id INT Primary key not null,
    age int,
    gender varchar(10), 
    country varchar(25)
    );
    
CREATE TABLE social_media (
	platform_id INT Primary key not null,
    name varchar(25)
    );
    
CREATE TABLE platform_use (
    platform_id INT NOT NULL,
    student_id INT NOT NULL, 
    avg_use FLOAT, 
    sleep_time int,
    mental_score INT,
    addicted_score INT,
    PRIMARY KEY (student_id, platform_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (platform_id) REFERENCES social_media(platform_id)
    );

CREATE TABLE academic_level (
	level_id INT Primary key not null,
    academic_level varchar(25)
    );
    
CREATE TABLE student_academic (
	student_id INT NOT NULL,
    level_id INT NOT NULL, 
    affects VARCHAR(10),
    PRIMARY KEY (student_id,level_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (level_id) REFERENCES academic_level(level_id)
    );
    
CREATE TABLE marital_status (
	marital_id INT PRIMARY KEY,
    status_name VARCHAR (25)
    );
    
CREATE TABLE marital_student (
	student_id INT NOT NULL, 
    marital_id INT NOT NULL, 
    conflicts INT, 
    PRIMARY KEY (student_id, marital_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (marital_id) REFERENCES marital_status(marital_id)
    );
