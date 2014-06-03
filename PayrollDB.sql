DROP DATABASE IF EXISTS Eaglewatch;

CREATE DATABASE Eaglewatch;

USE Eaglewatch;

CREATE TABLE FieldEmployeeTypes (
Type VARCHAR(3) PRIMARY KEY,
Description VARCHAR(30) NOT NULL
);

CREATE TABLE FieldEmployees (
ID INT AUTO_INCREMENT PRIMARY KEY,
Type VARCHAR(3) NOT NULL,
FECode VARCHAR(8) UNIQUE KEY NOT NULL,
DisplayCode VARCHAR(8) NOT NULL,
Suffix VARCHAR(10) NOT NULL,
LastName VARCHAR(30) NOT NULL,
FirstName VARCHAR(30) NOT NULL,
MiddleName VARCHAR(30) NOT NULL,
Landline VARCHAR(14) NOT NULL,
MobileNo VARCHAR(39) NOT NULL,
Address VARCHAR(250) NOT NULL,
BirthDate DATE NOT NULL,
Gender CHAR(1) NOT NULL,
CivilStatus VARCHAR(10) NOT NULL,
Dependents INT NOT NULL,
Skills VARCHAR(150) NOT NULL,
DateHired DATE NOT NULL,
DateResigned DATE NOT NULL DEFAULT '0000-00-00',
FieldEmpStatus VARCHAR(8) NOT NULL,
CholStatus VARCHAR(2) NOT NULL,
FileStatus VARCHAR(3) NOT NULL,
FOREIGN KEY (Type) REFERENCES FieldEmployeeTypes(Type)
);

CREATE TABLE Clients (
ID INT AUTO_INCREMENT PRIMARY KEY,
Code VARCHAR(5) UNIQUE KEY NOT NULL,
Name VARCHAR(30) NOT NULL,
BillingAddress VARCHAR(200) NOT NULL,
City VARCHAR(30) NOT NULL,
Landline VARCHAR(14) NOT NULL
);

CREATE TABLE ClientContactPersons (
ID INT AUTO_INCREMENT PRIMARY KEY,
ClientID INT NOT NULL,
Suffix VARCHAR(5) NOT NULL,
LastName VARCHAR(30) NOT NULL,
FirstName VARCHAR(30) NOT NULL,
MiddleName VARCHAR(30) NOT NULL,
Landline VARCHAR(14) NOT NULL,
MobileNo VARCHAR(39) NOT NULL,
BirthDate DATE NOT NULL,
FOREIGN KEY (ClientID) REFERENCES Clients(ID) 
);
CREATE TABLE HolidayMOR (
Type VARCHAR(2) PRIMARY KEY,
Description VARCHAR(30) NOT NULL
);

CREATE TABLE IncentiveMOR (
Type VARCHAR(2) PRIMARY KEY,
Description VARCHAR(30) NOT NULL
);

CREATE TABLE RateTypes (
Type VARCHAR(3) PRIMARY KEY,
Description VARCHAR(30) NOT NULL
);

CREATE TABLE Rates (
ID INT AUTO_INCREMENT PRIMARY KEY,
RateType VARCHAR(3) NOT NULL,
HolidayType VARCHAR(2) NOT NULL,
IncentiveType VARCHAR(2) NOT NULL,
Regular DECIMAL(10,2) NOT NULL,
Overtime DECIMAL(10,2) NOT NULL,
NDifferential DECIMAL(10,2) NOT NULL,
ECOLA DECIMAL(10,2) NOT NULL,
ThirteenMonth DECIMAL(10,2) NOT NULL,
PhilHealth DECIMAL(10,2) NOT NULL,
PagibigPrem DECIMAL(10,2) NOT NULL,
Incentive DECIMAL(10,2) NOT NULL,
LegalHoliday DECIMAL(10,2) NOT NULL,
SpecialHoliday DECIMAL(10,2) NOT NULL,
EffectiveDate DATE NOT NULL,
FOREIGN KEY (RateType) REFERENCES RateTypes(Type),
FOREIGN KEY (HolidayType) REFERENCES HolidayMOR(Type),
FOREIGN KEY (IncentiveType) REFERENCES IncentiveMOR(Type)
);

CREATE TABLE Detachments (
ID INT AUTO_INCREMENT PRIMARY KEY,
ClientID INT NOT NULL,
RateID INT NOT NULL,
Code VARCHAR(7) NOT NULL,
Name VARCHAR(30) NOT NULL,
Address VARCHAR(200) NOT NULL,
City VARCHAR(30) NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
Status VARCHAR(10) NOT NULL,
FOREIGN KEY (ClientID) REFERENCES Clients(ID),
FOREIGN KEY (RateID) REFERENCES Rates(ID)
);

CREATE TABLE DetachmentContactPersons (
ID INT AUTO_INCREMENT PRIMARY KEY,
DetachID INT NOT NULL,
Suffix VARCHAR(5) NOT NULL,
LastName VARCHAR(30) NOT NULL,
FirstName VARCHAR(30) NOT NULL,
MiddleName VARCHAR(30) NOT NULL,
Landline VARCHAR(14) NOT NULL,
MobileNo VARCHAR(39) NOT NULL,
BirthDate DATE NOT NULL,
FOREIGN KEY (DetachID) REFERENCES Detachments(ID)
);

CREATE TABLE Allowances (
ID INT AUTO_INCREMENT PRIMARY KEY,
DetachID INT NOT NULL,
FieldEmpID INT NOT NULL,
Amount DECIMAL(10,2) NOT NULL,
LastUpdateDate DATE NOT NULL,
Status VARCHAR(8) NOT NULL,
FOREIGN KEY (DetachID) REFERENCES Detachments(ID),
FOREIGN KEY (FieldEmpID) REFERENCES FieldEmployees(ID)
);

CREATE TABLE AuthorizedManHours (
ID INT AUTO_INCREMENT PRIMARY KEY,
DetachID INT NOT NULL,
WorkingDays INT NOT NULL,
Saturdays INT NOT NULL,
Holidays INT NOT NULL,
EffectiveDate DATE NOT NULL,
FOREIGN KEY (DetachID) REFERENCES Detachments(ID)
);

