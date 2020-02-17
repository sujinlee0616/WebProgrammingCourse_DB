-- 2020-02-17 (월) Music Project2 댓글 만들기
-- ============================================= MUSIC PROJECT ============================================= 
DESC music_reply;
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE mr_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;

INSERT INTO music_reply VALUES(mr_no_seq.nextval, 1, 'hong', '홍길동', '음악 댓글 달기',SYSDATE);
INSERT INTO music_reply VALUES(mr_no_seq.nextval, 1, 'shim', '심청이', '음악 댓글 달기 2번째',SYSDATE);
COMMIT; --반드시 커밋해야 저장됨!!
SELECT * FROM music_reply;

DESC music_member;
--스칼라 서브쿼리 
SELECT no,id,name,msg,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS'),(SELECT sex FROM music_member mm WHERE mm.id=mr.id) FROM music_reply mr;


-- ============================================= 오후 수업 ============================================= 
-- 클릭할 때마다 조회수 올리고, 조회수 기반으로 인기순위 출력하기. 
ALTER TABLE music_genie ADD hit NUMBER DEFAULT 0; --ALTER: 오토커밋 
--DDL: 오토커밋(O)
--DML: 오토커밋(X)
SELECT * FROM music_genie ORDER BY rank ASC;

--ex) 조회수 Top5 가져오기 
-- 이렇게 하면 안 됨! 테이블은 rownum이 이미 지정되어 있기 때문. 
SELECT title,rownum,hit
FROM music_genie
WHERE rownum<=5
ORDER BY hit DESC;
-- 이렇게 해야! (인라인뷰) 
SELECT title,rownum,hit
FROM (SELECT title,hit FROM music_genie ORDER BY hit DESC)
WHERE rownum<=5;
--참고) rownum: 오라클 자체적으로 지원함. 행 번호. 
--FROM 뒤에는 테이블명만 올 수 있는 것이 아니라, SELECT문장과 VIEW도 올 수 있다. 
--순위 결정 => SELECT 

SELECT title,rownum,hit,no
FROM (SELECT title,hit,poster,RANK() OVER(ORDER BY hit DESC) as no FROM music_genie ORDER BY hit DESC)
WHERE rownum<=5;


