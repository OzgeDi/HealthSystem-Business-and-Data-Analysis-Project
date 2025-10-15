-- HealthInformationSystem.sql
-- T-SQL script to create tables and insert realistic sample data
-- Run this script inside your target database in SSMS (do not include CREATE DATABASE)

SET NOCOUNT ON;

-- Hospitals table
IF OBJECT_ID('dbo.Hospital', 'U') IS NOT NULL DROP TABLE dbo.Hospital;
CREATE TABLE dbo.Hospital (
    HospitalID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Address NVARCHAR(300) NOT NULL,
    Phone NVARCHAR(30) NULL
);

-- Doctors table
IF OBJECT_ID('dbo.Doctor', 'U') IS NOT NULL DROP TABLE dbo.Doctor;
CREATE TABLE dbo.Doctor (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Specialty NVARCHAR(100) NOT NULL
);

-- Clinics table
IF OBJECT_ID('dbo.Clinic', 'U') IS NOT NULL DROP TABLE dbo.Clinic;
CREATE TABLE dbo.Clinic (
    ClinicID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    HospitalID INT NOT NULL,
    CONSTRAINT FK_Clinic_Hospital FOREIGN KEY (HospitalID) REFERENCES dbo.Hospital(HospitalID)
);

-- Patients table
IF OBJECT_ID('dbo.Patient', 'U') IS NOT NULL DROP TABLE dbo.Patient;
CREATE TABLE dbo.Patient (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    NationalID CHAR(11) NOT NULL,
    BirthDate DATE NOT NULL,
    Phone NVARCHAR(30) NULL,
    Email NVARCHAR(150) NULL,
    Address NVARCHAR(300) NOT NULL
);


-- Appointments table
IF OBJECT_ID('dbo.Appointment', 'U') IS NOT NULL DROP TABLE dbo.Appointment;
CREATE TABLE dbo.Appointment (
    AppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    ClinicID INT NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    CONSTRAINT FK_Appointment_Patient FOREIGN KEY (PatientID) REFERENCES dbo.Patient(PatientID),
    CONSTRAINT FK_Appointment_Doctor FOREIGN KEY (DoctorID) REFERENCES dbo.Doctor(DoctorID),
    CONSTRAINT FK_Appointment_Clinic FOREIGN KEY (ClinicID) REFERENCES dbo.Clinic(ClinicID)
);

-- Prescriptions table
IF OBJECT_ID('dbo.Prescription', 'U') IS NOT NULL DROP TABLE dbo.Prescription;
CREATE TABLE dbo.Prescription (
    PrescriptionID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    PrescriptionDate DATE NOT NULL,
    Diagnosis NVARCHAR(255) NULL,
    CONSTRAINT FK_Prescription_Patient FOREIGN KEY (PatientID) REFERENCES dbo.Patient(PatientID),
    CONSTRAINT FK_Prescription_Doctor FOREIGN KEY (DoctorID) REFERENCES dbo.Doctor(DoctorID)
);

-- Tests table
IF OBJECT_ID('dbo.Test', 'U') IS NOT NULL DROP TABLE dbo.Test;
CREATE TABLE dbo.Test (
    TestID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    Name NVARCHAR(200) NOT NULL,
    Result NVARCHAR(300) NOT NULL,
    Date DATE NOT NULL,
    CONSTRAINT FK_Test_Patient FOREIGN KEY (PatientID) REFERENCES dbo.Patient(PatientID),
    CONSTRAINT FK_Test_Doctor FOREIGN KEY (DoctorID) REFERENCES dbo.Doctor(DoctorID)
);

-- PrescriptionMedicines junction table
IF OBJECT_ID('dbo.PrescriptionMedicine', 'U') IS NOT NULL DROP TABLE dbo.PrescriptionMedicine;
CREATE TABLE dbo.PrescriptionMedicine (
    PrescriptionMedicineID INT IDENTITY(1,1) PRIMARY KEY,
    PrescriptionID INT NOT NULL,
    MedicineName NVARCHAR(100) NOT NULL,
    Dose INT NOT NULL,
    Description NVARCHAR(10) NULL, -- e.g. '1x1', '2x2' etc.
    CONSTRAINT FK_PrescriptionMedicine_Prescription FOREIGN KEY (PrescriptionID) REFERENCES dbo.Prescription(PrescriptionID)
);