CREATE TABLE ManHourLogs(
ID INT AUTO_INCREMENT PRIMARY KEY,
DetachID INT NOT NULL,
FieldEmpID INT NOT NULL,
NoOfFullDays INT(2) NOT NULL,
NightHours INT(5) NOT NULL,
RegHours INT(5) NOT NULL,
OTHours INT(5) NOT NULL,
LegHolidayHours INT(5) NOT NULL,
SpeHolidayHours INT(5) NOT NULL,
DateCreated DATE NOT NULL,
PeriodCode VARCHAR(4) NOT NULL,
FOREIGN KEY (DetachID) REFERENCES Detachments(ID),
FOREIGN KEY (FieldEmpID) REFERENCES FieldEmployees(ID)
);

CREATE TABLE SSSContributions (
ID INT AUTO_INCREMENT PRIMARY KEY,
PriceFrom DECIMAL(10,2) NOT NULL,
PriceTo DECIMAL(10,2) NOT NULL,
ER DECIMAL(10,2) NOT NULL,
EE DECIMAL(10,2) NOT NULL,
EffectiveYear YEAR NOT NULL
);

CREATE TABLE PersonalPayables (
ID INT AUTO_INCREMENT PRIMARY KEY,
FieldEmpID INT NOT NULL,
Type VARCHAR(30) NOT NULL,
Amount DECIMAL(10,2) NOT NULL,
PeriodCode INT(4) NOT NULL,
DateCreated DATE NOT NULL,
FOREIGN KEY (FieldEmpID) REFERENCES FieldEmployees(ID)
);

CREATE TABLE UniformDeposits (
ID INT AUTO_INCREMENT PRIMARY KEY,
FieldEmpID INT NOT NULL,
Amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (FieldEmpID) REFERENCES FieldEmployees(ID)
);

CREATE TABLE SSSLoans (
ID INT AUTO_INCREMENT PRIMARY KEY,
FieldEmpID INT NOT NULL,
Amount DECIMAL(10,2) NOT NULL,
MonthlyPay DECIMAL(10,2) NOT NULL,
Balance DECIMAL(10,2) NOT NULL,
DateCreated DATE NOT NULL,
FOREIGN KEY (FieldEmpID) REFERENCES FieldEmployees(ID)
);

CREATE TABLE PagibigCalamityLoans (
ID INT AUTO_INCREMENT PRIMARY KEY,
FieldEmpID INT NOT NULL,
Amount DECIMAL(10,2) NOT NULL,
MonthlyPay DECIMAL(10,2) NOT NULL,
Balance DECIMAL(10,2) NOT NULL,
DateCreated DATE NOT NULL,
FOREIGN KEY (FieldEmpID) REFERENCES FieldEmployees(ID)
);

CREATE TABLE PagibigSalaryLoans (
ID INT AUTO_INCREMENT PRIMARY KEY,
FieldEmpID INT NOT NULL,
Amount DECIMAL(10,2) NOT NULL,
MonthlyPay DECIMAL(10,2) NOT NULL,
Balance DECIMAL(10,2) NOT NULL,
DateCreated DATE NOT NULL,
FOREIGN KEY (FieldEmpID) REFERENCES FieldEmployees(ID)
);

CREATE TABLE PayrollRecord (
ID INT AUTO_INCREMENT PRIMARY KEY,
MHLogID INT NOT NULL,
UniDepoID INT NOT NULL,
Regular DECIMAL(10,2) NOT NULL,
Overtime DECIMAL(10,2) NOT NULL,
NDifferential DECIMAL(10,2) NOT NULL,
ECOLA DECIMAL(10,2) NOT NULL,
LegalHoliday DECIMAL(10,2) NOT NULL,
SpecialHoliday DECIMAL(10,2) NOT NULL,
Allowance DECIMAL(10,2) NOT NULL,
SSSCon DECIMAL(10,2) NOT NULL,
SSSLoan DECIMAL(10,2) NOT NULL,
CalamityLoan DECIMAL(10,2) NOT NULL,
SalaryLoan DECIMAL(10,2) NOT NULL,
PersonalPayable DECIMAL(10,2) NOT NULL,
NetPays DECIMAL(10,2) NOT NULL,
FOREIGN KEY (MHLogID) REFERENCES ManHourLogs(ID),
FOREIGN KEY (UniDepoID) REFERENCES UniformDeposits(ID)
);

CREATE TABLE Receivables (
ID INT AUTO_INCREMENT PRIMARY KEY,
FieldEmpID INT NOT NULL,
CholFund DECIMAL(10,2) NOT NULL,
EmpFileFund DECIMAL(10,2) NOT NULL,
HolidayPay DECIMAL(10,2) NOT NULL,
ThirteenMonthPay DECIMAL(10,2) NOT NULL,
IncentivesPay DECIMAL(10,2) NOT NULL,
UniAllowance DECIMAL(10,2) NOT NULL,
UniDeposit DECIMAL(10,2) NOT NULL,
FOREIGN KEY (FieldEmpID) REFERENCES FieldEmployees(ID)
);

CREATE TABLE OfficeEmployeeTypes (
Type VARCHAR(10) PRIMARY KEY NOT NULL,
Description VARCHAR(30) NOT NULL
);

CREATE TABLE OfficeEmployees (
ID INT AUTO_INCREMENT PRIMARY KEY,
Type VARCHAR(10) NOT NULL,
Username VARCHAR(50) UNIQUE KEY NOT NULL,
Password VARCHAR(100) NOT NULL,
Suffix VARCHAR(10) NOT NULL,
LastName VARCHAR(30) NOT NULL,
FirstName VARCHAR(30) NOT NULL,
MiddleName VARCHAR(30) NOT NULL,
Landline VARCHAR(14) NOT NULL,
MobileNo VARCHAR(39) NOT NULL,
Address VARCHAR(250) NOT NULL,
BirthDate DATE NOT NULL,
Gender CHAR(1) NOT NULL,
CivilStatus VARCHAR(10) NOT NULL,
Dependents INT NOT NULL,
Position VARCHAR(50) NOT NULL,
DateHired DATE NOT NULL,
DateResigned DATE NOT NULL,
EmpStatus VARCHAR(15) NOT NULL,
FOREIGN KEY (Type) REFERENCES OfficeEmployeeTypes(Type)
);

