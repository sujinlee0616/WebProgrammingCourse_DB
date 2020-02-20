--2020.02.20 (��) 
--<�����÷���Ʈ �����>

--ī�װ� ���̺�
CREATE TABLE category(
    cateno NUMBER,
    title VARCHAR2(200) CONSTRAINT cate_title_nn NOT NULL,
    subject VARCHAR2(200) CONSTRAINT cate_subject_nn NOT NULL,
    poster VARCHAR2(200) CONSTRAINT cate_poster_nn NOT NULL,
    link VARCHAR2(200) CONSTRAINT cate_link_nn NOT NULL,
    CONSTRAINT cate_no_pk PRIMARY KEY(cateno)
);

--foodhouse(����) ���̺�
CREATE TABLE foodhouse(
    no NUMBER, --PK
    cno NUMBER, --FK: category ���̺��� cateno ����
    title VARCHAR2(200) CONSTRAINT fh_title_nn NOT NULL,
    score NUMBER(2,1) CONSTRAINT fh_score_nn NOT NULL,
    address VARCHAR2(200) CONSTRAINT fh_addr_nn NOT NULL,
    tel VARCHAR2(30) CONSTRAINT fh_tel_nn NOT NULL, 
    type VARCHAR2(100) CONSTRAINT fh_type_nn NOT NULL,
    price VARCHAR2(100),
    parking VARCHAR2(100),
    time VARCHAR2(100),
    image VARCHAR2(2000) CONSTRAINT fh_image_nn NOT NULL,
    good NUMBER, --���ִ� �� 
    soso NUMBER, --������ ��
    bad NUMBER, --���� ��
    tag VARCHAR2(2000),
    CONSTRAINT fh_no_pk PRIMARY KEY(no),
    CONSTRAINT fh_cn_fk FOREIGN KEY(cno)
    REFERENCES category(cateno)
);

--����� ���̺��� ���� ������. 
CREATE SEQUENCE foodhouse_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
DESC foodhouse;
SELECT * FROM category;

--������ �߸� �־ ���̺� ����� �ٽ� ����� �� �Ф�
DROP TABLE foodhouse;
DROP TABLE category;
DROP SEQUENCE foodhouse_no_seq;

SELECT * FROM category;
SELECT * FROM foodhouse;
DESC foodhouse;

ALTER TABLE foodhouse DROP COLUMN parking;
ALTER TABLE foodhouse DROP COLUMN time;