-- Insert sample hospitals
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Central City Hospital', N'164 Main St, City', '+90-340-350-4657');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Grandview Medical Center', N'36 Main St, City', '+90-479-189-7912');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Riverside General Hospital', N'9 Main St, City', '+90-319-617-1434');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'St. Marys Hospital', N'144 Oak Ave, City', '+90-559-658-7873');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Pinecrest Health Center', N'57 Maple St, City', '+90-203-877-3615');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Lakeside Hospital', N'179 Maple St, City', '+90-279-320-6514');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Hilltop Regional Medical', N'27 Main St, City', '+90-383-967-6635');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Valleycare Hospital', N'155 Pine Rd, City', NULL);
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Northside Medical Center', N'187 Maple St, City', '+90-393-180-5803');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Meadowlands Hospital', N'161 Elm Blvd, City', NULL);
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Sunrise Clinic & Hospital', N'93 Elm Blvd, City', '+90-235-146-4733');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Westbrook Health Center', N'198 Pine Rd, City', NULL);
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Cedar Grove Medical', N'60 Main St, City', '+90-432-750-6977');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Silverlake Hospital', N'42 Pine Rd, City', '+90-543-373-2169');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Oakwood General', N'156 Oak Ave, City', '+90-325-267-8573');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Greenfield Hospital', N'98 Pine Rd, City', NULL);
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Maple Leaf Medical', N'164 Elm Blvd, City', '+90-366-963-1916');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Harborview Hospital', N'59 Main St, City', NULL);
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Prairie View Medical', N'103 Pine Rd, City', '+90-490-997-6155');
INSERT INTO dbo.Hospital (Name, Address, Phone) VALUES (N'Highland Regional', N'55 Maple St, City', '+90-529-569-3340');

-- Insert sample doctors
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Kimberly', N'Rodriguez', N'Dermatology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Christine', N'Wright', N'ENT');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Samuel', N'Ramirez', N'Family Medicine');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Kathleen', N'White', N'Dermatology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Margaret', N'Allen', N'Gastroenterology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Barbara', N'Carter', N'Cardiology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Joseph', N'Martinez', N'Orthopedics');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Jacob', N'Hill', N'Pediatrics');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Cynthia', N'Harris', N'Family Medicine');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Helen', N'King', N'ENT');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Brandon', N'Smith', N'Pediatrics');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Scott', N'Carter', N'ENT');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Anna', N'Davis', N'ENT');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Shirley', N'Hernandez', N'Gastroenterology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'John', N'Campbell', N'ENT');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Larry', N'Carter', N'Orthopedics');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Larry', N'Miller', N'ENT');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Larry', N'Hill', N'Dermatology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Dorothy', N'White', N'Orthopedics');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Samantha', N'Roberts', N'General Surgery');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'John', N'Hill', N'Neurology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Stephen', N'Johnson', N'Pediatrics');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Jason', N'Martin', N'Dermatology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Linda', N'Thomas', N'Family Medicine');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'William', N'Garcia', N'Gastroenterology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Robert', N'Carter', N'General Surgery');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Thomas', N'Rodriguez', N'Gastroenterology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Brandon', N'Hernandez', N'ENT');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Katherine', N'Hill', N'Endocrinology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Lisa', N'Wright', N'Dermatology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Michelle', N'Sanchez', N'Neurology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Gary', N'King', N'Gastroenterology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Jessica', N'Thomas', N'Dermatology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Robert', N'Perez', N'Cardiology');
INSERT INTO dbo.Doctor (FirstName, LastName, Specialty) VALUES (N'Rachel', N'Scott', N'Dermatology');

-- Insert sample clinics
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Cardiology Clinic', 19);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Pediatrics Clinic', 8);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Orthopedics Clinic', 1);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Dermatology Clinic', 3);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'ENT Clinic', 2);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Neurology Clinic', 8);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Endocrinology Clinic', 3);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Gastroenterology Clinic', 2);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Urology Clinic', 11);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Oncology Clinic', 3);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Ophthalmology Clinic', 17);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Psychiatry Clinic', 8);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Dental Clinic', 9);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Family Medicine Clinic', 16);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'OB-GYN Clinic', 7);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Pulmonology Clinic', 18);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Rheumatology Clinic', 5);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Nephrology Clinic', 19);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Allergy Clinic', 19);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Physical Therapy Clinic', 16);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Emergency Clinic', 8);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Rehabilitation Clinic', 16);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Geriatrics Clinic', 14);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Immunology Clinic', 7);
INSERT INTO dbo.Clinic (Name, HospitalID) VALUES (N'Sleep Disorders Clinic', 4);

