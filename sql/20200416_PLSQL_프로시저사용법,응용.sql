--2020.04.16(목) 프로시저 사용법

/*
    자바: 메소드
    오라클: 프로시저
    ※ [참고] 오라클에는 '프로시저'와 '함수'가 있음
     - 프로시저: 기능 처리. 리턴형 존재O.
     - 함수: 반복수행이 되는 경우. 리턴형 존재X. 주로 SELECT 뒤에 붙는다. 
            ex) SELECT AVG(math) FROM student;
                Hakbun  name    kor     eng     math 
                1       홍길동1    90      80     70 
                2       홍길동2    80      80     70 
                3       홍길동2    70      80     70 
*/

/*
    [PL/SQL의 문법]
    
    1. 변수 ===> 지역변수, 매개변수로 사용 
     - 일반변수: 변수명 데이터형(NUMBER,VARCHAR2,DATE...): 스칼라 변수 
       ex) SELECT CEIL(COUNT(*)/30.0) FROM chef 
           : 이런애들은 CEIL했으니 %TYPE 이런애로 받아올 수 없잖아 ==> 이런 애들은 스칼라 변수로 받는다. 
     - 실제 테이블의 데이터형을 받을 때: %TYPE
       형식) 테이블명.컬럼%TYPE
     - 테이블 전체 데이터를 받을 때: %ROWTYPE
       형식) 테이블명%ROWTYPE ==> VO처럼 사용할 수 있다.  
     - 사용자 정의: TYPE 변수명 IS RECORD()
       ex) subquery나 join 걸려있을 때
     - CURSOR: 여러개의 RECORD를 얻어오는 방식 
     
    2. 연산자
     - 산술연산자: +,-,*,/
     - 논리연산자: AND, OR, NOT
     - 비교연산자: =, !=(<>), <, >, <=, >=
     - 문자열결합: ||
     - NULL연산자: IS NULL, IS NOT NULL
     - 기간, 범위: BETWEEN ~ AND 
     - 유사 문자열: LIKE (%,_)
     - 부정연산자NOT
     
    3. 제어문
    1) IF 조건 THEN 
        실행구문
       END IF;
    2) IF 조건 THEN
        실행구문
       ELSE
        실행구문
       END IF;
    3) IF 조건 THEN
        실행구문
       ELSIF 조건 THEN
        실행구문
       END IF;
    4) LOOP
    5) WHILE
    6) FOR
*/

/*
    [PROCEDURE, FUNCTION, TRIGGER]
    1. PROCEDURE
     - 기능처리 (메소드). 리턴형이 존재하지 않는다.
       => 매개변수를 이용해서 데이터를 받아오기 시작한다. 
     1) 변수 
        (1)IN 변수(디폴트) ==> Call By Value 
          - DML은 IN변수라고 생각하면 된다. INSERT, UPDATE, DELETE 같이 값 받을 게 없는 애들.
        (2)OUT 변수 ==> Call By Reference 
          - SELECT가 나오면 OUT변수 쓴다고 생각하면 된다. 
        (3)INOUT 변수 ==> Call By Value + Call By Reference 
     2) 형식
        (1) 생성 
          - CREATE PROCEDURE 프로시저명(매개변수, 매개변수, ...)  -- <== 선언문 (DECLARE 대신)
            IS
                지역변수 생성 
            BEGIN
                SQL 문장으로 제어
            END;
            /
        (2) 수정
         - CREATE [OR REPLACE] PROCEDURE 프로시저명(매개변수, 매개변수, ...)  -- 기존에 있던 프로시저명과 동일한 프로시저명을 쓰면, 기존 프로시저가 날아가고 지금 만드는 프로시저로 대체된다. 
            IS
                지역변수 생성 
            BEGIN
                SQL 문장으로 제어
            END;
            /
        (3) 삭제 
*/

CREATE TABLE pro_test(
    no NUMBER,
    name VARCHAR2(34),
    kor NUMBER,
    eng NUMBER,
    math NUMBER
);


