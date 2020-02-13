--2020-02-13_Sequence_subquery
--내일은 VIEW 배울 예정
/*
<SEQEUNCE>: 자동 증가 번호 생성
0. 시퀀스란?
 - 자동으로 순차적으로 증가하는 순번을 반환하는 데이터베이스 객체
 - 보통 PK값에 중복값을 방지하기위해 사용함. 
1. 옵션
 1) start with
    - 시작번호. 
 2) increment by
    - 증가 단위. 증감숫자가 양수면 증가 음수면 감소. 디폴트는 1.
 3) cache | nocache
    - 메모리에 시퀀스값을 미리 할당할 것인지 말 것인지 
 4) cycle | nocycle
    - 시퀀스 값이 최대값까지 증가되고 나면 START WITH에서 지정한 시작 값으로 시퀀스를 다시 시작할 것인지.
    - CYCLE 설정시 최대값에 도달하면 최소값부터 다시 시작 NOCYCLE 설정시 최대값 생성 시 시퀀스 생성을 중지한다.
 5) max_value: 시퀀스의 최대값을 지정
 6) min_value: 시퀀스의 최소값을 지정
2. CURRVAL, NEXTVAL
 - CURRVAL: 현재 시퀀스를 확인한다.
 - NEXTVAL: 해당 시퀀스의 값을 증가시킨다.
 - 주의사항)☆
   SELECT 하는 조회에서도 NEXTVAL를 썼을 경우 시퀀스자체의 값을 증가된후에 그대로 증가된값으로 남는다.
   (테이블과 시퀀스는 별도로 움직이기 때문.)
3. 형식
 1) 생성 
 CREATE SEQUENCE seq명   ===> seq명: table명_컬럼명_seq 
    START WIH 1         : 1부터 시작
    INCREMENT BY 1      : 1씩 증가 
    NOCACHE             : cache 사용x
    NOCYCLE             : 무한반복 (최대값이 없으므로 시퀀스 생성 중지 시점이 없음==>무한반복)
 2) 삭제 
 DROP SEQUENCE seq명     
4. 시퀀스 조회
 1) 전체 시퀀스 조회 
    SELECT * FROM USER_SEQUENCES;
 2) 해당 시퀀스 조회
    SELECT 시퀀스명 FROM DUAl;
    ex) SEELCT 
      
*/
CREATE TABLE board3(
    no NUMBER PRIMARY KEY,
    name VARCHAR2(20) NOT NULL
);

CREATE SEQUENCE board3_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;

INSERT INTO board3 VALUES(board3_no_seq.nextval,'홍길동'); --1번 
SELECT board3_no_seq.currval FROM DUAL; --현재 seq번호: 1
SELECT board3_no_seq.nextval FROM DUAL; --다음 seq번호: 2
INSERT INTO board3 VALUES(board3_no_seq.nextval,'심청이'); --seq번호: 3 ★ 
--===> 윗줄에서 nextval 썼어서 seq가 2가 아니라 3이 들어온다 ==> 함부로 nextval 쓰면 안 된다.
--NEXTVAL 쓰면 시퀀스가 증가되니까..
SELECT * FROM board3;
DELETE FROM board3 WHERE no=3;
INSERT INTO board3 VALUES(board3_no_seq.nextval,'박문수'); --seq번호: 4 ★ 
-- 행을 삭제한다고 해서 시퀀스가 1씩 땡겨지고 이러지 않는다.
-- 시퀀스는 계속 증가하기만 한다. 
SELECT * FROM board3;

DROP TABLE board3;
DROP SEQUENCE board3_no_seq;
--시퀀스는 독립적!
--테이블 지운다고해서 시퀀스도 자동으로 지워지고 그러지 않음
--시퀀스 이름을 테이블명과 관련시켜서 지었을 뿐 사실 시퀀스는 그냥 독립적으로 숫자가 증가하는 애...
--물론, 테이블에서 시퀀스를 호출할 때마다 숫자가 증가하기는 하겠지만. 


CREATE SEQUENCE board3_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
SELECT board3_no_seq.nextval FROM DUAL; --seq=1
SELECT board3_no_seq.nextval FROM DUAL; --seq=2
SELECT board3_no_seq.nextval FROM DUAL; --seq=3
SELECT board3_no_seq.nextval FROM DUAL; --seq=4
SELECT board3_no_seq.nextval FROM DUAL; --seq=5

CREATE TABLE board3(
    no NUMBER PRIMARY KEY,
    name VARCHAR2(20) NOT NULL
);

INSERT INTO board3 VALUES(board3_no_seq.nextval,'aaa'); --seq=6
SELECT * FROM board3;

DESC student;
TRUNCATE TABLE student;
CREATE SEQUENCE std_hakbun_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
SELECT * FROM student;

INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동1',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동1',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동1',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동4',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동5',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동6',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동7',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동8',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동9',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동1-',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동1-',90,80,70,SYSDATE,'남');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'홍길동1-',90,80,70,SYSDATE,'남');
COMMIT;
SELECT * FROM student;

SELECT * FROM emp;

--[서브쿼리 맛보기]
--ex) emp에서 월급 많은 순서대로 5명 가져와라 
--아래와 같이 하면 월급순으로 제대로 결과 안 나옴. 
SELECT ename,sal,rownum
FROM emp
WHERE rownum<=5
ORDER BY sal DESC;
--이렇게 해야 결과 제대로 나옴. 
SELECT ename,sal,rownum
FROM (SELECT ename,sal FROM emp ORDER BY sal DESC)
WHERE rownum<=5;