-- Insert sample patients
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Richard', N'Nelson', '67356271327', '1978-09-02', '+90-573-155-2612', 'richard.nelson@healthmail.org', N'820 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Ashley', N'Gonzalez', '72432871908', '1957-01-23', '+90-293-385-8579', 'ashley.gonzalez@example.com', N'454 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Richard', N'Brown', '87306329557', '1998-07-04', '+90-247-871-4872', 'richard.brown@clinicmail.com', N'493 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Kathleen', N'Brown', '11627677155', '1954-10-08', NULL, 'kathleen.brown@clinicmail.com', N'293 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Christine', N'Nelson', '29270107001', '2004-06-13', '+90-311-159-9883', 'christine.nelson@healthmail.org', N'59 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Samuel', N'Walker', '33756005883', '1985-02-10', '+90-460-182-4044', 'samuel.walker@example.com', N'692 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Kathleen', N'Davis', '88366898196', '1991-02-09', '+90-517-183-7868', NULL, N'579 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Kenneth', N'Taylor', '41414180506', '1958-04-29', '+90-267-787-5915', 'kenneth.taylor@example.com', N'10 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Carolyn', N'Torres', '83329096416', '1948-12-20', '+90-335-235-6718', NULL, N'901 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Sharon', N'Jackson', '92903679846', '1954-02-25', NULL, NULL, N'542 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Brandon', N'Martin', '30951395781', '1999-07-07', '+90-254-860-3546', 'brandon.martin@patientmail.net', N'216 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Mark', N'Baker', '48022971018', '1996-11-24', '+90-328-966-1832', 'mark.baker@clinicmail.com', N'850 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Emily', N'Smith', '30491801037', '1969-12-03', '+90-334-265-8239', 'emily.smith@clinicmail.com', N'575 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Joseph', N'Jones', '31062212842', '2001-12-29', '+90-389-696-3426', 'joseph.jones@example.com', N'316 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Emily', N'Thompson', '42994225206', '1958-11-05', '+90-381-898-7658', NULL, N'768 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'George', N'Hernandez', '69620228624', '1955-11-19', '+90-577-440-7745', NULL, N'885 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Edward', N'Hernandez', '25896868772', '2010-08-21', '+90-219-979-8711', 'edward.hernandez@clinicmail.com', N'359 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Sandra', N'Anderson', '38604624730', '1942-02-14', '+90-342-985-2137', NULL, N'286 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Nicole', N'Sanchez', '55252701991', '2000-12-17', NULL, 'nicole.sanchez@healthmail.org', N'183 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Kimberly', N'Williams', '68396828876', '1949-09-22', '+90-360-546-9379', 'kimberly.williams@patientmail.net', N'195 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Emily', N'Rivera', '78726740707', '1979-02-13', NULL, 'emily.rivera@mail.com', N'373 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Robert', N'Nelson', '55626105063', '1969-08-15', '+90-263-837-5920', 'robert.nelson@clinicmail.com', N'335 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Carol', N'Scott', '66658521782', '1951-06-02', '+90-394-793-3851', NULL, N'309 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Brandon', N'Smith', '37002088812', '1967-04-06', '+90-496-721-6279', 'brandon.smith@clinicmail.com', N'692 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Nicole', N'Walker', '49018899720', '2006-01-09', '+90-524-734-6491', 'nicole.walker@mail.com', N'689 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Paul', N'Gonzalez', '14399873551', '1953-03-21', '+90-443-725-2193', 'paul.gonzalez@patientmail.net', N'200 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Pamela', N'Sanchez', '96533160004', '1961-11-20', '+90-584-981-2746', NULL, N'225 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Justin', N'Robinson', '42458810745', '1944-07-03', NULL, 'justin.robinson@mail.com', N'821 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Katherine', N'Scott', '93505217012', '1993-06-02', '+90-458-536-9976', 'katherine.scott@mail.com', N'762 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Angela', N'Taylor', '47098473391', '2007-06-12', '+90-466-596-4919', 'angela.taylor@example.com', N'731 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'George', N'Moore', '20909870727', '1970-02-17', '+90-318-492-3503', NULL, N'66 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Eric', N'Perez', '67835704506', '1988-09-05', '+90-415-498-1320', NULL, N'784 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Jeffrey', N'Walker', '61293684848', '1940-07-12', '+90-399-973-7865', 'jeffrey.walker@patientmail.net', N'820 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Paul', N'Young', '67006823094', '1959-09-08', '+90-399-444-7624', NULL, N'861 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Thomas', N'Flores', '89001715430', '1987-12-02', '+90-213-185-8022', 'thomas.flores@clinicmail.com', N'187 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Kimberly', N'Harris', '71038616156', '1969-05-14', '+90-589-488-5558', NULL, N'852 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Steven', N'Garcia', '16611754494', '1982-03-12', NULL, 'steven.garcia@example.com', N'800 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Sarah', N'Thomas', '13604460472', '1957-11-19', '+90-322-229-8758', NULL, N'578 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Helen', N'Hall', '60538442525', '1962-12-27', '+90-510-865-2876', NULL, N'168 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Susan', N'Nguyen', '52644245686', '1942-04-21', '+90-392-506-4249', 'susan.nguyen@mail.com', N'105 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Gregory', N'Davis', '17656360518', '1990-10-09', '+90-419-777-7071', 'gregory.davis@healthmail.org', N'13 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Stephen', N'Miller', '61371191447', '1978-11-22', '+90-435-824-3506', 'stephen.miller@patientmail.net', N'989 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Frank', N'Wright', '72206148127', '2009-06-30', '+90-574-706-5397', 'frank.wright@mail.com', N'851 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Donna', N'Lewis', '73352813247', '1961-11-16', '+90-542-488-6511', 'donna.lewis@healthmail.org', N'187 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Lisa', N'Thompson', '45821482566', '1963-03-06', NULL, NULL, N'283 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Mary', N'King', '40432475943', '1957-02-20', '+90-450-668-4937', NULL, N'662 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Angela', N'Johnson', '41328503269', '1948-05-07', '+90-324-413-7046', 'angela.johnson@patientmail.net', N'353 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Brandon', N'Perez', '73148281147', '1971-07-25', '+90-328-336-2976', NULL, N'324 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Scott', N'Carter', '36565016314', '2001-12-01', '+90-447-383-9595', 'scott.carter@example.com', N'853 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Carol', N'Anderson', '49425401235', '1972-05-17', '+90-473-229-5494', 'carol.anderson@example.com', N'567 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Thomas', N'Green', '24993209840', '2007-07-15', NULL, 'thomas.green@clinicmail.com', N'491 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Anna', N'Lopez', '78125581388', '1944-08-10', '+90-233-510-9056', 'anna.lopez@example.com', N'156 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Benjamin', N'Martin', '44333616916', '1947-08-23', '+90-591-526-4697', NULL, N'390 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Gary', N'Martin', '70086726736', '1992-10-18', '+90-517-161-2625', NULL, N'213 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Kimberly', N'Nelson', '40739326144', '1947-04-14', '+90-238-260-1043', 'kimberly.nelson@patientmail.net', N'482 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'David', N'Anderson', '51691057849', '1965-11-05', '+90-432-172-4824', NULL, N'807 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Betty', N'Ramirez', '42403648693', '1950-04-18', '+90-336-946-3330', 'betty.ramirez@mail.com', N'812 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Gregory', N'Mitchell', '52611197462', '1991-01-24', '+90-439-805-5982', NULL, N'966 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Larry', N'Wright', '20470094617', '1984-04-19', '+90-421-852-6280', NULL, N'27 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Sandra', N'Baker', '47887715751', '1991-08-09', '+90-590-874-3870', 'sandra.baker@clinicmail.com', N'939 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Nancy', N'Nguyen', '74816392589', '1979-02-08', '+90-370-428-2713', NULL, N'338 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Pamela', N'Jackson', '65599182910', '1999-06-11', '+90-481-137-8451', 'pamela.jackson@healthmail.org', N'332 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Kathleen', N'Allen', '72459963885', '1940-02-07', '+90-296-630-6927', NULL, N'511 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'James', N'Wilson', '29538749588', '1963-12-16', NULL, 'james.wilson@clinicmail.com', N'125 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Catherine', N'Thomas', '49334934709', '2003-09-05', '+90-482-517-2527', 'catherine.thomas@example.com', N'473 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Dorothy', N'Young', '79973012590', '2004-04-15', '+90-412-954-8905', NULL, N'250 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Brandon', N'Martinez', '81293783904', '1974-05-31', '+90-269-984-2143', 'brandon.martinez@clinicmail.com', N'349 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Edward', N'Smith', '51773070906', '1965-05-17', '+90-496-775-9022', NULL, N'458 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Brenda', N'Thompson', '63873621917', '1969-10-28', '+90-364-990-4090', NULL, N'245 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Cynthia', N'Anderson', '16059232914', '2009-07-30', '+90-442-822-7246', 'cynthia.anderson@mail.com', N'508 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Thomas', N'Allen', '73758958832', '1992-12-12', '+90-433-115-3361', 'thomas.allen@mail.com', N'77 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Kimberly', N'Perez', '64514751164', '1995-11-30', '+90-368-972-9742', 'kimberly.perez@healthmail.org', N'642 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Samantha', N'Williams', '40358635949', '1995-05-24', '+90-347-332-2480', 'samantha.williams@example.com', N'779 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Gary', N'Hernandez', '14419294815', '2002-04-06', '+90-228-400-6873', 'gary.hernandez@mail.com', N'251 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Eric', N'Torres', '34878681702', '2001-03-02', '+90-240-724-7267', NULL, N'247 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Samuel', N'Martinez', '97879969723', '1960-10-30', '+90-330-782-1153', NULL, N'477 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Samantha', N'Hernandez', '51178306916', '1946-08-17', '+90-417-806-5097', 'samantha.hernandez@healthmail.org', N'204 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Brenda', N'Miller', '88947358505', '1961-04-12', '+90-351-816-5837', 'brenda.miller@clinicmail.com', N'282 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Benjamin', N'Baker', '43495849178', '2009-10-28', '+90-380-324-4115', NULL, N'695 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Richard', N'Green', '48824024350', '1997-12-26', '+90-217-693-6977', NULL, N'93 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Laura', N'Mitchell', '36524172149', '1977-04-11', '+90-476-997-6994', 'laura.mitchell@healthmail.org', N'851 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Steven', N'Walker', '70624192275', '1966-06-24', NULL, 'steven.walker@mail.com', N'881 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Christine', N'White', '64935560740', '1948-02-07', '+90-474-226-8451', 'christine.white@healthmail.org', N'599 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Sharon', N'Miller', '75428766878', '2000-07-17', '+90-487-435-4626', NULL, N'651 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Ronald', N'Adams', '27680988521', '1976-08-18', '+90-219-411-9071', 'ronald.adams@mail.com', N'909 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Margaret', N'Harris', '68154683949', '1980-09-11', '+90-572-258-7797', NULL, N'854 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Frank', N'Clark', '37361217852', '1965-02-04', '+90-320-975-6942', 'frank.clark@healthmail.org', N'558 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Linda', N'Sanchez', '20542930840', '1964-10-01', '+90-528-754-1349', 'linda.sanchez@healthmail.org', N'250 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Benjamin', N'Wilson', '38150108098', '1946-02-26', '+90-319-436-3417', NULL, N'611 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Donna', N'Martinez', '46679946108', '1951-08-30', '+90-256-776-1422', 'donna.martinez@healthmail.org', N'809 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Rachel', N'Lee', '45108120110', '1941-06-01', '+90-579-531-9619', 'rachel.lee@example.com', N'488 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Jason', N'Allen', '70597925548', '1993-04-05', '+90-514-144-9543', 'jason.allen@example.com', N'63 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Kathleen', N'Ramirez', '74888201959', '2001-07-21', '+90-427-175-2323', 'kathleen.ramirez@mail.com', N'68 Elm St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Donna', N'Flores', '85528566209', '1996-10-17', '+90-395-711-9692', 'donna.flores@patientmail.net', N'620 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Richard', N'Hall', '99562062829', '1950-04-07', '+90-593-664-4522', 'richard.hall@mail.com', N'424 Oak Ave, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Nicholas', N'Sanchez', '26018563769', '1977-04-27', '+90-360-781-5176', 'nicholas.sanchez@mail.com', N'704 Pine Rd, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Robert', N'Garcia', '66234995073', '1947-08-29', '+90-578-481-3131', 'robert.garcia@patientmail.net', N'980 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Christine', N'Perez', '66359554209', '2000-02-09', '+90-540-868-7929', NULL, N'739 Main St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Brian', N'Hill', '24395210769', '1968-01-12', '+90-308-258-8900', 'brian.hill@example.com', N'359 Maple St, City');
INSERT INTO dbo.Patient (FirstName, LastName, NationalID, BirthDate, Phone, Email, Address) VALUES (N'Sharon', N'Davis', '88505852701', '2008-06-01', '+90-419-965-1430', NULL, N'674 Oak Ave, City');


