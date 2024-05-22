USE Testing_System_DB;

-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
DROP VIEW IF EXISTS vw_DS_Thuoc_PB_Sale;
CREATE VIEW vw_DS_Thuoc_PB_Sale AS
	SELECT 			A.*, B.DepartmentName AS PB
    FROM 			`Account` A 
    INNER JOIN 		Department B
    ON				A.DepartmentID = B.DepartmentID
    WHERE 			B.DepartmentName = 'Sale';

SELECT * 
FROM vw_DS_Thuoc_PB_Sale;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
-- DROP VIEW IF EXISTS vw_ThongTin_TgMax;
-- CREATE VIEW vw_ThongTin_TgMax AS
-- 	SELECT 		A.AccountID, A.Email, A.Username, A.FullName, COUNT(GA.AccountID) AS SoAcc
--     FROM 		`account` A
-- 	INNER JOIN	groupaccount GA
--     ON			A.AccountID = GA.AccountID
--     GROUP BY 	A.AccountID, A.Email, A.Username, A.FullName
--     HAVING 		COUNT(GA.GroupID) = (SELECT MAX(GroupCount)
-- 									FROM 	(SELECT COUNT(GroupID) AS GroupCount
-- 											FROM GroupAccount 
--                                             GROUP BY AccountID) AS GroupCounts);
--     
-- SELECT * 
-- FROM vw_ThongTin_TgMax;

DROP VIEW IF EXISTS vw_ThongTinAccount;
CREATE VIEW 	vw_ThongTinAccount AS
WITH 			CTE_DanhSachSoLuongAccount AS(
	SELECT 		COUNT(GA1.AccountID) AS countGA1
    FROM		GroupAccount GA1
    GROUP BY	GA1.AccountID
)
SELECT			A.AccountID, A.Username, COUNT(GA.AccountID) AS SL 
FROM			GroupAccount GA
INNER JOIN		`account` A
ON				GA.AccountID = A.AccountID
GROUP BY		GA.AccountID
HAVING			COUNT(GA.AccountID) = ( SELECT MAX(countGA1) AS maxCount FROM CTE_DanhSachSoLuongAccount);

SELECT * 
FROM vw_ThongTinAccount

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
DROP VIEW IF EXISTS vw_ContentQuaDai;
CREATE VIEW vw_ContentQuaDai AS
	SELECT 		Q.QuestionID, Q.Content, 
				(LENGTH(Q.Content) - LENGTH(REPLACE(Q.Content, ' ', '')) + 1) AS WordCount
	FROM 		Question Q
	WHERE 		(LENGTH(Q.Content) - LENGTH(REPLACE(Q.Content, ' ', '')) + 1) > 300;

SELECT * 
FROM vw_ContentQuaDai;

DELETE FROM Question
WHERE QuestionID IN (SELECT QuestionID FROM LongContentQuestions);


-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
DROP VIEW IF EXISTS vw_danhsachpbmaxnhanvien;
CREATE VIEW vw_danhsachpbmaxnhanvien AS
	SELECT 			D.DepartmentID, D.DepartmentName, COUNT(A.AccountID) AS SoNhanVien
	FROM 			Department D
	INNER JOIN 		`Account` A 
    ON 				D.DepartmentID = A.DepartmentID
	GROUP BY 		D.DepartmentID, D.DepartmentName
	HAVING 			COUNT(A.AccountID)=(SELECT 	MAX(NumberOfEmployees)
										FROM 	(SELECT 	COUNT(A.AccountID) AS NumberOfEmployees
												FROM 		Department D
												INNER JOIN 	`Account` A 
                                                ON 			D.DepartmentID = A.DepartmentID
												GROUP BY 	D.DepartmentID) AS CountNV);	
                                                
SELECT 	*
FROM 	vw_danhsachpbmaxnhanvien;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
DROP VIEW IF EXISTS vw_allquestioncreatebyuser;
CREATE VIEW vw_allquestioncreatebyuser AS
	SELECT 		Q.QuestionID, Q.Content, Q.CategoryID, Q.TypeID, Q.CreatorID, Q.CreateDate, A.FullName
	FROM 		Question Q
	INNER JOIN 	`Account` A
    ON 			Q.CreatorID = A.AccountID
	WHERE 		A.FullName LIKE 'Nguyễn%';
    
SELECT 	*
FROM 	vw_allquestioncreatebyuser;