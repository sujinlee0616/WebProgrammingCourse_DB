--2020-02-19(��)
/*
<VIEW>
 - �������̺� ==> SQL ���常 ����Ǿ� �ִ� ����.
 - �ݵ�� ���� ���̺��� �ʿ� (���� ���̺��� �����ؼ� ���) 
 - ����, ����� ���Ǹ� ���ؼ� ����. 
   ex) ���α׷����� ������ ���������� �ܼ�ȭ��Ų��. 
 - ����: 1~3: ������ ��������(X) / 4: ������ ���� ����(O)
 1) �ܼ���: ���̺��� �� ���� ���� 
 2) ���պ�: ���̺��� ������ ���� 
 3) �ζ��κ�: SQL ������ FROM ���� View�� �������� �κ��� �ٷ� ��� ���
 4) MView: �길 ���� �����͸� ���� �ִ� ==> '��ü ��', '��üȭ�� ��'��� �θ�.

1. VIEW ����
    CREATE VIEW view��
    AS 
    SELECT ~~ 
    ����) CREATE View emp_view
         AS
         SELECT empno,ename,job,hiredate FROM emp
         -- emp_view�� �θ��� SELECT ~~~ emp ������ ����ȴ�. 

2. VIEW ����
    CREATE OR REPLACE VIEW view��
    AS
    SELECT ~~ 
    - ALTER�� �� �� X
    - ������ ���� VIEW�� CREATE �ϰ�, 
      ������ �ִ� VIEW�� �����ϴ°Ÿ� REPLACE �ϸ� �ȴ�. (���� VIEW ������ �ʿ�X) 

3. VIEW ���� 
    DROP VIEW view��

4. VIEW �ɼ�
 1) WITH CHECK OPTION 
    : ����Ʈ��. DML�� ����. (DML: Manipulation: INSERT, UPDATE, DELETE)
      VIEW�� �����ϴ� ���� ���̺� ���� ����� ������ �ִ�. 
 2) WITH READ ONLY 
    : �б� ����. (DML �Ұ�) ==> �˻� ����. 
      VIEW�� �����ϴ� ���� ���̺� ���� ������� �����Ƿ� �����ϴ�. �����ϴ� ���. 
*/

--================== <�ܼ���> ==================
--����. �̷��� CATS(??)��� ��.
CREATE TABLE youDept 
AS SELECT * FROM dept;

SELECT * FROM youDept;

--�ܼ�VIEW ����
CREATE OR REPLACE VIEW dept_view
AS
SELECT * FROM youDept;

SELECT * FROM dept_view;

--VIEW�� ������ �߰� 
INSERT INTO dept_view VALUES (50,'������','����');
COMMIT;

--VIEW�� �����ϰ� �ִ� ���̺��� �����Ͱ� �߰��� ���� �� �� �ִ�. 
--==> �����ϰ� �ִ� �������̺��� �����Ͱ� ����� �� �־ ������..
SELECT * FROM youDept;
SELECT * FROM dept_view;

--================== <VIEW ����> ==================
--VIEW ����: read-only�� ����
CREATE OR REPLACE VIEW dept_view
AS
SELECT * FROM youDept WITH READ ONLY;

--VIEW�� ������ �߰� 
INSERT INTO dept_view VALUES (50,'��ȹ��','����'); --Error. �߰� �Ұ�. 

-- VIEW�� TABLE ��� �����Ͱ� ������� �ʾ����� Ȯ���� �� �ִ�.
SELECT * FROM youDept; 
SELECT * FROM dept_view;

--================== <���պ�> ==================
--���պ� ���� 
CREATE OR REPLACE VIEW emp_dept
AS
SELECT empno,ename,job,hiredate,sal,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno WITH READ ONLY;

SELECT * FROM emp_dept;


--================== <Inline View> ==================
SELECT ename,job,hiredate,dname,loc
FROM (SELECT ename,job,hiredate,dname,loc FROM emp,dept WHERE emp.deptno=dept.deptno);


--================== <���̺� ����> ==================
DROP VIEW dept_view;
DROP VIEW emp_dept;





