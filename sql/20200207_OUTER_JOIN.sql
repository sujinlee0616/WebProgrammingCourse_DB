-- 2020-02-07 OUTER JOIN
/*
<OUTER JOIN>
 A : a,b,c
 B : d,e,a
 OUTER JOIN => INNER JOIN (NULL일 경우에 처리 불가능) + 보완 (NULL일 경우에도 값을 가지고 온다) 
 1. LEFT OUTER JOIN
 => 오라클 JOIN
    SELECT a,b,d,e
           ======= A,B
    FROM A,B
    WHER=B.a (+)
    ==> 뒤에 (+)가 붙으면 OUTER JOIN, (+) 없으면 INNER JOIN
 => ANSI JOIN (전체 데이터베이스의 표준화)
    SELECT a,b,d,e
    FROM A LEFT OUTER JOIN B
    ON A.a = B.a
 2. RIGHT OUTER JOIN
  - 왼쪽 편에 값이 있는데 오른쪽에 값이 없을 때 
 3. FULL OUTER JOIN 
 => 오라클 조인은 존재하지 않는다.
 => ANSI JOIN만 존재. 
    SELECT a,b,d,e
    FROM A FULL OUTER JOIN B
    ON A.a = B.a
 
 - 어제 inner join까지 했음. 
*/

--SELF JOIN (오라클 조인) (mgr: 사수의 사번)
SELECT e1.ename "본인", e2.ename "사수"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno; --NULL인 애가 빠진다. 

SELECT e1.ename "본인", e2.ename "사수"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno(+); --NULL인 애도 출력함

--LEFT OUTER JOIN (ANSI JOIN) --위와 동일한 결과
SELECT e1.ename "본인", e2.ename "사수"
FROM emp e1 LEFT OUTER JOIN emp e2 
ON e1.mgr=e2.empno;

--RIGHT
SELECT deptno FROM emp; --deptno=10,20,30 만 보임 
SELECT deptno FROM dept; --그런데 사실 40번까지 있다! 

SELECT ename,emp.deptno,dname,loc
FROM emp, dept
WHERE emp.deptno=dept.deptno;

SELECT ename,emp.deptno,dname,loc
FROM emp, dept
WHERE emp.deptno(+)=dept.deptno; --NULL인 애가 나옴 

SELECT ename,emp.deptno,dname,loc
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno; --위와 동일한 결과 

SELECT e1.ename "본인", e2.ename "사수"
FROM emp e1 FULL OUTER JOIN emp e2 
ON e1.mgr=e2.empno; --FULL OUTER JOIN은 사용빈도가 많지 않다. 

----------------------------------------------------------------------------------------------------------------------------

-- <조인 문제>
-- ex1) 사원명, 부서명, 급여의 등급 출력 (테이블: emp, dept, salgrade) 
SELECT ename, dname,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;

-- ex2) 급여가 1000이상인 사원 중에 부서별, 직업별 평균 급여를 구하고, 평균급여가 2000이상인 부서의 부서명, 부서번호, 직업, 평균 급여를 출력하라. 
SELECT deptno,job,AVG(sal)
FROM emp
WHERE sal>=1000
GROUP BY deptno,job
HAVING AVG(sal)>=2000;

-- ex3) 30번 부서의 이름, 직위, 근무지를 출력
SELECT ename,job,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND emp.deptno=30;

-- ex4) 성과급을 받는 사원의 이름, 성과급, 급여, 성과급+급여, 부서명, 근무지 출력 
SELECT ename, comm, comm+sal, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND comm IS NOT NULL AND comm<>0;
-- 문제를 많이 풀어봐야한다!!

-- ★ex5) BLAKE보다 늦게 입사한 사원의 이름, 입사일을 출력 (SELF JOIN) 
-- JOIN으로 풀기 
SELECT e1.ename, e1.hiredate
FROM emp e1, emp e2
WHERE e2.ename='BLAKE' AND e1.hiredate > e2.hiredate;

SELECT hiredate
FROM emp
WHERE ename='BLAKE'; --BLAKE의 입사일은 91/01/05

-- 서브쿼리로 풀기 
SELECT ename,hiredate
FROM emp
WHERE hiredate>(SELECT hiredate FROM emp WHERE ename='BLAKE');