-- Insert sample appointments
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (82, 27, 10, '2025-08-13', '14:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (42, 11, 20, '2025-02-17', '13:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (56, 7, 8, '2025-03-01', '17:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (68, 6, 13, '2025-05-05', '13:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (43, 11, 3, '2025-01-22', '09:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (100, 23, 12, '2024-11-14', '10:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (14, 10, 9, '2025-07-01', '10:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (98, 5, 6, '2024-11-23', '15:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (97, 29, 22, '2024-12-25', '17:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (81, 21, 5, '2025-02-27', '09:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (57, 20, 9, '2024-12-12', '08:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (65, 5, 10, '2025-02-16', '15:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (8, 24, 10, '2025-09-01', '09:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (60, 3, 15, '2024-12-22', '11:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (78, 31, 17, '2025-07-25', '08:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (14, 22, 23, '2025-08-28', '16:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (6, 16, 23, '2025-02-28', '15:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (47, 24, 10, '2025-03-26', '14:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (87, 4, 21, '2024-11-13', '13:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (43, 7, 18, '2024-10-28', '14:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (33, 10, 11, '2025-08-30', '17:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (45, 20, 21, '2024-10-18', '14:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (77, 6, 10, '2024-12-28', '14:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (17, 34, 3, '2024-11-14', '14:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (3, 24, 10, '2025-07-10', '11:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (99, 32, 7, '2025-06-17', '10:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (10, 19, 4, '2025-01-24', '16:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (85, 22, 25, '2024-11-28', '10:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (20, 11, 6, '2024-10-21', '17:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (93, 29, 2, '2025-03-14', '13:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (57, 19, 25, '2025-02-23', '11:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (40, 31, 7, '2025-04-05', '17:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (60, 19, 25, '2025-03-29', '16:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (21, 13, 20, '2025-08-01', '12:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (83, 31, 12, '2024-12-31', '09:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (37, 6, 25, '2025-07-20', '12:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (66, 10, 14, '2025-08-25', '11:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (45, 2, 14, '2025-09-13', '14:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (31, 25, 3, '2025-04-02', '11:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (41, 7, 23, '2024-11-12', '13:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (18, 3, 10, '2025-02-11', '10:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (58, 1, 3, '2025-10-01', '12:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (20, 34, 14, '2025-08-15', '12:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (39, 8, 2, '2025-06-10', '14:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (9, 8, 16, '2024-12-09', '16:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (81, 33, 19, '2025-06-09', '10:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (55, 1, 20, '2025-04-13', '11:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (24, 6, 17, '2025-04-09', '09:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (50, 31, 2, '2024-11-19', '14:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (33, 2, 12, '2025-09-06', '13:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (94, 7, 25, '2024-12-17', '13:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (6, 23, 18, '2025-04-20', '10:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (90, 31, 21, '2025-07-09', '10:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (92, 30, 2, '2025-05-13', '11:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (26, 3, 11, '2025-05-05', '16:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (70, 31, 9, '2025-09-22', '11:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (46, 4, 21, '2025-04-24', '12:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (48, 28, 13, '2025-02-27', '14:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (24, 32, 23, '2025-01-29', '13:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (11, 28, 3, '2025-03-04', '17:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (70, 19, 11, '2025-08-19', '09:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (85, 19, 10, '2025-02-24', '17:45:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (22, 29, 12, '2025-02-24', '08:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (79, 28, 9, '2024-11-17', '08:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (86, 26, 12, '2025-01-21', '10:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (19, 29, 2, '2025-08-07', '09:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (100, 24, 12, '2025-03-28', '17:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (78, 10, 22, '2025-02-22', '13:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (57, 5, 19, '2025-08-01', '16:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (51, 21, 21, '2025-05-21', '11:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (4, 12, 16, '2025-01-18', '14:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (34, 17, 23, '2025-02-24', '11:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (89, 32, 7, '2025-08-09', '10:00:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (58, 12, 23, '2025-02-25', '09:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (86, 23, 23, '2025-09-07', '16:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (39, 11, 23, '2024-10-12', '10:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (66, 15, 4, '2025-06-30', '10:15:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (64, 2, 12, '2024-12-31', '17:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (60, 9, 20, '2025-08-27', '09:30:00');
INSERT INTO dbo.Appointment (PatientID, DoctorID, ClinicID, Date, Time) VALUES (51, 31, 17, '2025-03-14', '14:00:00');

-- Insert sample prescriptions
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (82, 8, '2025-09-16', N'Urinary tract infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (32, 15, '2025-05-22', N'Diabetes');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (87, 35, '2025-07-14', N'Thyroid disorder');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (5, 2, '2025-07-08', N'Bronchitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (30, 33, '2024-02-03', N'Flu');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (72, 13, '2023-10-09', N'Arthritis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (54, 15, '2024-07-09', N'Urinary tract infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (1, 11, '2023-10-28', N'Thyroid disorder');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (44, 18, '2025-05-05', N'Bronchitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (98, 22, '2025-06-29', N'Hypertension');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (49, 7, '2024-10-09', N'Anxiety');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (78, 17, '2025-08-28', N'High cholesterol');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (69, 8, '2024-09-19', N'Hypertension');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (71, 19, '2024-01-07', N'Anxiety');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (74, 13, '2023-10-21', N'Hypertension');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (6, 15, '2023-08-12', N'Back pain');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (11, 15, '2025-06-30', N'Depression');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (36, 30, '2023-12-31', N'Anxiety');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (21, 24, '2024-10-13', N'Bronchitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (86, 18, '2023-10-24', N'Hypertension');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (78, 11, '2024-04-13', N'Gastritis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (21, 30, '2024-09-18', N'Urinary tract infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (82, 15, '2023-11-10', N'Dermatitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (99, 4, '2025-02-19', N'Upper respiratory infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (41, 26, '2025-01-10', N'Hypertension');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (28, 21, '2025-03-08', N'Sinusitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (51, 30, '2025-05-18', N'Urinary tract infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (18, 16, '2023-09-10', N'Arthritis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (69, 17, '2023-09-08', N'Thyroid disorder');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (75, 26, '2024-10-06', N'Gastritis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (18, 33, '2024-05-24', N'Hypertension');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (97, 4, '2025-06-21', N'Migraine');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (81, 11, '2023-11-15', N'Thyroid disorder');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (77, 5, '2024-09-12', N'Depression');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (77, 30, '2024-04-18', N'Urinary tract infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (71, 1, '2023-11-15', N'Diabetes');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (88, 35, '2023-09-04', N'Urinary tract infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (99, 22, '2025-06-19', N'Back pain');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (56, 11, '2024-07-04', N'Flu');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (93, 17, '2024-05-17', N'Allergy');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (65, 7, '2024-01-10', N'Back pain');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (82, 33, '2024-01-27', N'Bronchitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (20, 24, '2023-08-23', N'Allergy');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (70, 34, '2025-10-11', N'Dermatitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (63, 2, '2025-06-19', N'Anxiety');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (40, 16, '2025-08-13', N'Gastritis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (73, 6, '2025-07-16', N'Sinusitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (9, 35, '2023-08-19', N'Migraine');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (17, 31, '2024-03-28', N'Allergy');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (34, 34, '2024-01-29', N'Thyroid disorder');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (28, 35, '2023-08-30', N'Bronchitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (92, 20, '2024-08-29', N'Anxiety');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (57, 34, '2024-07-06', N'Diabetes');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (32, 15, '2025-08-07', N'Dermatitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (3, 15, '2024-02-17', N'Gastritis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (1, 5, '2023-10-18', N'Upper respiratory infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (30, 5, '2025-09-09', N'Dermatitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (10, 33, '2025-02-10', N'Urinary tract infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (86, 32, '2025-03-06', N'Arthritis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (17, 31, '2025-02-05', N'Sinusitis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (53, 13, '2025-07-07', N'Diabetes');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (85, 28, '2024-10-14', N'Thyroid disorder');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (53, 30, '2023-09-26', N'Upper respiratory infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (87, 7, '2025-08-10', N'Depression');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (94, 22, '2025-06-22', N'Gastritis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (25, 13, '2024-04-10', N'High cholesterol');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (18, 28, '2025-04-07', N'Urinary tract infection');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (60, 16, '2025-07-26', N'High cholesterol');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (71, 7, '2025-08-21', N'Arthritis');
INSERT INTO dbo.Prescription (PatientID, DoctorID, PrescriptionDate, Diagnosis) VALUES (2, 6, '2023-09-01', N'Gastritis');


-- Insert sample prescription medicines
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (22, N'Warfarin', 32, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (28, N'Gabapentin', 58, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (22, N'Tramadol', 1, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (34, N'Tacrolimus', 51, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (37, N'Metronidazole', 45, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (63, N'Lisinopril', 13, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (28, N'Atorvastatin', 38, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (8, N'Olanzapine', 21, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (7, N'Hydrocortisone', 31, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (68, N'Simvastatin', 4, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (11, N'Losartan', 5, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (9, N'Atenolol', 56, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (52, N'Ciprofloxacin', 57, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (32, N'Hydrocortisone', 39, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (11, N'Warfarin', 43, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (67, N'Nitrofurantoin', 60, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (27, N'Levofloxacin', 46, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (31, N'Pantoprazole', 26, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (39, N'Morphine', 21, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (2, N'Morphine', 40, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (13, N'Omeprazole', 35, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (65, N'Pantoprazole', 9, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (9, N'Levothyroxine', 24, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (21, N'Insulin', 54, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (39, N'Propranolol', 52, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (2, N'Levofloxacin', 53, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (39, N'Levofloxacin', 7, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (34, N'Ciprofloxacin', 57, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (20, N'Sertraline', 19, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (27, N'Valsartan', 22, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (34, N'Spironolactone', 32, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (7, N'Metformin', 41, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (36, N'Amoxicillin', 1, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (17, N'Clindamycin', 17, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (57, N'Ketorolac', 46, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (2, N'Ciprofloxacin', 5, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (70, N'Amoxicillin', 54, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (19, N'Metronidazole', 9, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (40, N'Hydrochlorothiazide', 58, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (46, N'Prednisone', 44, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (14, N'Doxycycline', 50, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (53, N'Propranolol', 48, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (31, N'Simvastatin', 52, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (53, N'Ibuprofen', 12, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (53, N'Levofloxacin', 56, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (35, N'Simvastatin', 51, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (49, N'Amoxicillin', 55, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (29, N'Clopidogrel', 53, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (45, N'Furosemide', 53, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (29, N'Ibuprofen', 43, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (52, N'Cephalexin', 18, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (36, N'Doxycycline', 42, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (52, N'Atenolol', 54, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (43, N'Ibuprofen', 8, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (23, N'Hydrocortisone', 17, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (14, N'Ondansetron', 28, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (41, N'Metronidazole', 39, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (15, N'Tramadol', 58, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (25, N'Pantoprazole', 3, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (1, N'Amiodarone', 60, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (26, N'Hydrochlorothiazide', 28, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (43, N'Propranolol', 21, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (39, N'Spironolactone', 20, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (42, N'Gabapentin', 45, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (17, N'Clopidogrel', 27, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (23, N'Propranolol', 37, N'3x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (52, N'Ketorolac', 54, N'1x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (39, N'Fluconazole', 14, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (42, N'Morphine', 29, N'1x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (28, N'Spironolactone', 31, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (11, N'Fluconazole', 33, N'2x1');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (43, N'Metformin', 53, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (40, N'Albuterol', 52, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (19, N'Ibuprofen', 3, N'2x2');
INSERT INTO dbo.PrescriptionMedicine (PrescriptionID, MedicineName, Dose, Description) VALUES (61, N'Propranolol', 55, N'1x1');

-- Insert sample tests
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (36, 20, N'Lipid Panel', N'Pending', '2024-09-11');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (37, 14, N'COVID-19 PCR', N'Pending', '2025-02-07');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (45, 18, N'Thyroid Panel', N'Normal', '2024-12-21');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (87, 35, N'Urinalysis', N'Requires follow-up', '2024-08-17');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (45, 10, N'Thyroid Panel', N'Normal', '2025-05-16');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (92, 6, N'Glucose', N'Requires follow-up', '2024-11-09');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (33, 31, N'Lipid Panel', N'Abnormal', '2024-08-13');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (69, 18, N'Chest X-Ray', N'Pending', '2025-08-01');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (14, 16, N'Lipid Panel', N'Normal', '2024-11-02');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (68, 15, N'Lipid Panel', N'Normal', '2025-08-20');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (53, 22, N'COVID-19 PCR', N'Normal', '2024-10-27');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (99, 9, N'Blood Count', N'Abnormal', '2025-03-16');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (84, 31, N'COVID-19 PCR', N'Abnormal', '2024-09-18');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (37, 21, N'Thyroid Panel', N'Normal', '2024-07-03');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (99, 6, N'ECG', N'Abnormal', '2025-01-10');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (95, 3, N'Kidney Function', N'Requires follow-up', '2024-07-16');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (23, 3, N'Urinalysis', N'Requires follow-up', '2025-07-07');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (96, 19, N'Blood Count', N'Normal', '2025-05-11');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (73, 7, N'Glucose', N'Pending', '2025-02-20');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (83, 35, N'Chest X-Ray', N'Requires follow-up', '2024-07-12');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (18, 33, N'COVID-19 PCR', N'Pending', '2025-07-04');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (15, 22, N'Kidney Function', N'Requires follow-up', '2024-11-13');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (33, 12, N'Blood Count', N'Pending', '2024-09-01');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (38, 13, N'Kidney Function', N'Requires follow-up', '2024-08-13');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (55, 33, N'Glucose', N'Normal', '2025-03-19');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (86, 7, N'Kidney Function', N'Abnormal', '2025-02-08');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (42, 16, N'Blood Count', N'Pending', '2025-03-28');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (31, 29, N'Thyroid Panel', N'Pending', '2025-05-09');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (75, 1, N'Thyroid Panel', N'Pending', '2024-10-21');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (31, 4, N'Liver Function', N'Requires follow-up', '2025-05-06');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (21, 26, N'Chest X-Ray', N'Pending', '2024-10-22');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (16, 19, N'Glucose', N'Abnormal', '2025-06-20');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (18, 31, N'Kidney Function', N'Requires follow-up', '2024-09-23');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (78, 24, N'Urinalysis', N'Requires follow-up', '2024-09-18');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (69, 14, N'Lipid Panel', N'Normal', '2025-01-14');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (58, 34, N'Glucose', N'Normal', '2024-06-28');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (73, 8, N'Blood Count', N'Abnormal', '2024-12-21');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (69, 10, N'Kidney Function', N'Pending', '2024-07-30');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (67, 29, N'Liver Function', N'Abnormal', '2024-10-08');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (75, 32, N'Liver Function', N'Requires follow-up', '2024-08-22');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (8, 30, N'Kidney Function', N'Requires follow-up', '2025-02-19');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (73, 4, N'Chest X-Ray', N'Requires follow-up', '2024-10-31');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (40, 2, N'Urinalysis', N'Pending', '2024-08-18');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (1, 14, N'ECG', N'Normal', '2025-09-17');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (55, 23, N'Liver Function', N'Normal', '2024-06-19');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (9, 31, N'Blood Count', N'Pending', '2025-03-15');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (24, 9, N'Urinalysis', N'Pending', '2024-07-11');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (49, 29, N'Urinalysis', N'Requires follow-up', '2025-08-30');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (88, 35, N'Kidney Function', N'Pending', '2025-08-11');
INSERT INTO dbo.Test (PatientID, DoctorID, Name, Result, Date) VALUES (23, 35, N'Urinalysis', N'Abnormal', '2024-10-03');


-- Step 6: Final checks
-- Verify counts:
SELECT COUNT(*) AS PrescriptionCount FROM dbo.Prescription;
SELECT COUNT(*) AS PrescriptionMedicineCount FROM dbo.PrescriptionMedicine;
SET NOCOUNT OFF;