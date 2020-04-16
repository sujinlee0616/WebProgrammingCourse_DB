--2020.04.14(화) PL/SQL
/* 
    [PL/SQL의 구조]
    - PROCEDURE, FUNCTION, PACKAGE, TRIGGER
    
    DECLARE (익명)
        - DECLARE는 익명으로 들어갈 때. 연습용. DECLARE(연습용)이 아닐 땐 아래와 같이 쓴다. 
        - CREATE PROCEDURE pro_name()
        - CREATE FUNCTION func_name:NUMBER()
        - CREATE TRIGGER tri_name 
        선언부 => 변수, 상수 
    BEGIN
        구현부 : SQL 
    EXCEPTION : 예외처리 
    
    - ERP에서 많이 사용. (중복된 SQL이 많고, 보안이 걸려있어서..) 
*/
-- =================================================================================================
/*
    - %TYPE: 기존의 테이블이 가지고 있는 데이터형을 읽어올 때.
    - 테이블명.컬럼명%TYPE
    - emp.job%TYPE 이라고 쓰면 실제 데이터형인 VARCHAR2(20)를 알아서 가지고 옴. 
*/
-- =================================================================================================
/*
    데이터 읽기 CRUD
    SELECT empno,ename ==> 변수에 저장해서 사용
           =========== INTO vempno,vename : 변수. 변수에 데이터를 넣어서 가지고 올 수 있음. 이 변수는 JAVA 변수와 마찬가지로 하나의 값만 저장 가능. 
    FROM emp
    WHERE empno=7788
*/
-- =================================================================================================
/* [기타]
    JSP == React
    MVC == Redix
    Spring == mobx 
    
    [기타]
    함수(메소드) ==> 변수+연산자+제어문 
*/
-- =================================================================================================
-- [%TYPE]
SET SERVEROUTPUT ON
DECLARE -- 선언 
    -- 사용할 변수 설정
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vdname dept.dname%TYPE;
    vloc dept.loc%TYPE;
BEGIN
    -- 구현 : BEGIN과 END 사이 
    SELECT empno,ename,job,dname,loc 
    INTO vempno,vename,vjob,vdname,vloc  -- SELECT에서 가져온 값을 이 변수들에다가 넣어라 
    FROM emp,dept
    WHERE emp.deptno=dept.deptno
    AND empno=7788;
    
    -- 출력 
    DBMS_OUTPUT.put_line('****** 결과 ****** '); --sysout과 동일한 기능 (줄바꿈 有)
    DBMS_OUTPUT.put_line('사번: '||vempno);
    DBMS_OUTPUT.put_line('이름: '||vename);
    DBMS_OUTPUT.put_line('직위: '||vjob);
    DBMS_OUTPUT.put_line('부서명: '||vdname);
    DBMS_OUTPUT.put_line('근무지: '||vloc);
END;
/  -- '/' 빠뜨리면 안됨!!! '/'은 끝난다는 뜻.

-- =================================================================================================
-- ex) [%TYPE 예제] 이름,직위,입사일,급여,부서명,근무지를 출력하라. 
SET SERVEROUTPUT ON
DECLARE
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vhiredate emp.hiredate%TYPE;
    vsal emp.sal%TYPE;
    vdname dept.dname%TYPE;
    vloc dept.loc%TYPE;
BEGIN
    SELECT ename,job,hiredate,sal,dname,loc
    INTO vename,vjob,vhiredate,vsal,vdname,vloc
    FROM emp,dept
    WHERE emp.deptno=dept.deptno
    AND empno=7788; -- 요렇게 한 개의 컬럼 지정해주지 않으면 오류나겠지?! 왜냐면 변수는 한 개인데 결과가 여러행이면 담을 수가 없잖아...
    
    -- 출력 
    DBMS_OUTPUT.put_line('****** 결과 ****** '); --sysout과 동일한 기능 (줄바꿈 有)
    DBMS_OUTPUT.put_line('이름: '||vename);
    DBMS_OUTPUT.put_line('직위: '||vjob);
    DBMS_OUTPUT.put_line('입사일: '||vhiredate);
    DBMS_OUTPUT.put_line('급여: '||vsal);
    DBMS_OUTPUT.put_line('부서명: '||vdname);
    DBMS_OUTPUT.put_line('근무지: '||vloc);
    
