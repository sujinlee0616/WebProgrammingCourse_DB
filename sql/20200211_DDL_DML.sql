-- 2020-02-11 
/* 
<DDL> : 어제 배운 내용 복습 
1. CREATE: 테이블 생성 
 1) 형식
  - table, column => 30byte (10글자 정도) 
    CREATE TABLE table명(
        컬럼명 데이터형 [제약조건(여러개 설정도 가능)], => NOT NULL, DEFAULT
        컬럼명 데이터형 [제약조건(여러개 설정도 가능)],
        컬럼명 데이터형 [제약조건(여러개 설정도 가능)],
        [제약조건], => PRIMARY, FOREIGN, CHECK, UNIQUE
        [제약조건] ....
    )
 2) 제약조건 
  - 정형화된 데이터 => 필요한 데이터만 저장, 이상현상을 방지. (ex. 수정/삭제 시 문제 발생하는 것 방지) 
  (1) NOT NULL: NULL값 허용X.
  (2) UNIQUE: 중복을 허용하지 않음. (NULL값 허용함.)
      ex) 전화번호, 이메일 ==> 후보키.
  (3) PRIMARY KEY: NOT NULL + UNIQUE
      - 기본 키. 모든 테이블은 한 개의 PK를 가진다. 
      - 데이터 무결성의 원칙. 
  (4) FOREIGN KEY: 
      - 데이터베이스 => 분산(정규화) => 참조키 
      - ex) 사원정보 부서정보 근무지정보 등급정보 => 관리 용이
  (5) CHECK 
      - 지정된 데이터만 저장할 수 있게 한다.
      - ex) 부서명, 성별, 근무지     
  (6) DEFAULT
      - 값이 입력이 안 된 경우 디폴트값이 자동으로 들어가게 한다. 
      - ex) 게시판에서 조회수 디폴트는 0
 3) 데이터형 ==> 자바와 연동
   - step1. 오라클 테이블 구조 확인: DESC table명
     ex) =============================================
            id      pwd     name    addr    tel
         =============================================
            aa      1234    홍길동   서울    111-1111    ===> VO 
         =============================================
            bb      1234    심청이   경기    222-2222    ===> VO 
         =============================================
     
    [오라클 데이터형]                   [자바 데이터형]
    문자형: CHAR, VARCHAR2, CLOB ===> String  
    숫자형: NUMBER =================> int, double
    날짜형: DATE, TIMESTAMP ========> java.util.Date (java.sql.Date)
                                     - 보통 java.util.Date 사용
                                     - 문자열 형식으로 저장 
                                       ex) 오늘날짜(SYSDATE), 다른날짜 ('YY/MM/DD')  
    기타형: BLOB, BFILE ============> java.io.InputStream 
     - BLOB(4G): 이진파일로 저장
     - BFILE(4G): 파일 형태 저장 
       => 사진, 동영상 등 저장 시 사용. 
 

2. ALTER: 컬럼 추가, 수정, 삭제  
 1) 형식
    ALTER TABLE table명 ADD 컬럼명 데이터형 [제약조건]
    ALTER TABLE table명 MODIFY 컬럼명 데이터형 [제약조건]
    ALTER TABLE table명 DROP COLUMN 컬럼명  <========= 컬럼을 참조하고 있는 테이블이 있는 경우에는 지워지지 않는다. 

3. DROP: 테이블 자체를 삭제
 - 형식 : DROP TABLE table명
 
4. TRUNCATE: 테이블 구조는 놔두고 데이터만 삭제.
 - 형식: TRUNCATE TABLE table명

5. RENMAE: 테이블의 이름 변경
 - 형식 : ALTER TABLE '현재 table명' RENAME TO '바꿀 table명' 

*/

/*
1. 테이블 TABLE
2. 가상 저장 장소 VIEW
3. 자동 증가 번호 SEQUENCE 
4. 최적화 INDEX
5. PL/SQL
6. 튜닝  
*/

/*
<DML>: 데이터 조작
1. INSERT: 데티어 삽입
 - 형식) 
   1. 원하는 데이터만 저장 => DEFAULT
      INSERT INTO table명(컬럼1,컬럼2,컬럼3,...) VALUES(값1,값2,값3..)
   2. 전체를 저장하는 방법
      INSERT INTO table명 VALUES(값1,값2,....)
      => PRIMARY, NOT NULL, FOREIGN, CHECK
2. UPDATE: 데이터 수정 
 - 형식) 
   1. 전체를 수정 => 조건이 없는 상태
      UPDATE table명 SET
      컬럼명=변경할값, 컬럼명=변경할값, 컬렴명=변경할값, .....
   2. 원하는 부분만 수정 => 조건이 있는 상태 
      UPDATE table명 SET
      컬럼명=변경할값, 컬럼명=변경할값, 컬렴명=변경할값, .....
      WHERE 컬럼명 연산자 값

3. DELETE: 데이터 삭제 
 - 형식) 
   1. 전체 삭제 => 조건이 없는 상태
      DELETE FROM table명 
      ====> TRUNCATE => COMMIT or ROLLBACK
   2. 원하는 데이터만 삭제 => 조건이 있는 상태 
      DELETE FROM table명 
      WHERE 컬럼명 연산자 값(중복이 없는 데이터) 
*/

CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(30) CONSTRAINT st_name_nn NOT NULL,
    kor NUMBER CONSTRAINT st_kor_nn NOT NULL,
    eng NUMBER CONSTRAINT st_eng_nn NOT NULL,
    math NUMBER CONSTRAINT st_math_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT st_hakbun_pk PRIMARY KEY(hakbun)
);

-- 데이터 추가 
INSERT INTO student VALUES(1,'홍길동',90,85,70); --Error. 컬럼수가 안 맞음. 6개 넣어야 하는데 5개만 넣어서 그럼.
INSERT INTO student VALUES(1,'홍길동',90,85,70,SYSDATE); --정상수행.
INSERT INTO student(hakbun,name,kor,eng,math) VALUES(2,'심청이',90,80,60); --정상수행
INSERT INTO student(hakbun,name,kor,eng,math) VALUES(3,'',90,80,60); --Error. name이 NN인데 NULL넣어서. 

--위에서 만든 테이블 지우고 다시 만듦
DROP TABLE student;
CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(30) CONSTRAINT st_name_nn NOT NULL,
    kor NUMBER CONSTRAINT st_kor_nn NOT NULL,
    eng NUMBER CONSTRAINT st_eng_nn NOT NULL,
    math NUMBER CONSTRAINT st_math_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    sex VARCHAR2(10),
    CONSTRAINT st_hakbun_pk PRIMARY KEY(hakbun),
    CONSTRAINT st_sex_ck CHECK(sex IN('남','여'))
);

-- 데이터 추가 
INSERT INTO student VALUES(1,'홍길동',90,85,70,SYSDATE,'남자'); --Error. sex는 '남','여' 둘 중에 하나만 들어가야하므로 '남자' 들어갈 수 X.
INSERT INTO student VALUES(1,'홍길동',90,85,70,SYSDATE,'남'); --정상수행.
INSERT INTO student(hakbun,name,kor,eng,math,sex) VALUES(2,'심청이',80,100,100,'여'); --정상수행
INSERT INTO student(hakbun,name,kor,eng,sex, math) VALUES(3,'이순신',80,60,'남', 88); --정상수행: 앞에서 컬럼 순서 바꾸면 뒤에 들어가는 데이터도 순서 바꾸면 됨. 
-- 그냥 왠만하면 원래 컬럼 순서대로 데이터 집어넣어라.
COMMIT;
--COMMIT 안 하면 저장 안 됨. 주의!

SELECT * FROM student;

--데이터 수정
UPDATE student SET 
kor=95, eng=90, math=80
WHERE name='홍길동';

SELECT * FROM student;

--데이터 수정
UPDATE student SET 
math=88
WHERE hakbun=1;

SELECT * FROM student;
COMMIT;

--삭제 (모든 데이터 삭제) 
DELETE FROM student; --모든 데이터 다 삭제됨
ROLLBACK; --삭제 취소 
SELECT * FROM student;

--삭제 (1개 행만 삭제) 
DELETE FROM student --조건에 맞는 1개 행만 삭제함 
WHERE hakbun=3;
SELECT * FROM student;
COMMIT;

--다시 3번행 삽입
INSERT INTO student(hakbun,name,kor,eng,sex, math) VALUES(3,'이순신',80,60,'남', 88);
COMMIT;
SELECT * FROM student;

SELECT hakbun,name,kor,eng,math,RANK() OVER(ORDER BY (kor+eng+math) DESC) 등수
FROM student;

SELECT hakbun,name,kor,eng,math,(kor+eng+math) total, RANK() OVER(ORDER BY (kor+eng+math) DESC) 등수
FROM student;

SELECT hakbun,name,kor,eng,math,(kor+eng+math) AS total, RANK() OVER(ORDER BY (kor+eng+math) DESC) AS 등수
FROM student;

SELECT hakbun,name,kor,eng,math,ROUND((kor+eng+math)/3,2) AS 평균, RANK() OVER(ORDER BY (kor+eng+math) DESC) AS 등수
FROM student;

-- ================================================ 3교시 ================================================
-- 게시판을 만들어보자. 
-- 1페이지에 10개 출력. 
DROP TABLE board;

CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(50) CONSTRAINT board_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT board_subject_nn NOT NULL,
    content CLOB CONSTRAINT board_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT board_no_pk PRIMARY KEY(no)
);
COMMIT;

INSERT INTO board(no,name,subject,content,pwd) VALUES (1,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (2,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (3,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (4,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (5,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (6,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (7,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (8,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (9,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (10,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (11,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (12,'홍길동','처음하는 서블릿 게시판','자바 연동.... 내용입니다.','1234');
COMMIT;

SELECT * FROM board;
--INSERT, UPDATE, DELETE는 이제 Java로 한다. 

SELECT CEIL(COUNT(*)/10.0) FROM board;
SELECT * FROM board;






