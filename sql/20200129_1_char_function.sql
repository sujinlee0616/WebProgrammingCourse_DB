-- 2020-01-29 함수 (내장함수=오라클에서 지원하는 메소드) 
-- SELECT * FROM emp;
/*
<함수> : 단일행함수, 다중행함수 
1. 단일행 함수
1) 문자함수 : 문자열 관련 함수 
2) 숫자함수 : 숫자관련 
3) 날짜함수 : 날짜관련
4) 변환함수 : 숫자=>문자, 날짜=>문자
             ex) YYYY-MM-DD => 내가 원하는 형식의 날짜로 만들기 위해 문자로 변환 
             ex) $300000 
             ex) 120,000,000
5) 일반함수 : NVL, CASE, DECODE 
*/

--INITCAP, LOWER, UPPER
/*
INITCAP : 앞글자만 대문자로.
LOWER : 다 소문자로.
UPPER : 다 대문자로.
*/
SELECT ename, INITCAP(ename),LOWER(ename),UPPER(ename) FROM emp;

--LENGTH
/*
LENGTH : 입력된 문자열의 길이값을 출력. 
LEGNTHB : 입력된 문자열의 길이의 바이트값을 출력. 
*/
SELECT ename, LENGTH(ename),LENGTHB(ename) FROM emp; --영어 : LEGNTH 쓰던 LEGNTHB 쓰던 결과 똑같음 
SELECT LENGTH('홍길동'),LENGTHB('홍길동') FROM DUAL; -- 한글 : 1글자에 2or3Byte라서 LENGTH와 LENGTHB가 다르게 나옴. 
-- ex) emp 테이블에서 이름이 5글자인 사람을 출력해라.
SELECT * FROM emp
WHERE LENGTH(ename)=5;

--SUBSTR
/*
SUBSTR(문자열, 시작번호,문자갯수)
 - 문자를 자를 때 사용 
 - 문자 갯수가 많은 경우 사용 ex) 글자 수가 너무 많아서 UI의 범위를 벗어나는 경우...
 - 오라클은 번호가 1번부터 시작한다는 것 주의!! ★
   Hello Java
   12345678910
   SUBSTR('Hello Java',3,5)==> llo J
   실제로 쿼리 결과 확인해보고 싶으면 아래와 같이 DUAL 테이블에서 실행시켜야...
*/
SELECT SUBSTR('Hello Java',3,5) FROM DUAl;
--ex) EMPLOYEES 테이블에서 8월에 입사한 사람 리스트를 출력해라.
--데이터형식 02/08/16 
SELECT * FROM EMPLOYEES 
WHERE SUBSTR(hire_date,4,2)='08';
SELECT * FROM EMPLOYEES
WHERE hire_date LIKE '___08___'; 

--CONCAT : 문자 결합 함수. 근데 이것보다 || 쓰는게 훨씬 편하다. 
SELECT CONCAT('Hello',' Java') FROM DUAl;
SELECT 'Hello'||' Java' FROM DUAl;
SELECT CONCAT(SUBSTR('Hello Java!!!!!',1,10),'...') FROM DUAL;

--INSTR(문자열, 찾는 글자, 시작위치, 몇번째문자열인지)
SELECT INSTR('Hello Java','a',1,1) FROM DUAL; -- 결과 8 : 첫번째 a의 위치 
SELECT INSTR('Hello Java','a',1,2) FROM DUAL; -- 결과 10 : 두번째 a의 위치 
SELECT INSTR('Hello Java','l',1) FROM DUAL; -- 결과 3 : 첫번째 l의 위치  --생략하면첫번째문자열을 찾음
--ex) emp 테이블에서 이름 두 번째 글자가 A인 애를 출력하라. 
SELECT * FROM emp
WHERE INSTR(ename,'A',1)=2;

--LPAD (문자열,문자갯수,채울문자)
/*
LPAD('Java',8,'*') ==> ****Java
LPAD('Java',4,'*') ==> Java
*/
--ex) emp 테이블에서 이름 오른쪽부터 3글자만 남기고 나머지 왼쪽 글자들은 *로 가려라. 
SELECT LPAD(SUBSTR(ename,1,3),LENGTH(ename),'*') FROM emp; --ename에서 첫번째부터 글자3개 자르고, 전체 글자수는 ename 글자수만큼으로 만들고, *로 채워라
--ex) emp 테이블에서 이름 왼쪽부터 3글자만 남기고, 나머지는 오른쪽 글자들은 *로 가려라.
SELECT RPAD(SUBSTR(ename,1,3),LENGTH(ename),'*') FROM emp;
--ex)
SELECT RPAD('Hello Java',8,'*') FROM DUAL; --글자 수 넘치면 잘라버림. 모자라면 *로 채움. 

--LTRIM (문자열, 제거할문자) ==> 제거할 문자가 없는 경우는 공백 제거
SELECT LTRIM('AAABABABAAA','A') FROM DUAL; -- 결과 : BABABAAA
SELECT LTRIM('AA ABABABAAA','A') FROM DUAL; -- 결과 : ' ABABABAAA' <== 공백있으면 공백도 문자니까 공백 앞까지의 반복되는 A만 없앰.
--RTRIM (문자열, 제거할문자) 
SELECT RTRIM('AAABABABAAA','A') FROM DUAL; -- 결과 : AAABABAB
--TRIM (좌우)
SELECT TRIM('A' FROM 'AAABABABAAA') FROM DUAL; -- 결과 : BABAB

--REPLACE : 다른 문자로 변환 => 문자열, 문자1, 문자2 ==> 문자1을 문자2로 변경시킨다.
SELECT REPLACE('Hello Java','a','b') FROM DUAL; --결과 : Hello Jbvb













