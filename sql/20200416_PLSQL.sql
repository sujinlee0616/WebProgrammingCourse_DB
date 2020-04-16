-- 2020.04.16 PL/SQL 제어문(반복문)

/*
    1. Loop문
    형식) LOOP
            처리
            EXIT [조건] ==> 종료
         END LOOP 

    2. WHILE문
    형식) WHILE 조건 LOOP
            처리문장 => PL/SQL
         END LOOP
        
    3. FOR문 
    형식) FOR 변수 IN (REVERSE) start..end LOOP
                     ========
                        REVERSE가 붙으면 역순으로 실행한다. end부터 start까지 -1씩 감소하며 수행됨. 
                        <==> IN: start부터 시작해서 1씩 증가해서 end 까지 수행된다.
                             ex) FOR i IN 1..9 LOOP 
                                 for(int i=1; i<=9; i++)
                                 위의 두 문장은 동일하다.
                             ex2) for(int i=10;i>1;i--)
                                  FOR i IN REVERSE 10..1 LOOP
            처리문장 => PL/SQL
         END LOOP
*/

-- ====================================================================================
-- PL/SQL

SET SERVEROUTPUT ON
DECLARE 
    no NUMBER:=1;
    sum1 NUMBER:=0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(no);
        sum1:=sum1+no;
        no:=no+1;
        EXIT WHEN no>10;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1~10까지 합은 '||sum1);
END;
/
-- 변수이름 sum으로 주면 내장함수명이라서 안 됨.

-- ====================================================================================
-- [WHILE문] 
DECLARE
    no NUMBER:=1;
BEGIN
    WHILE no<=10 LOOP
        DBMS_OUTPUT.PUT_LINE('no='||no);
        no:=no+1;
    END LOOP;
END;
/
-- 얘네는 ++이 없어서 no:=no+1; 요런식으로만 해줘야함

-- ====================================================================================
-- [FOR문] 
BEGIN 
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE ('i='||i);
    END LOOP;
END;
/

BEGIN 
    FOR i IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE ('i='||i);
    END LOOP;
END;
/

-- 데이터 읽기
-- 데이터가 여러개일 경우 => ArrayList, [] 
-- 오라클 => ArrayList의 역할 수행 => CURSOR

/*
    CURSOR는 자바의 ResultSet!! 
    ==> ★오라클이 CURSOR를 전송하면 자바에서는 ResultSet으로 받아서 처리한다.★
               ==================================
                ROW(RECORD)의 집합
                BIT ==> WORD ==> RECORD ==> TABLE 
                CHAR    String   한 줄 문자열  file
                
                 - 테이블의 데이터 한 줄 한 줄을 레코드 또는 row라고 얘기함. 
                 
    ※ 단위(table)
    ===================================
        ID      NAME        SEX     =====> Column, Attribute: 멤버변수 
    ===================================
        aaa     홍길동       남자     =====> ROW, TUPLE, Record =====
    ===================================                           ∥
        bbb     심청이       여자     =====> ROW, TUPLE, Record =======> 이 한 줄 한 줄을 여러개를 모은 게 'CURSOR'
    ===================================                           ∥
        ccc     박문수       남자     =====> ROW, TUPLE, Record =====
    ===================================
    
    
    [CURSOR 사용법]
    1. CURSOR 선언: ADD 
     - 형식)
        CURSOR 커서명 IS
        SELECT 문장  <== 여기서 실행한 문장을 CURSOR에 저장
     - ex) 
        CURSOR cursor1 IS
        SELECT * FROM emp
    2. CURSOR 열기: 메모리 할당 
     - 형식) 
        커서명 OPEN 
    3. CURSOR에 있는 데이터 인출: get(), for(MovieVO vo:list)
     - 형식)
        FETCH
    4. CURSOR 닫기 
     - 형식) 
        커서명 CLOSE
*/

-- 모든 데이터형 다 필요하면 %ROWTYPE이 편하고,
-- JOIN 걸리면 RECORD 선언하는게 편함 
-- ★CURSOR를 이용하면 내가 원하는 갯수만큼의 데이터를 다 갖고 올 수 있다!!★

DECLARE 
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    CURSOR emp_cur IS
        SELECT empno,ename,job
        FROM emp;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO vempno,vename,vjob;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vempno||' '||vename||' '||vjob);
    END LOOP;
    CLOSE emp_cur;
END;
/
--%NOTFOUND: 더 이상 인출할 내용이 없을 때.
    
-- ====================================================================================
-- [FOR문]: 일반 for문... 
-- for(int i=1;i<list.size();i++) 같은 코딩.
DECLARE
    vemp emp%ROWTYPE;  --JAVA에서의 VO 연결과 동일
    CURSOR emp_cur IS
        SELECT *
        FROM emp;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO vemp;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job);
    END LOOP;
    CLOSE emp_cur;
END;
/

-- ====================================================================================
-- [FOR문 이용]: for each 구문 
-- for(EmpVO vemp:list) 와 같은 코딩.
DECLARE
    vemp emp%ROWTYPE;
    CURSOR emp_cur IS
        SELECT * FROM emp;
BEGIN
    FOR vemp IN emp_cur LOOP
    EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job);
    END LOOP;
END;
/




















