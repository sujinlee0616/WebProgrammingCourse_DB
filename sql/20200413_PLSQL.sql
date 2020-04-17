-- 2020.04.13 PL/SQL
/*
    PL => 오라클 안에서 함수를 만들 때 사용하는 언어 (비절차적 언어) 
          ========== 캐시 메모리에 저장. => 속도가 빠르다.
          1) 함수 vs 메소드? 차이점? 
           - 차이점은 "클래스 종속 여부". 클래스 안에 있으면 메소드, 클래스 밖에 있으면 함수라고 함. 
             ==> 자바는 클래스 안에 만들어지니까 메소드라고 하고, C는 클래스 밖에 만드니까 함수라고 함. 
          2) 함수 vs 프로시저? 차이점?
           - 차이점은 "리턴형 존재여부".
           - 함수(Function), 프로시저(Procedure) => Call By Reference 
             1. 함수 
              - ex) SUBSTR, MAX, ... : SELECT 뒤에서 사용. 
              - 용도) 결과값만 받을 목적. 
             2. 프로시저
              - ex) 
              - 용도) 실행한 결과를 받을 목적.
              - 장점) 
                (1) 보안이 뛰어나다. 
                (2) 트랜잭션 사용 가능. 
                (3) 반복을 제어. 
                
        트리거란 무엇인가... 
*/

/*
    [PL 문법]
    
    1. 코딩방식
     - 괄호 없음
     - 형식) 
        DECLARE
            변수선언
        BEGIN
            처리 기능(SQL)
        EXCEPTION
            예외처리
        END; 
        
    2. 변수 선언
     - 1)~4)는 단수, 5)는 복수 
     1) 스칼라 변수: 일반변수.
        ex) id VARCHAR2(10)
     2) TYPE 변수 
        - 테이블의 실제 데이터형을 가지고 올 때.
        ex) empno emp.empno%TYPE
        ex) ename emp.ename%TYPE: emp 테이블의 ename 컬럼의 실제 데이터형을 가지고 와라. 
     3) ROW 변수
        - 컬럼에 들어가있는 데이터형을 모두 가져옴. VO처럼. 
        ex) emp emp%ROWTYPE :emp 테이블에 있는 8개 컬럼의 데이터형을 모두 가지고 와라. 
     4) RECORD 변수 
        - 사용자 정의 변수. JOIN이거나 SUBQUERY 쓸 때 사용. 
        - 예를 들어, 두 개 테이블 JOIN 걸었으면, 두 개의 VO 가져와야 
     5) CURSOR 변수 
        - 복수. ResultSet 처럼. 
     
    3. 제어문
     1) IF문
      - 형식) 단일 IF문 
        IF (조건문)
            처리
        END IF;
      - 형식) IF ELSE문
        IF (조건문)
            처리
        ELSIF (조건문)
            처리
        ELSIF (조건문)
            처리
        END IF;
      - END IF로 끝남을 잊지 마라! 괄호가 없기 때문에 END IF로 끝나는 지점을 명시해줌.
     2) 반복문: FOR, WHILE,LOOP
      - FOR i IN 1..9 ('..'은 어디서부터 어디까지를 의미함. '1..9' ==> 1에서 9까지) 

    4. SQL 

*/
SET SERVEROUTPUT ON
DECLARE
    vempno NUMBER(4);
    vename VARCHAR2(20);
    vjob VARCHAR2(20);
BEGIN
    SELECT empno,ename,job INTO vempno,vename,vjob --변수에 값을 받는다 
    FROM emp 
    WHERE empno=7788;
    DBMS_OUTPUT.put_line('사번:'||vempno); --오라클의 sysout과 동일한 용도. '||'는 JAVA에서의 문자열결합 '+'와 같다.
    DBMS_OUTPUT.put_line('이름:'||vename);
    DBMS_OUTPUT.put_line('직위:'||vjob);
END;
/








