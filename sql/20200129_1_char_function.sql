-- 2020-01-29 �Լ� (�����Լ�=����Ŭ���� �����ϴ� �޼ҵ�) 
-- SELECT * FROM emp;
/*
<�Լ�> : �������Լ�, �������Լ� 
1. ������ �Լ�
1) �����Լ� : ���ڿ� ���� �Լ� 
2) �����Լ� : ���ڰ��� 
3) ��¥�Լ� : ��¥����
4) ��ȯ�Լ� : ����=>����, ��¥=>����
             ex) YYYY-MM-DD => ���� ���ϴ� ������ ��¥�� ����� ���� ���ڷ� ��ȯ 
             ex) $300000 
             ex) 120,000,000
5) �Ϲ��Լ� : NVL, CASE, DECODE 
*/

--INITCAP, LOWER, UPPER
/*
INITCAP : �ձ��ڸ� �빮�ڷ�.
LOWER : �� �ҹ��ڷ�.
UPPER : �� �빮�ڷ�.
*/
SELECT ename, INITCAP(ename),LOWER(ename),UPPER(ename) FROM emp;

--LENGTH
/*
LENGTH : �Էµ� ���ڿ��� ���̰��� ���. 
LEGNTHB : �Էµ� ���ڿ��� ������ ����Ʈ���� ���. 
*/
SELECT ename, LENGTH(ename),LENGTHB(ename) FROM emp; --���� : LEGNTH ���� LEGNTHB ���� ��� �Ȱ��� 
SELECT LENGTH('ȫ�浿'),LENGTHB('ȫ�浿') FROM DUAL; -- �ѱ� : 1���ڿ� 2or3Byte�� LENGTH�� LENGTHB�� �ٸ��� ����. 
-- ex) emp ���̺��� �̸��� 5������ ����� ����ض�.
SELECT * FROM emp
WHERE LENGTH(ename)=5;

--SUBSTR
/*
SUBSTR(���ڿ�, ���۹�ȣ,���ڰ���)
 - ���ڸ� �ڸ� �� ��� 
 - ���� ������ ���� ��� ��� ex) ���� ���� �ʹ� ���Ƽ� UI�� ������ ����� ���...
 - ����Ŭ�� ��ȣ�� 1������ �����Ѵٴ� �� ����!! ��
   Hello Java
   12345678910
   SUBSTR('Hello Java',3,5)==> llo J
   ������ ���� ��� Ȯ���غ��� ������ �Ʒ��� ���� DUAL ���̺��� ������Ѿ�...
*/
SELECT SUBSTR('Hello Java',3,5) FROM DUAl;
--ex) EMPLOYEES ���̺��� 8���� �Ի��� ��� ����Ʈ�� ����ض�.
--���������� 02/08/16 
SELECT * FROM EMPLOYEES 
WHERE SUBSTR(hire_date,4,2)='08';
SELECT * FROM EMPLOYEES
WHERE hire_date LIKE '___08___'; 

--CONCAT : ���� ���� �Լ�. �ٵ� �̰ͺ��� || ���°� �ξ� ���ϴ�. 
SELECT CONCAT('Hello',' Java') FROM DUAl;
SELECT 'Hello'||' Java' FROM DUAl;
SELECT CONCAT(SUBSTR('Hello Java!!!!!',1,10),'...') FROM DUAL;

--INSTR(���ڿ�, ã�� ����, ������ġ, ���°���ڿ�����)
SELECT INSTR('Hello Java','a',1,1) FROM DUAL; -- ��� 8 : ù��° a�� ��ġ 
SELECT INSTR('Hello Java','a',1,2) FROM DUAL; -- ��� 10 : �ι�° a�� ��ġ 
SELECT INSTR('Hello Java','l',1) FROM DUAL; -- ��� 3 : ù��° l�� ��ġ  --�����ϸ�ù��°���ڿ��� ã��
--ex) emp ���̺��� �̸� �� ��° ���ڰ� A�� �ָ� ����϶�. 
SELECT * FROM emp
WHERE INSTR(ename,'A',1)=2;

--LPAD (���ڿ�,���ڰ���,ä�﹮��)
/*
LPAD('Java',8,'*') ==> ****Java
LPAD('Java',4,'*') ==> Java
*/
--ex) emp ���̺��� �̸� �����ʺ��� 3���ڸ� ����� ������ ���� ���ڵ��� *�� ������. 
SELECT LPAD(SUBSTR(ename,1,3),LENGTH(ename),'*') FROM emp; --ename���� ù��°���� ����3�� �ڸ���, ��ü ���ڼ��� ename ���ڼ���ŭ���� �����, *�� ä����
--ex) emp ���̺��� �̸� ���ʺ��� 3���ڸ� �����, �������� ������ ���ڵ��� *�� ������.
SELECT RPAD(SUBSTR(ename,1,3),LENGTH(ename),'*') FROM emp;
--ex)
SELECT RPAD('Hello Java',8,'*') FROM DUAL; --���� �� ��ġ�� �߶����. ���ڶ�� *�� ä��. 

--LTRIM (���ڿ�, �����ҹ���) ==> ������ ���ڰ� ���� ���� ���� ����
SELECT LTRIM('AAABABABAAA','A') FROM DUAL; -- ��� : BABABAAA
SELECT LTRIM('AA ABABABAAA','A') FROM DUAL; -- ��� : ' ABABABAAA' <== ���������� ���鵵 ���ڴϱ� ���� �ձ����� �ݺ��Ǵ� A�� ����.
--RTRIM (���ڿ�, �����ҹ���) 
SELECT RTRIM('AAABABABAAA','A') FROM DUAL; -- ��� : AAABABAB
--TRIM (�¿�)
SELECT TRIM('A' FROM 'AAABABABAAA') FROM DUAL; -- ��� : BABAB

--REPLACE : �ٸ� ���ڷ� ��ȯ => ���ڿ�, ����1, ����2 ==> ����1�� ����2�� �����Ų��.
SELECT REPLACE('Hello Java','a','b') FROM DUAL; --��� : Hello Jbvb