END;
/

SELECT * FROM emp;
SELECT * FROM dept;
-- =================================================================================================
/*
    [%ROWTYPE]
    - ★한 개의 테이블★의  ★전체 데이터형★을 가지고 올 때. ==> 변수 emp%ROWTYPE, 변수 dept%ROWTYPE
    - 위의 %TYPE 처럼 JOIN해서 두 개 테이블의 데이터 갖고 오는 것 불가능. 한 개의 테이블 데이터만 가지고 올 수 있음. 
    - 얘도 %TYPE처럼 변수에 한 개의 값만 저장할 수 있다. 
*/
SET SERVEROUTPUT ON
DECLARE
    vemp emp%ROWTYPE;
BEGIN
    SELECT * INTO vemp
    FROM emp
    WHERE empno=7788;
    
    DBMS_OUTPUT.put_line('사번: '||vemp.empno);
    DBMS_OUTPUT.put_line('이름: '||vemp.ename);
    DBMS_OUTPUT.put_line('직위: '||vemp.job);
    DBMS_OUTPUT.put_line('관리자: '||vemp.mgr);
    DBMS_OUTPUT.put_line('입사일: '||vemp.hiredate);
    DBMS_OUTPUT.put_line('급여: '||vemp.sal);
    DBMS_OUTPUT.put_line('성과급: '||vemp.comm);
    DBMS_OUTPUT.put_line('부서번호: '||vemp.deptno);
END;
/
-- =================================================================================================
-- ex) [%ROWTYPE 예제] deptno가 10번인 데이터를 출력하라. 
SET SERVEROUTPUT ON
DECLARE
    vdept dept%ROWTYPE;
BEGIN
    SELECT * INTO vdept
    FROM dept
    WHERE deptno=10;

    DBMS_OUTPUT.put_line('부서명: '||vdept.dname);
    DBMS_OUTPUT.put_line('근무지: '||vdept.loc);
    DBMS_OUTPUT.put_line('부서번호: '||vdept.deptno);
END;
/
SELECT * FROM dept;
-- =================================================================================================
-- 반복되는 SQL문의 경우 함수 만들어서 쓰는 것이 편하다 
-- ex) 게시판: 싸이트에 게시판이 6개! 근데 계속 똑같은 SQL문 반복 코딩하기 싫으니까...

-- IN: 일반변수 
-- OUT: 값 받을 때 

/*
    C언어에서는.... 
    int a=10;
    int* p=&a;
    *p

    String ...
    CALL ....
    CREATE PROCEDURE pro_name(
        pno IN board.no%TYPE,
        pname OUT board.name%TYPE,
        pemail OUT board.email%TYPE
    )
    -- 프로시저는 기능을 수행하는 애인데 리턴형이 없다 
*/

-- 사용자 정의 데이터형.
-- JOIN 걸리거나 SUBQUERY를 쓸 때는 아래와 같이 처리하는 것이 좋다. 
DECLARE
    TYPE empdeptRecord IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        hiredate emp.hiredate%TYPE,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE,
        grade salgrade.grade%TYPE
    );
    -- 변수 선언
    ed empdeptRecord;
BEGIN
    SELECT empno,ename,job,hiredate,dname,loc,grade INTO ed
    FROM emp,dept,salgrade
    WHERE emp.deptno=dept.deptno
    AND sal BETWEEN losal AND hisal
    AND empno=7788;
    
    DBMS_OUTPUT.PUT_LINE('****** 결과 ******');
    DBMS_OUTPUT.PUT_LINE('사번: '||ed.empno);
    DBMS_OUTPUT.PUT_LINE('이름: '||ed.ename);
    DBMS_OUTPUT.PUT_LINE('직위: '||ed.job);
    DBMS_OUTPUT.PUT_LINE('입사일: '||ed.hiredate);
    DBMS_OUTPUT.PUT_LINE('부서명: '||ed.dname);
    DBMS_OUTPUT.PUT_LINE('근무지: '||ed.loc);
    DBMS_OUTPUT.PUT_LINE('등급: '||ed.grade);
