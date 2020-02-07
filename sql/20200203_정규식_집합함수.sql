--2020-02-03 오라클(그룹함수(=집합함수))

/*
<그룹함수(=집합함수)>
 - 단위 : Column (도메인 단위) ==> 다중행함수(그룹함수, 집합함수)
   ※ 다중행함수 ↔ 단일함수 : row(레코드) 단위 실행. 

1. COUNT : 갯수 
 - 사용 예시 : 로그인, 아이디 중복체크 시 많이 사용됨. 
 1) COUNT(*) ========> NULL 포함O
 2) COUNT(컬럼명) ====> NULL 포함X
SELECT COUNT(*) FROM emp;
SELECT COUNT(mgr) FROM emp; --mgr:사수번호. 한 명이 null값을 갖고 있다. 
SELECT COUNT(comm) FROM emp; --comm:커미션. 10명은 커미션 받지X.
SELECT empno FROM emp WHERE empno=8000; --결과: NULL
SELECT COUNT(*) FROM emp WHERE empno=8000; --존재하는지 안 하는지 체크하기 위해서 COUNT를 사용한다. 
--Java에서도 NULL값 처리 안되므로 오라클에서 NULL인지 아닌지 체크해줘야. 

2. AVG : 평균
 - 형식 : AVG(컬럼명) ==> AVG(sal) 
--주의) 집합함수는 단일행 함수, 컬럼과 같이 사용 할 수 없다. ★ (예외 : GROUP BY 사용 시, RANK 함수(RANK는 집합함수 아님)) 
SELECT AVG(sal) FROM emp; --가능
SELECT AVG(sal),ename,LENGTH(ename) FROM emp; --Error.: 집함함수는 결과가 1개, 단일행함수는 결과가 복수개 ==> 같이 나올 수 없다.
SELECT ROUND(AVG(sal),1) FROM emp;

3. MAX : 최대값 
 - 형식 : MAX(컬럼명) 
 - 사용 예시 : 중복이 없는 값(정수) => 자동으로 증가되는 함수 만들 때 많이 사용. 
   ※ 자동으로 증가되는 함수 관련하여 나중에 SEQUENCE라는 것을 배우지만, 그 전까지는 MAX를 사용할 것이다. 
 - ex) MAX(sal) 

4. MIN : 최소값
 - 형식 : MIN(컬럼명) 
 - ex) MIN(sal) 
SELECT MAX(sal),MIN(sal) FROM emp;

5. SUM : 합 
 - 형식 : SUM(컬럼명)
 - ex) SUM(sal) 
SELECT SUM(sal),SUM(comm) FROM emp;

6. RANK : 순위결정 
 - ex) RANK() OVER(ORDER BY sal DESC)
        ==> 급여가 높은 순으로 순위를 매긴다. 
 - 순위를 매기는 방법 : 동점자가 복수일 경우, 그 다음 등수를 카운트 하는 방법이 다르다. 
   1) 1등,2등,2등,☆4등☆ 방식 : ★RANK★
    - 같은 등수가 있을 때, 그 다음 등수를 건너뛴다.
   2) 1등,2등,2등,☆3등☆ 방식 : ★DENSE_RANK★
    - 같은 등수가 있을 때, 그 다음 등수를 건너뛰지 않는다. 
 - RANK함수는 단일행 함수와 함께 쓸 수 있다. ==> RANK는 사실 집합함수 아니다..
SELECT ename,sal,RANK() OVER(ORDER BY sal DESC) FROM emp; --연봉 많은 순으로 RANK 매김 --RANK : 1,2,2,4,5,...
SELECT ename,sal,DENSE_RANK() OVER(ORDER BY sal DESC) FROM emp; --DENSE_RANK : 1,2,2,3,4,...
SELECT ename,hiredate,RANK() OVER(ORDER BY hiredate ASC) FROM emp; --장기근속자 순으로 RANK 매김 

7. DENSE_RANK : 순위결정 
*/

/*
<정규식>
--ex) 급여가 평균보다 작은 사원의 정보를 출력하라. 
--방법0) Error. 그룹함수와 단일함수를 같이 썼으므로 실행 불가
SELECT * FROM emp WHERE sal<=AVG(sal); 
--방법1) 문장 2개로 수행. 
SELECT AVG(sal) FROM emp;
SELECT * FROM emp
WHERE sal<2073;
--방법2) 문장 1개로 수행. 서브쿼리 사용.  서브쿼리 : 괄호 有 ==> 먼저 수행됨.
SELECT * FROM emp
WHERE sal<=(SELECT AVG(sal) FROM emp);
*/

/*
<2교시 - 지니뮤직 크롤링하기>
mno: 고유번호
rank: 순위 
title
singer
album
poster
idcrement : 증가, 감소 
state : 상승, 하강, 유지
key
*/

--저장공간 생성 (테이블) 
CREATE TABLE music_genie (
    mno NUMBER,
    rank NUMBER,
    title VARCHAR2(500),
    singer VARCHAR2(200),
    album VARCHAR2(300),
    poster VARCHAR2(260),
    idcrement NUMBER,
    state CHAR(4),
    key VARCHAR2(100)
);
SELECT * FROM music_genie;

ALTER TABLE music_genie MODIFY state CHAR(6);
DESC music_genie;

TRUNCATE TABLE music_genie; --테이블에 쌓인 데이터 날렸음... 자바에서 Jsoup 돌린거 데이터가 일부만 들어가서... 데이터 날렸음. 

SELECT mno,title,singer,poster,album,idcrement,state FROM music_genie ORDER BY rank ASC;








