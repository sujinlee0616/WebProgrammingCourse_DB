-- DDL, DML 
/*
<DML>: Data Manipulation Language, ������ ����. 
 1. ������ �˻� 
    SELECT (SQL�� �ٽ�!)
        1) ���� 2) ������,�Լ� 3) JOIN, 4) Subquery 
 2. ������ �߰�
    INSERT 
    => INSERT INTO table�� VALUES(��1, ��2, ...)
 3. ������ ����
    UPDATE
    => UPDATE table�� SET 
       �÷���=��, �÷���=��...
       WHERE �ش����� => �ߺ��� ���� ���� ����. (ex.empno) 
 4. ������ ���� 
    DELETE
    => DELETE FROM table��
       WHERE �ش����� => �ߺ��� ���� ���� ����. (ex.empno) 
    
    ==> ���̺��� �ݵ�� �ߺ��� ���� ���� �ϳ��� �־�� �Ѵ�! (ex.empno) 
    
<���̺�> : ���� ����
 - ���̺�� ��Ģ
   1) ���ĺ��̳� �ѱ۷� �����Ѵ�.
      ���� ���ĺ� ��ҹ��� ��� ����. 
   2) ���� ��� ���� => ��, �� �տ��� �� �� ����. 
      ex) 2emp(X) emp2(O)
   3) Ű����� ��� ���� (ex. ���̺������ order ��� �Ұ�)
   4) Ư������ ��� ����. ('_', '$'�� ��� ����) 
      ex) _emp (O) emp_dept (O)
   5) ���̺���� ���̴� ������ ����. ��, ���� 3~10���� ������ ���´�. 
 - ���̺�� => �޸� ���� ���� => ����� ���� �� ���� ���� (�̹���)  

<DDL> : Data Definition Language, ������ ���� 
 - ROLLBACK�� ����. (����ڰ� COMMMIT �� �ص� AUTOCOMMIT��) 
 - ex. ���̺� �߸� ����� ROLLBACK�� �ƴ϶� ����� �ٽ� ������.

1. ����
   CREATE TABLE table�� )
        �÷��� �������� [��������], ==> �������� (column ����) 
        �÷��� �������� [��������],
        �÷��� �������� [��������],
        �÷��� �������� [��������].
        [��������] ==> table ����
   )
   �� ���������� �־/��� ��. 
2. ��������
   1) ������ : CHAR, VARCHAR2, CLOB 
    - CHAR : byte ���� => 1~2000 byte. ���� �޸�. 
             ex) CHAR(10)='A'. ==> �� ���ڹۿ� �� ������ ���� �޸𸮶� ������ 10Byte ����Ѵ�. 
               ===============
               A \0 \0 \0 \0    => ���ڼ��� ������ �� ����ϸ� ���ϴ�. (ex. Y/N, ����/����, �ֹι�ȣ..)  
               ===============
    - VARCHAR2 : byte ���� => 1~4000 byte. ���� �޸�. 
                 ex) VARCHAR2(5) ==> 'A' ���� �� 
                 ===
                  A 
                 ===
    - CLOB : byte ����. => 4G ���� ����. ���� �޸�. ==> �ڱ�Ұ�, ����, �ٰŸ� ���� CLOB���� ����. 
    
    - CLOB
   2) ������ : NUMBER : ����, �Ǽ�
    - NUMBER : 14�ڸ� ����
    - NUMBER(4) : 4�ڸ� �������� ���. 0~9999
    - NUMBER(7,2) : �� �ڸ����� 7�ڸ� => �� �� 2�ڸ��� �Ǽ�. 
   3) ��¥�� 
    - DATE : ��¥ => �ڹ��������� ����ȴ١� ==> '2020/02/07'�� ���� '' �ٿ��� ����.
      �Ϲ������� ���� ���ȴ�. 
    - TIMESTAMP : �����͸� �����ϱ� ���� ���� ��� [  
   4) ��Ÿ�� : �̹���, ������� ,������ => ���� => ��θ�� ���ϸ� ���� => 4G�� ���� ����. 
    - �������� : BFILE
    - Binary ���� : BLOB 
3. ��������
    1) PRIMARY KEY : �ߺ��� ���� ��. NULL���� ������� �ʴ´�. UNIQUE�� NOT NULL�� ������ ��. 
    2) UNIQUE : �ߺ��� ���� ��. �׷��� NULL���� ����Ѵ�. => '�ĺ�Ű'��� �Ҹ���. 
    3) NOT NULL : �ݵ�� �Է°��� ����. 
       ex) ȸ�����Խ� '*'�� �κ��� �ʼ� �Է»����Դϴ�.
    4) FOREIGN KEY : ����Ű. ���� �� ���. 
       ex1) PRIMARY�� �����ϴ� ���� ������ �� 
       �Խ��� ==> ��� : �Խ����� ��ȣ�� ����
       ���� ==> ȸ�������� ID�� ����.
    5) CHECK ==> ���ϴ� �����͸� �Էµǰ� �ϴ� ��
       ex) ���� : CHECK(sex IN('����','����'))
       ex) �޺��ڽ�UI/������ư ������ ���� �� 
    6) DEFAULT ==> ���� ���� ��� ������ ���� �������. 
       ex) ��¥ ��� �� ����Ʈ���� SYSDATE��...
4. �߰�, ���� (ALTER)
    1) �߰� ADD
       ALTER TABLE table�� ADD �÷��� �������� [��������] ==> �������� 
       (�� ���������� �� ��, NOT NULL, FOREIGN KEY, CHECK�� ����ִ°� �Ұ����� ���� ����. 
           ���� ��� �̹� ���� �����Ͱ� �ִ� ���¿����� ���������� �� �ɸ� ���� �ִ�...) 
    2) ���� MODIFY 
       ALTER TABLE table�� MODIFY �÷� �������� 
                                 ==== �ݵ�� ���̺� �����ϴ� �÷�
    3) ���� DROP
       ALTER TABLE table�� DROP COLUMN �÷��� 
        
5. ���� (���̺� ����)
    DROP TABLE table�� 
    
6. ���̺�, �÷����� ���� 
    RENAME TABLE '�������̺��' TO '�������̺��' 

    ==> ���̺� ���� 
    1) ����� ����
    2) ���� ���̺� ���� 
*/

