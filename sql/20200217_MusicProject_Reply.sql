-- 2020-02-17 (��) Music Project2 ��� �����
-- ============================================= MUSIC PROJECT ============================================= 
DESC music_reply;
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE mr_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;

INSERT INTO music_reply VALUES(mr_no_seq.nextval, 1, 'hong', 'ȫ�浿', '���� ��� �ޱ�',SYSDATE);
INSERT INTO music_reply VALUES(mr_no_seq.nextval, 1, 'shim', '��û��', '���� ��� �ޱ� 2��°',SYSDATE);
COMMIT; --�ݵ�� Ŀ���ؾ� �����!!
SELECT * FROM music_reply;

DESC music_member;
--��Į�� �������� 
SELECT no,id,name,msg,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS'),(SELECT sex FROM music_member mm WHERE mm.id=mr.id) FROM music_reply mr;


-- ============================================= ���� ���� ============================================= 
-- Ŭ���� ������ ��ȸ�� �ø���, ��ȸ�� ������� �α���� ����ϱ�. 
ALTER TABLE music_genie ADD hit NUMBER DEFAULT 0; --ALTER: ����Ŀ�� 
--DDL: ����Ŀ��(O)
--DML: ����Ŀ��(X)
SELECT * FROM music_genie ORDER BY rank ASC;

--ex) ��ȸ�� Top5 �������� 
-- �̷��� �ϸ� �� ��! ���̺��� rownum�� �̹� �����Ǿ� �ֱ� ����. 
SELECT title,rownum,hit
FROM music_genie
WHERE rownum<=5
ORDER BY hit DESC;
-- �̷��� �ؾ�! (�ζ��κ�) 
SELECT title,rownum,hit
FROM (SELECT title,hit FROM music_genie ORDER BY hit DESC)
WHERE rownum<=5;
--����) rownum: ����Ŭ ��ü������ ������. �� ��ȣ. 
--FROM �ڿ��� ���̺�� �� �� �ִ� ���� �ƴ϶�, SELECT����� VIEW�� �� �� �ִ�. 
--���� ���� => SELECT 

SELECT title,rownum,hit,no
FROM (SELECT title,hit,poster,RANK() OVER(ORDER BY hit DESC) as no FROM music_genie ORDER BY hit DESC)
WHERE rownum<=5;


-- ============================================= MOVIE PROJECT ============================================= 
DESC movie;
DROP TABLE movie; --������ �������� ���̺� ���� 
CREATE TABLE movie( --movie ���̺� ���� ����� 
MNO         NUMBER(4),      
TITLE       VARCHAR2(1000) CONSTRAINT movie_title_nn NOT NULL, 
POSTER      VARCHAR2(1000) CONSTRAINT movie_poster_nn NOT NULL, 
SCORE       NUMBER(4,2),    
GENRE       VARCHAR2(100) CONSTRAINT movie_genre_nn NOT NULL,  
REGDATE     VARCHAR2(100),  
TIME        VARCHAR2(10), 
GRADE       VARCHAR2(100),
DIRECTOR    VARCHAR2(200),
ACTOR       VARCHAR2(200),
STORY       CLOB,    
TYPE        NUMBER,
CONSTRAINT  movie_mno_pk PRIMARY KEY(mno), 
CONSTRAINT movie_type_ck CHECK(type IN(1,2,3,4,5))
);



-- ============================================= ���� ============================================= 
/*
<DDL>
 ===================> ���� CREATE  ==> auto commit
 - TABLE ==> CREATE TABLE ���̺�� ==> ALTER ��� ����
 - VIEW ==> CREATE OR REPLACE VIEW ���
 - SEQUENCE ==> CREAE SEQUENCE ��������  ==> ALTER ��� ����
 - INDEX ==> CREATE INDEX �ε����� ==> ALTER ��� ����
 - PROCEDURE ==> CREATE OR REPLACE PROCEDURE ���ν�����
 - FUNCTION ==> CREATE OR REPLACE FUNCTION �Լ���
 - TRIGGER ==> CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
 - �Ʒ� 3���� ALTER�� ����!

<ALTER>
1. ADD
    ALTER TABLE table�� ADD �÷��� �������� [��������], DEFAULT
                           =====       ==========
                    �������� �ʴ� �÷���    NOT NULL
                                        FOREIGN KEY 
                                        
2. MODIFY
    ALTER TABLE table�� MODIFY �÷��� �������� [��������]
                               ==== ���̺� �����ϴ� �÷��� 
3. DROP
    ALTER TABLE table�� DROP COLUMN �÷���
                             =====
4. TRUNCATE
    TRUNCATE table��
5. RENAME
    RENAME old_table�� TO new_table��
    *** ALTER TABLE table�� RENAME COLUMN old_column TO new_column    
*/

CREATE TABLE theater(
    tno NUMBER,
    name VARCHAR2(30),
    loc VARCHAR2(30),
    CONSTRAINT theater_tn_pk PRIMARY KEY(tno)
);
ALTER TABLE theater RENAME COLUMN loc TO location;

