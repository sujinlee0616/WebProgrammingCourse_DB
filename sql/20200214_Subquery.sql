--2020-02-14 SubQuery
/*
    JOIN: 테이블에서 필요한 데이터를 연결해서 가지고 온다. 
    SubQuery: SQL 문장을 여러개 묶어서 한 개의 SQL 문장으로 만들어준다.
    
    형식) 
        Main Query
        WHERE 조건 (subquery) 
        
         subquery를 먼저 실행 => 결과값을 얻어서 Main Query를 실행한다. 
        1) 단일행 서브쿼리: 서브쿼리의 결과값이 1개일 경우. 
        2) 다중행 서브쿼리: 서브쿼리의 결과값이 여러개일 경우. 
        3) 스칼라 서브쿼리: 컬럼 대신 사용.
        4) 인라인 뷰: table 대신 SELECT 문장 사용 => 페이징 기법에서 많이 사용. (Top-N)
        
        컬럼 대신
        테이블 대신 
*/
--사원 중에 KING과 같은 부서에 근무하는 사원의 이름,부서번호,급여,입사일을 달라. 
--1) KING이 어떤 부서 ==> 부서번호 읽어와야 ===> 서브쿼리. 
--2) 같은 부서에 근무하는 사원의 이름,부서번호,급여,입사일 ===> 메인쿼리. 
SELECT deptno FROM emp
WHERE ename='KING'; 

SELECT ename,deptno,sal,hiredate
FROM emp 
WHERE deptno=10;

SELECT ename,deptno,sal,hiredate
FROM emp 
WHERE deptno=(SELECT deptno FROM emp
WHERE ename='KING'); 

-- ==================================
SELECT comm FROM emp
WHERE ename='WARD';

SELECT ename,comm FROM emp
WHERE comm<500;

SELECT ename,comm FROM emp
WHERE comm<(SELECT comm FROM emp
WHERE ename='WARD');

--다중컬럼 서브쿼리


--스칼라 서브쿼리
SELECT ename,(SELECT dname FROM dept d WHERE e.deptno=d.deptno) 
FROM emp e;
--emp 테이블이 e고, dept 테이블이 d. 

--인라인 뷰: 페이징 기법에서 많이 사용함. 
SELECT ename,job
FROM (SELECT ename,job FROM emp WHERE job='MANAGER');











