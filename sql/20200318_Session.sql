--2020.03.18(수) Session

SELECT * FROM tab;
SELECT * FROM member;
DESC member;

DROP TABLE member;

CREATE TABLE member(
    id VARCHAR2(20),
    pwd VARCHAR2(10) CONSTRAINT m_pwd_nn NOT NULL,
    name VARCHAR2(34) CONSTRAINT m_name_nn NOT NULL,
    email VARCHAR2(100) ,
    sex VARCHAR2(10),
    birthday VARCHAR2(20) CONSTRAINT m_day_nn NOT NULL,
    post VARCHAR2(7) CONSTRAINT m_post_nn NOT NULL,
    addr1 VARCHAR2(200) CONSTRAINT m_addr1_nn NOT NULL,
    addr2 VARCHAR2(200),
    tel VARCHAR2(20),
    content CLOB CONSTRAINT m_cont_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    admin CHAR(1) DEFAULT 'n',
    CONSTRAINT m_id_pk PRIMARY KEY(id),
    CONSTRAINT m_email_uk UNIQUE(email),
    CONSTRAINT m_sex_ck CHECK(sex IN('남자','여자')),
    CONSTRAINT m_tel_uk UNIQUE(tel)
);

DESC member;

-- 후보키 

SELECT * FROM infoThema;
DELETE FROM infoThema;

