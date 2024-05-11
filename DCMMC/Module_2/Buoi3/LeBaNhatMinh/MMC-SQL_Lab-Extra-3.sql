USE hr;

-- Q1: Truy xuất tất cả nhân viên có địa chỉ ở Elgin, IL
SELECT *
FROM Employees
WHERE ADDRESS LIKE '%Elgin,IL%';

-- Q2: Truy xuất tất cả nhân viên sinh vào những năm 1970.
SELECT *
FROM Employees
WHERE B_DATE LIKE '%1970%';

-- Q3: Truy xuất tất cả nhân viên trong phòng ban 5 có mức lương từ 60000 đến 70000.
SELECT *
FROM Employees
WHERE DEP_ID = 5 AND SALARY BETWEEN 60000 AND 70000;

-- Q4A: Truy xuất danh sách nhân viên được sắp xếp theo ID phòng ban.
SELECT *
FROM Employees
ORDER BY DEP_ID ASC;

-- Q4B: Truy xuất danh sách nhân viên được sắp xếp theo thứ tự giảm dần theo ID phòng ban
-- và trong mỗi phòng ban, những nhân viên này được sắp xếp theo họ với thứ tự giảm dần 
-- của bảng chữ cái.
SELECT * 
FROM Employees
ORDER BY DEP_ID DESC, L_NAME DESC;

-- Q5A: Đối với mỗi ID phòng ban, truy xuất số lượng nhân viên trong phòng ban.
SELECT DEP_ID, COUNT(EMP_ID) AS SOLUONG
FROM Employees
GROUP BY DEP_ID;

-- Q5B: Đối với mỗi phòng ban, truy xuất số lượng nhân viên trong phòng ban và mức lương trung bình của nhân viên trong phòng ban.
SELECT MANAGER_ID, AVG(SALARY) AS LUONGTB, COUNT(EMP_ID) AS SOLUONG
FROM Employees
GROUP BY MANAGER_ID;

-- Q5C: Gắn nhãn các cột đã tính trong tập hợp kết quả của Truy vấn 5B là NUM_EMPLOYEES và AVG_SALARY.
SELECT MANAGER_ID, AVG(SALARY) AS AVG_SALARY, COUNT(EMP_ID) AS NUM_EMPLOYEE
FROM Employees
GROUP BY MANAGER_ID;

-- Q5D: Trong Truy vấn 5C, hãy sắp xếp tập hợp kết quả Mức lương trung bình.
SELECT MANAGER_ID, AVG(SALARY) AS AVG_SALARY, COUNT(EMP_ID) AS NUM_EMPLOYEE
FROM Employees
GROUP BY MANAGER_ID
ORDER BY AVG_SALARY DESC;

-- Q5E: Trong Truy vấn 5D, giới hạn kết quả thành ít hơn 4 nhân viên cho các phòng ban.
SELECT MANAGER_ID, AVG(SALARY) AS AVG_SALARY, COUNT(EMP_ID) AS NUM_EMPLOYEE
FROM Employees
GROUP BY MANAGER_ID
HAVING COUNT(EMP_ID) < 4
ORDER BY AVG_SALARY DESC;


