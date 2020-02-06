/* TEAM 27 Database Implementation 
Gaurao Thakur,
Chetan Shirsath
*/


CREATE DATABASE TEAM27_CG;

USE TEAM27_CG;
-- address
CREATE TABLE  [address](
	[address_id] [nvarchar](10) NOT NULL PRIMARY KEY,
	[street] [nvarchar](92) NULL,
	[apartment] [nvarchar](50) NULL,
	[area] [nvarchar](100) NULL,
	[city] [nvarchar](85) NULL,
	[zipcode] [nvarchar](6) NULL,
	[state] [nvarchar](55) NULL,
	[country] [nvarchar](75) NULL);
 
 -- Blood Bank
 CREATE TABLE  [blood_bank](
	[bloodbank_id] [nvarchar](10) NOT NULL PRIMARY KEY,
	[name] [nvarchar](100) NULL,
	[email] [nvarchar](100) NULL,
	[phone] [nvarchar](12) NULL,
	[fk_ADDRESS_address_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [address](address_id));
 
 -- Blood Camps
 CREATE TABLE  [blood_camps](
	[idBLOOD_CAMPS] [int] NOT NULL PRIMARY KEY,
	[name] [nvarchar](45) NOT NULL,
	[address] [nvarchar](45) NOT NULL,
	[date] [date] NOT NULL,
	[fk_bloodbank_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [blood_bank](bloodbank_id));
 
 -- Hospital
 CREATE TABLE  [hospital](
	[hospital_id] [nvarchar](10) NOT NULL PRIMARY KEY,
	[hospital_name] [nvarchar](100) NULL,
	[email] [nvarchar](100) NULL,
	[phone] [nvarchar](12) NULL,
	[fk_address_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [address](address_id));
 
 
 -- Blood Request
 CREATE TABLE  [blood_request](
	[emplyee_id] [nvarchar](10) NOT NULL PRIMARY KEY,
	[fk_hospital_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [hospital](hospital_id),
	[emp_firstName] [nvarchar](45) NULL,
	[emp_lastName] [nvarchar](45) NULL,
	[emp_phone] [nvarchar](45) NULL,
	[bloodType_requested] [nvarchar](3) NULL,
	[amount_requested] [int] NULL,
	[delivery_confirmation] [nchar](1) NULL,
	[fk_bloodbank_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [blood_bank](bloodbank_id));
 
 
 --DONOR
 CREATE TABLE  [donor](
	[donor_id] [nvarchar](10) NOT NULL PRIMARY KEY,
	[d_firstName] [nvarchar](45) NULL,
	[d_lastName] [nvarchar](45) NULL,
	[date_of_birth] [date] NULL,
	[d_gender] [nchar](1) NULL,
	[d_phone] [nvarchar](12) NULL,
	[fk_bloodbank_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [blood_bank](bloodbank_id));
	
 
 -- Donation
 CREATE TABLE  [donation](
	[donation_id] [nvarchar](10) NOT NULL PRIMARY KEY,
	[date] [date] NULL,
	[blood_type] [nvarchar](3) NULL,
	[amount_donated] [int] NULL,
	[fk_donor_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [donor](donor_id));
	

-- Donor has address
CREATE TABLE  [donor_has_address](
	[fk_donor_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [donor](donor_id),
	[fk_address_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [address](address_id));
	
	
-- Medical condition
CREATE TABLE  [medical_condition](
	[condition_id] [nvarchar](10) NOT NULL PRIMARY KEY,
	[condition_name] [nvarchar](45) NULL,
	[condition_desc] [nvarchar](200) NULL,
	[condtion_other] [nvarchar](200) NULL);
	
-- Donors medical condition
CREATE TABLE  [donors_medical_condition](
	[fk_donor_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [donor](donor_id),
	[fk_condition_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [medical_condition](condition_id));
	
-- Medication
CREATE TABLE  [medication](
	[medication_id] [nvarchar](10) NOT NULL PRIMARY KEY,
	[medication_name] [nvarchar](45) NULL,
	[medication_desc] [nvarchar](200) NULL,
	[medication_other] [nvarchar](200) NULL);
	
-- Donors medication
CREATE TABLE  [donors_medication](
	[fk_donor_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [donor](donor_id),
	[fk_medication_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [medication](medication_id));
	
	
-- Patient
CREATE TABLE  [patient](
	[idPatient] [int] NOT NULL PRIMARY KEY,
	[first] [nvarchar](45) NOT NULL,
	[lastname] [nvarchar](45) NOT NULL,
	[contact_number] [nvarchar](45) NOT NULL,
	[fk_hospital_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [hospital](hospital_id));
	
-- Patient has address
CREATE TABLE  [patient_has_address](
	[fk_Patient_id] [int] NOT NULL FOREIGN KEY REFERENCES  [patient](idPatient),
	[fk_address_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [address](address_id));

	
-- Staff Category
CREATE TABLE  [staff_category](
	[staff_category_id] [int] NOT NULL PRIMARY KEY,
	[staff_category_name] [nvarchar](45) NULL);
	
	
-- Staff
CREATE TABLE  [staff](
	[staff_id] [nvarchar](10) NOT NULL PRIMARY KEY,
	[staff_firstName] [nvarchar](45) NULL,
	[staff_lastName] [nvarchar](45) NULL,
	[date_of_birth] [date] NULL,
	[staff_gender] [nvarchar](2) NULL,
	[staff_qualification] [nvarchar](45) NULL,
	[fk_staff_category_id] [int] NOT NULL FOREIGN KEY REFERENCES  [staff_category](staff_category_id),
	[fk_bloodbank_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [blood_bank](bloodbank_id));

	
-- staff has address
CREATE TABLE  [staff_has_address](
	[fk_staff_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [staff](staff_id),
	[fk_address_id] [nvarchar](10) NOT NULL FOREIGN KEY REFERENCES  [address](address_id));
	

	-- INSERT DATA
USE TEAM27_CG;


-- PROCEDURE TO INSERT INTO address

 CREATE PROCEDURE sp_insert_Address(
	@address_id varchar(10), 
    @street varchar(92), 
    @apartment varchar(50),
    @area varchar(100),
    @city varchar(85), 
    @zipcode varchar(6), 
    @state varchar(55), 
    @country varchar(75))
	AS 
    BEGIN 

		INSERT INTO address VALUES(@address_id,@street,@apartment,@area,@city,@zipcode,@state,@country);
        
    END;

EXECUTE sp_insert_Address @address_id="1",@street="Smith Street",@apartment="51C",@area="Roxbury",@city="Boston",@zipcode="02120",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="2",@street="Smith Street",@apartment="100A",@area="Roxbury",@city="Boston",@zipcode="02120",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="3",@street="Smith Street",@apartment="199C",@area="Roxbury",@city="Boston",@zipcode="02120",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="4",@street="Ward Street",@apartment="105C",@area="Roxbury",@city="Boston",@zipcode="02120",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="5",@street="Ward Street",@apartment="106C",@area="Roxbury",@city="Boston",@zipcode="02120",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="6",@street="Ward Street",@apartment="19B",@area="Roxbury",@city="Boston",@zipcode="02120",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="7",@street="Parker Street",@apartment="1009B",@area="Fenway",@city="Boston",@zipcode="02115",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="8",@street="Parker Street",@apartment="149B",@area="Fenway",@city="Boston",@zipcode="02115",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="9",@street="Parker Street",@apartment="1013B",@area="Fenway",@city="Boston",@zipcode="02115",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="10",@street="Parker Street",@apartment="1449C",@area="Fenway",@city="Boston",@zipcode="02115",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="11",@street="Mass Avenue",@apartment="1002B",@area="Back Bay",@city="Boston",@zipcode="02120",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="12",@street="Mass Avenue",@apartment="1981",@area="Back Bay",@city="Boston",@zipcode="02115",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="13",@street="Parker Street",@apartment="1491B",@area="Fenway",@city="Boston",@zipcode="02115",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="14",@street="Parker Street",@apartment="1013B",@area="Fenway",@city="Boston",@zipcode="02115",@state="Massachusetts",@country="United States";
EXECUTE sp_insert_Address @address_id="15",@street="Ward Street",@apartment="1444C",@area="Roxbury",@city="Boston",@zipcode="02120",@state="Massachusetts",@country="United States";



-- PROCEDURE TO INSERT INTO blood_bank

 CREATE PROCEDURE sp_insert_BloodBank(
	@bloodbank_id varchar(10), 
    @name varchar(100), 
    @email varchar(100),
    @phone varchar(15),
    @ADDRESS_address_id varchar(10))
	AS
    BEGIN 

		INSERT INTO blood_bank VALUES(@bloodbank_id,@name,@email,@phone,@ADDRESS_address_id);
        
    END;

EXECUTE sp_insert_BloodBank @bloodbank_id="1",@name="NYC Blood Bank",@email="nycbloodbank@bloodbank.com",@phone="857-937-2866",@ADDRESS_address_id="2" ;
EXECUTE sp_insert_BloodBank @bloodbank_id="2",@name="Boston Blood Bank",@email="bostonbloodbank@bloodbank.com",@phone="888-937-2866",@ADDRESS_address_id="1" ;
EXECUTE sp_insert_BloodBank @bloodbank_id="3",@name="Cambridge Blood Bank",@email="cambridgebloodbank@bloodbank.com",@phone="812-937-2166",@ADDRESS_address_id="3" ;
EXECUTE sp_insert_BloodBank @bloodbank_id="4",@name="Bedford Blood Bank",@email="bedfordbloodbank@bloodbank.com",@phone="888-957-9866",@ADDRESS_address_id="4" ;


-- Blood Camps

INSERT INTO  blood_camps VALUES(1,'Boston Univ Blood Camp','Boston University Campus','2019-11-09',1),
(2,'Northeastern Univ Blood Camp','Northeastern University Campus','2019-11-10',1),
(3,'MIT Univ Blood Camp','MIT University Campus','2019-11-10',3),
(4,'Harvard Univ Blood Camp','Harvard University Campus','2019-11-11',4);



-- Hospital

INSERT INTO  HOSPITAL VALUES('1','Boston Children Hospital','boschild@hospital.com','857-698-5236','8'),
('2','Mass General Hospital','mgh@hospital.com','857-698-7854','9'),
('3','Brigham Hospital','brigham@hospital.com','857-698-5214','10'),
('4','New England Hospital','nehealth@hospital.com','857-698-6587','11');



--blood request

INSERT INTO  BLOOD_REQUEST VALUES('1','2','Addy','Kul','857-987-5698','O+',370,'Y','1'),
('2','4','Paul','Adams','857-987-3697','O-',600,'Y','1'),
 ('3','3','Dav','Gilbert','857-987-7412','A-',540,'Y','3'),

 ('4','1','Aditi','Joshi','857-987-8855',	'B+',	450,	'N','2'),
('5','3',	'Kat',	'Adams',	'857-987-2456',	'B-',500,	'Y','2'),
('6','4',	'David','Miller','857-987-9746','A+',660,'N','4');


-- donors

-- SELECT * FROM DONOR;

 CREATE PROCEDURE sp_insert_Donor(
	@id varchar(10), 
    @firstName varchar(100), 
    @lastName varchar(100), 
    @dob date,
	@gender CHAR(1),
    @phone varchar(15),
    @bloodbankId varchar(10))
	as
    BEGIN 

		INSERT INTO  DONOR VALUES(@id,@firstName,@lastName,@dob,@gender,@phone,@bloodbankId);
        
    END ;

-- DELETE FROM  DONOR;

EXEC sp_insert_Donor "1",	"Aditya","Kul","1994-11-25","M","857-399-7138","1" ;
EXEC sp_insert_Donor "2",	"Johny","Kashid","1991-12-03","M","857-399-4569","4" ;
EXEC sp_insert_Donor "3",	"Lilly","J","1989-01-11","F","857-399-9875","4" ;
EXEC sp_insert_Donor "4",	"Netha","Swamy","1988-12-21","F","857-399-3569","3" ;
EXEC sp_insert_Donor "5","Meghan","KUL","1995-03-19","F","857-399-6378","1" ;
EXEC sp_insert_Donor "6", "Ron","TP","1992-11-21","M","857-399-0039","3" ;
EXEC sp_insert_Donor "7","Bob","Golesar","1985-12-21","M","857-399-3596","4" ;
EXEC sp_insert_Donor "8","Babita","Iyer","1991-04-09","F","857-399-3469","1" ;
EXEC sp_insert_Donor "9","Ron","Sweeny","1994-06-27","M","857-399-7789","1" ;
EXEC sp_insert_Donor "10","Dinesh","Mantri","1988-06-12","M","857-399-3336","2" ;



-- donation

-- SELECT * FROM  DONATION;

 CREATE PROCEDURE sp_insert_DONATION(
	@id varchar(10), 
    @donatonDate date,
    @bloodType varchar(3),
    @amount int,
    @donarId varchar(10))
as
    BEGIN 

		INSERT INTO  DONATION VALUES(@id,@donatonDate,@bloodType,@amount,@donarId);
        
    END  ;

EXEC sp_insert_DONATION "1","2019-11-09","B+",380,"1" ;
EXEC sp_insert_DONATION "2"	,"2019-11-09","A+",380,"5" ;
EXEC sp_insert_DONATION "3"	,"2019-11-09","O-",460,"2" ;
EXEC sp_insert_DONATION "4","2019-11-09","A-",380,"6" ;
EXEC sp_insert_DONATION "5","2019-11-09","AB+",380,"3" ;
EXEC sp_insert_DONATION "6","2019-11-10","A-",380,"7" ;
EXEC sp_insert_DONATION "7","2019-11-10","A+",400,"4" ;
EXEC sp_insert_DONATION "8","2018-08-22","B+",400,"1" ;
EXEC sp_insert_DONATION "9","2018-08-22","A+",430,"4" ;
EXEC sp_insert_DONATION "10","2018-08-22","O-",400,"2" ;
EXEC sp_insert_DONATION "11","2018-08-22","A+",430,"5" ;
EXEC sp_insert_DONATION "12","2017-01-20","AB+",380,"3" ;
EXEC sp_insert_DONATION "13","2017-01-20","A-",430,"8" ;
EXEC sp_insert_DONATION "14","2017-01-20","O+",420,"9" ;


-- donor has address

insert into  donor_has_address values('1','14'),
('2','15'),
('3','6'),
('4','14'),
('5','7'),
('6','15'),
('7','2'),
('8','7'),
('9','13'),
('10','14');


-- medical condition

insert into  medical_condition values('1','Fever',null,null),
('2','OCD',null,null),
('3','Diabetes',null,null),
('4','Herpes',null,null),
('5','Arthritis',null,null),
('6','AIDS',null,null),
('7','Cold',null,null),
('8','Cancer',null,null),
('9','Asthma',null,null),
('10','Hypertension',null,null);


-- donors medical condition

insert into  donors_medical_condition values('1','7'),
('2','1'),
('3','3'),
('4','7'),
('5','1'),
('6','2'),
('7','2'),
('8','1'),
('9','3'),
('10','2');


-- INSERT Into Medication table

INSERT INTO medication(medication_id,medication_name,medication_desc,medication_other)
VALUES
('1','Analgesics','These medications help reduce pain, but have no effect on inflammation','No side effects'),
('2','Theophylline','Theophylline is a bronchodilator used as an add-on medication for symptoms that are not responding to other medications.','No side effects'),
('3','Carboplatin','Carboplatin is a cancer medication that interferes with the growth of cancer cells and slows their growth and spread in the body.','Carboplatin can cause side effects that may impair your vision.'),
('4','Alpha-glucosidase inhibitors','These medications help your body break down starchy foods and table sugar.','This effect lowers your blood sugar levels.');


-- donors medication

insert into  donors_medication values('1','4'),
('2','1'),
('3','3'),
('4','1'),
('5','4'),
('6','4'),
('7','2'),
('8','1'),
('9','3'),
('10','1');



-- Patient

insert into  patient values(1,'Ajit', 'Kade', '857-987-5698','1'),
(2,'Kedar', 'Munshi', '857-987-4689','1'),
(3,'Kiran', 'T', '857-987-6699','2'),
(4,'Ron', 'J', '857-987-8888','3'),
(5,'Anil', 'Dighe', '857-987-4452','1'),
(6,'Anita', 'Jay', '857-987-2288','4'),
(7,'Lilly', 'Sweeny', '857-987-3365','4'),
(8,'Eve', 'Hall', '857-987-7789','4'),
(9,'Aniket', 'Patel', '857-987-8856','2'),
(10,'Niks', 'Kashid', '857-987-4469','3');


-- patient has addreess

insert into  patient_has_address values(1,'2'),
(2,'2'),
(3,'6'),
(4,'7'),
(5,'7'),
(6,'13'),
(7,'6'),
(8,'7'),
(9,'13'),
(10,'6');


-- SELECT * FROM  STAFF_CATEGORY;


CREATE PROCEDURE sp_insert_StaffCategory(
	 @id int, 
     @category varchar(45))
as
    BEGIN 

		INSERT INTO  STAFF_CATEGORY VALUES(@id, @category);
        
    END ;


exec sp_insert_StaffCategory 1, "Pathologist";
exec sp_insert_StaffCategory 2,"Cytotechnologists";
exec sp_insert_StaffCategory 3,"Chemistry technicians" ;
exec sp_insert_StaffCategory 4,"Phlebotomists" ;



-- SELECT * FROM  STAFF;
CREATE PROCEDURE sp_insert_Staff(
	@id varchar(10), 
    @firstName varchar(45),
    @lastName varchar(45),
    @dob date,
    @gender varchar(1),
    @qualification varchar(45),
    @categoryId varchar(10),
    @bloodBankId varchar(10))
as
    BEGIN 

		INSERT INTO  STAFF VALUES(@id,@firstName,@lastName,@dob,@gender,@qualification,@categoryId,@bloodBankId);
        
    END ;

	exec sp_insert_Staff "1","Larry", "HALL","1977-04-09","M",	null,	"1", "1" ;
exec sp_insert_Staff "2","ARNAV",	"MK","1981-10-25","F",null,"1", "1" ;
exec sp_insert_Staff "3","AASHAY",	"TW","1979-12-13","M",	null,"2", "1" ;
exec sp_insert_Staff "4","JOHN","SWEENY","1988-03-17","F",	null,	"1", "2" ;
exec sp_insert_Staff "5","ROBERT","GILLIAM","1969-09-18","M",	null,	"3", "1" ;
exec sp_insert_Staff "6","ATUL","PAWAR","1982-02-27","M",	null,	"4", "1" ;
exec sp_insert_Staff "7","RAJ","PATIL","1981-07-29","F",null,	"1", "2" ;
exec sp_insert_Staff "8","ALEX","MK","1979-09-25","F",null,	"2", "3" ;
exec sp_insert_Staff "9","JAY","SHAH","1976-04-19","F",null,	"1", "4" ;
exec sp_insert_Staff "10","LILIUM","KR","1990-07-18","M",null,	"3", "4" ;




-- staff has addreess

insert into  staff_has_address values('1','6'),
('2','6'),
('3','2'),
('4','2'),
('5','13'),
('6','13'),
('7','2'),
('8','7'),
('9','13'),
('10','7');

	
-- Views	
	
-- VIEW Bloodrequests
CREATE VIEW Bloodrequests AS
SELECT bb.name as Blood_Bank_Name, br.bloodType_requested as Requested_BloodType, 
h.hospital_name as Hospital_Name, br.delivery_confirmation asRequest_Status
FROM blood_bank bb 
INNER JOIN blood_request br
ON bb.bloodbank_id = br.fk_bloodbank_id
INNER JOIN hospital h
ON br.fk_hospital_id = h.hospital_id;

select * from Bloodrequests;

-- VIEW BloodDonation
CREATE VIEW BloodDonation AS
SELECT bb.name as Blood_Bank_Name, donor.d_firstName as Donors_FirstName, donor.d_lastName as Donors_LastName,
donation.date as Donation_Date, donation.blood_type as Blood_Type, donation.amount_donated as Donated_BloodAmount
FROM donor donor 
INNER JOIN donation donation
ON donor.donor_id = donation.fk_donor_id
INNER JOIN blood_bank bb
ON bb.bloodbank_id = donor.fk_bloodbank_id;

select * from BloodDonation;


-- Functions
-- Computed Columns based on a function
use TEAM27_CG;

CREATE FUNCTION fn_CalculateBloodAmount(@HospitalID varchar)
RETURNS INT
AS
BEGIN
	DECLARE @bloodamount INT = 0 ;
	SELECT @bloodamount =  SUM(amount_requested)
		FROM blood_request
		WHERE fk_hospital_id=@HospitalID;
		return @bloodamount;
END;

-- CALCULATE TOTAL AMOUNT OF BLOOD REQUESTED BY ANY HOSPITAL
 SELECT h1.hospital_id AS HOSPITAL_ID, h1.hospital_name AS HOSPITAL_NAME, 
	dbo.fn_CalculateBloodAmount(h1.hospital_id) AS TOTAL_BLOOD_REQUESTED
 FROM hospital h1;

 
 
 -- Table-level CHECK Constraints based on a function
  CREATE FUNCTION fn_checkBloodAmount(@totalBloodAmt Int)
  RETURNS varchar(100)
  AS
  BEGIN
     DECLARE @RequestAllowed varchar(100);
	  if(@totalBloodAmt > 1000)
		  BEGIN
			SET @RequestAllowed = 'No further request are allowed for time being';
		  END
	   else 
		   BEGIN
			 SET @RequestAllowed = 'Further request can be made';
		   END

	  return @RequestAllowed;
	END;

 SELECT h1.hospital_id AS HOSPITAL_ID, h1.hospital_name AS HOSPITAL_NAME, 
	dbo.fn_CalculateBloodAmount(h1.hospital_id) AS TOTAL_BLOOD_REQUESTED,
	dbo.fn_checkBloodAmount(dbo.fn_CalculateBloodAmount(h1.hospital_id)) AS BLOOD_REQUEST_STATUS
 FROM hospital h1;