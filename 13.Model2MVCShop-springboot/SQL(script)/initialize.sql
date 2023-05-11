
DROP TABLE answer;
DROP TABLE inquiry;
DROP TABLE address;
DROP TABLE transaction;
DROP TABLE product;
DROP TABLE users;


CREATE TABLE branches (
branch_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
branch_name VARCHAR(50) NOT NULL,
addr VARCHAR(100),
phone VARCHAR(14),
manager VARCHAR(50)
);


CREATE TABLE users ( 
user_id VARCHAR(20)	NOT NULL PRIMARY KEY,
user_name VARCHAR(50) NOT NULL,
password VARCHAR(10) NOT NULL,
role VARCHAR(5) DEFAULT 'user',
branch_id INT
REFERENCES
ssn VARCHAR(13),
cell_phone VARCHAR(14),
addr VARCHAR(100),
email VARCHAR(50),
reg_date DATE
);




CREATE TABLE product (
prod_no INT AUTO_INCREMENT PRIMARY KEY,
prod_name VARCHAR(100) NOT NULL,
prod_detail VARCHAR(200),
manufacture_day VARCHAR(8),
price INT(10),
image_file VARCHAR(100),
reg_date DATE
) AUTO_INCREMENT=10001;

CREATE TABLE transaction ( 
tran_no INT AUTO_INCREMENT PRIMARY KEY,
prod_no INT(16)	NOT NULL REFERENCES product(prod_no),
buyer_id VARCHAR(20) NOT NULL REFERENCES users(user_id),
payment_option CHAR(3),
receiver_name VARCHAR(20),
receiver_phone VARCHAR(14),
dlvy_request VARCHAR(100),
tran_status_code CHAR(3),
order_data DATE,
dlvy_date DATE
) AUTO_INCREMENT=10001;

CREATE TABLE address ( 
tran_no INT(16)	NOT NULL REFERENCES transaction(tran_no),
road_address VARCHAR(100),
detail_address VARCHAR(100),
latitude DOUBLE,
longitude DOUBLE
);


CREATE TABLE inquiry ( 
	inquiry_no 			NUMBER 			NOT NULL,
	tran_no 			NUMBER(16)		REFERENCES transaction(tran_no),
	prod_no				NUMBER(16)		REFERENCES product(prod_no),
	user_id 			VARCHAR2(20)	NOT NULL REFERENCES users(user_id),
	inquiry_option		CHAR(4),
	title 		VARCHAR2(100),
	context		VARCHAR2(300),
	answer_status 		CHAR(3),
	post_date 		DATE,
	PRIMARY KEY(inquiry_no)
);

CREATE TABLE answer ( 
	inquiry_no 			NUMBER(16)		NOT NULL REFERENCES inquiry(inquiry_no),
	title		VARCHAR2(100)	NOT NULL,
	content		VARCHAR2(300),
	post_date  		DATE,
	PRIMARY KEY(inquiry_no)
);


INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) 
VALUES ( 'admin', 'admin', '1234', 'admin', NULL, NULL, '서울시 서초구', 'admin@mvc.com',str_to_date('2012/01/14 10:48:43', '%Y/%m/%d %H:%i:%s')); 

INSERT 
INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) 
VALUES ( 'manager', 'manager', '1234', 'admin', NULL, NULL, NULL, 'manager@mvc.com', str_to_date('2012/01/14 10:48:43', '%Y/%m/%d %H:%i:%s'));          

