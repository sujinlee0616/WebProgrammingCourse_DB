-- : 2020-01-28 SELECT ���� 
/*
-- : �� �� �ּ�

<SQL>
: ����ȭ�� ���� ��� ==> ����Ŭ ���Ǵ� ��� 
����Ŭ(������ �����ͺ��̽� �ý���) 
==============================
    ���̺�� ����
    ���̺� : 2���� ���� (Row + Column) 
    =================================
    id      password   name     addr   ==> column (attribute) �Ӽ���, Į���� 
    =================================
    aaa     1234       ȫ�浿    ����
    =================================
    bbb     1234       ��û��    ���
    =================================
1. SQL �� ����
1) DDL (������ ���Ǿ��) ===> ���� : Coulmn ���� (������. ��.)
 - CREATE : ���� => ���̺�, ��, ������, �Լ�, ���ν���, �ε���, Ʈ����  
 - ALTER : ���� (MODIFY), ����(DROP), �߰� (ADD) 
 - DROP : ���̺� ���� ��ü�� ���� 
 - TRUNCATE : ���̺��� ������ ����. �����͸� ����. 
 - RENAME : ���̺��̳� Į���� ����. 
2) DML (������ ���۾��) ===> ���� : Row ���� (������. ��.) 
 - DML�� COMMIT/ROLLBACk ����. ������ �ֵ��� �Ұ���. 
 - SELECT : ������ �˻� 
 - INSERT : ������ �߰�
 - UPDATE : ������ ����
 - DELETE : ������ ����
3) DCL (������ ������) 
 - GRANT : ���� �ο� 
 - REVOKE : ���� ���� 
 �� ����
  - system, sysdba : ���� �ο�/���� ���� ��
  - user : ���� �ο�/���� ���� ��
  - �츮�� ���� hr ������ user ����. 
4) TCL (Ʈ����� ���) ==> �ϰ�ó��. INSERT, UPDATE, DELETE������ ���. 
 - COMMIT : ���������� ���� 
 - ROLLBACK : ��� 
 �� �� �� Ŀ���ϸ� �ѹ� �Ұ�. 
 �� �������� ��� ==> 1�� �������� ������ �� �Ʒ��� 2,3�� ����� 
    INSERT �԰� ---1 
    ��� UPDATE ---2 
    ��� INSERT ---3 
    
========================================================================================================

<SELECT ����>
1. ����, ����
 ================================================
 �ʼ�) 
 SELECT * | column��, column�� ...
     - * : ��ü �����͸� �о�� ��
     - column�� : ���ϴ� �����͸� ����ϰ��� �� ��. 
 FROM table��, view��, select���� 
 ================================================
 �ɼ�)
 WHERE ���ǹ� (if)
 GROUP BY �׷�column��
 HAVING �׷쿡 ���� ���� 
    �� GROUP BY�� ���̴� HAVING �� �� �� X
 ORDER BY column�� ==> ���� (DESC, ASC) ==> �������̸� ���X (�ӵ� ������) ==> INDEX ���°� ����.
 ================================================
 
2. ������
3. �����Լ�
4. JOIN, SUBQUERRY

* ���̺� ���� Ȯ��
  : DESC table��; (desc : describe.) 
* ���� ��������ִ� ���̺� Ȯ�� 
  : SELECT * FROM tab; (tab : table) 
* Oracle�� ��ҹ��� �������� �ʴ´�. (��, ����� �����ʹ� ��ҹ��ڸ� �����Ѵ�.) 
  ex) SELECT * FROM emp WHERE ename='scott';  -- ��� �� (���̺� 'SCOTT'���� ����Ǿ� �ֱ� ����) 
      SELECT * FROM emp WHERE ename='SCOTT';  -- ��� �� 
* Ű����� �빮�ڷ� �ۼ��Ѵ�. (ex. SELECT, UPDATE, INSERT, ...) 

*/