CREATE TABLE Logs (
ID INT AUTO_INCREMENT PRIMARY KEY,
EmpID INT NOT NULL,
Type VARCHAR(30) NOT NULL,
Description VARCHAR(50) NOT NULL,
Timestamp TIMESTAMP
);


###########   DELIMITERS   #############
delimiter $$

###   FUNCTIONS   ###

#Generating Code
CREATE FUNCTION generateCode(prefix VARCHAR(3), ctr INT, len INT)
RETURNS VARCHAR(50)
BEGIN
  DECLARE ID VARCHAR(8);
  DECLARE counter INT DEFAULT 1;
  DECLARE totLen INT DEFAULT 0;

	IF LENGTH(prefix) + LENGTH(ctr) > len THEN
  	   RETURN 'ERROR: The code number exceeded in maximum length of code';
 	ELSE
	   IF LENGTH(prefix) + LENGTH(ctr) != len THEN
	     SET ID = '0';
	     IF LENGTH(CONCAT_WS(ID,prefix,ctr)) = len THEN
	        RETURN CONCAT_WS(ID,prefix,ctr);
	     ELSE
	        SET totLen = len - (LENGTH(prefix) + LENGTH(ctr));
	        looping:
	          LOOP
	           IF counter = totLen THEN
	              LEAVE looping;
	           END IF;
	           SET ID = CONCAT(ID,'0');
	           SET counter = counter + 1;
	          END LOOP;
	        RETURN CONCAT_WS(ID,prefix,ctr);
	     END IF;
   	END IF;
     RETURN CONCAT(prefix,ctr);
   END IF;
END $$

###   PROCEDURES   ###

#Getting Max No of ID
CREATE PROCEDURE getMaxIDByTB(TableName VARCHAR(30), OUT No INT)
BEGIN	
	SET @GetMaxID =
    CONCAT('SELECT ID+1 INTO @ID FROM ', TableName, ' ORDER BY ID DESC LIMIT 1');
	  PREPARE stmt FROM @GetMaxID;
	  EXECUTE stmt;

  SET No = @ID;
END $$

###   PROCEDURES FOR INSERTING and UPDATING DATA  ###

#Field Employee
CREATE PROCEDURE addFE(
	Type VARCHAR(3),
	DisplayCode VARCHAR(8),
	Suffix VARCHAR(10),
	LastName VARCHAR(30),
	FirstName VARCHAR(30),
	MiddleName VARCHAR(30),
	Landline VARCHAR(14),
	MobileNo VARCHAR(39),
	Address VARCHAR(250),
	BirthDate DATE,
	Gender CHAR(1),
	CivilStatus VARCHAR(10),
	Dependents INT,
	Skills VARCHAR(150),
	CholStatus VARCHAR(2),
	FileStatus VARCHAR(3))
BEGIN	
	CALL getMaxIDByTB('FieldEmployees',@NewID);
	INSERT INTO FieldEmployees
	(Type,FECode,DisplayCode,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Skills,DateHired,DateResigned,FieldEmpStatus,CholStatus,FileStatus)
	VALUES
	(Type,generateCode('FE',@NewID,8),DisplayCode,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Skills,CURDATE(),'0000-00-00','Floating',CholStatus,FileStatus);
END $$
#CALL addFE('SV',1111,'Jr.','Fabularum','Raymond','Maranan','(02)1234567','09121234567 / 09121234567','Caloocan City','2000-01-20','M','Single',0,'Driving, Reading, Shooting','C','C');

CREATE PROCEDURE updateFE(
	iID INT,
	iFECode VARCHAR(8),
	iType VARCHAR(3),
	iDisplayCode VARCHAR(8),
	iSuffix VARCHAR(10),
	iLastName VARCHAR(30),
	iFirstName VARCHAR(30),
	iMiddleName VARCHAR(30),
	iLandline VARCHAR(14),
	iMobileNo VARCHAR(39),
	iAddress VARCHAR(250),
	iBirthDate DATE,
	iGender CHAR(1),
	iCivilStatus VARCHAR(10),
	iDependents INT,
	iSkills VARCHAR(150),
	iDateResigned DATE,
	iFieldEmpStatus VARCHAR(8),
	iCholStatus VARCHAR(2),
	iFileStatus VARCHAR(3))
BEGIN	
	UPDATE FieldEmployees
	SET 
	Type=iType,DisplayCode=iDisplayCode,Suffix=iSuffix,LastName=iLastName,FirstName=iFirstName,MiddleName=iMiddleName,Landline=iLandline,MobileNo=iMobileNo,Address=iAddress,BirthDate=iBirthDate,Gender=iGender,CivilStatus=iCivilStatus,Dependents=iDependents,Skills=iSkills,DateResigned=iDateResigned,FieldEmpStatus=iFieldEmpStatus,CholStatus=iCholStatus,FileStatus=iFileStatus
	WHERE
	FECode=iFECode AND ID=iID;
END $$
#CALL updateFE(5,'FE000005','SV',1111,'Jr.','Fabularum','Raymond','Maranan','(02)1234567','09121234567 / 09121234567','Caloocan City','2000-01-20','M','Single',0,'Driving, Reading, Shooting','0000-00-00','Active','C','C');

#Client
CREATE PROCEDURE addClient(
	Name VARCHAR(30),
	BillingAddress VARCHAR(200),
	City VARCHAR(30),
	Landline VARCHAR(14))
BEGIN	
	CALL getMaxIDByTB('Clients',@NewID);
	INSERT INTO Clients
	(Code,Name,BillingAddress,City,Landline)
	VALUES
	(generateCode('C',@NewID,5),Name,BillingAddress,City,Landline);

END $$
#CALL addClient(Name,BillingAddress,City,Landline);

CREATE PROCEDURE updateClient(
	iCode VARCHAR(5),
	iName VARCHAR(30),
	iBillingAddress VARCHAR(200),
	iCity VARCHAR(30),
	iLandline VARCHAR(14))
