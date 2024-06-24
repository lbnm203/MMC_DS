CREATE DATABASE Testing_System_Db;

USE Testing_System_Db;

CREATE TABLE Department (
    DepartmentID INT AUTO_INCREMENT, DepartmentName VARCHAR(255), PRIMARY KEY (DepartmentID)
);

CREATE TABLE `Position` (
    PositionID INT AUTO_INCREMENT, PositionName VARCHAR(255), PRIMARY KEY (PositionID)
);

CREATE TABLE Account (
    AccountID INT AUTO_INCREMENT, Email VARCHAR(255), Username VARCHAR(255), FullName VARCHAR(255), DepartmentID INT, PositionID INT, CreateDate DATE, PRIMARY KEY (AccountID)
);

CREATE TABLE `Group` (
    GroupID INT AUTO_INCREMENT, GroupName VARCHAR(255), CreatorID INT, CreateDate DATE, PRIMARY KEY (GroupID)
);

CREATE TABLE GroupAccount (
    GroupID INT, AccountID INT, JoinDate DATE, PRIMARY KEY (GroupID, AccountID)
);

CREATE TABLE TypeQuestion (
    TypeID INT AUTO_INCREMENT, TypeName VARCHAR(50), PRIMARY KEY (TypeID)
);

CREATE TABLE CategoryQuestion (
    CategoryID INT AUTO_INCREMENT, CategoryName VARCHAR(50), PRIMARY KEY (CategoryID)
);

CREATE TABLE Question (
    QuestionID INT AUTO_INCREMENT, Content VARCHAR(255), CategoryID INT, TypeID INT, CreatorID INT, CreateDate DATE, PRIMARY KEY (QuestionID)
);

CREATE TABLE Answer (
    AnswerID INT AUTO_INCREMENT, Content VARCHAR(255), QuestionID INT, isCorrect BOOLEAN, PRIMARY KEY (AnswerID)
);

CREATE TABLE Exam (
    ExamID INT AUTO_INCREMENT, Code VARCHAR(255), Title VARCHAR(50), CategoryID INT, Duration INT, CreatorID INT, CreateDate DATE, PRIMARY KEY (ExamID)
);

CREATE TABLE ExamQuestion (
    ExamID INT, QuestionID INT, PRIMARY KEY (ExamID, QuestionID)
);