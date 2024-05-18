USE Testing_System_DB;

-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT 	FullName, B.*
FROM 	`Account` A 
INNER JOIN Department B
ON A.DepartmentID = B.DepartmentID;
        
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT *
FROM `Account`
WHERE CreateDate > '2010/12/20';

-- Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT *
FROM `Account` A 
INNER JOIN `Position` B
ON A.PositionID = B.PositionID
WHERE PositionName = 'Dev';

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT 		B.DepartmentID, B.DepartmentName ,COUNT(A.AccountID) AS NumEmployees
FROM 		`Account` A 
INNER JOIN 	Department B
ON 			A.DepartmentID = B.DepartmentID
GROUP BY 	B.DepartmentID, B.DepartmentName
HAVING 		COUNT(A.AccountID) > 3;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT 		TypeName, COUNT(A.TypeID) AS SoCH
FROM		question A 
INNER JOIN 	typequestion B
ON 			A.TypeID = B.TypeID
GROUP BY 	TypeName 
ORDER BY 	COUNT(A.TypeID) DESC
LIMIT 1;

-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
SELECT 		A.CategoryID, COUNT(B.CategoryID) AS SoCH
FROM		categoryquestion A 
INNER JOIN 	question B 
ON 			A.CategoryID = B.CategoryID
GROUP BY 	A.CategoryID ;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam *********
SELECT 		A.QuestionID, COUNT(B.ExamID) as SoLan
FROM		question A 
LEFT JOIN 	examquestion B 
ON 			A.QuestionID = B.QuestionID
GROUP BY 	QuestionID;

-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT 		A.QuestionID, COUNT(B.AnswerID) AS CauTraLoi
FROM 		question A
INNER JOIN	answer B
ON 			A.QuestionID = B.QuestionID
GROUP BY	A.QuestionID
ORDER BY	CauTraLoi DESC
LIMIT 1;

-- Question 9: Thống kê số lượng account trong mỗi group
SELECT 		GroupID, COUNT(AccountID) as SoLuongAcc
FROM		groupaccount 
GROUP BY	GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT 		B.PositionID, COUNT(A.PositionID) as SoNguoi
FROM 		`account` A
INNER JOIN	`position` B
ON			A.PositionID = B.PositionID
GROUP BY	B.PositionID
ORDER BY	SoNguoi ASC
LIMIT		1;

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM


SELECT 		    D.DepartmentID, D.DepartmentName,
				SUM(CASE WHEN B.PositionName = 'dev' THEN 1 ELSE 0 END) AS NumDev,
				SUM(CASE WHEN B.PositionName = 'test' THEN 1 ELSE 0 END) AS NumTest,
				SUM(CASE WHEN B.PositionName = 'scrum master' THEN 1 ELSE 0 END) AS NumScrumMaster,
				SUM(CASE WHEN B.PositionName = 'PM' THEN 1 ELSE 0 END) AS NumPM
FROM 			`department` D
INNER JOIN 		`account` A 
ON 				D.DepartmentID = A.DepartmentID
INNER JOIN 		`position` B 
ON A.PositionID = B.PositionID
GROUP BY 		D.DepartmentID, D.DepartmentName;


-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
-- question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT 		B.QuestionID, B.Content, CreatorID AS NguoiTaoCauHoi, C.TypeName, A.Content AS CauTraLoi
FROM		answer A
INNER JOIN	question B
ON			A.QuestionID = B.QuestionID
INNER JOIN 	typequestion C
ON			B.TypeID = C.TypeID;

-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT 		A.TypeName, COUNT(B.QuestionID) AS SoCH
FROM 		TypeQuestion A
LEFT JOIN 	Question B 
ON 			A.TypeID = B.TypeID
WHERE 		A.TypeName IN ('Essay', 'Multiple-Choice')
GROUP BY 	A.TypeName
ORDER BY 	A.TypeName;

-- Question 14: Lấy ra group không có account nào
SELECT G.GroupID, G.GroupName
FROM `Group` G
LEFT JOIN GroupAccount GA ON G.GroupID = GA.GroupID
WHERE GA.AccountID IS NULL;

-- Question 16: Lấy ra question không có answer nào
SELECT 		B.QuestionID, B.Content
FROM		answer A
RIGHT JOIN	question B
ON			A.QuestionID = B.QuestionID
WHERE		AnswerID IS NULL;


-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT 		A.*
FROM 		`Account` A
INNER JOIN 	GroupAccount B
ON 			A.AccountID = B.AccountID
WHERE 		B.GroupID = 1
UNION
SELECT 		A.*
FROM		`Account` A
INNER JOIN 	GroupAccount B 
ON 			A.AccountID = B.AccountID
WHERE 		B.GroupID = 2;	

-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- b) Lấy các group có nhỏ hơn 7 thành viên
-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT G.GroupID, G.GroupName, COUNT(GA.AccountID) AS NumberOfMembers
FROM 		`Group` G
INNER JOIN 		GroupAccount GA 
ON 			G.GroupID = GA.GroupID
GROUP BY 	G.GroupID, G.GroupName
HAVING 		COUNT(GA.AccountID) > 5
UNION
SELECT 		G.GroupID, G.GroupName, COUNT(GA.AccountID) AS NumberOfMembers
FROM 		`Group` G
INNER JOIN 	GroupAccount GA 
ON 			G.GroupID = GA.GroupID
GROUP BY 	G.GroupID, G.GroupName
HAVING		COUNT(GA.AccountID) < 7;
