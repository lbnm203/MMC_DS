USE Testing_System_Db;

-- Q1. Thêm ít nhất 10 record vào mỗi table
INSERT INTO Department          (DepartmentName 			) 
VALUES                          (N'Sản xuất'				),
                                (N'Kiểm soát'				),
                                (N'Kiểm toán nội bộ'		),
                                (N'Hành chính'				),
                                (N'Chăm sóc khách hàng'		),
                                (N'Công nghệ thông tin'		),
                                (N'Kinh doanh'				),
                                (N'Thu mua'					),
                                (N'Quản hệ quốc tế'			),
                                (N'Nghiên cứu phát triển'	);


INSERT INTO `Position`	        (PositionName		) 
VALUES 					        ('CopyWritter'		),
						        ('CEO'				),
						        ('Product Manager'	),
						        ('CFO'				),
						        ('Data Engineer'	),
						        ('QA'				),
						        ('BackEnd'			),
						        ('IT Manager'		),
						        ('DevOps'			),
						        ('Business Analyst'	); 
                                
			
INSERT INTO `Account`           (Email								, Username			, FullName				, DepartmentID	, PositionID , CreateDate)
VALUES 				            ('sakana1@gmail.com'				, 'sakana'			,'Nguyễn Mai'			,   '11'		,   '6'		 ,'2020-05-12'),
					            ('improve1@gmail.com'				, 'dinhhieu'		,'Le Dinh Hieu'			,   '12'		,   '7'		 ,'2020-05-23'),
                                ('improve2@gmail.com'				, 'vietvan'			,'Phan Viet Van'		,   '13'		,   '8'		 ,'2020-05-27'),
                                ('improve3@gmail.com'				, 'quangchien'		,'Le Quang Chien'		,   '14'		,   '10'	 ,'2020-06-03'),
                                ('improve4@gmail.com'				, 'lethai'			,'Nguyen Le Thai'		,   '15'		,   '14'	 ,'2020-06-15'),
                                ('example1@gmail.com'				, 'duyhung'			,'Do Duy Hung'			,   '16'		,   '9'		 ,'2020-06-21'),
                                ('example2@gmail.com'				, 'chaukiet'		,'Phan Chau Kiet'		,   '17'		,   '12'	 ,'2020-06-25'),
                                ('example3@gmail.com'				, 'viettung'		,'Van Viet Tung'		,   '18'		,   '11'	 ,'2020-06-29'),
                                ('example4@gmail.com'				, 'vanbao'			,'Ngo Van Bao'			,   '19'		,   '13'	 ,'2020-07-06'),
                                ('nguyenduyan@gmail.com'			, 'nguyenduyan'		,'Nguyen Duy An'		,   '20'		,   '5'		 ,'2020-07-11');


INSERT INTO `Group`	            (  GroupName			, CreatorID		, CreateDate )
VALUES 				            (N'Tester'				,   13			,'2019-04-11'),
					            (N'DevOps'				,   14			,'2020-04-12'),
                                (N'PAA Support 01'		,   11			,'2020-04-13'),
                                (N'PAA Support 02'		,   15			,'2020-04-17'),
                                (N'PAA Support 03'		,   19			,'2020-05-02'),
                                (N'PAA Support 04'		,   20			,'2020-05-09'),
                                (N'PAA CopyWritter 01'	,   18			,'2020-05-10'),
                                (N'PAA CopyWritter 02'	,   16			,'2020-06-04'),
                                (N'PAA Analyst 01'		,   17			,'2020-06-05'),
                                (N'PAA Analyst 02'		,   12			,'2020-06-06');


INSERT INTO GroupAccount	    ( GroupID	, AccountID	, JoinDate	 )
VALUES 						    (   4		,    1		,'2019-03-05'),
							    (   4		,    2		,'2020-03-07'),
							    (   20		,    3		,'2020-03-09'),
							    (   9		,    4		,'2020-03-10'),
							    (   2		,    5		,'2020-03-28'),
							    (   11		,    3		,'2020-04-06'),
							    (   12		,    7		,'2020-04-07'),
							    (   18		,    3		,'2020-04-08'),
							    (   14		,    9		,'2020-04-09'),
							    (   17		,    10		,'2020-04-10');



INSERT INTO TypeQuestion	    (TypeName				) 
VALUES 						    ('Slider'				), 
								('Benchmarkable'		),
								('Text'					),
								('True or false'		),
								('Closed'				),
								('Contact information'	),
								('Demographic'			),
								('Dropdown'				),
								('Rhetorical'			),
							    ('Probing'				); 



INSERT INTO CategoryQuestion	(CategoryName	)
VALUES 							('Kotlin'		),
								('JavaScript'	),
								('C'			),
								('Swift'		),
								('TypeScript'	),
								('R'			),
								('Dart'			),
								('Go'			),
								('Bash'			),
								('Matlab'		);
													

INSERT INTO Question	        (Content			            , CategoryID	, TypeID		, CreatorID		, CreateDate )
VALUES 					        (N'Câu hỏi về Kotlin'			,	11			,   '4'			,   '11'		,'2020-05-05'),
						        (N'Câu Hỏi về JavaScript'	    ,	20			,   '3'			,   '12'		,'2020-05-05'),
						        (N'Hỏi về C'		            ,	19			,   '10'		,   '13'		,'2020-05-06'),
						        (N'Hỏi về Swift'		        ,	16			,   '7'			,   '14'		,'2020-05-06'),
						        (N'Hỏi về TypeScript'	        ,	15			,   '4'			,   '15'		,'2020-05-06'),
						        (N'Hỏi về R'	            	,	13			,   '3'			,   '16'		,'2020-05-06'),
						        (N'Hỏi về Dart'	            	,	12			,   '8'			,   '17'		,'2020-05-06'),
						        (N'Hỏi về Go'		            ,	18			,   '2'			,   '18'		,'2020-05-07'),
						        (N'Hỏi về Bash'		            ,	14			,   '2'			,   '19'		,'2020-05-07'),
						        (N'Hỏi về Matlab'	            ,	17			,   '1'			,   '20'		,'2020-05-07');


