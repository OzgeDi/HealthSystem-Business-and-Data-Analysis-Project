--Show each appointment with patient, doctor,hospital and clinic info:
SELECT 
    Appointment.AppointmentID,
    Patient.FirstName + ' ' + Patient.LastName AS PatientName,
    Doctor.FirstName + ' ' + Doctor.LastName AS DoctorName,
    Clinic.Name AS ClinicName,
    Appointment.Date,
    Appointment.Time,
    Hospital.HospitalName
FROM Appointment
INNER JOIN Patient ON Appointment.PatientID = Patient.PatientID
INNER JOIN Doctor ON Appointment.DoctorID = Doctor.DoctorID
INNER JOIN Clinic ON Appointment.ClinicID = Clinic.ClinicID
INNER JOIN Hospital ON Hospital.HospitalID = Clinic.HospitalID
ORDER BY Appointment.Date DESC;


--List each prescription with doctor, patient, and medicines:
SELECT 
    Prescription.PrescriptionID,
    Patient.FirstName + ' ' + Patient.LastName AS PatientName,
    Doctor.FirstName + ' ' + Doctor.LastName AS DoctorName,
    PrescriptionMedicine.MedicineName AS MedicineName,
    PrescriptionMedicine.Dose,
    Prescription.PrescriptionDate
FROM Prescription
INNER JOIN Patient ON Prescription.PatientID = Patient.PatientID
INNER JOIN Doctor ON Prescription.DoctorID = Doctor.DoctorID
INNER JOIN PrescriptionMedicine ON Prescription.PrescriptionID = PrescriptionMedicine.PrescriptionID
ORDER BY Prescription.PrescriptionDate DESC;


--Tests taken by each patient
SELECT 
    Test.TestID,
    Patient.FirstName + ' ' + Patient.LastName AS PatientName,
    Doctor.FirstName + ' ' + Doctor.LastName AS DoctorName,
    Test.Name AS TestName,
    Test.Result,
    Test.Date
FROM Test
INNER JOIN Patient ON Test.PatientID = Patient.PatientID
INNER JOIN Doctor ON Test.DoctorID = Doctor.DoctorID
ORDER BY Test.Date DESC;


--Clinics and Their Hospitals
SELECT 
    Clinic.Name AS ClinicName,
    Hospital.HospitalName AS HospitalName,
    Hospital.Address,
    Hospital.Phone
FROM Clinic
INNER JOIN Hospital ON Clinic.HospitalID = Hospital.HospitalID;


--Total appointments per doctor
SELECT 
    Doctor.FirstName + ' ' + Doctor.LastName AS DoctorName,
    COUNT(Appointment.AppointmentID) AS TotalAppointments
FROM Doctor
LEFT JOIN Appointment ON Doctor.DoctorID = Appointment.DoctorID
GROUP BY Doctor.FirstName, Doctor.LastName
ORDER BY TotalAppointments DESC;


--Patients with no appointments
SELECT 
    Patient.PatientID,
    Patient.FirstName + ' ' + Patient.LastName AS PatientName,
    Patient.Phone,
    Patient.Email
FROM Patient
LEFT JOIN Appointment ON Patient.PatientID = Appointment.PatientID
WHERE Appointment.AppointmentID IS NULL;


--Count of prescriptions per Patient
SELECT 
    Patient.FirstName + ' ' + Patient.LastName AS PatientName,
    COUNT(Prescription.PrescriptionID) AS TotalPrescriptions
FROM Patient
LEFT JOIN Prescription ON Patient.PatientID = Prescription.PatientID
GROUP BY Patient.FirstName, Patient.LastName
ORDER BY TotalPrescriptions DESC;


--Doctors who haven’t written any prescriptions(with DISTINCT)
SELECT Doctor.DoctorID, 
Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor Name], 
Doctor.Specialty
FROM Doctor
LEFT JOIN Prescription ON Prescription.DoctorID=Doctor.DoctorID
WHERE Doctor.DoctorID NOT IN (SELECT DISTINCT Prescription.DoctorID FROM Prescription)


--Doctors who haven’t written any prescriptions(with IS NULL)
SELECT 
    Doctor.DoctorID,
    Doctor.FirstName + ' ' + Doctor.LastName AS DoctorName,
    Doctor.Specialty
FROM Doctor
LEFT JOIN Prescription ON Doctor.DoctorID = Prescription.DoctorID
WHERE Prescription.DoctorID IS NULL;


--Show all patients’ names, birth dates, and phone numbers, sorted by the most recent birth date
SELECT FirstName, LastName,BirthDate, Phone FROM Patient
ORDER BY BirthDate DESC