BEGIN	
	UPDATE Clients
	SET 
	Name=iName,BillingAddress=iBillingAddress,City=iCity,Landline=iLandline
	WHERE
	Code=iCode;
END $$

#CALL updateClient(Code,Name,BillingAddress,City,Landline);

#Client Contact Person
CREATE PROCEDURE addClientCP(	
	ClientID INT,
	Suffix VARCHAR(5),
	LastName VARCHAR(30),
	FirstName VARCHAR(30),
	MiddleName VARCHAR(30),
	Landline VARCHAR(14),
	MobileNo VARCHAR(39),
	BirthDate DATE)
BEGIN	
	INSERT INTO ClientContactPersons
	(ClientID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate)
	VALUES
	(ClientID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate);

END $$
#CALL addClientPerson(ClientID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate);

CREATE PROCEDURE updateClientCP(	
	iID INT,
	iClientID INT,
	iSuffix VARCHAR(5),
	iLastName VARCHAR(30),
	iFirstName VARCHAR(30),
	iMiddleName VARCHAR(30),
	iLandline VARCHAR(14),
	iMobileNo VARCHAR(39),
	iBirthDate DATE)
BEGIN	
	UPDATE ClientContactPersons
	SET
	ClientID = iClientID, Suffix = iSuffix,LastName = LastName,FirstName = iFirstName,MiddleName = iMiddleName, Landline = iLandline,MobileNo = iMobileNo, BirthDate = iBirthDate
	WHERE
	ID = iID;

END $$
#CALL updateClientPerson(ID,ClientID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate);


#Rate
CREATE PROCEDURE addRate(	
	RateType VARCHAR(3),
	HolidayType VARCHAR(2),
	IncentiveType VARCHAR(2),
	Regular DECIMAL(10,2),
	Overtime DECIMAL(10,2),
	NDifferential DECIMAL(10,2),
	ECOLA DECIMAL(10,2),
	ThirteenMonth DECIMAL(10,2),
	PhilHealth DECIMAL(10,2),
	PagibigPrem DECIMAL(10,2),
	Incentive DECIMAL(10,2),
	LegalHoliday DECIMAL(10,2),
	SpecialHoliday DECIMAL(10,2),
	EffectiveDate DATE)
BEGIN	
	INSERT INTO Rates
	(RateType,HolidayType,IncentiveType,Regular,Overtime,NDifferential,ECOLA,ThirteenMonth,PhilHealth,PagibigPrem,Incentive,LegalHoliday,SpecialHoliday,EffectiveDate)
	VALUES
	(RateType,HolidayType,IncentiveType,Regular,Overtime,NDifferential,ECOLA,ThirteenMonth,PhilHealth,PagibigPrem,Incentive,LegalHoliday,SpecialHoliday,EffectiveDate);

END $$
#CALL addRate(RateType,HolidayType,IncentiveType,Regular,Overtime,NDifferential,ECOLA,ThirteenMonth,PhilHealth,PagibigPrem,Incentive,LegalHoliday,SpecialHoliday,EffectiveDate);

#Detachment
CREATE PROCEDURE addDetachment(	
	ClientID INT,
	RateID INT,
	Name VARCHAR(30),
	Address VARCHAR(200),
	City VARCHAR(30),
	StartDate DATE,
	EndDate DATE,
	Status VARCHAR(10))
BEGIN	
	CALL getMaxIDByTB('Detachments',@NewID);
	INSERT INTO Detachments
	(ClientID,RateID,Code,Name,Address,City,StartDate,EndDate,Status)
	VALUES
	(ClientID,RateID,generateCode('D',@NewID,7),Name,Address,City,StartDate,EndDate,Status);
END $$

CREATE PROCEDURE updateDetachment(	
	iCode VARCHAR(7),
	iClientID INT,
	iRateID INT,
	iName VARCHAR(30),
	iAddress VARCHAR(200),
	iCity VARCHAR(30),
	iStartDate DATE,
	iEndDate DATE,
	iStatus VARCHAR(10))
BEGIN	
	CALL getMaxIDByTB('Detachments',@NewID);
	UPDATE Detachments
	SET
	ClientID=iClientID,RateID=iRateID,Name=iName,Address=iAddress,City=iCity,StartDate=iStartDate,EndDate=iEndDate,Status=iStatus
	WHERE
	Code = iCode;
END $$
#CALL updateDetachment('D000001',2,1,'Mc Donalds SM North EDSA','Grace Park Caloocan City','Caloocan','2014-06-02','0000-00-00','Waiting');

#Detachment Contact Person
CREATE PROCEDURE addDetachmentCP(	
	DetachID INT,
	Suffix VARCHAR(5),
	LastName VARCHAR(30),
	FirstName VARCHAR(30),
	MiddleName VARCHAR(3),
	Landline VARCHAR(14),
	MobileNo VARCHAR(39),
	BirthDate DATE)
BEGIN	
	INSERT INTO DetachmentContactPersons
	(DetachID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate)
	VALUES
	(DetachID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate);

END $$
#CALL addDetachmentCP(ClientID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate);


CREATE PROCEDURE updateDetachmentCP(	
	iID INT,
	iDetachID INT,
	iSuffix VARCHAR(5),
	iLastName VARCHAR(30),
	iFirstName VARCHAR(30),
	iMiddleName VARCHAR(3),
	iLandline VARCHAR(14),
	iMobileNo VARCHAR(39),
	iBirthDate DATE)
BEGIN	
	UPDATE DetachmentContactPersons
	SET
	DetachID = iDetachID, Suffix = iSuffix,LastName = LastName,FirstName = iFirstName,MiddleName = iMiddleName, Landline = iLandline,MobileNo = iMobileNo, BirthDate = iBirthDate
	WHERE
	ID = iID;

END $$
#CALL updateDetachmentCP(ID,ClientID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate);

#Allowance
CREATE PROCEDURE addAllowance(	
	DetachID INT,
	FieldEmpID INT,
	Amount DECIMAL(10,2),
	Status VARCHAR(8))