END;
/
-- =================================================================================================

ACCEPT pno PROMPT '사번:'
DECLARE
    vdeptno emp.deptno%TYPE:=10; -- 초기값을 만들 때: ':='
    -- PL/SQL에서 '='은 '같다' 이기 때문에, 대입을 위해서는 ':='를 사용한다. 
    vename emp.ename%TYPE:='Hong';
    vempno emp.empno%TYPE:=&pno; -- 입력값을 받는 경우: '&변수명' 
    TYPE empdeptRecord IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        hiredate emp.hiredate%TYPE,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE,
        grade salgrade.grade%TYPE
    );
    -- 변수 선언
    ed empdeptRecord;
BEGIN
    SELECT empno,ename,job,hiredate,dname,loc,grade INTO ed
    FROM emp,dept,salgrade
    WHERE emp.deptno=dept.deptno
    AND sal BETWEEN losal AND hisal
    AND empno=vempno;
    
    DBMS_OUTPUT.PUT_LINE('****** 결과 ******');
    DBMS_OUTPUT.PUT_LINE('사번: '||ed.empno);
    DBMS_OUTPUT.PUT_LINE('이름: '||ed.ename);
    DBMS_OUTPUT.PUT_LINE('직위: '||ed.job);
    DBMS_OUTPUT.PUT_LINE('입사일: '||ed.hiredate);
    DBMS_OUTPUT.PUT_LINE('부서명: '||ed.dname);
    DBMS_OUTPUT.PUT_LINE('근무지: '||ed.loc);
    DBMS_OUTPUT.PUT_LINE('등급: '||ed.grade);
END;
/
-- =================================================================================================
-- [제어문] 
-- : IF, FOR, LOOP 
/*
    1. IF문 
    - 형식) (단일 IF문) 
      IF (조건문) THEN
        처리
      END IF;
    - 형식) (IF ~ ELSE 문) 
      IF (조건문)THEN
        처리
      ELSE
        처리
      END IF;
    - 형식) (IF ~ ELSIF 문)
      IF (조건문) THEN
        처리
      ELSIF (조건문) THEN
        처리
      ELSIF (조건문) THEN
        처리
      END IF;
    - 유의점) '같다'가 '='이다. '=='은 사용하지 않는다.
      ex) deptno=10 (O) 
      ex) deptno==10 (X) 
*/
DECLARE
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vdname dept.dname%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN
    SELECT deptno INTO vdeptno
    FROM emp 
    WHERE empno=7788;
    
    IF (vdeptno=10) THEN
        vdname:='영업부';
    END IF;
    IF (vdeptno=20) THEN
        vdname:='개발부';
    END IF;
    IF (vdeptno=30) THEN
        vdname:='기획부';
    END IF;
    DBMS_OUTPUT.PUT_LINE('****** 결과 ******');
    DBMS_OUTPUT.PUT_LINE('부서명: '||vdname);
END;
/
-- =================================================================================================
DECLARE
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vdname dept.dname%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN
    SELECT deptno,ename,job INTO vdeptno,vename,vjob
    FROM emp 
    WHERE empno=7788;
    
    IF (vdeptno=10) THEN
        vdname:='영업부';
    END IF;
    IF (vdeptno=20) THEN
        vdname:='개발부';
    END IF;
    IF (vdeptno=30) THEN
        vdname:='기획부';
    END IF;
    DBMS_OUTPUT.PUT_LINE('****** 결과 ******');
    DBMS_OUTPUT.PUT_LINE('부서명: '||vdname);
    DBMS_OUTPUT.PUT_LINE('이름: '||vename);
    DBMS_OUTPUT.PUT_LINE('직위: '||vjob);
END;
/

-- =================================================================================================
-- empno=7499, empno=7788
DECLARE 
    vename emp.ename%TYPE;
    vcomm emp.comm%TYPE;