-- 추가
-- [참고] 특수문자는 _ 또는 $ 밖에 못 쓴다. 
CREATE PROCEDURE pro_test_insert(
    pname pro_test.name%TYPE,
    pkor pro_test.kor%TYPE,
    peng pro_test.eng%TYPE,
    pmath pro_test.math%TYPE    
)
IS
    --선언
BEGIN
    --구현
    INSERT INTO pro_test VALUES (
        (SELECT NVL(MAX(no)+1,1) FROM pro_test),
        pname,pkor,peng,pmath
    );
END;
/

-- 이런식으로 호출한다!! ==> 반복되는 쿼리를 계속 쓰지 않아도 된다. 그냥 프로시져 만들어서 호출만 하면 됨. 
CALL pro_test_insert('홍길동',90,85,100);
CALL pro_test_insert('심청이',95,100,75);
CALL pro_test_insert('박문수',90,60,60);

-- 데이터 확인 
SELECT * FROM pro_test;

-- =====================================================================================

-- update하는 프로시져를 만들어보자. 
-- 아래의 코드에 있는 변수는 모두 IN 변수이다. (값을 대입해주는 변수. 별도의 표시가 없으면 디폴트는 IN변수임. OUT변수는 디폴트가 아니라서 OUT이라고 써줘야함) 
CREATE OR REPLACE PROCEDURE pro_test_update(
    pno pro_test.no%TYPE, 
    pname pro_test.name%TYPE,
    pkor pro_test.kor%TYPE,
    peng pro_test.eng%TYPE,
    pmath pro_test.math%TYPE   
)
IS
BEGIN
    UPDATE pro_test SET
    name=pname,
    kor=pkor,
    eng=peng,
    math=pmath
    WHERE no=pno;
    commit;
END;
/


-- 데이터 확인 
SELECT * FROM pro_test;

-- 함수 호출 
CALL pro_test_update(1,'홍길수',80,80,75);

-- 함수 호출에 의해 변경된 데이터 확인 
SELECT * FROM pro_test;

-- 잘못 만들어서 삭제했다 다시 만듦...
DROP PROCEDURE pro_test_delete;

-- =====================================================================================
-- ex) DELETE 시키는 함수를 만드시오. 매개변수는 no 하나. 번호 넣으면 해당 번호 데이터 삭제하게. 
CREATE OR REPLACE PROCEDURE pro_test_delete(
    pno pro_test.no%TYPE 
)
IS
BEGIN
    DELETE FROM pro_test 
    WHERE no=pno;
    commit;
END;
/

-- 함수 호출
CALL pro_test_delete(1);

-- 함수 호출에 의해 삭제된 데이터 확인 
SELECT * FROM pro_test;

-- =====================================================================================

-- pno를 넣고 pname,pkor,peng,pmath 값을 달라 
-- ==> pname,pkor,peng,pmath: OUT 변수, pno:IN변수 
CREATE OR REPLACE PROCEDURE pro_test_select(
    pno pro_test.no%TYPE, 
    pname OUT pro_test.name%TYPE,
    pkor OUT pro_test.kor%TYPE,
    peng OUT pro_test.eng%TYPE,
    pmath OUT pro_test.math%TYPE  
)
IS
BEGIN
    SELECT name,kor,eng,math INTO pname,pkor,peng,pmath
    FROM pro_test 
    WHERE no=pno;
END;
/

CALL pro_test_select(2);
SELECT * FROM pro_test;


-- =====================================================================================
-- 변수 선언 
VARIABLE pname VARCHAR2(34);
VARIABLE pkor NUMBER;
VARIABLE peng NUMBER;
VARIABLE pmath NUMBER;
EXECUTE pro_test_select(2,:pname,:pkor,:peng,:pmath); 
PRINT pname pkor peng pmath;
-- ★★★★ ':'은 포인터임. 주소값을 넣어준다. ★★★★
-- 206~212줄 한 번에 블록처리 후 실행하기 















