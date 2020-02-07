-- 2020-02-06 JOIN
/*
        Join : �Ѱ��̻��� ���̺��� �ʿ��� �����͸� �о���� ���
               => ���� ���� ������ �ִ� �÷�
               => ���� ���ԵǾ� �ִ� �÷�
        *** �÷����� ���� => �ݵ�� �տ� ���̺��,��Ī���� ����Ѵ� (=> ��� ���ϸ� ���� �߻�)
        
        A(a,b,c) , B(d,e,f,c)
            A.c : �ߺ��� ���� �־ ������� (��, B.c�� �ִ� ���� ������ �־�� �Ѵ�) => Foregin Key
            B.c : �ߺ��� ���� ��                                                 => Primary Key
            
            A => a,b,c
            B => d,e
            
            ������ ���� �Ǵ� �����ʹ� ���� ���� => 1����ȭ
            �ߺ��� ���� ������ ���� ���� => 2����ȭ
        
        1. ���� ����
            = INNER JOIN (NULL�� �������� �ʴ´�) : ���� ���� ���
                = EQUI_JOIN
                    => Oracle JOIN
                        - ���̺������ ����
                        SELECT a,b,A.c,d,e 
                        FROM A,B
                        WHERE A.c=B.c
                        
                        - ��Ī������ ���� (���̺���� �� ���)
                        SELECT a,b,aa.c,d,e 
                        FROM A aa,B bb
                        WHERE aa.c=bb.c
                        
                    => Ansi JOIN (JOIN ~ ON)
                        SELECT a,b,A.c,d,e
                        FROM A (INNER) JOIN B
                        ON A.c=B.c
                    ============================
                    => �ڿ� ���� => NATURAL JOIN => �ߺ��� �÷��� ���̺���̳� ��Ī�� ����� �� ����
                        SELECT a,b,c,d,e
                        FROM A NATURAL JOIN B
                    => JOIN ~ USING => �ߺ��� �÷��� ���̺���̳� ��Ī�� ����� �� ����
                        SELECT a,b,c,d,e
                        FROM A JOIN B USING(c)
                                           === A,B�� ���� �÷����� ����
                    ============================ �ݵ�� ������ �÷����� ����
                = NON_EQUI_JOIN => =�� �ƴ� �ٸ� �����ڸ� ����ϴ� ���
                                    BETWEEN ~ AND, >= AND <=
            = OUTER JOIN (NULL�� �����ؼ� �����͸� ������ �´�)
                = LEFT OUTER JOIN
                = RIGHT OUTER JOIN
                = FULL OUTER JOIN
            = SELF JOIN : ���� ���̺� 2���� �̿��ؼ� ó��
*/

SELECT * FROM emp;
SELECT * FROM dept;

SELECT ename,job,emp.deptno,dname,loc
FROM emp,dept;

SELECT ename,job,e.deptno,dname,loc
FROM emp e,dept d;



-- ����� �̸�,����,�Ի���(emp) , �μ���,�ٹ���(dept)
-- ����Ŭ ����
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

-- NATURAL JOIN (���̺� ���� �÷����� ������ �ִ� ��쿡�� ��� ����)
SELECT ename,job,deptno,hiredate,dname,loc
FROM emp NATURAL JOIN dept;

-- JOIN USING (���̺� ���� �÷����� ������ �ִ� ��쿡�� ��� ����)
SELECT ename,job,deptno,hiredate,dname,loc
FROM emp JOIN dept USING(deptno);

-- ���� ���̺��� ������ �б�
SELECT * FROM emp;
SELECT e1.ename "����",e1.job,e2.ename "���"
FROM emp e1,emp e2
WHERE e1.mgr=e2.empno;

-- NON_EQUI_JOIN
SELECT * FROM salgrade;
SELECT ename,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal;

-- ����� �̸�,����,�Ի���,�޿�,�μ���,�ٹ���,���
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

-- �̸��߿� A�� �����ϰ� �ִ� ����� �̸�,�޿�,����,�μ���,�ٹ��� ���
SELECT ename,sal,job,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno 
AND ename LIKE '%A%';

SELECT ename,sal,job,dname,loc
FROM emp JOIN dept
ON emp.deptno=dept.deptno 
AND ename LIKE '%A%';


-- 81�⿡ �Ի��� ����� �̸�,����,�Ի���,�޿�,�޿��ǵ�� ���
SELECT ename,job,hiredate,sal,grade
FROM emp,salgrade
WHERE sal BETWEEN losal AND hisal
AND TO_CHAR(hiredate,'YY')=81;

SELECT ename,job,hiredate,sal,grade
FROM emp JOIN salgrade
ON sal BETWEEN losal AND hisal
AND TO_CHAR(hiredate,'YY')=81;

-- 10�� �μ��� �ٹ��ϴ� ����� �̸�,�μ��� ���
SELECT ename,dname
FROM emp,dept
WHERE emp.deptno=dept.deptno 
AND emp.deptno=10;