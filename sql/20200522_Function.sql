-- 2020.05.22(��) Function
/* 
    PL/SQL
    1. PROCEDURE
     - return�� ������ ���� �ʴ� => ������ ������� ���� ��� (�Ű����� => OUT)
    2. Function
     - return�� ������ �ִ� ==> return�� �� ���� ���� ����Ѵ�. 
     - ex) max, substr, ...
     <����� ���� �Լ�)
     1) ����� �������� ==> SELECT ����������Լ� FROM ...
     2) �÷�, ���ǹ�
     3) ���� ==> ������ SQL ������ �ִ� ��� 
     
     ����) 
     CREATE [OR REPLACE] FUNCTION function_name(�Ű�����)
     RETURN �������� 
     IS
        �������� => ��������
     BEGIN
        SQL���� ==> SELECT dname INTO ����
        RETURN ����
     END;
     / 
*/

SELECT empno,ename,hiredate,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

CREATE OR REPLACE FUNCTION deptGetDname(pdeptno emp.deptno%TYPE) -- <== PL
RETURN VARCHAR2
IS
    pDname dept.dname%TYPE;
BEGIN
    SELECT dname INTO pDname 
    FROM dept
    WHERE deptno=pdeptno;
    RETURN pDname;
END;
/

SELECT empno,ename,deptGetDname(deptno) FROM emp;

-- ex) loc ������� �Լ� ����, empno/ename/deptno/loc ����ض�.
--     ==> �Լ��� ����ϸ� JOIN�� ���� �ʾƵ� ���� ������ �� �ְ�, �ҽ��� ª����. 

SELECT * FROM dept;

CREATE OR REPLACE FUNCTION deptGetLoc(pdeptno emp.deptno%TYPE)
RETURN VARCHAR2
IS
    pLoc dept.loc%TYPE;
BEGIN
    SELECT loc INTO pLoc
    FROM dept
    WHERE deptno=pdeptno;
    RETURN pLoc;
END;
/

SELECT empno,ename,deptGetDname(deptno),deptGetLoc(deptno) FROM emp;
    




SELECT * FROM student;
INSERT INTO student VALUES(1,'ȫ�浿',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(2,'��û��',85,95,99,SYSDATE,'��');
INSERT INTO student VALUES(3,'�ڹ���',65,86,70,SYSDATE,'��');
INSERT INTO student VALUES(4,'������',90,90,95,SYSDATE,'��');
INSERT INTO student VALUES(5,'�̼���',76,49,70,SYSDATE,'��');
COMMIT;

-- ������ ���� ������ ���� ������, (ex. student ���̺��� �й�1~5�� �л��� kor ���� �հ�)
-- ������ ���� ������ ���� ����
-- ==> �̶������� �Ʒ��� ���� ������ ���� �����ؿ��� 
SELECT hakbun,name,kor,eng,math,(kor+eng+math) as total,ROUND((kor+eng+math)/3.0,2) as avg FROM student;

-- ������ ���� ��ó�� ���� �ʾƵ�, �Լ��� ����ؼ� �Ʒ��� ���� ���� �� �ִ�.
CREATE OR REPLACE FUNCTION mySum(phakbun student.hakbun%TYPE)
RETURN NUMBER
IS
    pSum NUMBER;
BEGIN
    SELECT kor+eng+math INTO pSum
    FROM student WHERE hakbun=phakbun;
    RETURN pSum;
END;
/
SELECT hakbun,name,kor,eng,math,mySum(hakbun) FROM student;

-- ex) ������ ������ ���ϴ� �Լ��� ������.
CREATE OR REPLACE FUNCTION myAvg(phakbun student.hakbun%TYPE)
RETURN NUMBER
IS
    pAvg NUMBER;
BEGIN
    SELECT ROUND((kor+eng+math)/3.0,2) INTO pAvg
    FROM student WHERE hakbun=phakbun;
    RETURN pAvg;
END;
/
SELECT hakbun,name,kor,eng,math,mySum(hakbun),myAvg(hakbun) FROM student;


CREATE OR REPLACE FUNCTION getTotalPage
RETURN NUMBER
IS
    total NUMBER;
BEGIN
    SELECT CEIL(COUNT(*)/10.0) INTO total
    FROM recipe;
    RETURN total;
END;
/

SELECT getTotalPage() FROM recipe; -- �������Լ� 