--List all doctors and how many appointments each has had.
SELECT 
    Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor Name],
    COUNT (AppointmentID) AS [Total Appointment]
    FROM Doctor
LEFT JOIN Appointment ON Appointment.DoctorID=Doctor.DoctorID
GROUP BY Doctor.FirstName + ' ' + Doctor.LastName
ORDER BY [Total Appointment] DESC


--Find the total number of appointments made in each clinic
SELECT Clinic.Name AS [Clinic Name], COUNT(AppointmentID) AS [Total Appointment] FROM Clinic
LEFT JOIN Appointment ON Appointment.ClinicID=Clinic.ClinicID
GROUP BY Clinic.Name


--Show all tests done by patients whose results contain the word "Abnormal"
SELECT FirstName + ' ' + LastName AS [Patient Name],
Test.Name AS [Test Category],
Test.Result
FROM Patient 
INNER JOIN Test ON Patient.PatientID=Test.PatientID
WHERE Test.Result LIKE 'Abnormal'


--List all medicines that appear in more than one prescription
SELECT PrescriptionMedicine.MedicineName, COUNT(PrescriptionMedicine.PrescriptionMedicineID) AS [Total Medicine Prescribed] 
FROM PrescriptionMedicine
GROUP BY PrescriptionMedicine.MedicineName
HAVING COUNT(PrescriptionMedicine.PrescriptionMedicineID) > 1


