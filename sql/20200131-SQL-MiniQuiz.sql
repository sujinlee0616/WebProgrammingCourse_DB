--2020-01-31 ��ȯ�Լ�, �Ϲ��Լ� 

/*
<��ȯ�Լ�>
TO_CHAR�� => ��¥ => �ð� ��� (���) ===> ��¥��ȯ, ����. ���� ����.
 1)�⵵: YYYY, YYY, YY (RRRRR,RR)
 2)��: MM, M
 3)��: DD, D
 4)�ð�: HH(=H12), HH12, HH24 ==> HH24�� �� ���� ����. 
 5)��: MI (���� M�̶� ���� M�� �ƴ϶� MI�� ǥ��) 
 6)��: SS
 7)����:
   õ�ڸ� �տ� �޸�: 999,999 
   ���� �տ� $ ���̱�: $999,999
   ���� �տ� �� ���̱�: L999,999
TO_NUMBER : Java���� Integer.parseInt()�ϴ°� �� ����. �� �� ��.
TO_DATE : Java���� new Date()�ϴ°� �� ����. �� �� ��. 
NVL�� : NULL���� �ٸ� ������ ���� 
 - NVL(Į����, null�� ��� �־��� ��) 
DECODE : Java�� swtich~case ��
CASE : �������ǹ� 

<�����Լ�>
LENGTH : ������ ����
SUBSTR : ���ڸ� �ڸ� ���
INSTR : ������ ��ġ
RPAD : ���ڰ� ���� ��쿡 ��ȣȭ

<�����Լ�>
ROUND : �ݿø�
TRUNC : ����
CEIL : �ø�
MOD : ������

<��¥�Լ�>
SYSDATE : �ý����� �ð��� �о�� 
MONTH_BETWEEN : �Ⱓ�� ������ 
*/
SELECT last_name, hire_date, salary FROM employees;
-- ��¥ ��ȯ (2020-01-31 ��������)
SELECT last_name,TO_CHAR(hire_date,'YYYY-MM-DD'), salary FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY-MM-DD HH24:MI:SS'), salary FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"�⵵"-MM"��" DD"��"'), salary FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"�⵵"-MM"��" DD"��"') as hiredate, salary FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"�⵵"-MM"��" DD"��"') as hiredate, TO_CHAR(salary,'999,999') FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"�⵵"-MM"��" DD"��"') as hiredate, TO_CHAR(salary,'$999,999') FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"�⵵"-MM"��" DD"��"') as hiredate, TO_CHAR(salary,'L999,999') FROM employees;

--NVL
SELECT last_name,hire_date,salary,commission_pct FROM employees; --null���� ���� ==> null���� �ٸ� ������ �ٲ�� ��� ����.. ex) commission�� salary�� ���ļ� �Ѽҵ��� ����ٴ���...
SELECT last_name,hire_date,salary,commission_pct,salary+commission_pct FROM employees;
SELECT last_name,hire_date,salary,NVL(commission_pct,0),salary+(salary*NVL(commission_pct,0)) FROM employees; --NULL���� �����ϴϱ� NVL ���

/*
ex) �����ȣ �˻� => ������ ���� ���(null) => ������������ null => NVL(bunji,' ') : ������ null�̸� �������� ó�� 
cf) '': null vs ' ': ���� 
*/

--DECODE
SELECT * FROM emp;
/*
1. DECODE
DECODE(deptno,10,'������',
              20,'��ȹ��',
              30,'���ߺ�',
              '���Ի��') as dept
2. CASE
CASE deptno WHEN 10 THEN '������'  --�޸�(,) �� ��´�!!
            WHEN 20 THEN '��ȹ��'
            WHEN 30 THEN '��ȹ��'
            ELSE '���Ի��'
            END "dept"
3. ��Ÿ
- DECODE�� CASE�ε� ������ �� �ִ�. 
- DECODE�� Java������ switch ���� �Ȱ���.
switch(deptno)
{
    case 10:
    case 20:
    case 30:
}

*/
--DECODE ex)
SELECT empno,ename, DECODE(deptno,10,'������',
                                  20,'��ȹ��',
                                  30,'���ߺ�',
                                  '���Ի��') as dept 
