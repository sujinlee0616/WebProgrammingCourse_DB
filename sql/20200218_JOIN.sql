--2020.02.18(ȭ) 
/*
<JOIN>
 - �����͸� ��Ƽ� ó�� ===> JOIN 
 - ����) �÷����� ��ġ���� ���� ���� �ִ�. ��, ���� ���� ������ �־�� �Ѵ�.
   ex) emp => mgr. empno : �÷����� �ٸ����� ���� ���� ������ ����. 
 
 1. INNER JOIN (������)
  - ���� ����. 
  - NULL���� ó���� �� ����. 
  1) EQUI-JOIN: '=' �����ڸ� ���
    ��) ����Ŭ ����
        SELECT A.a B.b 
        FROM A,B
        WHERE A.c=B.c
    ��) ǥ��ȭ�� ����(ANSI JOIN)
        SELECT A.a,B.b
        FROM A (INNER) JOIN B
        ON A.c=B.c
  2) NON-EQUI-JOIN: '='�� �ƴ� �ٸ� �����ڸ� ���. �񱳿�����, BETWEEN ~ AND, IN
    ��) ����Ŭ ����
        SELECT A.a, B.b 
        FROM A,B
        WHERE A.c BETWEEN AND B.C1 AND B.C2
    ��) ǥ��ȭ�� ����(ANSI JOIN)
        SELECT A.a, B.b 
        FROM A JOIN B
        WHERE A.c BETWEEN AND B.C1 AND B.C2
  
 2. OUTER JOIN 
  - NULL�� �����ؼ� �����͸� ������ �� �� �ִ�. 
  1) LEFT OUTER JOIN
    ��) ����Ŭ ����
        SELECT A.a,B.b
        FROM A,B
        WHERE A.c=B.c(+)
    ��) ǥ�� ����
        SELECT A.a,B.b
        FROM A LEFT OUTER JOIN B
        ON A.c=B.c

  2) RIGHT OUTER JOIN
    ��) ����Ŭ ����
        SELECT A.a,B.b
        FROM A,B
        WHERE A.c(+)=B.c
    ��) ǥ�� ����
        SELECT A.a,B.b
        FROM A RIGHT OUTER JOIN B
        ON A.c = B.c
  3) FULL OUTER JOIN - ǥ�����θ� ����. 
    ��) ǥ�� ����
        SELECT A.a,B.b
        FROM A FULL OUTER JOIN B
        ON A.c = B.c
*/

/*
<SubQuery>
 - SQL ������ ������ ��Ƽ� ó��

 1. ������ ��������: ������� �� �� (SELECT �ڿ� �÷� 1�� ���) 
    ex) 10
  1) ����) Main SQL ==> ���� 
          WHERE �÷��� ������ (SubQuery)
                            ========= ���� �����
     ex)  SELECT * 
          FROM emp
          WHERE sal<(SELECT AVG(sal) FROM emp) ==> TRIGGEER          

 2. ������ ��������: ������� �� �� ���ε� �������� ������ ��. (SELECT �ڿ� �÷� 1�� ���)
    ex) 10
        20
        30
  1) ����) 
  2) ������: IN, ANY, ALL 3�� �����ڸ� ������ �ִ�. 
   - ANY, ALL ���ٴ� IN, MAX, MIN�� �� ���� �����
     ex)  emp�� distinct�� sal�� 100,200,300,400,500�� �� 
          SELECT * 
          FROM emp
          WHERE deptno IN(SELECT DISTINCT deptno FROM emp); -- ==> 10,20,30
                       > ANY(SELECT DISTINCT deptno FROM emp); -- ==> 10���� ū �ִ� �� ���� ==> deptno=20,30
                       < ANY(SELECT DISTINCT deptno FROM emp); -- ==> 30���� ���� �ִ� �� ���� ===> deptno=10,20
                       <= ALL(SELECT DISTINCT deptno FROM emp); -- ==> deptno=10 
                       >= ALL(SELECT DISTINCT deptno FROM emp); -- ==> ��� deptno���� ũ�ų� ���� �� ==> �ִ밪 ==> deptno=30  
                       <= (SELECT MIN(deptno) FROM emp); -- ===> �ּҰ����� �۰ų� ���� �� ==> �ּҰ� ==> deptno=10
                       >= (SELECT MAX(deptno) FROM emp);  -- ===> �ִ밪���� ũ�ų� ���� �� ==> �ִ밪 ==> deptno=30
        
 3. ��Į�� ��������: �÷��� ����ؼ� ��� 
  - ����: �ӵ��� ����. (�ӵ��� ���� ���� ��� ����ϱ⵵ �Ѵ�)
  - ����: SQL ������ �������. 

 4. �ζ��κ�: ���̺��� ����ؼ� ���
  - FROM ���� SELECT�� �� 
  - ������ �ʿ��� ��, ����¡ ���, TOP-N�� ���� ���. 
*/

-- ex1) KING�� �μ����� �ٹ��ϴ� ����� �̸�, �Ի���, ������ �����Ͷ�. 
SELECT * FROM emp;
SELECT ename, hiredate, job
FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING'); 

-- ex2) DALLAS���� �ٹ��ϴ� ����� ��� ������ ����ض�. (emp, dept ���̺�) 
SELECT * FROM dept;
SELECT * 
FROM emp
WHERE deptno=(SELECT deptno FROM dept WHERE loc='DALLAS');