BEGIN
    SELECT ename,comm INTO vename,vcomm
    FROM emp
    WHERE empno=7788; 
    
    IF(vcomm>0) THEN -- vcomm이 NULL이면 IF문 실행 못해서 ELSE 문 실행함 (ex. empno=7788)
        DBMS_OUTPUT.PUT_LINE(vename||'님의 성과급은 '||vcomm||'입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(vename||'님의 성과급은 없습니다.');
    END IF;
    -- 참고) Oracle에서 데이터가 NULL이면 모든 연산이 불가능하다.    
END;
/
-- =================================================================================================

DECLARE
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vdname dept.dname%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN
    SELECT deptno,ename,job INTO vdeptno,vename,vjob
    FROM emp 
    WHERE empno=7788;
    
    IF (vdeptno=10) THEN
        vdname:='영업부';
    ELSIF (vdeptno=20) THEN
        vdname:='개발부';
    ELSIF (vdeptno=30) THEN
        vdname:='기획부';
    END IF;
    DBMS_OUTPUT.PUT_LINE('****** 결과 ******');
    DBMS_OUTPUT.PUT_LINE('부서명: '||vdname);
    DBMS_OUTPUT.PUT_LINE('이름: '||vename);
    DBMS_OUTPUT.PUT_LINE('직위: '||vjob);
END;
/

-- =================================================================================================
-- ex) 전화번호(tel) 입력 => hong => id가 존재하면 ho**, 없는 경우 => 'ID가 존재하지 않습니다' 출력. 
SELECT * FROM member;
-- tel: 010-235-1351 
DECLARE
    vcount NUMBER;
    vid member.id%TYPE;
    vtel member.tel%TYPE:='010-235-1351';
    vresult VARCHAR2(100);
BEGIN
    SELECT COUNT(*) INTO vcount
    FROM member
    WHERE tel=vtel;
    
    IF (vcount=0) THEN
        vresult:='ID가 존재하지 않습니다.';
    ELSE
        SELECT RPAD(SUBSTR(id,1,2),LENGTH(id),'*') INTO vid
        FROM member
        WHERE tel=vtel;
        vresult:='ID는 '||vid||'입니다';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('****** 결과 ******');
    DBMS_OUTPUT.PUT_LINE(vresult);
    
END;
/
-- =================================================================================================
-- 위에꺼를 procedure로 만들기
CREATE PROCEDURE idFind(vtel IN member.tel%TYPE, vresult OUT VARCHAR2(100))
IS
    -- 변수 설정 
    vcount NUMBER;
    vid member.id%TYPE;
    vresult VARCHAR2(100);
BEGIN
    SELECT COUNT(*) INTO vcount
    FROM member
    WHERE tel=vtel;
    
    IF (vcount=0) THEN
        vresult:='ID가 존재하지 않습니다.';
    ELSE
        SELECT RPAD(SUBSTR(id,1,2),LENGTH(id),'*') INTO vid
        FROM member
        WHERE tel=vtel;
        vresult:='ID는 '||vid||'입니다';
    END IF;
    DBMS_OUTPUT.PUT_LINE('****** 결과 ******');
    DBMS_OUTPUT.PUT_LINE(vresult);
END;
/
-- =================================================================================================
-- ex) id받아서 이름이랑 전화번호 출력해주는 procedure 만들기
DROP PROCEDURE DataFind;
CREATE PROCEDURE DataFind(pid IN member.id%TYPE,pname OUT member.name%TYPE,ptel OUT member.tel%TYPE)
IS
BEGIN
    SELECT name,tel INTO pname,ptel
    FROM member 
    WHERE id=pid;
END;
/

-- VARIABLE pname VARCHAR2(25); <=== 요 구문은 Epname 변수에 값을 채워달라는 뜻
-- 아래의 4문장 한번에 블록처리 후 실행시키면 출력됨 
VARIABLE pname VARCHAR2(25); 
VARIABLE ptel VARCHAR2(25);
EXECUTE DataFind('hong',:pname,:ptel);
PRINT pname ptel;


-- =================================================================================================
-- [반복문 LOOP]
DECLARE
    
BEGIN
    
END;
/










