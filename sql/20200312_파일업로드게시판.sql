--2020.03.12(��) 
--���Ͼ��ε�,�ٿ�ε� �Խ���
--pageContext�� Ȱ����� �˱� 
CREATE TABLE fileBoard(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT fb_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT fb_subject_nn NOT NULL,
    content CLOB CONSTRAINT fb_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT fb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    filename VARCHAR2(260), --window�� ��ΰ� 260�� �����̴�. 
    filesize NUMBER DEFAULT 0,
    CONSTRAINT fb_no_pk PRIMARY KEY(no)
); 

CREATE SEQUENCE fb_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;

-- ������ ���� : ����Ʈ �ִ� ����� �� �� �ʿ� ���� 
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'ȫ�浿','���� ���ε� ����','���� ���ε� ����','1234','');
COMMIT;

SELECT * FROM fileBoard;











