-- Creates the application's database.
CREATE DATABASE MentalHealthDB;

GO
USE MentalHealthDB;
GO

/*
User table stores the common attributes of admins, therapists, and patients.
*/
CREATE TABLE [User](
    user_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    name VARCHAR(10) NOT NULL,
    gender VARCHAR(6) NOT NULL CHECK (gender IN ('male','female','other')),
    age INT NOT NULL,
    phone_number VARCHAR(20),
    email NVARCHAR(100) NOT NULL,
    password NVARCHAR(40) NOT NULL,
    [role] VARCHAR(10) NOT NULL CHECK([role] IN ('admin','therapist', 'patient')),
    registration_date DATETIME NOT NULL DEFAULT GETDATE(),
);

/*
TherapistProfile table takes the user_id from the User table.
When a row in the User table is deleted or updated, the corresponding row here is deleted or updated.
Unlike a regular user, it has additional columns such as rating, years_of_experience, bio, and specilization.
These provide extra details for a therapist.
*/
CREATE TABLE TherapistProfile(
    therapist_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    rating DECIMAL(3,2) DEFAULT 0.00,
    years_of_experience INT NOT NULL,
    bio VARCHAR(1000),
    specilization VARCHAR(1000),
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES [User](user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/*
PatientProfile table takes the user_id from the User table.
When the associated row in the User table is deleted or updated, the corresponding row here is also deleted or updated.
Unlike a regular user, it includes a 'concers' column.
These provide extra details for a patient.
*/
CREATE TABLE PatientProfile(
    patient_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    concers VARCHAR(300) NOT NULL,
    FOREIGN KEY(user_id) REFERENCES [User](user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/*
Admin table takes the user_id from the User table.
When the associated row in the User table is deleted or updated, the corresponding row here is deleted or updated.
*/
CREATE TABLE [Admin](
    admin_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES [User](user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

/*
Article table takes the therapist_id from the TherapistProfile table.
This indicates which therapist wrote the article.
*/
CREATE TABLE Article(
    article_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    title VARCHAR(40) NOT NULL,
    content VARCHAR(2000) NOT NULL,
    tags VARCHAR(50),
    created_by VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    therapist_id INT NOT NULL,
    FOREIGN KEY(therapist_id) REFERENCES TherapistProfile(therapist_id)
);

/*
Review table has two foreign keys: therapist_id and patient_id.
It indicates which user made each review.
*/
CREATE TABLE Review(
    review_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    rating INT NOT NULL,
    comment VARCHAR(500),
    submitted_at DATETIME NOT NULL DEFAULT GETDATE(),
    therapist_id INT,
    patient_id INT,
    FOREIGN KEY(therapist_id) REFERENCES TherapistProfile(therapist_id),
    FOREIGN KEY(patient_id) REFERENCES PatientProfile(patient_id)
);

/*
ScheduleSlot table takes therapist_id and review_id as foreign keys.
These indicate which therapist created the slot and include the therapist's comments about how the session went.
*/
CREATE TABLE ScheduleSlot(
    schedule_id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    schedule_date DATE NOT NULL,
    is_booked BIT NOT NULL DEFAULT 0,
    therapist_id INT NOT NULL,
    review_id INT NOT NULL,
    FOREIGN KEY(therapist_id) REFERENCES TherapistProfile(therapist_id),
    FOREIGN KEY(review_id) REFERENCES Review(review_id)
);

/*
Appointment table takes patient_id and schedule_id as foreign keys.
*/
CREATE TABLE Appointment(
    patient_id INT NOT NULL,
    schedule_id INT NOT NULL,
    [status] VARCHAR(10) CHECK([status] IN ('pending', 'confirmed', 'cancelled')) NOT NULL,
    meeting_link NVARCHAR(200) NOT NULL,
    FOREIGN KEY(patient_id) REFERENCES PatientProfile(patient_id),
    FOREIGN KEY(schedule_id) REFERENCES ScheduleSlot(schedule_id)
);





