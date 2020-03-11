--2020.03.10(ȭ) ����: �亯�� �Խ��� �����

CREATE TABLE replyBoard(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT rb_name_nn NOT NULL,
    subject VARCHAR2(2000) CONSTRAINT rb_sub_nn NOT NULL,
    content CLOB CONSTRAINT rb_cont_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT rb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    group_id NUMBER,
    group_step NUMBER DEFAULT 0,
    group_tab NUMBER DEFAULT 0,
    root NUMBER DEFAULT 0,
    depth NUMBER DEFAULT 0,
    CONSTRAINT rb_no_pk PRIMARY KEY(no)
);

--seq ����ؼ� �ڵ�������ȣ ����
CREATE SEQUENCE rb_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 1
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 2
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 3
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 4
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 5
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 6
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 7
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 8
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 9
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 10
);

INSERT INTO replyBoard(no,name,subject,content,pwd,group_id) VALUES(
    rb_no_seq.nextval, 'ȫ�浿', '�亯�� �Խ��� �����', 'Request, Respone ��ü Ȱ��', '1234', 11
);
COMMIT; 

SELECT * FROM replyBoard;

-- 12�� �Խù�: 11���� ���� ��� 
INSERT INTO replyBoard(no,name,subject,content,pwd,group_id, group_step, group_tab, root) VALUES(
    rb_no_seq.nextval, '��û��', '�亯�Դϴ�', 'Request, Respone ��ü Ȱ��', '1234', 11, 1, 1, 11  
);
-- 13�� �Խù�: 12���� ���� ��� (=11���� ���� ����� ���) 
INSERT INTO replyBoard(no,name,subject,content,pwd,group_id, group_step, group_tab, root) VALUES(
    rb_no_seq.nextval, '��û��', '�亯�Դϴ�', 'Request, Respone ��ü Ȱ��', '1234', 11, 2, 2, 12  
);

-- 14�� �Խù� : 10���� ���� ��� 
INSERT INTO replyBoard(no,name,subject,content,pwd,group_id, group_step, group_tab, root) VALUES(
    rb_no_seq.nextval, '��û��', '�亯�Դϴ�', 'Request, Respone ��ü Ȱ��', '1234', 10, 1, 1, 10 
);

COMMIT;
SELECT * FROM replyBoard;
SELECT * FROM replyBoard
ORDER BY group_id DESC, group_step ASC;





