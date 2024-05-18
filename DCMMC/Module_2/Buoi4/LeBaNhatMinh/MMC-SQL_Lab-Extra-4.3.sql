USE hr;

-- Bài toán 1: Viết truy vấn để lấy tên và ngày bắt đầu công việc của tất cả 
-- nhân viên làm việc trong phòng ban số 5
SELECT 	F_NAME, L_NAME, START_DATE
FROM 	Employees A INNER JOIN Job_history B 
ON 		A.EMP_ID = B.EMPL_ID
WHERE 	DEPT_ID = 5;

-- Bài toán 2: Viết truy vấn để lấy tên, ngày bắt đầu công việc và tên công việc 
-- của tất cả nhân viên làm việc trong phòng ban số 5.
SELECT 	F_NAME, L_NAME, START_DATE, JOB_TITLE
FROM 	Employees A INNER JOIN Job_history B 
		ON A.EMP_ID = B.EMPL_ID INNER JOIN Jobs C
		ON B.JOBS_ID = C.JOB_IDENT
WHERE 	DEPT_ID = 5;

-- Bài toán 3: Thực hiện Left Outer Join trên các bảng  EMPLOYEES và DEPARTMENT 
-- và chọn employee id (id nhân viên), last name (họ), department id (id phòng ban), 
-- department name (tên phòng ban ) cho tất cả nhân viên.

SELECT 	A.EMP_ID, L_NAME, B.DEPT_ID_DEP, DEP_NAME
FROM 	Employees A LEFT JOIN Departments B
		ON A.DEP_ID = B.DEPT_ID_DEP;
 
-- Bài toán 4: Viết lại truy vấn trước đó nhưng giới hạn tập kết quả chỉ có các hàng dành
-- cho nhân viên sinh trước năm 1980.
SELECT 	A.EMP_ID, L_NAME, B.DEPT_ID_DEP, DEP_NAME
FROM 	Employees A LEFT JOIN Departments B
		ON A.DEP_ID = B.DEPT_ID_DEP
WHERE 	YEAR(B_DATE) < 1980;


-- Bài toán 5: Viết lại truy vấn trước đó nhưng sẽ sử dụng INNER JOIN 
-- thay vì sử dụng LEFT OUTER JOIN.
SELECT 	A.EMP_ID, L_NAME, B.DEPT_ID_DEP, DEP_NAME
FROM 	Employees A INNER JOIN Departments B
		ON A.DEP_ID = B.DEPT_ID_DEP
WHERE 	YEAR(B_DATE) < 1980;

-- Bài toán 6: Thực hiện một FULL OUTER JOIN trên bảng EMPLOYEES và DEPARTMENT và chọn
-- First name (tên), Last name (họ) và Department name (tên phòng ban) của tất cả nhân viên.

SELECT 		F_NAME, L_NAME, DEP_NAME
FROM 		Employees A LEFT JOIN Departments B
			ON A.DEP_ID = B.DEPT_ID_DEP
UNION ALL
SELECT 		F_NAME, L_NAME, DEP_NAME
FROM 		Employees A RIGHT JOIN Departments B
			ON A.DEP_ID = B.DEPT_ID_DEP;

-- Bài toán 7: Viết lại truy vấn trước đó nhưng có tập kết quả bao gồm tất cả employee names (tên nhân viên)
-- nhưng department id (id phòng ban) và department names (tên phòng ban) chỉ dành cho nhân viên nam.
SELECT 		F_NAME, L_NAME, DEPT_ID_DEP, DEP_NAME
FROM 		Employees A LEFT JOIN Departments B
			ON A.DEP_ID = B.DEPT_ID_DEP AND SEX = 'M'
UNION ALL
SELECT 		F_NAME, L_NAME, DEPT_ID_DEP, DEP_NAME
FROM 		Employees A RIGHT JOIN Departments B
			ON A.DEP_ID = B.DEPT_ID_DEP AND SEX = 'M'