INSERT INTO theater VALUES(1,'CGV','����');
INSERT INTO theater VALUES(2,'�ް��ڽ�','����');
INSERT INTO theater VALUES(3,'�Ե��ó׸�','�Ÿ�');
COMMIT;
SELECT * FROM theater;

CREATE TABLE myMovie(
    mno NUMBER,
    title VARCHAR2(100),
    CONSTRAINT mm_mno_pk PRIMARY KEY(mno)
);
INSERT INTO myMovie VALUES(1,'aaa');
INSERT INTO myMovie VALUES(2,'bbb');
INSERT INTO myMovie VALUES(3,'ccc');
COMMIT;
SELECT * FROM myMovie;
ALTER TABLE myMovie ADD director VARCHAR2(100) CONSTRAINT mm_director_nn NOT NULL; --�Ұ���.  
-- �̹� �����Ͱ� �� �Ŀ� NOT NULL �����ϸ� �� ��. 
ALTER TABLE myMovie ADD tno NUMBER CONSTRAINT mm_tno_fk FOREIGN KEY(tno) REFERENCES theater(tno);

/*
<��������>
1. NOT NULL: �ݵ�� �Է��ϰ� ������ ==> js���� alert();
2. UNIQUE: �ߺ�X. NULL�� ���O. ==> �ĺ�Ű. ex) �̸���,��ȭ��ȣ ���� ��. 
3. PRIMARY KEY: NOT NULL + UNIQUE. ==> ���̺��� �ݵ�� �� �� �̻��� �����ؾ� �Ѵ�. ==> ���� ==> ������ Ȥ�� max+1 ���. 
4. FORIEGN KEY: ����Ű. => �ݵ�� �����ϴ� ���̺��� �÷����� ������ �־�� �Ѵ�. 
                 => ���� (���� ���� => ���� ����. ������ �����ϰ� �ʹٸ� ���� ������ �����ؾ� �Ѵ�.) 
5. CHECK: �̸� ������ �����͸� �߰� ����. 
��Ÿ) DEFAULT: �����, ��ȸ�� ��...
    
==> ������ �߰� 
    ALTER TABLE table�� ADD CONSTRAINT ��Ī �������� => UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK
                        ====
                        MODIFY ==> NOT NULL�� �� ó�� 
*/

-- ����Ŭ�� ����� ��, �÷���� ���̺���� ��� ��ü�� �빮�ڷ� ����ȴ�. 
DROP TABLE myEmp;
CREATE TABLE myEmp(
    empno NUMBER,
    ename VARCHAR2(20)
);
-- �������� �߰�
ALTER TABLE myEmp ADD CONSTRAINT me_empno_pk PRIMARY KEY(empno);
-- �������� �߰�
ALTER TABLE myEmp MODIFY ename CONSTRAINT me_ename_nn NOT NULL;
DESC myEmp;
-- �������� ���� 
ALTER TABLE myEmp DROP CONSTRAINT me_ename_nn; --�������� ���� 
DESC myEmp;

/* 
SEQUENCE: �ڵ�������ȣ
 => CREATE SEQUENCE seq��  
    1) start with: � ���ں��� �����Ұ���
    2) increment by: � �����Ұ��� 
    3) cycle|nocycle: 
        - cycle: start with ���ں��� �����ؼ� max������ �ö󰡸� �ּҰ����� ���ƿͼ� �ٽ� �����Ѵ�. 
        - nocycle: start with ���ں��� �����ؼ� max������ ���� ���� ���� �����. 
    4) cache|nocache
        - cache: �޸𸮿� ������ ���� �̸� �Ҵ�. �̰� ����Ʈ��. 
        - nocache: �޸𸮿� ������ �� �̸� �Ҵ�X. 
 => ���� ������ �� �� 
    ���簪: currval
    ������: nextval
    ����) table�� �������� ����!
 => DROP SEQUENCE seq�� 
*/

CREATE SEQUENCE my_no_seq 
    START WITH 1
    INCREMENT BY 10
    NOCYCLE
    NOCACHE
    MAXVALUE 100
    MINVALUE 1;

SELECT my_no_seq.nextval FROM DUAL; --1
SELECT my_no_seq.currval FROM DUAL; --1
SELECT my_no_seq.nextval FROM DUAL; --11
SELECT my_no_seq.nextval FROM DUAL; --21
SELECT my_no_seq.nextval FROM DUAL; --31
SELECT my_no_seq.nextval FROM DUAL; --41
SELECT my_no_seq.nextval FROM DUAL; --51
SELECT my_no_seq.nextval FROM DUAL; --61
SELECT my_no_seq.nextval FROM DUAL; --71
SELECT my_no_seq.nextval FROM DUAL; --81
SELECT my_no_seq.nextval FROM DUAL; --91
SELECT my_no_seq.nextval FROM DUAL; --Error. maxvalue���� 100�� ������ �� �Ǳ� ����. 
--���� cycle�̾��ٸ� minvalue�� 1�� ���ư��� ���̴�. 
--���� maxvalue,minvalue���� nocycle�̸� ��~~�� ������ ���̴�. 

DROP SEQUENCE my_no_seq; --������ ���� 







