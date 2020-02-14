--2020-02-14 SubQuery
/*
    JOIN: ���̺��� �ʿ��� �����͸� �����ؼ� ������ �´�. 
    SubQuery: SQL ������ ������ ��� �� ���� SQL �������� ������ش�.
    
    ����) 
        Main Query
        WHERE ���� (subquery) 
        
         subquery�� ���� ���� => ������� �� Main Query�� �����Ѵ�. 
        1) ������ ��������: ���������� ������� 1���� ���. 
        2) ������ ��������: ���������� ������� �������� ���. 
        3) ��Į�� ��������: �÷� ��� ���.
        4) �ζ��� ��: table ��� SELECT ���� ��� => ����¡ ������� ���� ���. (Top-N)
*/
--��� �߿� KING�� ���� �μ��� �ٹ��ϴ� ����� �̸�,�μ���ȣ,�޿�,�Ի����� �޶�. 
--1) KING�� � �μ� ==> �μ���ȣ �о�;� ===> ��������. 
--2) ���� �μ��� �ٹ��ϴ� ����� �̸�,�μ���ȣ,�޿�,�Ի��� ===> ��������. 
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

--�����÷� ��������


--��Į�� ��������
SELECT ename,(SELECT dname FROM dept d WHERE e.deptno=d.deptno) 
FROM emp e;
--emp ���̺��� e��, dept ���̺��� d. 

--�ζ��� ��: ����¡ ������� ���� �����. 
SELECT ename,job
FROM (SELECT ename,job FROM emp WHERE job='MANAGER');











