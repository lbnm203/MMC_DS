DROP DATABASE IF EXISTS QuanLyXe;
CREATE DATABASE QuanLyXe;
USE QuanLyXe;

DROP TABLE IF EXISTS CUSTOMER;
CREATE TABLE CUSTOMER (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(50),
    Address VARCHAR(100),
    Note TEXT
);

DROP TABLE IF EXISTS CAR;
CREATE TABLE CAR (
    CarID INT PRIMARY KEY,
    Maker ENUM('HONDA', 'TOYOTA', 'NISSAN'),
    Model VARCHAR(50),
    Year INT,
    Color VARCHAR(20),
    Note TEXT
);

DROP TABLE IF EXISTS CAR_ORDER;
CREATE TABLE CAR_ORDER (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    CarID INT,
    Amount INT DEFAULT 1,
    SalePrice DECIMAL(10,2),
    OrderDate DATE,
    DeliveryDate DATE,
    DeliveryAddress VARCHAR(100),
    Status TINYINT DEFAULT 0,
    Note TEXT,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID)ON DELETE CASCADE,
    FOREIGN KEY (CarID) REFERENCES CAR(CarID) ON DELETE CASCADE
);

INSERT INTO CUSTOMER 	(Name			,  Phone		, Email							, Address					, Note					) 
VALUES					('John Wick'	, '123456789'	, 'john.doe@example.com'		, '123 Main Street, City'	, 'Regular customer'	),
						('Alice Smith'	, '987654321'	, 'alice.smith@example.com'		, '456 Elm Street, Town'	, 'VIP customer'		),
						('Bob Johnson'	, '555555555'	, 'bob.johnson@example.com'		, '789 Oak Avenue, Village'	, 'New customer'		),
						('Emily Brown'	, '777777777'	, 'emily.brown@example.com'		, '321 Pine Road, County'	, 'Returning customer'	),
						('Michael Davis', '999999999'	, 'michael.davis@example.com'	, '654 Maple Lane, Country'	, 'Preferred customer'	);


INSERT INTO CAR			(CarID	,  Maker	, Model		, Year	, Color		, Note				)
VALUE					(1		, 'HONDA'	, 'Civic'	, 2020	, 'Black'	, 'Compact sedan'	),
						(2		, 'TOYOTA'	, 'Camry'	, 2019	, 'White'	, 'Mid-size sedan'	),
						(3		, 'NISSAN'	, 'Altima'	, 2018	, 'Silver'	, 'Family sedan'	),
						(4		, 'HONDA'	, 'CR-V'	, 2021	, 'Blue'	, 'Compact SUV'		),
						(5		, 'TOYOTA'	, 'Rav4'	, 2020	, 'Red'		, 'Crossover SUV'	);
                        
                        
INSERT INTO CAR_ORDER 	(CustomerID	, CarID	, SalePrice	, OrderDate		, DeliveryDate	, DeliveryAddress			, Note						) 
VALUES					(1			, 1		, 25000.00	, '2021-10-15'	, '2021-10-20'	, '123 Main Street, City'	, 'Regular customer order'	),
						(2			, 2		, 30000.00	, '2021-10-16'	, '2021-10-21'	, '456 Elm Street, Town'	, 'VIP customer order'		),
						(3			, 3		, 20000.00	, '2021-10-17'	, '2021-10-22'	, '789 Oak Avenue, Village'	, 'New customer order'		),
						(4			, 4		, 35000.00	, '2021-10-18'	, '2021-10-23'	, '321 Pine Road, County'	, 'Returning customer order'),
						(5			, 5		, 28000.00	, '2021-10-19'	, '2021-10-24'	, '654 Maple Lane, Country'	, 'Preferred customer order');


-- 2. Viết lệnh lấy ra thông tin của khách hàng: tên, số lượng oto khách hàng đã
-- mua và sắp sếp tăng dần theo số lượng oto đã mua.
SELECT 		A.Name, COUNT(B.CarID) AS SOLUONG
FROM 		CUSTOMER A 
INNER JOIN 	CAR_ORDER B
ON			A.CustomerID = B.CustomerID
GROUP BY	A.Name
ORDER BY	SOLUONG ASC;

-- 3. Viết hàm (không có parameter) trả về tên hãng sản xuất đã bán được
-- nhiều oto nhất trong năm nay.
DROP FUNCTION IF EXISTS func_TraVeHangBanNhieuOto;
DELIMITER $$
CREATE FUNCTION func_TraVeHangBanNhieuOto() RETURNS VARCHAR(50)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE hang_ban_nhieu_nhat VARCHAR(50);
    
    SELECT Maker INTO hang_ban_nhieu_nhat
    FROM (
        SELECT 		C.Maker, COUNT(*) AS TotalSales
        FROM 		CAR_ORDER A
        JOIN 		CAR C
        ON 			A.CarID = C.CarID
        WHERE 		YEAR(A.OrderDate) = YEAR(CURDATE())
        GROUP BY 	C.Maker
        ORDER BY 	TotalSales DESC
        LIMIT 		1
		) AS BestMaker;

    RETURN hang_ban_nhieu_nhat;
END$$
DELIMITER ;

-- Gọi hàm để kiểm tra kết quả
SELECT func_TraVeHangBanNhieuOto();