INSERT INTO users 
VALUES ( 'user01', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user02', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user03', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user04', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user05', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user06', 'SCOTT', '6666', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user07', 'SCOTT', '7777', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user08', 'SCOTT', '8888', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user09', 'SCOTT', '9999', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user10', 'SCOTT', '1010', 'user', NULL, NULL, NULL, NULL, NOW()); 

INSERT INTO users 
VALUES ( 'user11', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user12', 'SCOTT', '1212', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user13', 'SCOTT', '1313', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user14', 'SCOTT', '1414', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user15', 'SCOTT', '1515', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user16', 'SCOTT', '1616', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user17', 'SCOTT', '1717', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user18', 'SCOTT', '1818', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user19', 'SCOTT', '1919', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user20', 'SCOTT', '2020', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user21', 'SCOTT', '2121', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user22', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, NOW());

INSERT INTO users 
VALUES ( 'user23', 'SCOTT', '2323', 'user', NULL, NULL, NULL, NULL, NOW());
           
           
insert into product values (null, '해바라기 핫후라이드','매콤하게 튀긴 매운 맛 후라이드 치킨의 정석','20120514',18000, '410_0023.jpg',str_to_date('2012/12/14 11:27:27', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'양념치킨','바삭한 후라이드에 매콤달달 소스를 입힌 치킨','20120514',18000, '410_0020.jpeg',str_to_date('2012/11/14 10:48:43', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'뿌링클','세상에 없던 마법의 맛 뿌링클','20120201',18000, '410_0024.jpeg',str_to_date('2012/10/14 10:49:39', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'뿌링클HOT','뿌링가루의 HOT한 변신','20120217', 19000, '410_0025.jpeg',str_to_date('2012/11/14 10:50:58', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'맛초킹','매콤짭짤! 밥과 함께 먹기에 딱 좋은 완벽조합','20120819', 18000, '410_0026.jpeg',str_to_date('2012/11/14 10:51:40', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'레드킹','레드핫칠리페퍼에 마늘을 토핑한 확실하게 매운 맛',19000, '410_0027.jpeg',str_to_date('2012/11/14 18:46:58', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'커리퀸','인도 커리 파우더와 로스팅 갈릭 시즈닝을 더해 이국적인 맛','20121022',18000, '410_0028.jpeg',str_to_date('2012/11/15 17:39:01', '%Y/%m/%d %H:%i:%s')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          );
insert into product values (null,'골드킹','숙성간장과 꿀의 황금비율','20120212',17000, '410_0029.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'맵소킹','눈물이 찔끔 날 듯한 홍고추의 알싸한 매운 맛','20120212',180000, '410_0030.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'포테킹 후라이드','리얼 감자 후라이드','20120212',19000, '410_0031.jpeg',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'치퐁당 후라이드','새우,마늘 후레이크 치킨','20120212',20000, '410_0032.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'고추장 직화구이','직화로 구워낸 고추장 소스를 더해 맵싸한 직화구이 치킨','20120212',14000, '410__0033.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'뿌링감자','뿌링뿌링 가루가 더해진 바삭한 케이준 프라이','20120212',4500, '410__0020.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'케이준프라이','바삭 튀긴 프라이','20120212',3500, '411_0021.jpeg',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'달콤바삭치즈볼','쫄깃한 모짜렐라 치즈가 들어간 바삭한 치즈볼','20120212',5000, '411_0022.jpeg',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'뿌링치즈볼','뿌링뿌링 가루가 뿌려진 뿌링치즈 치즈볼','20120212',6000, '411_0023.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'분모자로제떡볶이','로제소스와 분모자가 어우러진 떡볶이','20120212',5500, '411_0024.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'뿌링소떡','뿌링뿌링 가루가 더해진 쫄깃달콤한 소떡','20120212',3500, '411_0025.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'빨간소떡','매콤 양념 소스의 매콤쫄깃한 소떡','20120212',3000, '411_0026.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'뿌링치즈스틱','뿌링뿌링 가루를 입힌 모짜렐라 치즈스틱','20120212',4500, '411_0027.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));
insert into product values (null,'링멘보샤','새우살과 바게트 빵을 이용한 bhc만의 멘보샤','20120212',6000, '411_0028.png',str_to_date('2012/11/12 13:04:31', '%Y/%m/%d %H:%i:%s'));


commit;
