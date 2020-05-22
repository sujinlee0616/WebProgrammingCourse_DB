-- 2020.05.22(금) Function
/* 
    PL/SQL
    1. PROCEDURE
     - return을 가지고 있지 않다 => 수행한 결과값을 받을 경우 (매개변수 => OUT)
    2. Function
     - return을 가지고 있다 ==> return은 한 개의 값만 사용한다. 
     - ex) max, substr, ...
     <사용자 정의 함수)
     1) 출력을 목적으로 ==> SELECT 사용자정의함수 FROM ...
     2) 컬럼, 조건문
     3) 목적 ==> 복잡한 SQL 문장이 있는 경우 
     
     형식) 
     CREATE [OR REPLACE] FUNCTION function_name(매개변수)
     RETURN 데이터형 
     IS
        변수설정 => 지역변수
     BEGIN
        SQL문장 ==> SELECT dname INTO 변수
        RETURN 변수
     END;
     / 
*/

SELECT empno,ename,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

CREATE OR REPLACE FUNCTION deptGetDname(pdeptno emp.deptno%TYPE) -- <== PL
RETURN VARCHAR2
IS
    pDname dept.dname%TYPE;
BEGIN
    SELECT dname INTO pDname 
    FROM dept
    WHERE deptno=pdeptno;
    RETURN pDname;
END;
/

SELECT empno,ename,deptGetDname(deptno) FROM emp;

-- ex) loc 갖고오는 함수 만들어서, empno/ename/deptno/loc 출력해라.
--     ==> 함수를 사용하면 JOIN을 걸지 않아도 값을 가져올 수 있고, 소스도 짧아짐. 

SELECT * FROM dept;

CREATE OR REPLACE FUNCTION deptGetLoc(pdeptno emp.deptno%TYPE)
RETURN VARCHAR2
IS
    pLoc dept.loc%TYPE;
BEGIN
    SELECT loc INTO pLoc
    FROM dept
    WHERE deptno=pdeptno;
    RETURN pLoc;
END;
/

SELECT empno,ename,deptGetDname(deptno),deptGetLoc(deptno) FROM emp;
    




SELECT * FROM student;
INSERT INTO student VALUES(1,'홍길동',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(2,'심청이',85,95,99,SYSDATE,'여');
INSERT INTO student VALUES(3,'박문수',65,86,70,SYSDATE,'남');
INSERT INTO student VALUES(4,'춘향이',90,90,95,SYSDATE,'여');
INSERT INTO student VALUES(5,'이순신',76,49,70,SYSDATE,'남');
COMMIT;

-- 복수의 행을 연산할 수는 있으나, (ex. student 테이블에서 학번1~5번 학생의 kor 점수 합계)
-- 복수의 열을 연산할 수는 없음
-- ==> 이때까지는 아래와 같은 식으로 열을 연산해왔음 
SELECT hakbun,name,kor,eng,math,(kor+eng+math) as total,ROUND((kor+eng+math)/3.0,2) as avg FROM student;

-- 이제는 굳이 위처럼 하지 않아도, 함수를 사용해서 아래와 같이 만들 수 있다.
CREATE OR REPLACE FUNCTION mySum(phakbun student.hakbun%TYPE)
RETURN NUMBER
IS
    pSum NUMBER;
BEGIN
    SELECT kor+eng+math INTO pSum
    FROM student WHERE hakbun=phakbun;
    RETURN pSum;
END;
/
SELECT hakbun,name,kor,eng,math,mySum(hakbun) FROM student;

-- ex) 개인의 평점을 구하는 함수를 만들어라.
CREATE OR REPLACE FUNCTION myAvg(phakbun student.hakbun%TYPE)
RETURN NUMBER
IS
    pAvg NUMBER;
BEGIN
    SELECT ROUND((kor+eng+math)/3.0,2) INTO pAvg
    FROM student WHERE hakbun=phakbun;
    RETURN pAvg;
END;
/
SELECT hakbun,name,kor,eng,math,mySum(hakbun),myAvg(hakbun) FROM student;


CREATE OR REPLACE FUNCTION getTotalPage
RETURN NUMBER
IS
    total NUMBER;
BEGIN
    SELECT CEIL(COUNT(*)/10.0) INTO total
    FROM recipe;
    RETURN total;
END;
/

SELECT getTotalPage() FROM recipe; -- 단일행함수 