BEGIN	
	INSERT INTO Allowances
	(DetachID,FieldEmpID,Amount,LastUpdateDate,Status)
	VALUES
	(DetachID,FieldEmpID,Amount,CURDATE(),Status);

END $$
#CALL addAllowance(DetachID,FieldEmpID,Amount,Status);

CREATE PROCEDURE updateAllowance(	
	iID INT,
	iDetachID INT,
	iFieldEmpID INT,
	iAmount DECIMAL(10,2),
	iStatus VARCHAR(8))
BEGIN	
	UPDATE Allowances
	SET
	DetachID = iDetachID, FieldEmpID = iFieldEmpID, Amount =iAmount, LastUpdateDate = CURDATE(), Status = iStatus
	WHERE
	ID = iID;

END $$
#CALL updateAllowance(ID,DetachID,FieldEmpID,Amount,Status);

#Authorized Man Hours
CREATE PROCEDURE addAuthManHour(	
	DetachID INT,
	WorkingDays INT,
	Saturdays INT,
	Holidays INT,
	EffectiveDate DATE)
BEGIN	
	INSERT INTO AuthorizedManHours
	(DetachID,WorkingDays,Saturdays,Holidays,EffectiveDate)
	VALUES
	(DetachID,WorkingDays,Saturdays,Holidays,EffectiveDate);

END $$
#CALL addAuthManHour(DetachID,WorkingDays,Saturdays,Holidays,EffectiveDate);

CREATE PROCEDURE updateAuthManHour(	
	iID INT,
	iDetachID INT,
	iWorkingDays INT,
	iSaturdays INT,
	iHolidays INT,
	iEffectiveDate DATE)
BEGIN	
	UPDATE AuthorizedManHours
	SET
	DetachID =iDetachID, WorkingDays = iWorkingDays, Saturdays=iSaturdays, Holidays=iHolidays,EffectiveDate=iEffectiveDate
	WHERE ID = iID;

END $$
#CALL updateAuthManHour(ID,DetachID,WorkingDays,Saturdays,Holidays,EffectiveDate);

#Man Hours
CREATE PROCEDURE addManHour(	
	DetachID INT,
	FieldEmpID INT,
	NoOfFullDays INT(2),
	NightHours INT(5),
	RegHours INT(5),
	OTHours INT(5),
	LegHolidayHours INT(5),
	SpeHolidayHours INT(5),
	PeriodCode VARCHAR(4))
BEGIN	
	INSERT INTO ManHourLogs
	(DetachID,FieldEmpID,NoOfFullDays,NightHours,RegHours,OTHours,LegHolidayHours,SpeHolidayHours,DateCreated,PeriodCode)
	VALUES
	(DetachID,FieldEmpID,NoOfFullDays,NightHours,RegHours,OTHours,LegHolidayHours,SpeHolidayHours,CURDATE(),PeriodCode);

END $$
#CALL addManHour(DetachID,FieldEmpID,NoOfFullDays,NightHours,RegHours,OTHours,LegHolidayHours,SpeHolidayHours,PeriodCode);

CREATE PROCEDURE updateManHour(	
	iID INT,	
	iDetachID INT,
	iFieldEmpID INT,
	iNoOfFullDays INT(2),
	iNightHours INT(5),
	iRegHours INT(5),
	iOTHours INT(5),
	iLegHolidayHours INT(5),
	iSpeHolidayHours INT(5),
	iPeriodCode VARCHAR(4))
BEGIN	
	UPDATE ManHourLogs
	SET
	DetachID = iDetachID, FieldEmpID = iFieldEmpID, NoOfFullDays = iNoOfFullDays, NightHours = iNightHours, RegHours = iRegHours, OTHours = iOTHours, LegHolidayHours = iLegHolidayHours, SpeHolidayHours = iSpeHolidayHours, PeriodCode = iPeriodCode
	WHERE
	ID = iID;

END $$
#CALL updateManHour(ID,DetachID,FieldEmpID,NoOfFullDays,NightHours,RegHours,OTHours,LegHolidayHours,SpeHolidayHours,PeriodCode);


CREATE PROCEDURE addPersonalPayable(	
	FieldEmpID INT,
	Type VARCHAR(30),
	Amount DECIMAL(10,2),
	PeriodCode INT(4))
BEGIN	
	INSERT INTO PersonalPayables
	(FieldEmpID,Type,Amount,PeriodCode,DateCreated)
	VALUES
	(FieldEmpID,Type,Amount,PeriodCode,CURDATE());

END $$
#CALL addPersonalPayable(FieldEmpID,Type,Amount,PeriodCode);


CREATE PROCEDURE updatePersonalPayable(	
	iID INT,	
	iFieldEmpID INT,
	iType VARCHAR(30),
	iAmount DECIMAL(10,2),
	iPeriodCode INT(4))
BEGIN	
	UPDATE PersonalPayables
	SET
	FieldEmpID = iFieldEmpID, Type = iType, Amount = iAmount,PeriodCode = iPeriodCode
	WHERE
	ID = iID;

END $$
#CALL updatePersonalPayable(ID,FieldEmpID,Type,Amount,PeriodCode);

#Uniform Deposit
CREATE PROCEDURE addUniformDepo(	
	FieldEmpID INT,
	Amount DECIMAL(10,2))
BEGIN	
	INSERT INTO UniformDeposits
	(FieldEmpID,Amount)
	VALUES
	(FieldEmpID,Amount);

END $$

CREATE PROCEDURE updateUniformDepo(	
	iID INT,
	FieldEmpID INT,
	Amount DECIMAL(10,2))
BEGIN	
	UPDATE UniformDeposits
	SET
	FieldEmpID = iFieldEmpID, Amount = iAmount
	WHERE
	ID = iID;

END $$

#SSS Loans

CREATE PROCEDURE addSSSLoan(	
	FieldEmpID INT,
	Amount DECIMAL(10,2),
	MonthlyPay DECIMAL(10,2))
BEGIN
	INSERT INTO SSSLoans
	(FieldEmpID,Amount,MonthlyPay,Balance,DateCreated)
	VALUES
	(FieldEmpID,Amount,MonthlyPay,Amount,CURDATE());

