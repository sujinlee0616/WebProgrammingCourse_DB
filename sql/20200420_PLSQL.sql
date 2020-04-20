--2020.04.20(월) 영화예약

-- =================================== ReserveTheater 테이블 ===================================
CREATE TABLE ReserveTheater(
    tno NUMBER,
    tname VARCHAR2(100),
    tloc VARCHAR2(100),
    tdate VARCHAR2(100)  
);
--tdate: 예약 가능 날짜 ==> 랜덤으로 집어넣자 (ex. 1,2,4,8 값은 이런식으로 넣을 예정)

INSERT INTO ReserveTheater VALUES(1,'CGV','마포',null);
INSERT INTO ReserveTheater VALUES(2,'롯데시네마','목동',null);
INSERT INTO ReserveTheater VALUES(3,'CGV','홍대',null);
INSERT INTO ReserveTheater VALUES(4,'CGV','상수',null);
INSERT INTO ReserveTheater VALUES(5,'롯데시네마','구로',null);
INSERT INTO ReserveTheater VALUES(6,'CGV','강남',null);
INSERT INTO ReserveTheater VALUES(7,'CGV 골드','청담',null);
INSERT INTO ReserveTheater VALUES(8,'CGV','강남2점',null);
INSERT INTO ReserveTheater VALUES(9,'CGV','신촌아트레온',null);
INSERT INTO ReserveTheater VALUES(10,'CGV','신논현',null);
INSERT INTO ReserveTheater VALUES(11,'메가박스','당산',null);
INSERT INTO ReserveTheater VALUES(12,'CGV','영등포구청',null);
INSERT INTO ReserveTheater VALUES(13,'메가박스','마곡',null);
INSERT INTO ReserveTheater VALUES(14,'CGV','김포',null);
INSERT INTO ReserveTheater VALUES(15,'CGV','인천공항점',null);

SELECT * FROM ReserveTheater;

-- =================================== ReserveTheater 테이블 ===================================
CREATE TABLE ReserveDate(
    tno NUMBER,
    time VARCHAR2(100)
);
INSERT INTO ReserveDate VALUES(1,null);
INSERT INTO ReserveDate VALUES(2,null);
INSERT INTO ReserveDate VALUES(3,null);
INSERT INTO ReserveDate VALUES(4,null);
INSERT INTO ReserveDate VALUES(5,null);
INSERT INTO ReserveDate VALUES(6,null);
INSERT INTO ReserveDate VALUES(7,null);
INSERT INTO ReserveDate VALUES(8,null);
INSERT INTO ReserveDate VALUES(9,null);
INSERT INTO ReserveDate VALUES(10,null);
INSERT INTO ReserveDate VALUES(11,null);
INSERT INTO ReserveDate VALUES(12,null);
INSERT INTO ReserveDate VALUES(13,null);
INSERT INTO ReserveDate VALUES(14,null);
INSERT INTO ReserveDate VALUES(15,null);
INSERT INTO ReserveDate VALUES(16,null);
INSERT INTO ReserveDate VALUES(17,null);
INSERT INTO ReserveDate VALUES(18,null);
INSERT INTO ReserveDate VALUES(19,null);
INSERT INTO ReserveDate VALUES(20,null);
INSERT INTO ReserveDate VALUES(21,null);
INSERT INTO ReserveDate VALUES(22,null);
INSERT INTO ReserveDate VALUES(23,null);
INSERT INTO ReserveDate VALUES(24,null);
INSERT INTO ReserveDate VALUES(25,null);
INSERT INTO ReserveDate VALUES(26,null);
INSERT INTO ReserveDate VALUES(27,null);
INSERT INTO ReserveDate VALUES(28,null);
INSERT INTO ReserveDate VALUES(29,null);
INSERT INTO ReserveDate VALUES(30,null);
INSERT INTO ReserveDate VALUES(31,null);

SELECT * FROM ReserveDate;

-- =================================== ReserveTime 테이블 ===================================
CREATE TABLE ReserveTime(
    tno NUMBER,
    time VARCHAR2(20)
);
INSERT INTO ReserveTime VALUES(1,'08:00');
INSERT INTO ReserveTime VALUES(2,'08:30');
INSERT INTO ReserveTime VALUES(3,'09:00');
INSERT INTO ReserveTime VALUES(4,'09:30');
INSERT INTO ReserveTime VALUES(5,'10:00');
INSERT INTO ReserveTime VALUES(6,'10:30');
INSERT INTO ReserveTime VALUES(7,'11:00');
INSERT INTO ReserveTime VALUES(8,'11:30');
INSERT INTO ReserveTime VALUES(9,'12:00');
INSERT INTO ReserveTime VALUES(10,'12:30');

INSERT INTO ReserveTime VALUES(11,'13:00');
INSERT INTO ReserveTime VALUES(12,'13:30');
INSERT INTO ReserveTime VALUES(13,'14:00');
INSERT INTO ReserveTime VALUES(14,'14:30');
INSERT INTO ReserveTime VALUES(15,'15:00');
INSERT INTO ReserveTime VALUES(16,'15:30');
INSERT INTO ReserveTime VALUES(17,'16:00');
INSERT INTO ReserveTime VALUES(18,'16:30');
INSERT INTO ReserveTime VALUES(19,'17:00');
INSERT INTO ReserveTime VALUES(20,'17:30');

INSERT INTO ReserveTime VALUES(21,'18:00');
INSERT INTO ReserveTime VALUES(22,'18:30');
INSERT INTO ReserveTime VALUES(23,'19:00');
INSERT INTO ReserveTime VALUES(24,'19:30');
INSERT INTO ReserveTime VALUES(25,'20:00');
INSERT INTO ReserveTime VALUES(26,'20:30');
INSERT INTO ReserveTime VALUES(27,'21:00');
INSERT INTO ReserveTime VALUES(28,'21:30');
INSERT INTO ReserveTime VALUES(29,'22:00');
INSERT INTO ReserveTime VALUES(30,'22:30');

SELECT * FROM ReserveTime ORDER BY tno ASC;
SELECT COUNT(*) FROM ReserveTime;

-- =================================== Reserve 테이블 ===================================
CREATE TABLE Reserve(
    rno NUMBER,
    id VARCHAR2(20),
    mno NUMBER,
    tname VARCHAR2(100),
    rdate VARCHAR2(100),
    rtime VARCHAR2(100),
    rinwon VARCHAR2(20),
    rprice VARCHAR2(20),
    isReserve NUMBER
);
--isReserve: 예약여부 확인 컬럼

-- ======================================================================

SELECT mno,title FROM movie
ORDER BY mno ASC;
DESC movie;

ALTER TABLE movie ADD theaterNo VARCHAR2(200);

SELECT * FROM reserveTheater;

SELECT * FROM movie;



SELECT * FROM member;










