-- 2020-02-11 
/* 
<DDL> : ���� ��� ���� ���� 
1. CREATE: ���̺� ���� 
 1) ����
  - table, column => 30byte (10���� ����) 
    CREATE TABLE table��(
        �÷��� �������� [��������(������ ������ ����)], => NOT NULL, DEFAULT
        �÷��� �������� [��������(������ ������ ����)],
        �÷��� �������� [��������(������ ������ ����)],
        [��������], => PRIMARY, FOREIGN, CHECK, UNIQUE
        [��������] ....
    )
 2) �������� 
  - ����ȭ�� ������ => �ʿ��� �����͸� ����, �̻������� ����. (ex. ����/���� �� ���� �߻��ϴ� �� ����) 
  (1) NOT NULL: NULL�� ���X.
  (2) UNIQUE: �ߺ��� ������� ����. (NULL�� �����.)
      ex) ��ȭ��ȣ, �̸��� ==> �ĺ�Ű.
  (3) PRIMARY KEY: NOT NULL + UNIQUE
      - �⺻ Ű. ��� ���̺��� �� ���� PK�� ������. 
      - ������ ���Ἲ�� ��Ģ. 
  (4) FOREIGN KEY: 
      - �����ͺ��̽� => �л�(����ȭ) => ����Ű 
      - ex) ������� �μ����� �ٹ������� ������� => ���� ����
  (5) CHECK 
      - ������ �����͸� ������ �� �ְ� �Ѵ�.
      - ex) �μ���, ����, �ٹ���     
  (6) DEFAULT
      - ���� �Է��� �� �� ��� ����Ʈ���� �ڵ����� ���� �Ѵ�. 
      - ex) �Խ��ǿ��� ��ȸ�� ����Ʈ�� 0
 3) �������� ==> �ڹٿ� ����
   - step1. ����Ŭ ���̺� ���� Ȯ��: DESC table��
     ex) =============================================
            id      pwd     name    addr    tel
         =============================================
            aa      1234    ȫ�浿   ����    111-1111    ===> VO 
         =============================================
            bb      1234    ��û��   ���    222-2222    ===> VO 
         =============================================
     
    [����Ŭ ��������]                   [�ڹ� ��������]
    ������: CHAR, VARCHAR2, CLOB ===> String  
    ������: NUMBER =================> int, double
    ��¥��: DATE, TIMESTAMP ========> java.util.Date (java.sql.Date)
                                     - ���� java.util.Date ���
                                     - ���ڿ� �������� ���� 
                                       ex) ���ó�¥(SYSDATE), �ٸ���¥ ('YY/MM/DD')  
    ��Ÿ��: BLOB, BFILE ============> java.io.InputStream 
     - BLOB(4G): �������Ϸ� ����
     - BFILE(4G): ���� ���� ���� 
       => ����, ������ �� ���� �� ���. 
 

2. ALTER: �÷� �߰�, ����, ����  
 1) ����
    ALTER TABLE table�� ADD �÷��� �������� [��������]
    ALTER TABLE table�� MODIFY �÷��� �������� [��������]
    ALTER TABLE table�� DROP COLUMN �÷���  <========= �÷��� �����ϰ� �ִ� ���̺��� �ִ� ��쿡�� �������� �ʴ´�. 

3. DROP: ���̺� ��ü�� ����
 - ���� : DROP TABLE table��
 
4. TRUNCATE: ���̺� ������ ���ΰ� �����͸� ����.
 - ����: TRUNCATE TABLE table��

5. RENMAE: ���̺��� �̸� ����
 - ���� : ALTER TABLE '���� table��' RENAME TO '�ٲ� table��' 

*/

/*
1. ���̺� TABLE
2. ���� ���� ��� VIEW
3. �ڵ� ���� ��ȣ SEQUENCE 
4. ����ȭ INDEX
5. PL/SQL
6. Ʃ��  
*/

/*
<DML>: ������ ����
1. INSERT: ��Ƽ�� ����
 - ����) 
   1. ���ϴ� �����͸� ���� => DEFAULT
      INSERT INTO table��(�÷�1,�÷�2,�÷�3,...) VALUES(��1,��2,��3..)
   2. ��ü�� �����ϴ� ���
      INSERT INTO table�� VALUES(��1,��2,....)
      => PRIMARY, NOT NULL, FOREIGN, CHECK
2. UPDATE: ������ ���� 
 - ����) 
   1. ��ü�� ���� => ������ ���� ����
      UPDATE table�� SET
      �÷���=�����Ұ�, �÷���=�����Ұ�, �÷Ÿ�=�����Ұ�, .....
   2. ���ϴ� �κи� ���� => ������ �ִ� ���� 
      UPDATE table�� SET
      �÷���=�����Ұ�, �÷���=�����Ұ�, �÷Ÿ�=�����Ұ�, .....
      WHERE �÷��� ������ ��

3. DELETE: ������ ���� 
 - ����) 
   1. ��ü ���� => ������ ���� ����
      DELETE FROM table�� 
      ====> TRUNCATE => COMMIT or ROLLBACK
   2. ���ϴ� �����͸� ���� => ������ �ִ� ���� 
      DELETE FROM table�� 
      WHERE �÷��� ������ ��(�ߺ��� ���� ������) 
*/

CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(30) CONSTRAINT st_name_nn NOT NULL,
    kor NUMBER CONSTRAINT st_kor_nn NOT NULL,
    eng NUMBER CONSTRAINT st_eng_nn NOT NULL,
    math NUMBER CONSTRAINT st_math_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT st_hakbun_pk PRIMARY KEY(hakbun)
);

-- ������ �߰� 
INSERT INTO student VALUES(1,'ȫ�浿',90,85,70); --Error. �÷����� �� ����. 6�� �־�� �ϴµ� 5���� �־ �׷�.
INSERT INTO student VALUES(1,'ȫ�浿',90,85,70,SYSDATE); --�������.
INSERT INTO student(hakbun,name,kor,eng,math) VALUES(2,'��û��',90,80,60); --�������
INSERT INTO student(hakbun,name,kor,eng,math) VALUES(3,'',90,80,60); --Error. name�� NN�ε� NULL�־. 

--������ ���� ���̺� ����� �ٽ� ����
DROP TABLE student;
CREATE TABLE student(
    hakbun NUMBER,
    name VARCHAR2(30) CONSTRAINT st_name_nn NOT NULL,
    kor NUMBER CONSTRAINT st_kor_nn NOT NULL,
    eng NUMBER CONSTRAINT st_eng_nn NOT NULL,
    math NUMBER CONSTRAINT st_math_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    sex VARCHAR2(10),
    CONSTRAINT st_hakbun_pk PRIMARY KEY(hakbun),
    CONSTRAINT st_sex_ck CHECK(sex IN('��','��'))
);

-- ������ �߰� 
INSERT INTO student VALUES(1,'ȫ�浿',90,85,70,SYSDATE,'����'); --Error. sex�� '��','��' �� �߿� �ϳ��� �����ϹǷ� '����' �� �� X.
INSERT INTO student VALUES(1,'ȫ�浿',90,85,70,SYSDATE,'��'); --�������.
INSERT INTO student(hakbun,name,kor,eng,math,sex) VALUES(2,'��û��',80,100,100,'��'); --�������
INSERT INTO student(hakbun,name,kor,eng,sex, math) VALUES(3,'�̼���',80,60,'��', 88); --�������: �տ��� �÷� ���� �ٲٸ� �ڿ� ���� �����͵� ���� �ٲٸ� ��. 
-- �׳� �ظ��ϸ� ���� �÷� ������� ������ ����־��.
COMMIT;
--COMMIT �� �ϸ� ���� �� ��. ����!

SELECT * FROM student;

--������ ����
UPDATE student SET 
kor=95, eng=90, math=80
WHERE name='ȫ�浿';

SELECT * FROM student;

--������ ����
UPDATE student SET 
math=88
WHERE hakbun=1;

SELECT * FROM student;
COMMIT;

--���� (��� ������ ����) 
DELETE FROM student; --��� ������ �� ������
ROLLBACK; --���� ��� 
SELECT * FROM student;

--���� (1�� �ุ ����) 
DELETE FROM student --���ǿ� �´� 1�� �ุ ������ 
WHERE hakbun=3;
SELECT * FROM student;
COMMIT;

--�ٽ� 3���� ����
INSERT INTO student(hakbun,name,kor,eng,sex, math) VALUES(3,'�̼���',80,60,'��', 88);
COMMIT;
SELECT * FROM student;

SELECT hakbun,name,kor,eng,math,RANK() OVER(ORDER BY (kor+eng+math) DESC) ���
FROM student;

SELECT hakbun,name,kor,eng,math,(kor+eng+math) total, RANK() OVER(ORDER BY (kor+eng+math) DESC) ���
FROM student;

SELECT hakbun,name,kor,eng,math,(kor+eng+math) AS total, RANK() OVER(ORDER BY (kor+eng+math) DESC) AS ���
FROM student;

SELECT hakbun,name,kor,eng,math,ROUND((kor+eng+math)/3,2) AS ���, RANK() OVER(ORDER BY (kor+eng+math) DESC) AS ���
FROM student;

-- ================================================ 3���� ================================================
-- �Խ����� ������. 
-- 1�������� 10�� ���. 
DROP TABLE board;

CREATE TABLE board(
    no NUMBER,
    name VARCHAR2(50) CONSTRAINT board_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT board_subject_nn NOT NULL,
    content CLOB CONSTRAINT board_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT board_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    CONSTRAINT board_no_pk PRIMARY KEY(no)
);
COMMIT;

INSERT INTO board(no,name,subject,content,pwd) VALUES (1,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (2,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (3,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (4,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (5,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (6,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (7,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (8,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (9,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (10,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (11,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
INSERT INTO board(no,name,subject,content,pwd) VALUES (12,'ȫ�浿','ó���ϴ� ���� �Խ���','�ڹ� ����.... �����Դϴ�.','1234');
COMMIT;

SELECT * FROM board;
--INSERT, UPDATE, DELETE�� ���� Java�� �Ѵ�. 

SELECT CEIL(COUNT(*)/10.0) FROM board;
SELECT * FROM board;