-- ���� ���̺� ���� (CATS) 
CREATE TABLE myEmp
AS SELECT empno,ename,job,hiredate,sal,deptno FROM emp;
SELECT * FROM myEmp;
DROP TABLE myEmp;

-- ���̺��� ���� �ϸ� ���������� ������� ������, ���������� üũ�ؾ��Ѵ�!  
-- ==> ���纸�� VIEW�� ���°� �� ����. (Ư��, read-only�϶�!) 
CREATE TABLE myEmp
AS SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno 
AND sal BETWEEN losal AND hisal;

SELECT * FROM myEmp;
DESC myEmp;
DESC emp;

DROP TABLE myEMP;
-- �Ժη� DROP ���� ����! ROLLBACK�� �� ��!

DROP TABLE member;
--ex) ����� ���� ���̺� ����
-- ����(2/6) ���� ȸ������ �� ������� �ʿ��� ���̺� �����
CREATE TABLE member(
    id VARCHAR2(20) PRIMARY KEY, --PRIMARY KEY : �ߺ����x & NOT NULL
    name VARCHAR2(51) NOT NULL,
    pwd VARCHAR2(20) NOT NULL,--�� ������: 1���ڿ� 1byte. �ѱ� : 1���ڿ� 2~3byte.
    phone VARCHAR2(13), 
    hp VARCHAR2(13),
    email VARCHAR2(100) UNIQUE, --UNIQUE : �ߺ����O & NOT NULL 
    --email�� �ĺ�Ű: id �ؾ�񸮸� �̸��Ϸ� ã�� �� ����
    info CHAR(12) CHECK(info IN ('�Ϲݱ��','�������')), --info: �Ҽ�����. 4���ڷ� �׻� ���ڼ� �Ȱ����ϱ� CHAR�� �������. 
    post VARCHAR2(7) NOT NULL,
    addr1 VARCHAR2(500) NOT NULL,
    addr2 VARCHAR2(100),
    regdate DATE DEFAULT SYSDATE
);
DESC member;

/*
<�Խ���>
�Խù���ȣ
�̸�
�̸���
����
����
��й�ȣ
�ۼ���
��ȸ��
*/
--ex) �Խ��� ���̺� ����� (���̺��: board) 
CREATE TABLE board2(
    boardno NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100),
    title VARCHAR2(50) NOT NULL,
    content CLOB NOT NULL,
    pwd VARCHAR2(50) NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0
);
DESC board2;

--ex) ���� ���� �������� ����� (���̺��: food)
CREATE TABLE food(
    restno NUMBER PRIMARY KEY,
    img VARCHAR2(200),
    addr1 VARCHAR2(100) NOT NULL,
    addr2 VARCHAR2(100) NOT NULL,
    tel VARCHAR2(100) NOT NULL,
    category VARCHAR2(100),
    price VARCHAR2(100),
    parking VARCHAR2(100),
    ophr VARCHAR2(100),
    resthr VARCHAR2(100),
    lastorder VARCHAR2(100),
    website VARCHAR2(200),
    holiday VARCHAR2(100),
    menu VARCHAR2(100),    
    regdate DATE DEFAULT SYSDATE
);
DESC food;





