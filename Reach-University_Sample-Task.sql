USE Census;

-- This will join all of the tables together into one dataset
SELECT * FROM student_roster2 AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN employer ON zipcode.SonisID=employer.SonisID;

-- This will give me the count of students enrolled by Entry Date who have a status of Enrolled
SELECT EntryDate, COUNT(roster.SonisID) AS Count FROM student_roster AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN employer ON zipcode.SonisID=employer.SonisID
WHERE StatusCode="Enrolled Student" AND (State="Louisiana" OR State="Arkansas")
GROUP BY EntryDate;

-- This will give me the count of total students enrolled by Entry Date 
SELECT EntryDate, COUNT(roster.SonisID) AS Count FROM student_roster AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN employer ON zipcode.SonisID=employer.SonisID
WHERE State="Louisiana" OR State="Arkansas"
GROUP BY EntryDate;

-- This will give me the count of enrollment grouped by ethnicity 
SELECT EthnicityIPEDs AS Ethnicity, COUNT(roster.SonisID) AS Count FROM student_roster AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN employer ON zipcode.SonisID=employer.SonisID
WHERE StatusCode="Enrolled Student" AND (State="Louisiana" OR State="Arkansas")
GROUP BY EthnicityIPEDs;

-- This will give me the count of enrollment grouped by gender 
SELECT Gender, COUNT(roster.SonisID) AS Count FROM student_roster AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN employer ON zipcode.SonisID=employer.SonisID
WHERE StatusCode="Enrolled Student" AND (State="Louisiana" OR State="Arkansas")
GROUP BY Gender;

-- This will give the count of the top 3 districts with the highest number of enrolled students
SELECT DistrictName, COUNT(roster.SonisID) AS Count FROM student_roster2 AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN employer ON zipcode.SonisID=employer.SonisID
WHERE StatusCode="Enrolled Student" AND DistrictName NOT LIKE "%No District Listed%" AND (State="Louisiana" OR State="Arkansas")
GROUP BY DistrictName
ORDER BY Count DESC
LIMIT 3;

-- This will give the count of the top 3 counties with the highest number of enrolled students
SELECT CountyName, COUNT(roster.SonisID) AS Count FROM student_roster2 AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN employer ON zipcode.SonisID=employer.SonisID
WHERE StatusCode="Enrolled Student" AND CountyName NOT LIKE "%No County Name Listed%"  AND (State="Louisiana" OR State="Arkansas")
GROUP BY CountyName
ORDER BY Count DESC
LIMIT 3;

-- This will give identify the students who live in rural communities
SELECT * FROM student_roster2 AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN federal_rural_zipcodes ON zipcode.ZipCode=federal_rural_zipcodes.ZipCode;

-- This will give the count of the enrolled students who live in rural communities
SELECT StatusCode, COUNT(roster.SonisID) AS Count FROM student_roster2 AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN federal_rural_zipcodes ON zipcode.ZipCode=federal_rural_zipcodes.ZipCode
WHERE State="Louisiana" OR State="Arkansas"
GROUP BY StatusCode;

-- This will give the total count of the enrolled students
SELECT StatusCode, COUNT(roster.SonisID) AS Count FROM student_roster2 AS roster
LEFT JOIN student_demographics AS demographics ON roster.SonisID=demographics.SonisID
LEFT JOIN state_zipcode AS zipcode ON demographics.SonisID=zipcode.SonisID
LEFT JOIN employer ON zipcode.SonisID=employer.SonisID
GROUP BY StatusCode;