FROM emp; 
--CASE ex)
SELECT empno,ename, CASE deptno WHEN 10 THEN '������'  
                    WHEN 20 THEN '��ȹ��'
                    WHEN 30 THEN '��ȹ��'
                    ELSE '���Ի��'
                    END "dept"
FROM emp; 

/* Mini Test�� ���� ���̺� ����/������ insert 
DROP TABLE emp;

create table dept(
  deptno number,
  dname  varchar2(14),
  loc    varchar2(13),
  constraint pk_dept primary key (deptno)
);
  
create table emp(
  empno    number,
  ename    varchar2(10),
  job      varchar2(9),
  mgr      number(4,0),
  hiredate date,
  sal      number(7,2),
  comm     number(7,2),
  deptno   number
);

insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');
COMMIT;

DELETE FROM dept;
COMMIT;

insert into emp values( 7839, 'KING', 'PRESIDENT', null, '96/11/17', 5000, null, 10);
insert into emp values( 7698, 'BLAKE', 'MANAGER', 7839, '91/01/05', 2850, null, 30);
insert into emp values( 7782, 'CLARK', 'MANAGER', 7839, '99/09/06', 2450, null, 10);
insert into emp values( 7566, 'JONES', 'MANAGER', 7839, '01/02/04', 2975, null, 20);
insert into emp values( 7788, 'SCOTT', 'ANALYST', 7566, '17/03/06', 3000, null, 20);
insert into emp values( 7902, 'FORD', 'ANALYST', 7566, '81/03/12', 3000, null, 20);
insert into emp values( 7369, 'SMITH', 'CLERK', 7902, '07/12/01', 800, null, 20);
insert into emp values( 7499, 'ALLEN', 'SALESMAN', 7698, '81/02/20', 1600, 300, 30);
insert into emp values( 7521, 'WARD', 'SALESMAN', 7698, '81/02/22', 1250, 500, 30);
insert into emp values( 7654, 'MARTIN', 'SALESMAN', 7698, '81/09/28', 1250, 1400, 30);
insert into emp values( 7844, 'TURNER', 'SALESMAN', 7698, '81/08/09', 1500, 0, 30);
insert into emp values( 7876, 'ADAMS', 'CLERK', 7788, '87/07/13', 1100, null, 20);
insert into emp values( 7900, 'JAMES', 'CLERK', 7698, '81/03/21', 950, null, 30);
insert into emp values( 7934, 'MILLER', 'CLERK', 7782, '03/01/23', 1300, null, 10);
COMMIT;
*/
SELECT * FROM dept;
SELECT * FROM emp;

