-- *** 표시: 반드시 기억할 것!

--숫자함수
/*
ROUND : 반올림 (실수,소숫점이하 자리수) ==> 반올림시켜서 소숫점이하 자리수 얼마까지만 남겨라.
        ROUND(12345.6789, 1) ==> 12345.7 ==> 반올림시켜서 소숫점이하 1자리까지만 남겨라. 
        ROUND(12345.6789, 2) ==> 12345.68
TRUNC : 버림 (실수, 소숫점이하 자리수)
        TRUNC(12345.6789,1) ==> 12345.6
        TRUNC(12345.6789,2) ==> 12345.67
CEIL : 올림 (실수) ==> 올림한 정수 출력 
       CEIL(11/10) ==> 1.1을 올림한 정수 출력 ==> 2
       - 게시판 만들 때, 총 페이지 계산할 때 많이 사용함. 
       - (게시물 전체 갯수 / 한 페이지에 노출시키는 갯수) 이 값을 CEIL 하면 총 페이지 갯수가 됨.
MOD : 나머지. 
      MOD(숫자, 나눌값) ==> MOD(10,3) ==> Java의 10%3과 동일함. 
*/
-- ex) 앞의 값들 예시
SELECT ROUND(12345.6789, 1),ROUND(12345.6789, 2), TRUNC(12345.6789,1), TRUNC(12345.6789,2), CEIL(11/10) FROM DUAL;
-- ex) 사번이 짝수인 애들만 출력
SELECT empno,ename,job,sal FROM emp
WHERE MOD(empno,2)=0;

--날짜함수
/*
***SYSDATE
***MONTHS_BETWEEN
***ADD_MONTHS
LAST_DAY
NEXT_DAY
*/
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-1,SYSDATE,SYSDATE+1 FROM DUAL; --어제/오늘/내일 날짜 

--변환함수
/*
***TO_CHAR
TO_NUMBER
TO_DATE
*/

--기타함수(일반함수)
/*
***NVL
CASE
***DECODE
*/

--연습용 movie 테이블 생성 
CREATE TABLE movie(
    mno NUMBER(4), --정수형. 만약 () 안 적고 NUMBER로만 쓰면 14자리까지 입력 가능.
    title VARCHAR2(1000), --VARCHAR 가변형이니까 길게줘도 상관없음. 
    score NUMBER(4,2), --double. 전체 숫자는 4개. 2개는 소숫점. 
    genre VARCHAR2(100), -- 참고) VARCHAR는 4000Byte까지 저장 가능.
    regdate VARCHAR2(100),
    time VARCHAR2(10),
    grade VARCHAR2(100),
    director VARCHAR2(200),
    actor VARCHAR2(200),
    story CLOB, --CLOB는 4G까지 저장 가능. 얘도 가변형임. 데이터가 들어오는만큼만 메모리 저장. 
    type NUMBER -- 현재상영:1, 개봉예정:2, 박스오피스 주간:3, 월간:4, 연간:5    
);








