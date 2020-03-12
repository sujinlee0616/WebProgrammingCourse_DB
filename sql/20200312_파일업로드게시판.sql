--2020.03.12(목) 
--파일업로드,다운로드 게시판
--pageContext의 활용법을 알기 
CREATE TABLE fileBoard(
    no NUMBER,
    name VARCHAR2(34) CONSTRAINT fb_name_nn NOT NULL,
    subject VARCHAR2(1000) CONSTRAINT fb_subject_nn NOT NULL,
    content CLOB CONSTRAINT fb_content_nn NOT NULL,
    pwd VARCHAR2(10) CONSTRAINT fb_pwd_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0,
    filename VARCHAR2(260), --window는 경로가 260자 이하이다. 
    filesize NUMBER DEFAULT 0,
    CONSTRAINT fb_no_pk PRIMARY KEY(no)
); 

CREATE SEQUENCE fb_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;

-- 데이터 삽입 : 디폴트 있는 놈들은 값 줄 필요 없음 
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
INSERT INTO fileBoard(no, name, subject, content, pwd, filename) VALUES(fb_no_seq.nextval,'홍길동','파일 업로드 예제','파일 업로드 예제','1234','');
COMMIT;

SELECT * FROM fileBoard;











