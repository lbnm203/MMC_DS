USE Testing_System_DB;

-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account
-- thuộc phòng ban đó
DROP PROCEDURE IF EXISTS sp_GetAccFromDep;
DELIMITER $$
CREATE PROCEDURE sp_GetAccFromDep(IN in_dep_Name NVARCHAR(50))
BEGIN
	SELECT 		*
	FROM 		`Account` A 
	INNER JOIN 	Department D
	ON 			A.DepartmentID = D.DepartmentID
	WHERE		DepartmentName = in_dep_Name;
END$$
DELIMITER ;

CALL sp_GetAccFromDep(N'Giám đốc')

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS sp_CountAccFromGroup;
DELIMITER $$
CREATE PROCEDURE sp_CountAccFromGroup(IN in_CountAcc INT)
BEGIN
	SELECT 		GroupID, COUNT(AccountID) AS CountAcc
    FROM 		groupaccount
    WHERE	 	GroupID = in_CountAcc
    GROUP BY 	GroupID;
END$$
DELIMITER ;

CALL sp_CountAccFromGroup(1);


-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DROP PROCEDURE IF EXISTS sp_TKTypeQuestion;
DELIMITER $$
CREATE PROCEDURE sp_TKTypeQuestion(IN in_Month INT, IN in_Year INT)
BEGIN
    SELECT 		TypeID, COUNT(QuestionID) AS NumQuestions
    FROM 		question
    WHERE 		MONTH(CreateDate) = in_Month AND YEAR(CreateDate) = in_Year 
    GROUP BY	TypeID ;
END$$
DELIMITER ;

CALL sp_TKTypeQuestion(5, 2020);

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS sp_GetMaxTypeID;
DELIMITER $$
CREATE PROCEDURE sp_GetMaxTypeID(OUT out_Max_TypeID INT)
BEGIN
	WITH CTE_CountTypeID AS(
		SELECT 		COUNT(TypeID) AS CountTypeID
		FROM 		question 
		GROUP BY	TypeID    
	)
	SELECT 		TypeID INTO out_Max_TypeID
	FROM		question
	GROUP BY 	TypeID
	HAVING 		COUNT(TypeID) = (SELECT MAX(CountTypeID) FROM CTE_CountTypeID);
END$$
DELIMITER ;

SET 	@ID = 0;
CALL 	sp_GetMaxTypeID(@ID);
SELECT 	@ID


-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
SELECT 	TypeName
FROM 	TypeQuestion
WHERE 	TypeID = @ID;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của
-- người dùng nhập vào
DROP PROCEDURE IF EXISTS sp_traVeGroup_User;
DELIMITER $$
CREATE PROCEDURE sp_traVeGroup_User(IN searchString VARCHAR(255))
BEGIN
    SELECT 	GroupID, GroupName 
    FROM 	`Group`
    WHERE 	GroupName LIKE CONCAT('%', searchString, '%')
    UNION
    SELECT 	AccountID , Username 
    FROM 	`Account`
    WHERE 	Username LIKE CONCAT('%', searchString, '%');
END$$
DELIMITER ;

CALL sp_traVeGroup_User('VTI Sale');

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công


-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để
-- thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS sp_layContentMax;
DELIMITER $$
CREATE PROCEDURE sp_layContentMax(IN questionType ENUM('Essay', 'Multiple-Choice'))
BEGIN
    SELECT QuestionID, Content, CHAR_LENGTH(Content) AS ContentLength
    FROM Question
    WHERE TypeID = (SELECT TypeID 
					FROM TypeQuestion 
                    WHERE TypeName = questionType)
    ORDER BY        CHAR_LENGTH(Content) DESC
    LIMIT 1;
END$$
DELIMITER ;
-- Gọi stored procedure để kiểm tra
CALL sp_layContentMax('Essay');
CALL sp_layContentMax('Multiple-Choice');

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS sp_DeleteExamByID;
DELIMITER $$
CREATE PROCEDURE sp_DeleteExamByID(IN exam_id_param TINYINT UNSIGNED)
BEGIN
    DELETE FROM Exam 
    WHERE ExamID = exam_id_param;
END$$
DELIMITER ;

CALL sp_DeleteExamByID(1);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng
-- store ở câu 9 để xóa)
DROP PROCEDURE IF EXISTS sp_find_delete_exam_before_3y;
DELIMITER $$
CREATE PROCEDURE sp_find_delete_exam_before_3y(IN current_date_param DATE, IN three_years_ago DATE)
BEGIN    
    SELECT ExamID
    FROM Exam 
    WHERE CreateDate < three_years_ago;
    
END$$
DELIMITER ;

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập
-- vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng ban
-- default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS sp_delete_
DELIMITER $$
CREATE PROCEDURE DeleteDepartmentAndMoveAccounts(IN department_name_param NVARCHAR(50))
BEGIN
    DECLARE department_id_param TINYINT UNSIGNED;
    DECLARE default_department_id TINYINT UNSIGNED;
    
    -- Lấy DepartmentID của phòng ban cần xóa
    SELECT DepartmentID INTO department_id_param F
    ROM Department 
    WHERE DepartmentName = department_name_param;
    
    -- Lấy DepartmentID của phòng ban mặc định "phòng ban chờ việc"
    SELECT DepartmentID INTO default_department_id 
    FROM Department 
    WHERE DepartmentName = 'phòng ban chờ việc';
    
    IF department_id_param IS NOT NULL THEN
        -- Chuyển các account thuộc phòng ban cần xóa về phòng ban mặc định
        UPDATE Account 
        SET DepartmentID = default_department_id
        WHERE DepartmentID = department_id_param;
        
        -- Xóa phòng ban cần xóa
        DELETE FROM Department 
        WHERE DepartmentID = department_id_param;
        SELECT 'Phòng ban đã được xóa và các account đã được chuyển về phòng ban chờ việc' AS Message;
    ELSE
        SELECT 'Không tìm thấy phòng ban cần xóa' AS Message;
    END IF;
END$$
DELIMITER ;