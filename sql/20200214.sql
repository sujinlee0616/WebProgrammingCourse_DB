--2020-02-14 DML

/*
<DML>

1. SELECT 
����) 
    SELECT *|�÷�1,�÷�2,...
    FROM table�� (SELECT, VIEW~) 
    [
        WHERE ���ǹ�
        GROUP BY �÷���(�Լ�)
        HAVING ���ǹ�(�׷�)
        ORDER BY �÷��� (ASC|DESC) 
    ]

2. INSERT 
����) 
 1) �ʿ��� �÷��� ��� (DEFAULT�� �����ϴ� ���) 
 2) ��ü �÷� ����
    INSERT INTO table�� VALUES(��1, ��2, ...) 

3. UPDATE
����) 
    UPDATE table�� SET
    �÷���=��,�÷���=��,
    WHERE ���ǹ�
    
4. DELETE 
����)
    DELETE FROM table��
    WHERE ���ǹ� 

*/

/*
<DDL> => �÷� ����
1. CREATE: table, VIEW, SEQUENCE, INDEX, FUNCTION, PROCEDURE, TRIGGER
 - table: �������, VIEW: �������̺�, SEQUENCE: �ڵ� ������ȣ, INDDEXL: ã��(ORDER BY), PROCEDURE: �Լ�(������)or �Լ�(�������� ����), TRIGGER: �ڵ� �̺�Ʈ ó��
  
 ����) CREATE(
    �÷��� ������Ÿ�� [CONSTRAINTS �������Ǹ� ��������]
 );
 �ɼ�) 
 1) NOT NULL
 2) PRIMARY KEY: UNIQUE + NOT NULL. �ߺ����X. NULL���X. 
 3) FOREIGN KEY: ���� Ű. ���� �� ���. 
 4) UNIQUE: �ߺ����X. NULL���O. 
 5) CHECK: �־��� ������ �������� ���� ����. 
 6) DEFAULT: ���� �� �ص� ����Ʈ���� ��. 

2. ALTER
 1) ADD: �߰� 
 ����) ALTER TABLE ADD �÷���; 
 2) MODIFY: ���� 
 ����) MODIFY TABLE 
 3) DROP: ���� 
 ����) 

3. DROP
 - ���̺� ���� ����
 ����) DROP TABLE table��;

4. TRUNCATE 
 - �����͸� ����. ���̺� �����͸� ����� ���̺� ����(����)�� ���ܵд�. 
 ����) TRUNCATE TABLE table��;
 
5. RENAME
 - 
 ����) RENMAE '���� ���̺��' TO '�� ���̺��';

*/

/* 
<SEQUENCE>

*/

--3. �� ���̺� ����
CREATE TABLE music_reply(
    no NUMBER,
    mno NUMBER,
    id VARCHAR2(20),
    name VARCHAR2(51) CONSTRAINT mr_name_nn NOT NULL,
    msg CLOB CONSTRAINT mr_msg_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    CONSTRAINT mr_no_pk PRIMARY KEY(no),
    CONSTRAINT mr_mno_fk FOREIGN KEY(mno)
    REFERENCES music_genie(mno),
    CONSTRAINT mr_id_fk FOREIGN KEY(id)
    REFERENCES music_member(id)
);
--2. ���� ���̺� ������ �ϴµ� �̰� ��� �� ��������ϱ� �̰� ����
ALTER TABLE music_genie ADD CONSTRAINT mg_mno_pk PRIMARY KEY(mno);

--1. �� ���̺� ����
CREATE TABLE music_member(
    id VARCHAR2(20),
    name VARCHAR2(51)CONSTRAINT mm_name_nn NOT NULL,
    sex VARCHAR2(10),    
    CONSTRAINT mm_no_pk PRIMARY KEY(id),
    CONSTRAINT mm_sex_ck CHECK(sex IN('����','����'))
);

--4. ������ �����. 
CREATE SEQUENCE mr_no_sequence 
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
    
INSERT INTO music_member VALUES('hong','ȫ�浿', '����');
INSERT INTO music_member VALUES('shim','��û��', '����');
INSERT INTO music_member VALUES('park','�ڹ���', '����');
INSERT INTO music_member VALUES('kim','�����', '����');
INSERT INTO music_member VALUES('lee','�̼���', '����');
COMMIT; 
ALTER TABLE music_member ADD pwd VARCHAR2(10) DEFAULT '1234';
SELECT * FROM music_member;

--����: ���� ���� ��� ����.

DESC music_reply;











