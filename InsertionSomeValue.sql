USE MentalHealthDB;
-- Insert example users into the User table.
INSERT INTO [User] (name, gender, age, phone_number, email, password, [role])
VALUES 
  ('Alice', 'female', 30, '123-456-7890', 'alice@example.com', 'password123', 'admin'),
  ('Bob', 'male', 40, '234-567-8901', 'bob@example.com', 'securePass', 'therapist'),
  ('Charlie', 'other', 25, '345-678-9012', 'charlie@example.com', 'charliePass', 'patient');

-- Insert a record into TherapistProfile.
-- Assuming Bob (therapist) received user_id = 2.
INSERT INTO TherapistProfile (rating, years_of_experience, bio, specilization, user_id)
VALUES (4.50, 10, 'Experienced therapist specializing in anxiety disorders.', 'Anxiety, Stress', 2);

-- Insert a record into PatientProfile.
-- Assuming Charlie (patient) received user_id = 3.
INSERT INTO PatientProfile (user_id, concers)
VALUES (3, 'Concerns regarding anxiety and depression.');

-- Insert a record into Admin.
-- Assuming Alice (admin) received user_id = 1.
INSERT INTO [Admin] (user_id)
VALUES (1);

-- Insert a record into Article.
-- Assuming the therapist profile (Bob) has therapist_id = 1.
INSERT INTO Article (title, content, tags, created_by, therapist_id)
VALUES ('Coping with Anxiety', 'This article provides methods and tips to cope with anxiety in everyday life.', 'anxiety, coping', 'Bob', 1);

-- Insert a record into Review.
-- Creating a review for the therapist by the patient.
-- Assuming therapist_id = 1 from TherapistProfile and patient profile's patient_id = 1 from PatientProfile.
INSERT INTO Review (rating, comment, therapist_id, patient_id)
VALUES (5, 'Very helpful session, highly recommended.', 1, 1);

-- Insert a record into ScheduleSlot.
-- Using therapist_id = 1 and review_id = 1.
INSERT INTO ScheduleSlot (start_time, end_time, schedule_date, is_booked, therapist_id, review_id)
VALUES ('2025-04-05 10:00:00', '2025-04-05 11:00:00', '2025-04-05', 1, 1, 1);

-- Insert a record into Appointment.
-- Linking the appointment to the patient (patient_id = 1) and the schedule slot (schedule_id = 1).
INSERT INTO Appointment (patient_id, schedule_id, [status], meeting_link)
VALUES (1, 1, 'confirmed', 'https://meetinglink.example.com/12345');
