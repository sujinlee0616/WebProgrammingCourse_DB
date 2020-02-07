-- 2020-01-30 ��¥�Լ� 

/*
1. SYSTEM : �ý����� �ð��� �о�� �� 
 - ����� ��¥�� ������ �����δ� ����. ==> ����� (+1, -1 ��..) 
 - ex) SYSDATE+10 => 10�� �� 
 - ����� �� ���� ���. ex) �Խ���, ȸ������
 --ex) 
 SELECT SYSDATE "����", SYSDATE + 1 "����", SYSDATE + 2 "��" FROM DUAL;
 
2. MONTHS_BETWEEN : �Ⱓ�� �������� ������ �´� => ����. 
 - �⵵+��+��+�ð�+��+�� => �Ҽ������� ���´�. 
 --ex)
 SELECT last_name,hire_Date,ROUND(MONTHS_BETWEEN(SYSDATE,hire_date),0) as "�ٹ�����",ROUND(MONTHS_BETWEEN(SYSDATE,hire_date)/12,0) as "����" FROM employees; 

3. NEXT_DAY : �������ڿ��� ������ ������ �������� ���°� �������� 
 - ���� : NEXT_DAY('��������', 'ã������')
 - ex) ������ ������� ����? 
 --ex)
 --ex) 
 SELECT NEXT_DAY(SYSDATE,'��') FROM DUAL;
 SELECT NEXT_DAY(SYSDATE,'��') FROM DUAL;

 
4. LAST_DAY : ���� ������ ��¥
 --ex) 
 SELECT LAST_DAY(SYSDATE) FROM DUAL;
 SELECT LAST_DAY(ADD_MONTHS(SYSDATE,1)) FROM DUAL;
 --ex) 20�� 8���� ������ ��¥�� ���ض�
 SELECT LAST_DAY('20/08/01') FROM DUAL;
 
5. ADD_MONTHS
 - �־��� ��¥�� ������ ���� 
 --ex)
 SELECT ADD_MONTHS('19/12/02',6) FROM DUAL;
 
*/

--[Mini Quiz] 
--1) 2017�⿡ �������(��ȭ�� ���� (2017)�Ǿ� �ִ� ��) ��ȭ�� ������ �ߺ����� ���
SELECT DISTINCT title FROM movie 
WHERE title LIKE '%(2017)';

--2) �帣�� �ڹ̵��� ��ȭ�� ����� ����, �⿬, �帣, �������� ����϶�.  
SELECT title,director,actor,genre,regdate FROM movie 
WHERE genre LIKE '%�ڹ̵�%';

--3) ���� ������ ��ȭ�� ��� ������ ����϶�. 
SELECT * FROM movie
WHERE type=1;

--4) �帣�� �ִϸ��̼ǰ� �ڹ̵��� ��ȭ�� ��� ������ ���
SELECT * FROM movie
WHERE genre LIKE '%�ڹ̵�%' AND genre LIKE '%�ִϸ��̼�%';

--5) �ð��� 100�� ������ ��ȭ�� ���
SELECT * FROM movie
WHERE RTRIM(time,'��')<=100;

--6) ��������� '15���̻������'�� ��ȭ�� ���
SELECT * FROM movie
WHERE grade='15���̻������';
SELECT * FROM movie
WHERE SUBSTR(grade,1,2)='15';

--6-1) ��������� '15���̻������'�̰ų� �װͺ��� �� ���� ��ȭ�� ���  <==�̰� ��� �� �� ������? 


--7) ������ ���� ���� ��ȭ�� ����� ������ ������ 5�� ��� �ڡڡ�
SELECT title,score,rownum --rownum : ����. 
FROM (SELECT title,score FROM movie ORDER BY score DESC) --From ���̺��� ������������ �����߱⶧���� rownum�� �������������� ��ȣ�� �Ű�����. 
WHERE rownum<=5;

--8) ��ȭ�� ������� �⵵ ������������ (��ȭ ���� (2017) �ִ� ��, (2018), (2019) �ִ� �� ������...) ��ȭ�� ������ �ߺ����� ���
--�� ��� : LENGTH ��� 
SELECT DISTINCT title FROM MOVIE
ORDER BY SUBSTR(title,LENGTH(title)-4,4) ASC; 
--������ ��� : INSTR ���  <== �ٽ� �� �� ���� 
SELECT DISTINCT title FROM MOVIE
ORDER BY SUBSTR(title,INSTR(title,'(',1)+1,4) ASC;
--                    ================== INSTR�� ���� ������
--                    ==================== SUBSTR�� ���۹�ȣ : INSTR(title,'(',1)+1
--                    INSTR('���� ���', '���ϰ����ϴ� ��', �񱳸� ������ ��ġ, �˻��� ����� ����)


--9) 2020.01.15 ~ 2020.02.20 ���̿� �����ϴ� ��ȭ�� ����ض�.
SELECT * FROM movie
WHERE REPLACE(SUBSTR(regdate,3,8),'.','/') BETWEEN '20/01/15' AND '20/02/20';

SELECT * FROM movie;

-- �̰� �� �ȵ�? 
SELECT * FROM movie
WHERE 
(SUBSTR(REGDATE,1,4)='2020' AND (SUBSTR(REGDATE,6,2)='01' AND to_number(SUBSTR(REGDATE,9,2))>=15))
OR
(SUBSTR(REGDATE,1,4)='2020' AND (SUBSTR(REGDATE,6,2)='02' AND to_number(SUBSTR(REGDATE,9,2))<=20));

--10) ������ '������'�� ��ȭ�� ����϶�.
SELECT * FROM movie
WHERE LTRIM(SUBSTR(director,INSTR(director,')',1)+1,4))='������';





--������ Bistro ���̺� ���� 
CREATE TABLE bistro(
    bistroId NUMBER(4), --������� �ѹ� (ex. 8472275)
    title VARCHAR2(1000), --���Ը� 
    score NUMBER(4,1) --����
);

ALTER TABLE bistro ADD(mno NUMBER(4));

ALTER TABLE bistro DROP COLUMN bistroId;









