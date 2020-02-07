-- 2020-02-07 OUTER JOIN
/*
<OUTER JOIN>
 A : a,b,c
 B : d,e,a
 OUTER JOIN => INNER JOIN (NULL�� ��쿡 ó�� �Ұ���) + ���� (NULL�� ��쿡�� ���� ������ �´�) 
 1. LEFT OUTER JOIN
 => ����Ŭ JOIN
    SELECT a,b,d,e
           ======= A,B
    FROM A,B
    WHER=B.a (+)
    ==> �ڿ� (+)�� ������ OUTER JOIN, (+) ������ INNER JOIN
 => ANSI JOIN (��ü �����ͺ��̽��� ǥ��ȭ)
    SELECT a,b,d,e
    FROM A LEFT OUTER JOIN B
    ON A.a = B.a
 2. RIGHT OUTER JOIN
  - ���� �� ���� �ִµ� �����ʿ� ���� ���� �� 
 3. FULL OUTER JOIN 
 => ����Ŭ ������ �������� �ʴ´�.
 => ANSI JOIN�� ����. 
    SELECT a,b,d,e
    FROM A FULL OUTER JOIN B
    ON A.a = B.a
 
 - ���� inner join���� ����. 
*/

--SELF JOIN (����Ŭ ����) (mgr: ����� ���)
SELECT e1.ename "����", e2.ename "���"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno; --NULL�� �ְ� ������. 

SELECT e1.ename "����", e2.ename "���"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno(+); --NULL�� �ֵ� �����

--LEFT OUTER JOIN (ANSI JOIN) --���� ������ ���
SELECT e1.ename "����", e2.ename "���"
FROM emp e1 LEFT OUTER JOIN emp e2 
ON e1.mgr=e2.empno;

--RIGHT
SELECT deptno FROM emp; --deptno=10,20,30 �� ���� 
SELECT deptno FROM dept; --�׷��� ��� 40������ �ִ�! 

SELECT ename,emp.deptno,dname,loc
FROM emp, dept
WHERE emp.deptno=dept.deptno;

SELECT ename,emp.deptno,dname,loc
FROM emp, dept
WHERE emp.deptno(+)=dept.deptno; --NULL�� �ְ� ���� 

SELECT ename,emp.deptno,dname,loc
FROM emp RIGHT OUTER JOIN dept
ON emp.deptno=dept.deptno; --���� ������ ��� 

SELECT e1.ename "����", e2.ename "���"
FROM emp e1 FULL OUTER JOIN emp e2 
ON e1.mgr=e2.empno; --FULL OUTER JOIN�� ���󵵰� ���� �ʴ�. 

----------------------------------------------------------------------------------------------------------------------------

-- <���� ����>
-- ex1) �����, �μ���, �޿��� ��� ��� (���̺�: emp, dept, salgrade) 
SELECT ename, dname,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal;

-- ex2) �޿��� 1000�̻��� ��� �߿� �μ���, ������ ��� �޿��� ���ϰ�, ��ձ޿��� 2000�̻��� �μ��� �μ���, �μ���ȣ, ����, ��� �޿��� ����϶�. 
SELECT deptno,job,AVG(sal)
FROM emp
WHERE sal>=1000
GROUP BY deptno,job
HAVING AVG(sal)>=2000;

-- ex3) 30�� �μ��� �̸�, ����, �ٹ����� ���
SELECT ename,job,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno
AND emp.deptno=30;

-- ex4) �������� �޴� ����� �̸�, ������, �޿�, ������+�޿�, �μ���, �ٹ��� ��� 
SELECT ename, comm, comm+sal, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND comm IS NOT NULL AND comm<>0;
-- ������ ���� Ǯ������Ѵ�!!

-- ��ex5) BLAKE���� �ʰ� �Ի��� ����� �̸�, �Ի����� ��� (SELF JOIN) 
-- JOIN���� Ǯ�� 
SELECT e1.ename, e1.hiredate
FROM emp e1, emp e2
WHERE e2.ename='BLAKE' AND e1.hiredate > e2.hiredate;

SELECT hiredate
FROM emp
WHERE ename='BLAKE'; --BLAKE�� �Ի����� 91/01/05

-- ���������� Ǯ�� 
SELECT ename,hiredate
FROM emp
WHERE hiredate>(SELECT hiredate FROM emp WHERE ename='BLAKE');