END $$
#CALL addSSSLoan((FieldEmpID,Amount,MonthlyPay);

CREATE PROCEDURE updateSSSLoan(	
	iID INT,
	iFieldEmpID INT)
BEGIN
	UPDATE SSSLoans
	SET
	Balance = (Balance - MonthlyPay)
	WHERE
	ID = iID AND FieldEmpID = iFieldEmpID AND Balance > 0;
END $$
#CALL updateSSSLoan(ID,FieldEmpID);

CREATE PROCEDURE deleteSSSLoan(	
	iID INT,
	iFieldEmpID INT)
BEGIN
	DELETE SSSLoans
	WHERE
	ID = iID AND FieldEmpID = iFieldEmpID;
END $$
#CALL deleteSSSLoan(ID,FieldEmpID);

#Calamity Loans

CREATE PROCEDURE addCalamityLoan(	
	FieldEmpID INT,
	Amount DECIMAL(10,2),
	MonthlyPay DECIMAL(10,2))
BEGIN	
	INSERT INTO PagibigCalamityLoans
	(FieldEmpID,Amount,MonthlyPay,Balance,DateCreated)
	VALUES
	(FieldEmpID,Amount,MonthlyPay,Amount,CURDATE());

END $$
#CALL addCalamityLoan((FieldEmpID,Amount,MonthlyPay);

CREATE PROCEDURE updateCalamityLoan(	
	iID INT,
	iFieldEmpID INT)
BEGIN
	UPDATE PagibigCalamityLoans
	SET
	Balance = (Balance - MonthlyPay)
	WHERE
	ID = iID AND FieldEmpID = iFieldEmpID AND Balance > 0;
END $$
#CALL updateCalamityLoan(ID,FieldEmpID);

CREATE PROCEDURE deleteCalamityLoan(	
	iID INT,
	iFieldEmpID INT)
BEGIN
	DELETE PagibigCalamityLoans
	WHERE
	ID = iID AND FieldEmpID = iFieldEmpID;
END $$
#CALL deleteCalamityLoan(ID,FieldEmpID);


#Salary Loans

CREATE PROCEDURE addSalaryLoan(	
	FieldEmpID INT,
	Amount DECIMAL(10,2),
	MonthlyPay DECIMAL(10,2))
BEGIN	
	INSERT INTO PagibigSalaryLoans
	(FieldEmpID,Amount,MonthlyPay,Balance,DateCreated)
	VALUES
	(FieldEmpID,Amount,MonthlyPay,Amount,CURDATE());

END $$
#CALL addCalamityLoan((FieldEmpID,Amount,MonthlyPay);

CREATE PROCEDURE updateSalaryLoan(	
	iID INT,
	iFieldEmpID INT)
BEGIN
	UPDATE PagibigSalaryLoans
	SET
	Balance = (Balance - MonthlyPay)
	WHERE
	ID = iID AND FieldEmpID = iFieldEmpID AND Balance > 0;
END $$
#CALL updateCalamityLoan(ID,FieldEmpID);

CREATE PROCEDURE deleteSalaryLoan(	
	iID INT,
	iFieldEmpID INT)
BEGIN
	DELETE PagibigSalaryLoans
	WHERE
	ID = iID AND FieldEmpID = iFieldEmpID;
END $$
#CALL deleteCalamityLoan(ID,FieldEmpID);

#Get amount from SSS COntribution
CREATE PROCEDURE getSSSCon(
	iFieldEmpID INT,
	OUT EEAmt DECIMAL(10,2)	)
BEGIN
	SELECT (m.RegHours * r.Regular),(m.OTHours * r.Overtime), (m.NightHours * r.NDifferential), (m.NoOfFullDays * r.ECOLA) 
	INTO @RegPay, @OT,@Night,@ECOLAPay
	FROM ManHourLogs m
	INNER JOIN Detachments d ON m.DetachID = d.ID
	INNER JOIN FieldEmployees fe ON m.FieldEmpID = fe.ID
	INNER JOIN Rates r ON d.RateID = r.ID
	WHERE m.NoOfFullDays <> 0 AND fe.ID = iFieldEmpID;
	
	SELECT EE INTO @Amt FROM SSSContributions WHERE PriceFrom <= (@RegPay + @OT + @Night + @ECOLAPay) AND PriceTo >= (@RegPay + @OT + @Night + @ECOLAPay);
	SET EEAmt = @Amt;
END $$
#CALL getSSSCon(3,@Amt);SELECT @Amt;

#########################################################################



delimiter ;

###########  END OF DELIMITERS   #############


###########  INSERTING DATA   #############