-- ============================================= MOVIE PROJECT ============================================= 
DESC movie;
DROP TABLE movie; --이전에 만들어놨던 테이블 삭제 
CREATE TABLE movie( --movie 테이블 새로 만든다 
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



-- ============================================= 복습 ============================================= 
/*
<DDL>
 ===================> 생성 CREATE  ==> auto commit
 - TABLE ==> CREATE TABLE 테이블명 ==> ALTER 사용 가능
 - VIEW ==> CREATE OR REPLACE VIEW 뷰명
 - SEQUENCE ==> CREAE SEQUENCE 시퀀스명  ==> ALTER 사용 가능
 - INDEX ==> CREATE INDEX 인덱스명 ==> ALTER 사용 가능
 - PROCEDURE ==> CREATE OR REPLACE PROCEDURE 프로시저명
 - FUNCTION ==> CREATE OR REPLACE FUNCTION 함수명
 - TRIGGER ==> CREATE OR REPLACE TRIGGER 트리거명
 - 아래 3개는 ALTER가 없다!

<ALTER>
1. ADD
    ALTER TABLE table명 ADD 컬럼명 데이터형 [제약조건], DEFAULT
                           =====       ==========
                    존재하지 않는 컬럼명    NOT NULL
                                        FOREIGN KEY 
                                        
2. MODIFY
    ALTER TABLE table명 MODIFY 컬럼명 데이터형 [제약조건]
                               ==== 테이블에 존재하는 컬럼명 
3. DROP
    ALTER TABLE table명 DROP COLUMN 컬럼명
                             =====
4. TRUNCATE
    TRUNCATE table명
5. RENAME
    RENAME old_table명 TO new_table명
    *** ALTER TABLE table명 RENAME COLUMN old_column TO new_column    
*/

CREATE TABLE theater(
    tno NUMBER,
    name VARCHAR2(30),
    loc VARCHAR2(30),
    CONSTRAINT theater_tn_pk PRIMARY KEY(tno)
);
ALTER TABLE theater RENAME COLUMN loc TO location;

INSERT INTO theater VALUES(1,'CGV','강남');
INSERT INTO theater VALUES(2,'메가박스','신촌');
INSERT INTO theater VALUES(3,'롯데시네마','신림');
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
ALTER TABLE myMovie ADD director VARCHAR2(100) CONSTRAINT mm_director_nn NOT NULL; --불가능.  
-- 이미 데이터가 들어간 후에 NOT NULL 설정하면 안 됨. 
ALTER TABLE myMovie ADD tno NUMBER CONSTRAINT mm_tno_fk FOREIGN KEY(tno) REFERENCES theater(tno);

/*
<제약조건>
1. NOT NULL: 반드시 입력하게 만들어야 ==> js에서 alert();
2. UNIQUE: 중복X. NULL값 허용O. ==> 후보키. ex) 이메일,전화번호 인증 등. 
3. PRIMARY KEY: NOT NULL + UNIQUE. ==> 테이블마다 반드시 한 개 이상이 존재해야 한다. ==> 숫자 ==> 시퀀스 혹은 max+1 사용. 
4. FORIEGN KEY: 참조키. => 반드시 참조하는 테이블의 컬럼값을 가지고 있어야 한다. 
                 => 삭제 (하위 삭제 => 상위 삭제. 상위를 삭제하고 싶다면 먼저 하위를 삭제해야 한다.) 
5. CHECK: 미리 지정한 데이터만 추가 가능. 
기타) DEFAULT: 등록일, 조회수 등...
    
==> 별도로 추가 
    ALTER TABLE table명 ADD CONSTRAINT 명칭 제약조건 => UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK
                        ====
                        MODIFY ==> NOT NULL일 때 처리 
*/

-- 오라클에 저장될 때, 컬럼명과 테이블명은 모두 전체가 대문자로 저장된다. 
DROP TABLE myEmp;
CREATE TABLE myEmp(
    empno NUMBER,
    ename VARCHAR2(20)
);
-- 제약조건 추가
ALTER TABLE myEmp ADD CONSTRAINT me_empno_pk PRIMARY KEY(empno);
-- 제약조건 추가
ALTER TABLE myEmp MODIFY ename CONSTRAINT me_ename_nn NOT NULL;
DESC myEmp;
-- 제약조건 삭제 
ALTER TABLE myEmp DROP CONSTRAINT me_ename_nn; --제약조건 삭제 
DESC myEmp;

/* 
SEQUENCE: 자동증가번호
 => CREATE SEQUENCE seq명  
    1) start with: 어떤 숫자부터 시작할건지
    2) increment by: 몇씩 증가할건지 
    3) cycle|nocycle: 
        - cycle: start with 숫자부터 시작해서 max값까지 올라가면 최소값으로 돌아와서 다시 증가한다. 
        - nocycle: start with 숫자부터 시작해서 max값까지 가면 숫자 증가 멈춘다. 
    4) cache|nocache
        - cache: 메모리에 시퀀스 값을 미리 할당. 이게 디폴트임. 
        - nocache: 메모리에 시퀀스 값 미리 할당X. 
 => 값을 가지고 올 때 
    현재값: currval
    다음값: nextval
    주의) table과 시퀀스는 별도!
 => DROP SEQUENCE seq명 
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
SELECT my_no_seq.nextval FROM DUAL; --Error. maxvalue값인 100을 넘으면 안 되기 때문. 
--만약 cycle이었다면 minvalue인 1로 돌아갔을 것이다. 
--만약 maxvalue,minvalue없고 nocycle이면 계~~속 증가할 것이다. 

DROP SEQUENCE my_no_seq; --시퀀스 삭제 







