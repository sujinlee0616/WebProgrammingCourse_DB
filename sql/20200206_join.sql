-- 2020-02-06 JOIN
/*
        Join : 한개이상의 테이블에서 필요한 데이터를 읽어오는 기법
               => 같은 값을 가지고 있는 컬럼
               => 값이 포함되어 있는 컬럼
        *** 컬럼명이 동일 => 반드시 앞에 테이블명,별칭명을 사용한다 (=> 사용 안하면 에러 발생)
        
        A(a,b,c) , B(d,e,f,c)
            A.c : 중복된 값이 있어도 상관없다 (단, B.c에 있는 값만 가지고 있어야 한다) => Foregin Key
            B.c : 중복이 없는 값                                                 => Primary Key
            
            A => a,b,c
            B => d,e
            
            수정이 많이 되는 데이터는 따로 뺀다 => 1정규화
            중복이 많은 데이터 따로 뺀다 => 2정규화
        
        1. 조인 종류
            = INNER JOIN (NULL을 포함하지 않는다) : 가장 많이 사용
                = EQUI_JOIN
                    => Oracle JOIN
                        - 테이블명으로 접근
                        SELECT a,b,A.c,d,e 
                        FROM A,B
                        WHERE A.c=B.c
                        
                        - 별칭명으로 접근 (테이블명이 길 경우)
                        SELECT a,b,aa.c,d,e 
                        FROM A aa,B bb
                        WHERE aa.c=bb.c
                        
                    => Ansi JOIN (JOIN ~ ON)
                        SELECT a,b,A.c,d,e
                        FROM A (INNER) JOIN B
                        ON A.c=B.c
                    ============================
                    => 자연 조인 => NATURAL JOIN => 중복된 컬럼도 테이블명이나 별칭을 사용할 수 없다
                        SELECT a,b,c,d,e
                        FROM A NATURAL JOIN B
                    => JOIN ~ USING => 중복된 컬럼도 테이블명이나 별칭을 사용할 수 없다
                        SELECT a,b,c,d,e
                        FROM A JOIN B USING(c)
                                           === A,B가 같은 컬럼명을 제시
                    ============================ 반드시 동일한 컬럼명이 존재
                = NON_EQUI_JOIN => =이 아닌 다른 연산자를 사용하는 경우
                                    BETWEEN ~ AND, >= AND <=
            = OUTER JOIN (NULL을 포함해서 데이터를 가지고 온다)
                = LEFT OUTER JOIN
                = RIGHT OUTER JOIN
                = FULL OUTER JOIN
            = SELF JOIN : 같은 테이블 2개를 이용해서 처리
*/

SELECT * FROM emp;
SELECT * FROM dept;

SELECT ename,job,emp.deptno,dname,loc
FROM emp,dept;

SELECT ename,job,e.deptno,dname,loc
FROM emp e,dept d;



-- 사원의 이름,직위,입사일(emp) , 부서명,근무지(dept)
-- 오라클 조인
SELECT ename,job,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

SELECT ename,job,emp.deptno,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

-- ANSI JOIN
SELECT ename,job,emp.deptno,hiredate,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno;

-- NATURAL JOIN (테이블에 같은 컬럼명을 가지고 있는 경우에만 사용 가능)
SELECT ename,job,deptno,hiredate,dname,loc
FROM emp NATURAL JOIN dept;

-- JOIN USING (테이블에 같은 컬럼명을 가지고 있는 경우에만 사용 가능)
SELECT ename,job,deptno,hiredate,dname,loc
FROM emp JOIN dept USING(deptno);

-- 같은 테이블에서 데이터 읽기
SELECT * FROM emp;
SELECT e1.ename "본인",e1.job,e2.ename "사수"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno;

-- NON_EQUI_JOIN
SELECT * FROM salgrade;
SELECT ename,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal;

-- 사원의 이름,직위,입사일,급여,부서명,근무지,등급
-- Oracle JOIN
SELECT ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;
-- ANSI JOIN
SELECT *
FROM emp JOIN dept 
ON emp.deptno=dept.deptno
JOIN salgrade ON sal BETWEEN losal AND hisal;

-- 이름중에 A를 포함하고 있는 사원의 이름,급여,직위,부서명,근무지 출력
SELECT ename,sal,job,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno 
AND ename LIKE '%A%';

SELECT ename,sal,job,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno 
AND ename LIKE '%A%';


-- 81년에 입사한 사원의 이름,직위,입사일,급여,급여의등급 출력
SELECT ename,job,hiredate,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal
AND TO_CHAR(hiredate,'YY')=81;

SELECT ename,job,hiredate,sal,grade
FROM emp JOIN salgrade
ON sal BETWEEN losal AND hisal
AND TO_CHAR(hiredate,'YY')=81;

-- 10번 부서에 근무하는 사원의 이름,부서명 출력
SELECT ename,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno 
AND emp.deptno=10;