-- ex3) IN, MAX, ANY, ALL
--IN
SELECT * FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp);
--MAX
SELECT * FROM emp
WHERE deptno <(SELECT MAX(deptno) FROM emp);
--MIN
SELECT * FROM emp
WHERE deptno >(SELECT MIN(deptno) FROM emp);
-->ANY ==> �ִ밪??? ===> �ٽ� Ȯ�� deptno=20,30
SELECT * FROM emp
WHERE deptno >ANY(SELECT deptno FROM emp); 
-- <ANY ==> �ּҰ�???? ===> �ٽ� Ȯ�� 
SELECT * FROM emp
WHERE deptno <ANY(SELECT deptno FROM emp); 
-->=ALL ==> �ִ밪. deptno=30 
SELECT * FROM emp
WHERE deptno >=ALL(SELECT deptno FROM emp); 
--<=ALL ==> �ּҰ�. deptno=10
SELECT * FROM emp
WHERE deptno <=ALL(SELECT deptno FROM emp); 


--�ζ��κ�: FROM �ڿ� ���� �÷��� SELECT���� ������ �� ����. 
SELECT empno,ename,job,hiredate,sal,dname,loc,sal,grade
FROM (SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal);


--rownum
SELECT ename,job,hiredate,sal,rownum
FROM emp;

SELECT ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum<=5;

--ex) �Ի������ 1~5�� �̱�. 
--�Ի簡 ���� ��� 5���� ���. �̸�, ����, �޿�, �Ի��� ���. ==> �ζ��κ� ���. TOP-N. 
SELECT ename, job, sal, hiredate
FROM (SELECT ename, job, sal, hiredate FROM emp ORDER BY hiredate DESC)
WHERE rownum<=5;
SELECT ename, job, sal, hiredate, rownum
FROM (SELECT ename, job, sal, hiredate FROM emp ORDER BY hiredate DESC)
WHERE rownum BETWEEN 1 AND 5;

--�ζ��κ並 ����ϸ� TOP-N�� ���� �� �ִµ� �߰������� ���� �� ����. �Ф� ex) �Ի��� ���� ������ 6~10��° �ֵ��� �̾ƿ��� ���� 
SELECT ename, job, sal, hiredate,rownum
FROM (SELECT ename, job, sal, hiredate FROM emp ORDER BY hiredate DESC)
WHERE rownum BETWEEN 6 AND 10; --�Ұ���. 

--ex) �Ի������ 6~11�� �̱�. 
--����¡������ ���� ��� �ڡڡ�
--���� �ָ� ���������� ����, �߰����� �ֵ鵵 �̾ƿ� �� �ִ�. ==> SELECT�� 3�� ���� ==> �䷱������ ����¡�� ���� �� �ִ�. 
SELECT ename, job, sal, hiredate,num
FROM (SELECT ename, job, sal, hiredate,rownum as num
FROM (SELECT ename, job, sal, hiredate FROM emp ORDER BY hiredate DESC))
WHERE num BETWEEN 6 AND 10; 

--JOIN���� Ǯ�� 
SELECT ename,job,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

--��Į�� �������� 
--�̷��� �Ұ���. SELECT���� ������� ���� 1��,1��,14���� �̹Ƿ� ��Ī �Ұ�.  
--SELECT���� ���� ���� ���� 1�����̾��!!
SELECT ename,job,(SELECT dname FROM emp,dept WHERE emp.deptno=dept.deptno)
FROM emp,dept;
--�̷��Դ� ����. JOIN �� �ɸ鼭 �ٸ� ���̺� �ִ� �÷� ���� ���� ����� ����. 
SELECT ename,job,(SELECT dname FROM dept WHERE emp.deptno=dept.deptno)
FROM emp,dept;
--�翬�� �̷��Ե� ����. 
SELECT ename,job,(SELECT dname FROM dept WHERE emp.deptno=dept.deptno),(SELECT loc FROM dept WHERE emp.deptno=dept.deptno)
FROM emp,dept;


DESC movie;
SELECT * FROM movie;

--�󿵿�ȭ(type=1) ����¡ ó��: 1page 
SELECT poster, title, score, regdate, num
FROM (SELECT poster, title, score, regdate, rownum as num
      FROM (SELECT poster, title, score, regdate FROM movie WHERE type=1))
WHERE num BETWEEN 1 AND 12;

--�󿵿�ȭ(type=1) ����¡ ó��: 2page
SELECT poster, title, score, regdate, num
FROM (SELECT poster, title, score, regdate, rownum as num
      FROM (SELECT poster, title, score, regdate FROM movie WHERE type=1))
WHERE num BETWEEN 13 AND 24;

SELECT * FROM movie
WHERE type=4; 
--����������ȭ(type=2) ����¡ ó��: 7page

CREATE TABLE news(
    title VARCHAR2(4000) CONSTRAINT news_title_nn NOT NULL,
    poster VARCHAR2(1000) CONSTRAINT news_poster_nn NOT NULL,
    link VARCHAR2(300) CONSTRAINT news_link_nn NOT NULL,
    author VARCHAR2(200) CONSTRAINT news_author_nn NOT NULL,
    regdate VARCHAR2(100) CONSTRAINT news_regdate_nn NOT NULL,
    content CLOB CONSTRAINT news_content_nn NOT NULL
);

DESC news;
SELECT * FROM news;
DROP TABLE news;