-- ���̺��� ���� Ȯ��
/*
<��������>
1. ������ : CHAR, VARCHAR2, CLOB ==> String 
           ���ڸ� ���� ==> '' ����ؾ�. (""�� �ο��ȣ or ��Ī�� �� ���.)
   1) CHAR : 1~2000 Byte (�ѱ��� 2Byte ==> 1000�ڱ��� ���� ����)
   2) VARCHAR : 1~4000 Byte (�ѱ� 2000�ڱ��� ���� ����)
   3) CLOB : 4G ���� ���� ==> ���ڰ� ������ CLOB����('���κ�'��� ����) ����.
   �� VARCHAR�� ������. CHAR�� ������X ==> VARCHAR�� ���°� ����뷮�� �� ������ �� �ִ�. 
      ex) �̸� ���ڱ��� max�� 17���� (34byte) ==> CHAR�� �� 34byte�� �����ؾ�... VARCHAR�� �������̹Ƿ� �ٸ� ª�� �̸��鿡�� �̸����ڱ����� ����. 
2. ������ : NUMBER(10) : int , NUMBER(10,2): double 
3. ��¥�� : Date ==> java.util.Date
4. ��Ÿ�� : BLOB, BFILE ==> InputStream 

* ��¥, ���� : '' ���δ�. 
 - ��¥���� : YY/MM/DD
 - ��¥�� ������ ���ڿ��� �ȴ�. 
* ���ڴ� ''�� ������� �ʴ´�. 

ex) DESC emp;
�̸�       ��?       ����           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    
====> Not Null�� EMPNO�� PK��. (��?? Not Null�̶�� ������ PK��� ���� �� ���� �ʳ�?) 

*/

-- ��� ������ ��� 
SELECT  * FROM emp;
/*
emp (�������)
empno : ��� 
ename : �̸� 
job : ���� 
mgr : �����ȣ(����� ���) 
hiredate : �Ի���
sal : �޿� 
comm : ������
deptno : �μ���ȣ 
*/
SELECT * FROM dept;
SELECT * From emp;

-- ���ϴ� �����͸� ���
-- ex1) �̸�, ����, �޿� 
SELECT ename,job,sal FROM emp;
-- ex2) ���, �޿�, �Ի��� ��� 
SELECT empno, sal, hiredate FROM emp;
-- ex3) �ߺ� ���� �������� : DISTINCT
SELECT deptno FROM emp; -- �ߺ� ��
SELECT DISTINCT deptno FROM emp; -- �ߺ� ��
-- ex4) ���ڿ� ���� : ||
SELECT ename||'���� �޿��� '||sal||'�Դϴ�' FROM emp;
-- �� SQL���� ||�� ���ڿ� ����, && �� Scanner��. 
-- �� SQL������ OR, AND �� ���. 
-- ex5) ��Ī �ֱ� - "" �Ǵ� as ���. 
SELECT empno "���", ename "�̸�", sal "�޿�" FROM emp;
SELECT empno as ���, ename as �̸�, sal as �޿� FROM emp;
SELECT ename||'���� �޿��� '||sal||'�Դϴ�' as ���� FROM emp;


SELECT empno, ename, sal FROM emp;
-- ���� �������� - (�޿��� ���� ������ : �� �� �� : ��������)
SELECT empno, ename, sal FROM emp ORDER BY sal DESC;
-- ���� �������� - (�޿��� ���� ������ : �� �� �� : ��������) ==> ASC �������� (����Ʈ�� ASC)
SELECT empno, ename, sal FROM emp ORDER BY sal ASC; 
-- ���� : column �ѹ� ��� - ����Ŭ������ ���ڸ� 0�� �ƴ϶� 1���� ���� ==> column number 3 = SAL��. 
SELECT empno, ename, sal FROM emp ORDER BY 3 DESC; 
-- ���� : column �ѹ� ��� 
SELECT * FROM emp ORDER BY 2 ASC;  --ABC..������. 
-- ���� : ���� sort - col#3 ������������. col#3���� ������ ��쿡�� col#2 ������������. (ASC�� �����Ǿ���) ==> F��  S���� ���� ����. 
SELECT empno,ename,sal FROM emp
ORDER BY 3 DESC,2; 
-- ���� : ���� sort -
SELECT empno,ename,sal FROM emp -- �� �� ASC��. 
ORDER BY 3,2; 
-- �� SELECT�� for���� �����. ã�� ������ŭ loop ������ �������� ����. 

-- ����Ŭ�� ��ȣ�� 1������ �����Ѵ�! (0������ ����X)