INSERT INTO Answer	            (  Content		, QuestionID	, isCorrect	)
VALUES 				            (N'Trả lời 11'	,   12			,	0		),
					            (N'Trả lời 12'	,   11			,	1		),
                                (N'Trả lời 13'	,   11			,	0		),
                                (N'Trả lời 14'	,   14			,	1		),
                                (N'Trả lời 15'	,   15			,	1		),
                                (N'Trả lời 16'	,   16			,	1		),
                                (N'Trả lời 17'	,   17			,	0		),
                                (N'Trả lời 18'	,   18			,	0		),
                                (N'Trả lời 19'	,   19			,	1		),
                                (N'Trả lời 20'	,   20			,	1		);
	

INSERT INTO Exam	            (`Code`			, Title					, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				            ('VTIQ011'		, N'Đề thi Kotlin'		,	11			,	60		,   '15'			,'2019-05-03'),
					            ('VTIQ012'		, N'Đề thi JavaScript'	,	20			,	60		,   '12'			,'2019-05-05'),
                                ('VTIQ013'		, N'Đề thi C'			,	19			,	120		,   '12'			,'2019-05-07'),
                                ('VTIQ014'		, N'Đề thi Swift'		,	16			,	60		,   '13'			,'2020-05-08'),
                                ('VTIQ015'		, N'Đề thi TypeScript'	,	15			,	120		,   '14'			,'2020-05-10'),
                                ('VTIQ016'		, N'Đề thi R'			,	13			,	60		,   '16'			,'2020-06-05'),
                                ('VTIQ017'		, N'Đề thi Dart'		,	12			,	60		,   '17'			,'2020-04-05'),
                                ('VTIQ018'		, N'Đề thi Go'			,	18			,	60		,   '18'			,'2020-06-07'),
                                ('VTIQ019'		, N'Đề thi Bash'		,	14			,	90		,   '19'			,'2020-05-07'),
                                ('VTIQ020'		, N'Đề thi Matlab'		,	17			,	90		,   '20'			,'2020-04-08');
                    
                    

INSERT INTO ExamQuestion        (ExamID	, QuestionID) 
VALUES 					        (	11	,	15		),
						        (	12	,	20		), 
						        (	13	,	14		), 
						        (	14	,	13		), 
						        (	15	,	17		), 
						        (	16	,	20		), 
						        (	17	,	12		), 
						        (	18	,	20		), 
						        (	19	,	19		), 
						        (	20	,	18		); 



-- Q2: Lấy ra tất cả các phòng ban Department
SELECT 	*
FROM 	Department;

-- Q3: Lấy ra id của phòng ban 'Sale'
SELECT 	*
FROM 	Department
WHERE 	DepartmentName = 'Sale';

-- Q4. lấy ra thông tin account có full name dài nhất
SELECT 	* 
FROM 	`Account` 
WHERE 	LENGTH(FullName) = (SELECT    MAX(LENGTH(FullName))
						    FROM      `Account`);

-- Q5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
SELECT 		* 
FROM 		`Account` 
WHERE 		LENGTH(FullName) = (SELECT    MAX(LENGTH(FullName))
								FROM      `Account`
								WHERE 	  DepartmentID = 3)
ORDER BY 	FullName
LIMIT 		1		;

-- Q6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT 	GroupName, CreateDate
FROM 	`Group`
WHERE 	CreateDate < '2019/12/20';		

-- Q7: Lấy ra ID của question có >= 4 câu trả lời
SELECT 		QuestionID
FROM 		Answer
GROUP BY 	QuestionID
HAVING 		COUNT(QuestionID) >= 4;

-- Q8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT 	*
FROM 	Exam
WHERE 	Duration >= 60 AND CreateDate < '2019/12/20';

-- Q9: Lấy ra 5 group được tạo gần đây nhất
SELECT 		*
FROM 		`Group`
ORDER BY 	CreateDate DESC
LIMIT 		5;

-- Q10: Đếm số nhân viên thuộc department có id = 2
SELECT 	COUNT(*) AS TotalEmployee
FROM 	`Account`
WHERE 	DepartmentID = 2;

-- Q11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT 	*
FROM 	`Account`
WHERE 	FullName LIKE N'D%o';

-- Q12: Xóa tất cả các exam được tạo trước ngày 20/12/2019 
DELETE FROM Exam
WHERE CreateDate < '2019-12-20';

-- Q13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi" 
DELETE FROM Question
WHERE Content LIKE 'Câu hỏi%';

-- Q14: Update thông tin của account có id = 5 thành tên "Lô Văn Đề" và
-- email thành lo.vande@mmc.edu.vn
UPDATE `Account`
SET FullName = 'Lô Văn Đề', Email = 'lo.vande@mmc.edu.vn'
WHERE AccountID = 5;

-- Q15: Update account có id = 5 sẽ thuộc group có id = 4 
UPDATE `Group`
SET CreatorID = 5
WHERE GroupID = 4






