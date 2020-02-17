--2020-02-14 DML

/*
<DML>

1. SELECT 
형식) 
    SELECT *|컬럼1,컬럼2,...
    FROM table명 (SELECT, VIEW~) 
    [
        WHERE 조건문
        GROUP BY 컬럼명(함수)
        HAVING 조건문(그룹)
        ORDER BY 컬럼명 (ASC|DESC) 
    ]

2. INSERT 
형식) 
 1) 필요한 컬럼만 출력 (DEFAULT가 존재하는 경우) 
 2) 전체 컬럼 저장
    INSERT INTO table명 VALUES(값1, 값2, ...) 

3. UPDATE
형식) 
    UPDATE table명 SET
    컬럼명=값,컬럼명=값,
    WHERE 조건문
    
4. DELETE 
형식)
    DELETE FROM table명
    WHERE 조건문 

*/

/*
<DDL> => 컬럼 단위
1. CREATE: table, VIEW, SEQUENCE, INDEX, FUNCTION, PROCEDURE, TRIGGER
 - table: 저장장소, VIEW: 가상테이블, SEQUENCE: 자동 증가번호, INDDEXL: 찾기(ORDER BY), PROCEDURE: 함수(린턴형)or 함수(리턴형이 없는), TRIGGER: 자동 이벤트 처리
  
 형식) CREATE(
    컬럼명 데이터타입 [CONSTRAINTS 제한조건명 제한조건]
 );
 옵션) 
 1) NOT NULL
 2) PRIMARY KEY: UNIQUE + NOT NULL. 중복허용X. NULL허용X. 
 3) FOREIGN KEY: 참조 키. 참조 시 사용. 
 4) UNIQUE: 중복허용X. NULL허용O. 
 5) CHECK: 주어진 선택지 내에서만 선택 가능. 
 6) DEFAULT: 선택 안 해도 디폴트값을 줌. 

2. ALTER
 1) ADD: 추가 
 형식) ALTER TABLE ADD 컬럼명; 
 2) MODIFY: 수정 
 형식) MODIFY TABLE 
 3) DROP: 삭제 
 형식) 

3. DROP
 - 테이블 완전 삭제
 형식) DROP TABLE table명;

4. TRUNCATE 
 - 데이터만 삭제. 테이블 데이터만 지우고 테이블 형태(구조)는 남겨둔다. 
 형식) TRUNCATE TABLE table명;
 
5. RENAME
 - 
 형식) RENMAE '현재 테이블명' TO '새 테이블명';

*/

/* 
<SEQUENCE>

*/

--3. 이 테이블 생성
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
--2. 위의 테이블 만들어야 하는데 이거 없어서 안 만들어지니까 이거 수행
ALTER TABLE music_genie ADD CONSTRAINT mg_mno_pk PRIMARY KEY(mno);

--1. 이 테이블 생성
CREATE TABLE music_member(
    id VARCHAR2(20),
    name VARCHAR2(51)CONSTRAINT mm_name_nn NOT NULL,
    sex VARCHAR2(10),    
    CONSTRAINT mm_no_pk PRIMARY KEY(id),
    CONSTRAINT mm_sex_ck CHECK(sex IN('남자','여자'))
);

--4. 시퀀스 만든다. 
CREATE SEQUENCE mr_no_sequence 
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
    
INSERT INTO music_member VALUES('hong','홍길동', '남자');
INSERT INTO music_member VALUES('shim','심청이', '여자');
INSERT INTO music_member VALUES('park','박문수', '남자');
INSERT INTO music_member VALUES('kim','김두한', '남자');
INSERT INTO music_member VALUES('lee','이순신', '남자');
COMMIT; 
ALTER TABLE music_member ADD pwd VARCHAR2(10) DEFAULT '1234';
SELECT * FROM music_member;

--세션: 오늘 세션 배울 예정.

DESC music_reply;