--Show each prescription together with the patient name, doctor name, and prescribed medicine
SELECT Prescription.PrescriptionID,Patient.FirstName + ' ' + Patient.LastName AS [Patient's Name],
Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor's Name], 
PrescriptionMedicine.MedicineName AS [Prescribed Medicine Name]
FROM Prescription
LEFT JOIN PrescriptionMedicine ON PrescriptionMedicine.PrescriptionID=Prescription.PrescriptionID
LEFT JOIN Patient ON Patient.PatientID=Prescription.PatientID
LEFT JOIN Doctor ON Doctor.DoctorID=Prescription.DoctorID


--Display all appointments and their date with the hospital and clinic they belong to.
SELECT AppointmentID,Appointment.Date, 
Clinic.Name AS [Clinic],
Hospital.HospitalName AS [Hospital]
FROM Appointment
LEFT JOIN Clinic ON Clinic.ClinicID= Appointment.ClinicID
LEFT JOIN Hospital ON Hospital.HospitalID=Clinic.HospitalID


--List all patients who have never taken any test.
SELECT FirstName + ' ' + LastName AS [Patient Name],
Test.TestID
FROM Patient
LEFT JOIN Test ON Test.PatientID=Patient.PatientID
WHERE Test.TestID IS NULL;


--Show the doctors who have never written a prescription.
SELECT FirstName + ' ' + LastName AS [Doctor's Name],
Prescription.PrescriptionID
FROM Doctor
LEFT JOIN Prescription ON Prescription.DoctorID=Doctor.DoctorID
WHERE Prescription.PrescriptionID IS NULL


--Find each patient’s total prescribed medicine quantitity
SELECT Patient.FirstName + ' ' + Patient.LastName AS [Patient's Name],
SUM(PrescriptionMedicine.Dose) AS [Total Medicine Quantity]
FROM PrescriptionMedicine
INNER JOIN Prescription ON Prescription.PrescriptionID=PrescriptionMedicine.PrescriptionID
INNER JOIN Patient ON Patient.PatientID=Prescription.PatientID
GROUP BY Patient.FirstName, Patient.LastName
ORDER BY [Total Medicine Quantity] DESC


--Which hospital has the most clinics?
SELECT TOP 1 Hospital.HospitalName,
COUNT(Clinic.HospitalID) AS [How many clinic]
FROM Clinic
LEFT JOIN Hospital ON Hospital.HospitalID=Clinic.HospitalID
GROUP BY HospitalName
ORDER BY COUNT(Clinic.HospitalID) DESC


--Which doctor has written the most prescriptions?
SELECT TOP 1 Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor's Name],
COUNT(Prescription.DoctorID) AS [Total number of prescription] 
FROM Prescription
LEFT JOIN Doctor ON Doctor.DoctorID=Prescription.DoctorID
GROUP BY Doctor.FirstName,Doctor.LastName
ORDER BY COUNT(Prescription.DoctorID) DESC


--Which medicine has been prescribed the most?
SELECT TOP 1 PrescriptionMedicine.MedicineName AS [Medicine],
COUNT(PrescriptionMedicineID) AS [Total prescribed number]
FROM PrescriptionMedicine
GROUP BY MedicineName
ORDER BY COUNT(PrescriptionMedicineID) DESC


--How many appointments were made per month in 2025?
SELECT MONTH(Date) AS [MONTH] , COUNT(AppointmentID) AS [Total Appointment]
FROM Appointment
WHERE YEAR(Date) = 2025
GROUP BY MONTH(Date)


--Show the total number of appointments per doctor
SELECT Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor's Name],
COUNT(Appointment.DoctorID) AS [Doctor's Total Appointment]
FROM Doctor
LEFT JOIN Appointment ON Appointment.DoctorID=Doctor.DoctorID
GROUP BY Doctor.FirstName,Doctor.LastName


--Show all patients who visited more than one doctor.
SELECT Patient.FirstName + ' ' + Patient.LastName AS [Patient's Name], 
COUNT(DISTINCT Appointment.DoctorID) AS [Number of Different Doctors]
FROM Patient
INNER JOIN Appointment ON Appointment.PatientID=Patient.PatientID
GROUP BY Patient.FirstName, Patient.LastName
HAVING COUNT(DISTINCT Appointment.DoctorID) > 1


--Find the doctor–patient pairs who have met more than 1 times in appointments.
SELECT Patient.FirstName + ' ' + Patient.LastName AS [Patient's Name], 
Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor's Name],
COUNT(Appointment.AppointmentID) AS [Total Meeting]
FROM Patient
INNER JOIN Appointment ON Appointment.PatientID=Patient.PatientID
INNER JOIN Doctor ON Doctor.DoctorID=Appointment.DoctorID
GROUP BY Patient.FirstName, Patient.LastName, Doctor.FirstName,Doctor.LastName
HAVING COUNT(Appointment.AppointmentID) > 1


--List all patients who had a test and a prescription on the same day.
SELECT Patient.FirstName + ' ' + Patient.LastName AS [Patient's Name],
Test.Date [Test Date], 
Prescription.PrescriptionDate [Prescription Date]
FROM Patient
INNER JOIN Test ON Test.PatientID=Patient.PatientID
INNER JOIN Prescription ON Prescription.PatientID=Test.PatientID
WHERE Test.Date = Prescription.PrescriptionDate


--Find the clinic that handled the highest number of different patients.
SELECT TOP 1 Clinic.Name AS [Clinic Name],
COUNT(DISTINCT Appointment.PatientID) AS [Total Handled Patient]
FROM Clinic
INNER JOIN Appointment ON Appointment.ClinicID=Clinic.ClinicID
INNER JOIN Patient ON Patient.PatientID=Appointment.PatientID
GROUP BY Clinic.Name
ORDER BY COUNT(DISTINCT Appointment.PatientID) DESC


--Queries below; Generated by ChatGPT
--Display the top 5 most active doctors by total number of tests + prescriptions + appointments.
SELECT TOP 5
    Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor Name],
    SUM(AllCounts.ActivityCount) AS [Total Activity]
FROM Doctor
LEFT JOIN (
    SELECT DoctorID, COUNT(*) AS ActivityCount FROM Test GROUP BY DoctorID
    UNION ALL
    SELECT DoctorID, COUNT(*) AS ActivityCount FROM Prescription GROUP BY DoctorID
    UNION ALL
    SELECT DoctorID, COUNT(*) AS ActivityCount FROM Appointment GROUP BY DoctorID
) AS AllCounts ON Doctor.DoctorID = AllCounts.DoctorID
GROUP BY Doctor.FirstName, Doctor.LastName
ORDER BY SUM(AllCounts.ActivityCount) DESC;


--Display the top 5 most active doctors by total number of tests + prescriptions + appointments (also show each seperately)
SELECT TOP 5
    Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor Name],
    (SELECT COUNT(*) FROM Test WHERE Test.DoctorID = Doctor.DoctorID) AS TestCount,
    (SELECT COUNT(*) FROM Prescription WHERE Prescription.DoctorID = Doctor.DoctorID) AS PrescriptionCount,
    (SELECT COUNT(*) FROM Appointment WHERE Appointment.DoctorID = Doctor.DoctorID) AS AppointmentCount,
    ( (SELECT COUNT(*) FROM Test WHERE Test.DoctorID = Doctor.DoctorID)
      + (SELECT COUNT(*) FROM Prescription WHERE Prescription.DoctorID = Doctor.DoctorID)
      + (SELECT COUNT(*) FROM Appointment WHERE Appointment.DoctorID = Doctor.DoctorID)
    ) AS TotalActivity
FROM Doctor
ORDER BY TotalActivity DESC;


--Display the top 5 most active doctors by total number of tests + prescriptions + appointments (also show each seperately)
SELECT TOP 5
    Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor Name],
    ISNULL(TestCounts.TestCount, 0)           AS [Test Count],
    ISNULL(PrescCounts.PrescriptionCount, 0) AS [Prescription Count],
    ISNULL(AppCounts.AppointmentCount, 0)    AS [Appointment Count],
    (ISNULL(TestCounts.TestCount, 0)
     + ISNULL(PrescCounts.PrescriptionCount, 0)
     + ISNULL(AppCounts.AppointmentCount, 0)) AS [Total Activity]
FROM Doctor
LEFT JOIN (
    SELECT DoctorID, COUNT(*) AS TestCount
    FROM Test
    GROUP BY DoctorID
) AS TestCounts ON Doctor.DoctorID = TestCounts.DoctorID
LEFT JOIN (
    SELECT DoctorID, COUNT(*) AS PrescriptionCount
    FROM Prescription
    GROUP BY DoctorID
) AS PrescCounts ON Doctor.DoctorID = PrescCounts.DoctorID
LEFT JOIN (
    SELECT DoctorID, COUNT(*) AS AppointmentCount
    FROM Appointment
    GROUP BY DoctorID
) AS AppCounts ON Doctor.DoctorID = AppCounts.DoctorID
ORDER BY [Total Activity] DESC;


--Show the average number of appointment per doctor(with subquery)
SELECT 
    AVG(AppointmentCount) AS [Average Appointment per Doctor]
FROM (
    SELECT COUNT(AppointmentID) AS AppointmentCount
    FROM Appointment
    GROUP BY DoctorID
) AS SubQuery;


--Show the average number of appointment per doctor(using with)
WITH DoctorAppointments AS (
    SELECT 
        DoctorID,
        COUNT(AppointmentID) AS TotalAppointments
    FROM Appointment
    GROUP BY DoctorID
)
SELECT 
    AVG(TotalAppointments) AS [Average Appointments Per Doctor]
FROM DoctorAppointments;


--Find doctors who have appointments on the latest appointment date
SELECT 
    Doctor.DoctorID, 
    FirstName + ' ' + LastName AS [Doctor], 
    Specialty,
    Appointment.Date
FROM Doctor
INNER JOIN Appointment ON Appointment.DoctorID=Doctor.DoctorID
WHERE Appointment.Date = (
    SELECT MAX(Appointment.Date)
    FROM Appointment
);


-- Rank doctors by total number of appointments
SELECT 
    Doctor.DoctorID,
    Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor],
    COUNT(Appointment.AppointmentID) AS TotalAppointments,
    RANK() OVER (ORDER BY COUNT(Appointment.AppointmentID) DESC) AS [RankByAppointments]
FROM Doctor
INNER JOIN Appointment
    ON Doctor.DoctorID = Appointment.DoctorID
GROUP BY Doctor.DoctorID, Doctor.FirstName, Doctor.LastName
ORDER BY [RankByAppointments];


-- Rank doctors by total number of appointments (no gaps in ranking)
SELECT 
    Doctor.DoctorID,
    Doctor.FirstName + ' ' + Doctor.LastName AS [Doctor],
    COUNT(Appointment.AppointmentID) AS TotalAppointments,
    DENSE_RANK() OVER (ORDER BY COUNT(Appointment.AppointmentID) DESC) AS [DenseRankByAppointments]
FROM Doctor
INNER JOIN Appointment
    ON Doctor.DoctorID = Appointment.DoctorID
GROUP BY Doctor.DoctorID, Doctor.FirstName, Doctor.LastName
ORDER BY [DenseRankByAppointments];


--Combine first name and last name into one column
SELECT 
    DoctorID,
    CONCAT(FirstName, ' ', LastName) AS [FullName],
    Specialty
FROM Doctor;


SELECT * FROM Appointment
WHERE Appointment.Date=CURRENT_DATE


--Find appointments scheduled for today
SELECT 
    AppointmentID,
    DoctorID,
    PatientID,
    Date,
    Time
FROM Appointment
WHERE CAST(Date AS DATE) = CAST(GETDATE() AS DATE);


--All appointments from the current month
SELECT 
    AppointmentID,
    DoctorID,
    PatientID,
    Date
FROM Appointment
WHERE DATEPART(MONTH, Date) = DATEPART(MONTH, GETDATE())
  AND DATEPART(YEAR, Date) = DATEPART(YEAR, GETDATE());


--How many days passed between the appointment date and today
SELECT 
    AppointmentID,
    PatientID,
    Date,
    DATEDIFF(DAY, Date, GETDATE()) AS [DaysSinceAppointment]
FROM Appointment;