SELECT * FROM emp;
/*
<WHERE> 
: ���ǿ� �´� �����͸� ���

[������] 
�� null�� ������ �Ұ�. null�� �����ϸ� �������� ������ null�� �ȴ�. 
ex) 800+null = null

1. ��������� (+, -, *, /) 
 - 0���� ���� �� ����. 
 - ����/����=�Ǽ���  ex) 5/2=2.5  <=========> Java : ����/����=����. ex) 5/2=2 
 - �� mod �Լ� : JAVA�� %�� ���� ����. 
2. �񱳿����� ( = ����, != ���� �ʴ�, <> ���� �ʴ�, <, >, <=, >=, ....) 
 ex) empno=7788 (����x. ���ٴ� ��.) 
 ex) -- ����� 7400 �̻��̰� 7600 ������ ����� ��� ����  
    SELECT * FROM emp WHERE empno >=7400 AND empno <=7600;
    SELECT * FROM emp WHERE empno BETWEEN 7400 AND 7600;  -- between�� �� �� ���� '����'��!!
3. �������� (AND, OR)
 - AND : �׳� AND ��� ��.
 - OR : �׳� OR�̶�� ��. 
 - ����Ŭ���� &&�� AND�� �ƴ϶� ��ĳ�ʰ�, 
   ||�� OR�� �ƴ϶� ���ڿ� ������. 
===> ũ�Ѹ��� �� �ּ� �ȿ� & ������ ��ĳ�� �������... 
==> �̷��� ũ�Ѹ� �� �� &�� ^�� �ٲ�ٰ� �ٽ� �� &�� �ٲ������...
ex) http://img1.daumcdn.net/thumb/C236x340/?fname=
4. NULL ������
 - �ݵ�� IS NULL �Ǵ� IS NOT NULL ����ؾ�. 
 ex) comm=null (X)
5. BETWEEN ~ AND : ����, �Ⱓ 
ex) SELECT * FROM emp WHERE empno BETWEEN 7369 AND 7521;
6. LIKE : ���繮�ڿ� �˻�
ex) SELECT * FROM emp WHERE ename LIKE '%S%'; 
7. IN : ���Ե� �����͸� ������ �� �� => OR�� �������� �� ���� ���. 
ex) SELECT * FROM emp
WHERE deptno=10 OR deptno=20 OR deptno=30;
==> SELECT * FROM emp
    WHERE deptno IN(10,20,30);
���Ʒ� ���� ������.
ex) SELECT * FROM emp WHERE sal IN(1500,3000,1600);
8. NOT : ���� 
NOT IN()
ex) SELECT * FROM emp WHERE sal NOT IN(1500,3000,1600);
NOT BETWEEN ~ AND
ex) SELECT * FROM emp WHERE empno NOT BETWEEN 7369 AND 7521;
*/

SELECT 10+20,10-5,10*20,10/3 FROM DUAL;  -- DUAL : ���� ������ ���̺�. ����/����=�Ǽ�.
SELECT 10+20,10-5,10*20,10/0 FROM DUAL;  -- Error. 0���� ���� �� ����. 

-- NULL�� �����ϸ� NULL
SELECT NULL+1 FROM DUAL;
SELECT NULL*100 FROM DUAL;

/*
<WHERE ������ ����>
 - SELECT ~~ FROM table��
   WHERE �÷��� ������ �� 
 - WHERE�� �� ���忡 �� �� �ۿ� �� ����. (JOIN�� ��� ����)
ex) �̸��� SCOTT�� ����� ��� ������ �����Ͷ�
SELECT * FROM emp WHERE ename='SCOTT';
ex) �μ��� 20���� ������ �̸��� �޿��� ���
SELECT ename,sal FROM emp WHERE deptno=20;
ex) �μ��� 30���� �ƴ� ������ ���� ��� �����Ͷ�. 
SELECT * FROM emp WHERE deptno NOT IN(30);
SELECT * FROM emp WHERE deptno!=30;
SELECT * FROM emp WHERE deptno<>30;
*/

/*
<NULL ����>
1. NVL : NUll���� �� �ٸ� ������ �ٲٴ� �Լ�. 
SELECT ename,sal as ���� ,comm as �󿩱�,sal+comm as �ѱ޿� FROM emp; -- comm�� NULL�̸� �ѱ޿��� NULL�� ����. 
SELECT ename,sal as ���� ,comm as �󿩱�,sal+NVL(comm,0) as �ѱ޿� FROM emp; -- �̷��� ��� �ѱ޿� ����� ���´�. 
2. ' ' : ����. '' : �Ұ���. ''�� NULL�� �ν�, ��������.  
3. NULL�� ���� ��Ű�� �ȵȴ� ==> IS NULL, IS NOT NULL ����ؾ�.
ex) �������� �޴� ����� ��� ������ ���
SELECT * FROM emp WHERE comm IS NOT NULL AND comm<>0; -- (O) �̰� ���� ��Ȯ. 
SELECT * FROM emp WHERE comm IS NOT NULL; -- (��). comm=0�� ����� ����. 
SELECT * FROM emp WHERE comm!=Null; -- (X). �̷��� �ϸ� �� ��. 
*/