--[Mini Test]
--ex1) �����ȣ, �̸�, ������ ����Ͻÿ�.
SELECT empno,ename,sal FROM emp;
--ex2) �̸� ���� ���� �Ի����� ����Ͻÿ�.
SELECT ename,sal,job,hiredate FROM emp;
--ex3) �̸�, ����, Ŀ�̼�, ���� + Ŀ�̼��� ����Ͻÿ�.
SELECT ename,sal,comm,sal+NVL(comm,0) FROM emp;
/*
<NVL>
 - ����) 
   NVL(����,��ü����) 
   NVL(����,��ü����)
 - NULL���� ��� ����ó���� �ȵǹǷ� NVL �Ἥ NULL���� �ٸ� ������ �ٲ��ش�. 
 - NVL �ȿ� ���������� ���ƾ� �Ѵ�! ex) 74�� ex)���� 
*/
--ex4) ����̸��� ������ ����ϴµ�, �̸��� �÷����� employee��� �ϰ� ������ �÷����� salary��� �Ͻÿ�.
SELECT ename as "employee",sal as "salary" FROM emp; --Į������ �ҹ��ڷ� ���� 
-- "" �ٿ��� ���� �Է��� ��ҹ��ڰ� �ݿ��� ==> �ظ��ϸ� "" ������. 
SELECT ename as employee,sal as salary FROM emp; --Į������ �빮�ڷ� ���� 
/*
<��Ī>
 - ����) 
   �÷��� "��Ī"
   �÷��� as "��Ī"
   �÷��� as ��Ī
 - as�� ���� ����. 
 - �÷����� �� �� ��Ī ����Ѵ�. 
*/
--ex5) ����̸��� �Ի����� ����ϴµ� ����̸��� �÷����� employee name���� ��µǰ� �Ͻÿ�.
SELECT ename as "employee name",hiredate FROM emp;
--ex6) ������ ����Ͻÿ�. (distinct : �ߺ����� Ű����)
SELECT DISTINCT job FROM emp;
--����) DISTINCT ==> �帣, ��ǰ���� � ���� ����. 
--ex7) �μ���ȣ�� ����ϴµ� �ߺ������ؼ� ����Ͻÿ�
SELECT DISTINCT deptno FROM emp;
--ex8) �����ȣ�� 7788���� ����� �����ȣ�� �̸��� ����Ͻÿ�.
SELECT empno,ename FROM emp WHERE empno=7788;
/*
<��������>
1. ������ 
 1) CHAR(��������Ʈ, 1~2000byte)
 2) VARCHAR2(��������Ʈ, 1~4000byte)
 3) CLOB (��������Ʈ, 4G) => String
 �� �ѱ��� 1���ڿ� 2~3byte ������. 
2. ������ 
 1) NUMBER, NUMBER(�ڸ���) => int
 2) NUMBER(�ڸ���, �Ҽ����ڸ���) => double 
3. ��¥�� 
 1) DATE
 2) TIMESTAMP(��� ���ֿ� ���� ���) 
4. ��Ÿ�� 
 - ����, ������, �ִϸ��̼� � ���� ���. 4G.
 1) BLOB : binary(2����)���� ���� 
 2) BFILE : ���� �������� ����
5. ����
 1) ���̺� ���� �ñ��� �� : DESC table��; 

<������>
 - NULL�� �ִ� ��쿡�� ������ �Ұ����ϹǷ� �ݵ�� NVL ����ؼ� NULL�� �ٸ� ��ü������ �����������. 
1. ��������� (+,-,*,/)
 - 0���� ���� �� ����
 - ����/����=�Ǽ� 
 - SELECT���� ���� ��� 
2. �񱳿����� (=,!=,<>,<,>,>=,<=) 
 - ������� boolean 
 - WHERE���� ���� ���
3. �������� (AND, OR)
 - ||, && �� 'OR', 'AND'�� �ƴ϶� '���ڿ�����', 'Scanner'�̴�. 
 - ����) 
   ����Ŭ�� ��ҹ��� ������ ����. (���: Ű����� �빮�ڸ� ����Ѵ�)
   *** �����ʹ� ��ҹ��ڸ� �����Ѵ�. 
 - WHERE���� ���� ���
4. ���Կ����� (=)
 - ���Կ����ڷμ��� '='�� UPDATE ������ ����.
 - WHERE �ڿ� '='�� �ִٸ� �񱳿�����, WHERE �ۿ� '='�� �ִٸ� ���Կ����ڷ� ���� ��. 
 -  ex) UPDATE emp SET
        ename='ȫ�浿' -- <== '='�� ���Կ����� 
        WHERE empno=7788; -- <== '='�� �񱳿����� 
5. NULL ������
 - IS NULL : NULL�� ���
 - IS NOT NULL : NULL�� �ƴ� ��� 
 - null���� null�� �ƴ����� �Ǻ��ϱ� ���ؼ��� �ݵ�� NULL �����ڸ� ����ؾ� �Ѵ�.
 - comm=null �̷������δ� null ���θ� �Ǻ��� �� ����. 
6. BETWEEN ~ AND 
 - ����, �Ⱓ ���� �� 
 - '�̻�' '����'�̴�. ex) BETWEEN 1~10 : 1�̻� 10����
 - ������ ������, ���űⰣ, üũ��/üũ�ƿ� � ���� ���ȴ�. 
7. LIKE
 - ���繮�ڿ� �˻�
 1) % : ���ڿ� ������ �� �� ���� ��
 2) _ : ���� 1�� 
8. NOT : ���� 
 1) NOT IN
 2) NOT BETWEEN 
 3) NOT LIKE
9. IN : ����
 - OR�� ������ ����ؾ� �� ��� OR ������ ��� IN ���
*/
--ex9) ������ 3000�� ������� �̸��� ������ ����Ͻÿ�
SELECT ename,sal FROM emp WHERE sal=3000;
--ex10) �̸��� scott�� ����� �̸��� ������ ����Ͻÿ�.
SELECT ename,job FROM emp WHERE ename='SCOTT';
--ex11) ������ 3000 �̻��� ������� �̸��� ������ ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE sal>=3000;
--ex12) ������ SALESMAN�� �ƴѻ������ �̸��� ������ ����Ͻÿ�.
--���� : !=, <>, ^=
SELECT ename,job FROM emp WHERE job!='SALESMAN';
SELECT ename,job FROM emp WHERE job<>'SALESMAN';
SELECT ename,job FROM emp WHERE job^='SALESMAN';
SELECT ename,job FROM emp WHERE NOT(job='SALESMAN');
SELECT ename,job FROM emp WHERE job NOT IN ('SALESMAN');
--ex13) ������ 1000���� 3000 ������ ������� �̸��� ������ ����ϴµ�, �÷����� Employee, Salary�� ����Ͻÿ�. (between A and B : A�̻� B���� ������ ������)
--��Ī) 1) as "��Ī" 2) "��Ī" 3) ��Ī 
SELECT ename as "Employee", sal as "Salary" FROM emp WHERE sal BETWEEN 1000 AND 3000;
SELECT ename "Employee", sal "Salary" FROM emp WHERE sal BETWEEN 1000 AND 3000;
SELECT ename as "Employee", sal as "Salary" FROM emp WHERE sal>= 1000 AND sal<=3000; --�ε�ȣ�� BETWEEN���� �ӵ� �� ���� 
--ex14) ����̸��� ������ ����ϴµ� ������ ���� ������� ���� ��������� ����Ͻÿ�. (order by)
--����) ORDER BY �÷���/�÷����� ASC|DESC;
SELECT ename,sal FROM emp ORDER BY sal ASC;
SELECT ename,sal FROM emp ORDER BY 2 ASC;
--ex15) �̸��� �Ի����� ����ϴµ� ���� �ֱٿ� �Ի��� ������� ����Ͻÿ�.
SELECT ename,hiredate FROM emp ORDER BY hiredate DESC;
--ex16) ������ SALESMAN�� ������� �̸��� ���ް� ������ ����ϴµ�, ������ ���� ������� ����Ͻÿ�.
SELECT ename,job FROM emp WHERE job='SALESMAN' ORDER BY sal DESC;
--����) SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY 
--ex17) ������ 1000 �̻��� ������� �̸��� ������ ����ϴµ� ������ ���� ������� ���� ��������� ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE sal>=1000 ORDER BY sal ASC;
--ex18) ����(������*12)�� 36000 �̻��� ������� �̸��� ������ ����ϰ� �÷����� ��Ī�� "����"���� �Ͻÿ�.
SELECT ename,sal as "����" FROM emp WHERE sal*12>=36000;
--ex19) ������ 1000���� 3000���̰� �ƴ� ������� �̸��� ������ ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE sal NOT BETWEEN 1000 AND 3000;
--ex20) �̸��� ù ���ڰ� s�� �����ϴ� ������� �̸��� ����Ͻÿ�.
SELECT ename FROM emp WHERE ename LIKE 'S%';
--ex21) �̸��� �� ���ڰ� T�� ������ ������� �̸��� ����Ͻÿ�.
SELECT ename FROM emp WHERE ename LIKE '%T';
--ex22) �̸��� �ι�° ö�ڰ� m�� ������� �̸��� ����Ͻÿ�.
 SELECT ename FROM emp WHERE ename LIKE '_M%';