#FieldEmployeeTypes
INSERT INTO FieldEmployeeTypes (Type,Description) VALUES ('SV','Supervisor');
INSERT INTO FieldEmployeeTypes (Type,Description) VALUES ('SG','Security Guard');
INSERT INTO FieldEmployeeTypes (Type,Description) VALUES ('LG','Lady Guard');
INSERT INTO FieldEmployeeTypes (Type,Description) VALUES ('CSA','Customer Service Assistant');
#RateTypes
INSERT INTO RateTypes (Type,Description) VALUES ('MR','Monthly Rate');
INSERT INTO RateTypes (Type,Description) VALUES ('HR','Hourly Rate');
#HolidayMOR
INSERT INTO HolidayMOR (Type,Description) VALUES ('PD','Pay Day');
INSERT INTO HolidayMOR (Type,Description) VALUES ('YE','Year End');
#IncentiveMOR
INSERT INTO IncentiveMOR (Type,Description) VALUES ('PD','Pay Day');
INSERT INTO IncentiveMOR (Type,Description) VALUES ('YE','Year End');
#SSSContributions
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (1000,1249.99,90.70,33.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (1250,1749.99,116,33.50,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (1750,2249.99,151.30,66.70,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (2250,2749.99,186.70,83.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (2750,3249.99,222,100,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (3250,3749.99,257.30,116.70,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (3750,4249.99,292.70,133.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (4250,4749.99,328,150,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (4750,5249.99,363.30,167.70,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (5250,5749.99,398.70,183.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (5750,6249.99,434,200,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (6250,6749.99,469.30,216.70,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (6750,7249.99,504.70,233.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (7250,7749.99,540,250,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (7750,8249.99,575.30,266.70,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (8250,8749.99,610.70,283.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (8750,9249.99,646,300,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (9250,9749.99,681.30,316.70,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (9750,10249.99,716.70,333.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (10250,10749.99,752,350,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (10750,11249.99,787.30,366.70,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (11250,11749.99,822.70,383.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (11750,12249.99,858,400,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (12250,12749.99,893.30,416.70,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (12750,13249.99,928.70,433.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (13250,13749.99,964,450,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (13750,14249.99,999.30,466.70,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (14250,14749.99,1034.70,483.30,2014);
INSERT INTO SSSContributions (PriceFrom,PriceTo,ER,EE,EffectiveYear) VALUES (14750,30000,1060,500,2014);
#OfficeEmployeeTypes
INSERT INTO OfficeEmployeeTypes (Type,Description) VALUES ('ADM', 'Administrator');
INSERT INTO OfficeEmployeeTypes (Type,Description) VALUES ('PrO', 'Payroll Officer');
INSERT INTO OfficeEmployeeTypes (Type,Description) VALUES ('BiO', 'Billing Officer');
INSERT INTO OfficeEmployeeTypes (Type,Description) VALUES ('HR', 'Human Resource Officer');
INSERT INTO OfficeEmployeeTypes (Type,Description) VALUES ('BeO', 'Benefit Officer');
INSERT INTO OfficeEmployeeTypes (Type,Description) VALUES ('PyO', 'Payable Officer');
INSERT INTO OfficeEmployeeTypes (Type,Description) VALUES ('MO', 'Man Hour Officer');
INSERT INTO OfficeEmployeeTypes (Type,Description) VALUES ('RO', 'Receivable Officer');
INSERT INTO OfficeEmployeeTypes (Type,Description) VALUES ('DO', 'Deployment Officer');
#OfficeEmployees
INSERT INTO OfficeEmployees
(Type,Username,Password,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Position,DateHired,DateResigned,EmpStatus)
VALUES
('ADM','Admin',SHA1('1234'),'IV','Jamila','Sergio','O.','(2)1234567','09121234567','Commonwealth','1989-01-06','M','Single',0,'President and Owner',CURDATE(),'0000-00-00','Active');
INSERT INTO OfficeEmployees
(Type,Username,Password,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Position,DateHired,DateResigned,EmpStatus)
VALUES
('PrO','PayrollOfficer',SHA1('1234'),'','Monje','Josef','O.','(2)1234567','09121234567','Commonwealth','1989-01-06','M','Single',0,'Payroll Officer',CURDATE(),'0000-00-00','Active');
INSERT INTO OfficeEmployees
(Type,Username,Password,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Position,DateHired,DateResigned,EmpStatus)
VALUES
('BiO','BillingOfficer',SHA1('1234'),'','Monje','Josef','O.','(2)1234567','09121234567','Commonwealth','1989-01-06','M','Single',0,'Billing Officer',CURDATE(),'0000-00-00','Active');
INSERT INTO OfficeEmployees
(Type,Username,Password,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Position,DateHired,DateResigned,EmpStatus)
VALUES
('HR','HROfficer',SHA1('1234'),'','Monje','Josef','O.','(2)1234567','09121234567','Commonwealth','1989-01-06','M','Single',0,'Human Resource Officer',CURDATE(),'0000-00-00','Active');
INSERT INTO OfficeEmployees
(Type,Username,Password,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Position,DateHired,DateResigned,EmpStatus)
VALUES
('BeO','BenefitOfficer',SHA1('1234'),'','Monje','Josef','O.','(2)1234567','09121234567','Commonwealth','1989-01-06','M','Single',0,'Benefit Officer',CURDATE(),'0000-00-00','Active');
INSERT INTO OfficeEmployees
(Type,Username,Password,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Position,DateHired,DateResigned,EmpStatus)
VALUES
('PyO','PayableOfficer',SHA1('1234'),'','Monje','Josef','O.','(2)1234567','09121234567','Commonwealth','1989-01-06','M','Single',0,'Payable Officer',CURDATE(),'0000-00-00','Active');
INSERT INTO OfficeEmployees
(Type,Username,Password,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Position,DateHired,DateResigned,EmpStatus)
VALUES
('MO','ManHourOfficer',SHA1('1234'),'','Monje','Josef','O.','(2)1234567','09121234567','Commonwealth','1989-01-06','M','Single',0,'Man Hour Officer',CURDATE(),'0000-00-00','Active');
INSERT INTO OfficeEmployees
(Type,Username,Password,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Position,DateHired,DateResigned,EmpStatus)
VALUES
('RO','ReceivableOfficer',SHA1('1234'),'','Monje','Josef','O.','(2)1234567','09121234567','Commonwealth','1989-01-06','M','Single',0,'Receivable Officer',CURDATE(),'0000-00-00','Active');
INSERT INTO OfficeEmployees
(Type,Username,Password,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Position,DateHired,DateResigned,EmpStatus)
VALUES
('DO','DeploymentOfficer',SHA1('1234'),'','Monje','Josef','O.','(2)1234567','09121234567','Commonwealth','1989-01-06','M','Single',0,'Deployment Officer',CURDATE(),'0000-00-00','Active');

#### Test Data #####

#FieldEmployees
INSERT INTO FieldEmployees
(Type,FECode,DisplayCode,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,Address,BirthDate,Gender,CivilStatus,Dependents,Skills,DateHired,FieldEmpStatus,CholStatus,FileStatus)
VALUES
('SV','FE000001',1234,'Test','Test','Test','Test','(02)1234567','09121234567 / 09121234567','Test Test Test Test','2001-01-31','T','Test',0,'Test Test Test',CURDATE(),'Test','T','T');
#Clients
INSERT INTO Clients
(Code,Name,BillingAddress,City,Landline)
VALUES
('C0001','Test','Test Test Test ','Test','(02)1234567');
#ClientContactPersons
INSERT INTO ClientContactPersons
(ClientID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate)
VALUES
(1,'Jr.','Person 1','Person 1','Person 1','(02)1234567','09121234567 / 09121234567','2000-01-20');
INSERT INTO ClientContactPersons
(ClientID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate)
VALUES
(1,'Sr.','Person 2','Person 2','Person 1','(02)1234567','09121234567 / 09121234567','2000-01-20');

####Inserting New Rate
INSERT INTO Rates
(RateType,HolidayType,IncentiveType,Regular,Overtime,NDifferential,ECOLA,ThirteenMonth,PhilHealth,PagibigPrem,Incentive,LegalHoliday,SpecialHoliday,EffectiveDate)
VALUES
('HR','PD','PD',40,50,50,30,40,35,35,20,60,40,'2013-06-01');
INSERT INTO Rates
(RateType,HolidayType,IncentiveType,Regular,Overtime,NDifferential,ECOLA,ThirteenMonth,PhilHealth,PagibigPrem,Incentive,LegalHoliday,SpecialHoliday,EffectiveDate)
VALUES
('HR','YE','YE',40,50,50,30,40,35,35,20,60,40,'2013-06-01');

#Detachments
INSERT INTO Detachments
(ClientID,RateID,Code,Name,Address,City,StartDate,EndDate,Status)
VALUES
(1,1,'D000001','Test Test','Test Test','Test','2014-06-01','0000-00-00','Test');
#DetachmentContactPersons
INSERT INTO DetachmentContactPersons
(DetachID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate)
VALUES
(1,'Jr.','Person 1','Person 1','P.','(02)1234567','09121234567 / 09121234567','2000-01-20');
INSERT INTO DetachmentContactPersons
(DetachID,Suffix,LastName,FirstName,MiddleName,Landline,MobileNo,BirthDate)
VALUES
(1,'Sr.','Person 2','Person 2','P.','(02)1234567','09121234567 / 09121234567','2000-01-20');


#######################   SAMPLE DATA   #####################

####Inserting New Field Employee
CALL addFE('SV',1234,'Jr.','Monje','Josef','Maranan','(02)1234567','09121234567 / 09121234567','Caloocan City','2000-01-20','M','Single',0,'Driving, Reading, Shooting','C','C');
CALL addFE('SG',1234,'Jr.','Yeung','John','','(02)1234567','09121234567 / 09121234567','Caloocan City','2000-01-20','M','Single',0,'Driving, Reading, Shooting','C','C');
CALL addFE('SG',1234,'Jr.','Mendez','JC','','(02)1234567','09121234567 / 09121234567','Caloocan City','2000-01-20','M','Single',0,'Driving, Reading, Shooting','C','C');

####Inserting New Client

CALL addClient('Mc Donalds','Malate, Metro Manila','Quezon','(02)8154708');

####Inserting New ContactPerson for Client

CALL addClientCP(2,'','Jamila','Nadine','ABCDEF','(02)1234567','09121234567 / 09121234567','2000-01-20');

####Inserting New Detachments
CALL addDetachment(2,1,'Mc Donalds Valenzuela','McArthur Highway Marulas Valenzuela City','Valenzuela','2014-06-01','0000-00-00','Waiting');
CALL addDetachment(2,1,'Mc Donalds Caloocan','Grace Park Caloocan City','Caloocan','2014-06-02','0000-00-00','Waiting');
CALL addDetachment(2,1,'Mc Donalds SM North EDSA','Grace Park Caloocan City','Caloocan','2014-06-02','0000-00-00','Waiting');

####Inserting New ContactPerson for Detachment

CALL addDetachmentCP(2,'Jr.','Fabularum','Raymond','P.','(02)1234567','09121234567 / 09121234567','2000-01-20');

CALL addDetachmentCP(2,'Jr.','Monje','Josef','P.','(02)1234567','09121234567 / 09121234567','2000-01-20');

CALL addDetachmentCP(2,'Jr.','Samy','Mervin','P.','(02)1234567','09121234567 / 09121234567','2000-01-20');

CALL addDetachmentCP(2,'III','Sandy','Sandy','P.','(02)1234567','09121234567 / 09121234567','2000-01-20');

####Allowances
CALL addAllowance(2,2,650,'Active');

####AuthorizedManHours
CALL addAuthManHour(2,10,2,3,'2014-06-01');

####ManHourLogs

CALL addManHour(2,3,13,0,104,52,0,0,'1114');
CALL addManHour(2,4,13,0,104,52,0,0,'1114');

####PersonalPayables
CALL addPersonalPayable(3,'Payable',150,'1114');
CALL addPersonalPayable(3,'Cash Advance',2000,'1114');
CALL addPersonalPayable(3,'Water',2000,'1114');

####UniformDeposits
CALL addUniformDepo(2,60);
CALL addUniformDepo(3,175);
CALL addUniformDepo(4,175);

####SSSLoans

CALL addSSSLoan(4,10000,120);

####PagibigCalamityLoans
CALL addCalamityLoan(4,10000,120);

####PagibigSalaryLoans
CALL addSalaryLoan(4,10000,120);

####PayrollRecord
# Field EmpID No 3
INSERT INTO PayrollRecord
(MHLogID,UniDepoID,Allowance,Regular,Overtime,NDifferential,ECOLA,LegalHoliday,SpecialHoliday,SSSCon,SSSLoan,CalamityLoan,SalaryLoan,PersonalPayable,NetPays)
VALUES
(1,2,0,4160,2600,0,390,0,0,233.30,0,0,0,0,6742);
# Field EmpID No 4
INSERT INTO PayrollRecord
(MHLogID,UniDepoID,Allowance,Regular,Overtime,NDifferential,ECOLA,LegalHoliday,SpecialHoliday,SSSCon,SSSLoan,CalamityLoan,SalaryLoan,PersonalPayable,NetPays)
VALUES
(1,3,0,4160,2600,0,390,0,0,233.30,120,120,120,360,6742);

#DROP USER 'AdminPayroll';

#CREATE USER 'AdminPayroll' IDENTIFIED BY 'Password';

#GRANT ALL ON Eaglewatch.* TO AdminPayroll;
