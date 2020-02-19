--2020-02-19(수)
/*
<VIEW>
 - 가상테이블 ==> SQL 문장만 저장되어 있는 상태.
 - 반드시 기존 테이블이 필요 (기존 테이블을 참조해서 사용) 
 - 보안, 사용자 편의를 위해서 만듦. 
   ex) 프로그래머의 복잡한 쿼리문장을 단순화시킨다. 
 - 종류: 1~3: 데이터 갖고있지(X) / 4: 데이터 갖고 있음(O)
 1) 단순뷰: 테이블을 한 개만 참조 
 2) 복합뷰: 테이블을 여러개 참조 
 3) 인라인뷰: SQL 문장의 FROM 절에 View의 서브쿼리 부분을 바로 적어서 사용
 4) MView: 얘만 실제 데이터를 갖고 있다 ==> '실체 뷰', '구체화된 뷰'라고도 부름.

1. VIEW 생성
    CREATE VIEW view명
    AS 
    SELECT ~~ 
    예시) CREATE View emp_view
         AS
         SELECT empno,ename,job,hiredate FROM emp
         -- emp_view를 부르면 SELECT ~~~ emp 문장이 실행된다. 

2. VIEW 수정
    CREATE OR REPLACE VIEW view명
    AS
    SELECT ~~ 
    - ALTER를 쓸 수 X
    - 기존에 없던 VIEW면 CREATE 하고, 
      기존에 있던 VIEW를 수정하는거면 REPLACE 하면 된다. (기존 VIEW 삭제할 필요X) 

3. VIEW 삭제 
    DROP VIEW view명

4. VIEW 옵션
 1) WITH CHECK OPTION 
    : 디폴트값. DML이 가능. (DML: Manipulation: INSERT, UPDATE, DELETE)
      VIEW가 참조하는 원본 테이블 값이 변경될 위험이 있다. 
 2) WITH READ ONLY 
    : 읽기 전용. (DML 불가) ==> 검색 전용. 
      VIEW가 참조하는 원본 테이블 값이 변경되지 않으므로 안전하다. 권장하는 방법. 
*/

--================== <단순뷰> ==================
--복사. 이런걸 CATS(??)라고 함.
CREATE TABLE youDept 
AS SELECT * FROM dept;

SELECT * FROM youDept;

--단순VIEW 생성
CREATE OR REPLACE VIEW dept_view
AS
SELECT * FROM youDept;

SELECT * FROM dept_view;

--VIEW에 데이터 추가 
INSERT INTO dept_view VALUES (50,'영업부','서울');
COMMIT;

--VIEW가 참조하고 있던 테이블에도 데이터가 추가된 것을 볼 수 있다. 
--==> 참조하고 있던 원본테이블의 데이터가 변경될 수 있어서 위험함..
SELECT * FROM youDept;
SELECT * FROM dept_view;

--================== <VIEW 수정> ==================
--VIEW 수정: read-only로 변경
CREATE OR REPLACE VIEW dept_view
AS
SELECT * FROM youDept WITH READ ONLY;

--VIEW에 데이터 추가 
INSERT INTO dept_view VALUES (50,'기획부','제주'); --Error. 추가 불가. 

-- VIEW와 TABLE 모두 데이터가 변경되지 않았음을 확인할 수 있다.
SELECT * FROM youDept; 
SELECT * FROM dept_view;

--================== <복합뷰> ==================
--복합뷰 생성 
CREATE OR REPLACE VIEW emp_dept
AS
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno WITH READ ONLY;

SELECT * FROM emp_dept;


--================== <Inline View> ==================
SELECT ename,job,hiredate,dname,loc
FROM (SELECT ename,job,hiredate,dname,loc FROM emp,dept WHERE emp.deptno=dept.deptno);


--================== <테이블 삭제> ==================
DROP VIEW dept_view;
DROP VIEW emp_dept;