/*
<LIKE>
 - ���繮�ڿ� ã��
 - % : ���ڿ�. (���� ���� �� �� ����) vs  _ : �� ����. (���ڼ��� �� ��) 
 - ������ LIKE���� ���Խ��� �� ���� ���̱⵵ ��. 
   ex) REGEXP_LIKE(ename,'^A$')
1.A% : A�� �����ϴ� ��� ���ڿ� 
 - ex) �̸��� A�� �����ϴ� ��� ��� 
       SELECT * FROM emp WHERE ename LIKE 'A%';
 - Java�� 'startsWith'�� ���� 
2.%A : A�� ������ ��� ���ڿ� 
 - ex) �̸��� N���� ������ ��� ��� 
       SELECT * FROM emp WHERE ename LIKE '%N';
 - Java�� 'EndsWith'�� ����
3.%A% : A�� �����ϴ� ��� ���ڿ�. (A�� ����, �߰��� A �ְų�, A�� �����ų�) ex) ABCD, BACD, DCBA, AABB
 - ex) �̸��� N�� ���� ��� ��� 
       SELECT * FROM emp WHERE ename LIKE '%N%';
4.__A% : 3��° ���ڰ� A�� ��� ���ڿ� 
5.__O__ : �� 5����. �� �� 3���� ���ڰ� O�� ���ڿ�. 
 - ex) S�� �����ϴ�, �̸��� �� 5������ ����� ���� 
       SELECT * FROM emp WHERE ename LIKE 'S____';
 - ex) 2��° ���ڰ� A�� ��� ����� ���� 
       SELECT * FROM emp WHERE ename LIKE '_A%';
*/

/* �������� 
ex) 
SELECT * FROM emp
WHERE sal>(SELECT AVG(sal) FROM emp);
ex2) SELECT�� Į�������� ������� 
SELECT ename,(SELECT deptno FROM emp WHERE ename='KING') FROM emp;
ex3) ex2�� Į������ as(alias) �Ἥ ª�� �ٿ����� 
SELECT ename,(SELECT deptno FROM emp WHERE ename='KING') as deptno FROM emp;
*/

/* 
<SELECT ���ó>
1. ������ �˻�
 - SELECT Į���� FROM ���̺��; 
2. Į�� ��� ���
 - SELECT (SELECT~), (SELECT~) FROM emp; ==> ��Ī�� �ִ� ���� ����. 
 - ex) SELECT ename,(SELECT deptno FROM emp WHERE ename='KING') FROM emp;
 - ex) SELECT ename,(SELECT deptno FROM emp WHERE ename='KING') as deptno FROM emp;
3. ���ǿ� �ش�Ǵ� ���� ������ �� �� 
 - SELECT ~~ FROM table�� 
   WHERE sal=(SELECT ~~)
 - ex) SELECT * FROM emp WHERE sal>(SELECT AVG(sal) FROM emp);
4. ���̺� ��� ��� 
 - SELECT ~~ 
   FROM (SELECT~~)
*/

SELECT * FROM emp
WHERE TO_CHAR(hiredate,'YY/MM/DD')='20/01/07';

-- �̷������ε� ���ڿ� �񱳵� ��� ����. ==> K���� ū ename�� �����´�. 
SELECT * FROM emp
WHERE ename>='KING';

SELECT first_name||' '||last_name,hire_date FROM employees
WHERE hire_date<'06/01/03'; --06�⺸�� �� ������ �Ի��� �ֵ�. 

-- ex) 2005�� �Ի��� ��� ������� �̸��� �Ի����� ����϶�. 
-- ���1.
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE hire_date BETWEEN '05/01/01' AND '05/12/31'; -- BETWEEN AND�� �̻�/����(O). �ʰ�/�̸�(X).
-- ���2. 
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE hire_date>='05/01/01' AND hire_date<='05/12/31';
-- ���3. 
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE hire_date LIKE '05%'; --��¥�� ���ڿ��� ����Ǵϱ� �̷��Ե� ����!��

-- ���� ���� �Լ� ���� - INITCAP �Լ�
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE first_name=INITCAP('John'); 
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE first_name=INITCAP('john'); --�� ù���ڸ� �빮�ڷ� �ٲ��ִ� �Լ�

-- ����Ŭ���� &�� Scanner(����� �Է°� ���� ���), ||�� ���ڿ� ������.
SELECT * FROM emp
WHERE empno=&no; -- ��ǲâ �ߴ� ���ٰ� ��� �Է� �� �ش� ����� ���� ���� �˷��� 

/*
SELECT
FROM
WHERE
ORDER BY

����)
ORDER BY Į����(ASC|DESC)
         ename DESC
         ename ASC ==> ���� ���� (ASC�� ����Ʈ��)
 - ���� ORDER BY �Ѱ� �ƴϸ� �� ���̺� insert�� ������ ������ ������. 

*/












