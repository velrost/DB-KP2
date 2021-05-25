DROP TABLE IF EXISTS ZNO_Result;
DROP TABLE IF EXISTS Participant;
DROP TABLE IF EXISTS Educational_Institution;
DROP TABLE IF EXISTS Location;


CREATE TABLE Location (
    location_id SERIAL PRIMARY KEY,
    TerTypeName VARCHAR(40),
    TerName VARCHAR(255),
    AreaName VARCHAR(255),
    RegName VARCHAR(255)
);


CREATE TABLE Educational_Institution (
    InstitutionName VARCHAR(255) PRIMARY KEY,
    TypeName VARCHAR(255),
    location_id SERIAL REFERENCES Location(location_id),
    Category VARCHAR(255)
);


CREATE TABLE Participant (
    OutID VARCHAR(40) PRIMARY KEY,
    birth INTEGER,
    SexTypeName VARCHAR(40),
    location_id SERIAL REFERENCES Location(location_id),
    ParticipType VARCHAR(255),
    ClassProfileName VARCHAR(255),
    ClassLangName VARCHAR(255),
    InstitutionName VARCHAR(255) REFERENCES Educational_Institution(InstitutionName)
);


CREATE TABLE ZNO_Result (
    OutID VARCHAR(40) REFERENCES Participant(OutID) NOT NULL,
    TestName VARCHAR(255) NOT NULL,
    Year INTEGER NOT NULL,
    Lang VARCHAR(255),
    TestStatus VARCHAR(255),
    DPA_mark VARCHAR(255),
    Ball_100 REAL,
    Ball_12 REAL,
    Ball REAL,
    AdaptScale VARCHAR(10),
    PTName VARCHAR(255) REFERENCES Educational_Institution(InstitutionName),
    PRIMARY KEY(OutID, TestName, Year)
);