--ex23) �̸��� ����° ö�ڰ� L�� ����� �̸��� ����Ͻÿ�.
SELECT ename FROM emp WHERE ename LIKE '__L%';
--ex24) �̸��� �ι�° ö�ڰ� C�� ����� �̸��� ����Ͻÿ�.
SELECT ename FROM emp WHERE ename LIKE '_C%';
--ex25) �̸��� �ι�° ö�� A�� ����° ö�ڰ� R�� ������� �̸��� ����Ͻÿ�
SELECT ename FROM emp WHERE ename LIKE '_AR%';
--ex26) �̸��� ù��° ö�ڰ� S �� �ƴ� ������� �̸��� ����Ͻÿ�.
SELECT ename FROM emp WHERE ename NOT LIKE 'S%';
--ex27) ��� ��ȣ�� 7788, 7902, 7369���� ������� �����ȣ�� �̸��� ����Ͻÿ�.
SELECT empno,ename FROM emp WHERE empno IN(7788,7902,7369);
--ex28) ������ SALESMAN ANALYST�� �ƴ� ������� �̸��� ������ ����Ͻÿ�.
SELECT ename,job FROM emp WHERE job NOT IN('SALESMAN', 'ANALYST');
--ex29) Ŀ�̼��� null�� ������� �̸��� Ŀ�̼��� ����Ͻÿ�.
SELECT ename,comm FROM emp WHERE comm IS NULL; 
--ex30) Ŀ�̼��� null�� �ƴ� ������� �̸��� Ŀ�̼��� ����Ͻÿ�.
SELECT ename,comm FROM emp WHERE comm IS NOT NULL; 
--ex31) ������ 1000���� 3000 ������ ������� �̸��� ������ ����ϴµ� ������ ����  ������� ����Ͻÿ�
SELECT ename,sal FROM emp WHERE sal BETWEEN 1000 AND 3000 ORDER BY sal DESC;
--ex32) 1981�� 8�� 9�Ͽ� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�.
SELECT ename,hiredate FROM emp WHERE hiredate='81/08/09';
SELECT ename,hiredate FROM emp WHERE TO_CHAR(hiredate,'YYYY"��" MM"��" DD"��"')='1981�� 08�� 09��'; --��
--ex33) 1981�� 2�� 20�Ͽ� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�.
SELECT ename,hiredate FROM emp WHERE hiredate='81/02/20';
--ex34) 1981�⵵�� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�.
SELECT ename,hiredate FROM emp 
WHERE hiredate BETWEEN '81/01/01' AND '81/12/31';  --�� ����O
SELECT ename,hiredate FROM emp WHERE hiredate LIKE '81%'; --����X. �ӵ� ����. 
SELECT ename,hiredate FROM emp WHERE SUBSTR(hiredate,1,2)=81; -- ����O.
--ex35) ���Ῥ���ڸ� �̿��ؼ� �̸��� ������ �����ؼ� ����Ͻÿ�.
SELECT ename||' '||sal FROM emp;
SELECT CONCAT (ename,sal) FROM emp;
--ex36) ������ ����� "SCOTT�� ������ ANALYST �Դϴ�."�� ���� ����� ����Ͻÿ�.
SELECT ename||'�� ������ '||job||' �Դϴ�.' FROM emp;
--�١�ex037) �Ʒ��� ���� ����� ����Ͻÿ�. (�̹��� ����) 
SELECT ename,job,sal FROM emp ORDER BY job ASC, sal ASC;
--ex38) ������ SALESMAN�� ������� �̸��� ������ ����ϴµ� ������ ���� ������� ����ϰ� �Ʒ��� ���� ����� ����Ͻÿ�. "ALLEN �� ������ 36000 �Դϴ�."
SELECT ename||'�� ������ '||sal*12||' �Դϴ�' FROM emp WHERE job='SALESMAN' ORDER BY sal DESC; 
--ex39) �̸��� �빮�ڷ� ������ �ҹ��ڷ�, �̸��� ù���ڸ� �빮�� �������� �ҹ��ڷ� ����Ͻÿ�.
SELECT UPPER(ename), LOWER(job), INITCAP(ename) FROM emp;
--ex40) �̸��� scott�� ����� �̸��� ������ ����ϴµ� where���� scott�� �ҹ��ڷ� �˻��ؼ� ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE ename=UPPER('scott');
--e041) �Ʒ��� ���� ����� ����Ͻÿ�. (�̹��� ����) 
SELECT ename,SUBSTR(ename,1,3) as "SUBSTR" FROM emp;
--ex42) �̸��� ù��° ö�ڸ� �빮�ڷ� ���, �������� �ҹ��ڷ� ��µǰ� �Ͻÿ�.
SELECT INITCAP(ename) FROM emp;
--ex43) upper, lower, substr, || �� ����ؼ� �Ʒ��� ���� ����� ����Ͻÿ�. (�̹��� ����. Smith, Allen,...) 
SELECT UPPER(SUBSTR(ename,1,1))||LOWER(SUBSTR(ename,2,LENGTH(ename))) FROM emp;
--ex44) �̸��� M�ڸ� �����ϰ��ִ� ������� �̸��� ������ ����Ͻÿ�.
SELECT ename,sal FROM emp WHERE ename LIKE '%M%';
SELECT ename,sal FROM emp 
WHERE regexp_like(ename,'M'); --���Խġ�
--ex45) �̸��� EN �Ǵ� IN�� �����ϰ� �ִ� ������� �̸��� �Ի����� ����ϴµ� �ֱٿ� �Ի��� ������ ����Ͻÿ�.
SELECT ename,hiredate FROM emp WHERE ename LIKE '%EN%' OR ename LIKE '%IN%' ORDER BY hiredate DESC;
SELECT ename,hiredate FROM emp 
WHERE regexp_like(ename,'EN|IN')
ORDER BY hiredate DESC; --���Խġ�
--ex46) ������ SALESMAN�� ������� ��� �̸��� ������ ������ ����ϴµ� ������ ���� ������� ����Ͻÿ�.
--����) ����Ŭ ���� ������ from, where, select, order by ������ ����ȴ�. �� ���� ������ ���� as ��Ī�� �ν��ϰ� ���ϴ� �� �� �ִ�.
SELECT ename,job,sal FROM emp WHERE job='SALESMAN' ORDER BY sal DESC;
--ex47) �̸��� ù���ڰ� A�� �����ϴ� ������� �̸��� ���ް� ������ ����Ͻÿ�. 
SELECT ename,sal,job FROM emp WHERE ename LIKE 'A%';
--ex48) ������ 1000���� 3000 ������ ������� �̸��� ���ް� �Ի����� ����ϴµ�, �Ի����� ���� �Ի��� ������� ��µǰ� �Ͻÿ�.
SELECT ename,sal,hiredate FROM emp WHERE sal BETWEEN 1000 AND 3000 ORDER BY hiredate;
--ex49) 1981�⵵�� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�. 
SELECT ename,hiredate FROM emp WHERE hiredate LIKE '81%';
--ex50) �̸��� M�ڸ� �����ϰ� �ִ� ������� �̸��� ����Ͻÿ�. 
SELECT ename FROM emp WHERE ename LIKE '%M%';
--����) �������Լ� : ����, ����, ��¥, ��ȯ, �Ϲ�
--����) ������ �Լ� : MAX, MIN, AVG, SUM, COUNT
--����) ���� �Լ� : upper, lower, initcap, substr, instr, lpad, rpad, trim, replace
--��ex52) instr �Լ��� �̿��ؼ� �̸��� A�ڸ� �����ϰ� �ִ� ������� �̸��� ����Ͻÿ�. 
SELECT ename FROM emp 
WHERE INSTR(ename,'A',1)>=1;
--����) INSTR('����', '���ϰ����ϴ� ��', ������ ��ġ, ����� ����)
--ex54) �̸��� ������ ����ϴµ� ������ ��ü 10�ڸ��� ����ϰ� ������ �ڸ��� *�� ����Ͻÿ�! 
--����)  RPAD("��", "�� ���ڱ���", "ä����")
SELECT ename,LPAD(sal,10,'*') FROM emp;
--����) ���̵�ã��, ��й�ȣ ã�� => RPAD �̿�, JavaMail
--��ex55) �̸��� ������ ����ϴµ� ������ ��ü 10�ڸ��� ����ϰ� ������ �ڸ��� �������� ����Ͻÿ�. 
SELECT ename,LPAD(sal,10,' ') FROM emp;
--ex56) length �Լ��� �̿��ؼ� �̸��� �̸��� ö���� ����(�̸� ���� ����)�� ����Ͻÿ�. 
SELECT ename,LENGTH(ename) FROM emp;
--��ex57) �̸�, �Ի��� ��¥���� ���ñ��� �� ���� �ٹ��ߴ��� �Ҽ��� �ڿ��� �߶� ����Ͻÿ�.
SELECT ename,TRUNC(SYSDATE-hiredate) FROM emp;
/* ����) 
1. round : �ݿø��ϴ� �Լ�(������ �ڸ������� �ݿø��ؼ� ǥ��)
2. trunc : �׳� ������ �Լ�(������ �ڸ������� �����ؼ� ǥ��)
3. mod : ������ ���� �� ������ �� 
*/
--ex058) �̸�, �Ի��� ��¥���� ���ñ��� �� ��� �ٹ��ߴ��� �Ҽ��� �ڿ��� �߶� ����Ͻÿ�. 
SELECT ename,TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate)) FROM emp;
/*
����) ���� ��¥ Ȯ���ϴ� ��� : select sysdate from dual;
��¥�Լ�) 
 1. months_between : ��¥�� ��¥ ������ ������ ���
  - ��¥ + ��¥ = ��¥
  - ��¥ - ���� = ��¥
  - ��¥ - ��¥ = ����
 2. add_months : ��¥���� �������� ���� ��¥
 3. next_day : ������ ��¥���� ������ ���ƿ� ������ ��¥�� ���
 4. last_day : ������ ��¥���� ������ ��¥�� ���
*/
--ex59) ���ú��� 100�� ���� ��¥�� ����Ͻÿ�.
SELECT SYSDATE, ADD_MONTHS(SYSDATE,100) FROM DUAL;
--ex60) ���ú��� ������ ���ƿ� �������� ��¥�� ����Ͻÿ�. 
SELECT NEXT_DAY(SYSDATE,'������') FROM DUAL;
SELECT NEXT_DAY(SYSDATE,'��') FROM DUAL;
--ex61) ���ú��� 100�޵� ���ƿ� �ݿ����� ��¥�� ����Ͻÿ�. 
SELECT NEXT_DAY(ADD_MONTHS(SYSDATE,100),'�ݿ���') FROM DUAL;
SELECT NEXT_DAY(ADD_MONTHS(SYSDATE,100),'��') FROM DUAL;
--ex62) �̹��� ������ ��¥�� ����Ͻÿ�. 
SELECT LAST_DAY(SYSDATE) FROM DUAL;
--ex63) ���ú��� ����� ���ϱ��� �� ���ϳ��Ҵ��� ����Ͻÿ�! 
SELECT LAST_DAY(SYSDATE)-SYSDATE FROM DUAL;
--SYSDATE: �������� 
/*
�� ������ Ÿ���� ��ȯ�ϴ� �Լ�
1. ���ڷ� ����ȯ :to_char
2. ���ڷ� ����ȯ :to_number
3. ��¥�� ����ȯ :to_date
*/ 
--ex64) ������ ���� �������� ����Ͻÿ�. 
SELECT TO_CHAR(SYSDATE,'day') FROM DUAL; --�ݿ���
SELECT TO_CHAR(SYSDATE,'dy') FROM DUAL; --��
SELECT TO_CHAR(SYSDATE,'d') FROM DUAL; --6
SELECT TO_CHAR(SYSDATE,'DAY') FROM DUAL;
--ex65) �̸�, �Ի��� ������ ����Ͻÿ�. 
SELECT ename,TO_CHAR(hiredate,'day') FROM emp;
/*����) 
��¥ ���佺Ʈ��(����1�� ����1 4-12)
���� : day, dy
�⵵ : YYYY, YY, RRRR, RR, year
�� : mm, mon, month
�� : dd
�� : ww, w, iw
�ð� : hh, hh24
�� : mi
�� : ss
*/
--ex66) ���ú��� 200�� �ڿ� ���ƿ��� ��¥�� ������ ��� 
SELECT TO_CHAR(ADD_MONTHS(sysdate,200),'day') FROM DUAL;
--ex67) �̸��� �Ի��� �⵵�� ����Ͻÿ�.
SELECT ename,TO_CHAR(hiredate,'YYYY') FROM emp;
--ex68) 1981�⵵�� �Ի��� ������� �̸��� �Ի����� ����Ͻÿ�.
SELECT ename,hiredate FROM emp WHERE TO_CHAR(hiredate,'YYYY')=1981;
--ex69) ����Ͽ� �Ի��� ������� �̸��� �Ի���, �Ի��� ������ ����Ͻÿ�.
SELECT ename,TO_CHAR(hiredate,'day') FROM emp WHERE TO_CHAR(hiredate,'day')='�����';
--��ex71) �̸��� ������ ����ϴµ� ���޿� õ������ �ο��Ͻÿ�! (��: 3000 -> 3,000)
SELECT ename,TO_CHAR(sal,'999,999') FROM emp;
--ex72) �̸��� ���� * 5400�� ����ϴµ�, õ������ �鸸������ �޸��� �����Ͻÿ�.
SELECT ename,TO_CHAR(sal*5400,'999,999,999') FROM emp;
/* ����) 
�Ϲ��Լ�
1. nvl
2. decode
3. case
*/
SELECT CONCAT('�ȳ�','�ϼ���') FROM DUAL;
--ex73) �̸��� Ŀ�̼��� ����ϴµ� Ŀ�̼��� null�� ������� 0���� ����Ͻÿ�.
SELECT ename,NVL(comm,0) FROM emp;
--����) nvl �Լ��� argument ������ ������ Ÿ���� ����� �Ѵ�.
--��ex74) �̸��� Ŀ�̼��� ����ϴµ� Ŀ�̼��� null�� ������� no comm �̶� �۾��� ����Ͻÿ�.
SELECT ename,NVL(comm,'no comm') FROM emp; --Error  --�ֳĸ� NVL(���ڿ�,��ü���ڿ�) or NVL(����,��ü����) �̷��� NVL�� ���� �������������� ó�� �����ϱ� ����
SELECT ename,NVL(TO_CHAR(comm),'no comm') FROM emp; --�������

/*
<���̺�>
 - ������ ���̽� ���� ����
 - 2���� ������ ������ : row + column 
<SQL>
1. DML (������ ����) => row ���� ���� 
 (�� �ڹٿ����� �÷� �������� ���� ���� '���ڵ�'��� �Ѵ�.) 
 1) ������ �˻� (SELECT) 
  - ����)
    SELECT *|column1,column2,...
    FROM table��
    {
        WHERE ���ǽ�
        GROUP BY �׷��÷�
        HAVING �׷�����
        ORDER BY Į���� ASC|DESC (ASC�� ����Ʈ)
    }
 2) ������ �߰� (INSERT)
 3) ������ ���� (UPDATE)
 4) ������ ���� (DELETE)
2. DDL (������ ����) 
 1) CREATE (����) => ���������� ���������� �� ����ؾ�. 
 2) ALTER (����) => ����, ����, �߰�
 3) DROP (����) => ���̺� ���� ����.
 4) TRUNCATE (�߶󳻱�) => �����͸� ����. ���̺��� �״�� ����. 
 5) RENAME => �̸����� 
3. DCL (������ ����) : DBA�Ե��� �Ͻô� ��.  
 1) ���Ѻο� : GRANT
 2) �������� : REVOKE
4. TCL (�ϰ�ó��) : Ʈ�����
 1) COMMIT - ���� ����(����) 
 2) ROLLBACK - ������ ����(���) 
*/

CREATE VIEW emp_view
AS SELECT * FROM emp;

DELETE FROM emp;
SELECT * FROM emp;
ROLLBACK;

--1. ���ϴ� �÷��� �����ؼ� ������ �б�
SELECT empno,ename,sal FROM emp;







