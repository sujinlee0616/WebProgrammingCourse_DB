-- : 2020-01-28 SELECT 연습 
/*
-- : 한 줄 주석

<SQL>
: 구조화된 질의 언어 ==> 오라클 사용되는 언어 
오라클(관계형 데이터베이스 시스템) 
==============================
    테이블로 구성
    테이블 : 2차원 구조 (Row + Column) 
    =================================
    id      password   name     addr   ==> column (attribute) 속성명, 칼럼명 
    =================================
    aaa     1234       홍길동    서울
    =================================
    bbb     1234       심청이    경기
    =================================
1. SQL 의 종류
1) DDL (데이터 정의언어) ===> 단위 : Coulmn 단위 (세로줄. 열.)
 - CREATE : 생성 => 테이블, 뷰, 시퀀스, 함수, 프로시저, 인덱스, 트리거  
 - ALTER : 수정 (MODIFY), 삭제(DROP), 추가 (ADD) 
 - DROP : 테이블 구조 자체를 삭제 
 - TRUNCATE : 테이블의 구조는 존재. 데이터만 삭제. 
 - RENAME : 테이블이나 칼럼명 변경. 
2) DML (데이터 조작언어) ===> 단위 : Row 단위 (가로줄. 행.) 
 - DML만 COMMIT/ROLLBACk 가능. 나머지 애들은 불가능. 
 - SELECT : 데이터 검색 
 - INSERT : 데이터 추가
 - UPDATE : 데이터 수정
 - DELETE : 데이터 삭제
3) DCL (데이터 제어언어) 
 - GRANT : 권한 부여 
 - REVOKE : 권한 해제 
 ※ 계정
  - system, sysdba : 권한 부여/해제 권한 有
  - user : 권한 부여/해제 권한 無
  - 우리가 쓰는 hr 계정은 user 계정. 
4) TCL (트랜잭션 언어) ==> 일괄처리. INSERT, UPDATE, DELETE에서만 사용. 
 - COMMIT : 정상적으로 저장 
 - ROLLBACK : 취소 
 ※ 한 번 커밋하면 롤백 불가. 
 ※ 비절차적 언어 ==> 1이 오류나도 오류난 것 아래의 2,3은 실행됨 
    INSERT 입고 ---1 
    재고 UPDATE ---2 
    재고 INSERT ---3 
    
========================================================================================================

<SELECT 문장>
1. 형식, 순서
 ================================================
 필수) 
 SELECT * | column명, column명 ...
     - * : 전체 데이터를 읽어올 때
     - column명 : 원하는 데이터만 출력하고자 할 때. 
 FROM table명, view명, select문장 
 ================================================
 옵션)
 WHERE 조건문 (if)
 GROUP BY 그룹column명
 HAVING 그룹에 대한 조건 
    ※ GROUP BY가 없이는 HAVING 을 쓸 수 X
 ORDER BY column명 ==> 정렬 (DESC, ASC) ==> 가급적이면 사용X (속도 느려짐) ==> INDEX 쓰는게 낫다.
 ================================================
 
2. 연산자
3. 내장함수
4. JOIN, SUBQUERRY

* 테이블 구조 확인
  : DESC table명; (desc : describe.) 
* 현재 만들어져있는 테이블 확인 
  : SELECT * FROM tab; (tab : table) 
* Oracle은 대소문자 구분하지 않는다. (단, 저장된 데이터는 대소문자를 구분한다.) 
  ex) SELECT * FROM emp WHERE ename='scott';  -- 결과 無 (테이블에 'SCOTT'으로 저장되어 있기 때문) 
      SELECT * FROM emp WHERE ename='SCOTT';  -- 결과 有 
* 키워드는 대문자로 작성한다. (ex. SELECT, UPDATE, INSERT, ...) 

*/

-- 테이블의 구조 확인
/*
<데이터형>
1. 문자형 : CHAR, VARCHAR2, CLOB ==> String 
           문자를 저장 ==> '' 사용해야. (""은 인용부호 or 별칭줄 때 사용.)
   1) CHAR : 1~2000 Byte (한글은 2Byte ==> 1000자까지 저장 가능)
   2) VARCHAR : 1~4000 Byte (한글 2000자까지 저장 가능)
   3) CLOB : 4G 저장 가능 ==> 문자가 많으면 CLOB으로('씨로브'라고 읽음) 저장.
   ※ VARCHAR는 가변형. CHAR은 가변형X ==> VARCHAR를 쓰는게 저장용량을 더 절약할 수 있다. 
      ex) 이름 글자길이 max가 17글자 (34byte) ==> CHAR은 다 34byte씩 저장해야... VARCHAR는 가변형이므로 다른 짧은 이름들에선 이름글자까지만 저장. 
2. 숫자형 : NUMBER(10) : int , NUMBER(10,2): double 
3. 날짜형 : Date ==> java.util.Date
4. 기타형 : BLOB, BFILE ==> InputStream 

* 날짜, 문자 : '' 붙인다. 
 - 날짜형식 : YY/MM/DD
 - 날짜는 저장은 문자열로 된다. 
* 숫자는 ''를 사용하지 않는다. 

ex) DESC emp;
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    
====> Not Null인 EMPNO가 PK다. (왜?? Not Null이라고 무조건 PK라고 말할 수 없지 않나?) 

*/

-- 모든 데이터 출력 
SELECT  * FROM emp;
/*
emp (사원정보)
empno : 사번 
ename : 이름 
job : 직위 
mgr : 사수번호(사수의 사번) 
hiredate : 입사일
sal : 급여 
comm : 성과급
deptno : 부서번호 
*/
SELECT * FROM dept;
SELECT * From emp;

-- 원하는 데이터만 출력
-- ex1) 이름, 직위, 급여 
SELECT ename,job,sal FROM emp;
-- ex2) 사번, 급여, 입사일 출력 
SELECT empno, sal, hiredate FROM emp;
-- ex3) 중복 없이 가져오기 : DISTINCT
SELECT deptno FROM emp; -- 중복 有
SELECT DISTINCT deptno FROM emp; -- 중복 無
-- ex4) 문자열 결합 : ||
SELECT ename||'님은 급여가 '||sal||'입니다' FROM emp;
-- ※ SQL에서 ||는 문자열 결합, && 는 Scanner임. 
-- ※ SQL에서는 OR, AND 로 사용. 
-- ex5) 별칭 주기 - "" 또는 as 사용. 
SELECT empno "사번", ename "이름", sal "급여" FROM emp;
SELECT empno as 사번, ename as 이름, sal as 급여 FROM emp;
SELECT ename||'님은 급여가 '||sal||'입니다' as 정보 FROM emp;


SELECT empno, ename, sal FROM emp;
-- 정렬 내림차순 - (급여가 많은 순으로 : 많 → 적 : 내림차순)
SELECT empno, ename, sal FROM emp ORDER BY sal DESC;
-- 정렬 오름차순 - (급여가 낮은 순으로 : 적 → 많 : 오름차순) ==> ASC 생략가능 (디폴트가 ASC)
SELECT empno, ename, sal FROM emp ORDER BY sal ASC; 
-- 정렬 : column 넘버 사용 - 오라클에서는 숫자를 0이 아니라 1부터 센다 ==> column number 3 = SAL임. 
SELECT empno, ename, sal FROM emp ORDER BY 3 DESC; 
-- 정렬 : column 넘버 사용 
SELECT * FROM emp ORDER BY 2 ASC;  --ABC..순서로. 
-- 정렬 : 이중 sort - col#3 내림차순으로. col#3값이 동일할 경우에는 col#2 오름차순으로. (ASC라 생략되었음) ==> F가  S보다 먼저 나옴. 
SELECT empno,ename,sal FROM emp
ORDER BY 3 DESC,2; 
-- 정렬 : 이중 sort -
SELECT empno,ename,sal FROM emp -- 둘 다 ASC임. 
ORDER BY 3,2; 
-- ※ SELECT는 for문과 비슷함. 찾은 갯수만큼 loop 돌려서 가져오기 때문. 

-- 오라클은 번호가 1번부터 시작한다! (0번부터 시작X)

SELECT * FROM emp;
/*
<WHERE> 
: 조건에 맞는 데이터만 출력

[연산자] 
※ null은 연산이 불가. null을 연산하면 연산결과는 무조건 null이 된다. 
ex) 800+null = null

1. 산술연산자 (+, -, *, /) 
 - 0으로 나눌 수 없다. 
 - 정수/정수=실수★  ex) 5/2=2.5  <=========> Java : 정수/정수=정수. ex) 5/2=2 
 - ※ mod 함수 : JAVA의 %와 같은 역할. 
2. 비교연산자 ( = 같다, != 같지 않다, <> 같지 않다, <, >, <=, >=, ....) 
 ex) empno=7788 (대입x. 같다는 뜻.) 
 ex) -- 사번이 7400 이상이고 7600 이하인 사원의 모든 정보  
    SELECT * FROM emp WHERE empno >=7400 AND empno <=7600;
    SELECT * FROM emp WHERE empno BETWEEN 7400 AND 7600;  -- between은 양 끝 범위 '포함'임!!
3. 논리연산자 (AND, OR)
 - AND : 그냥 AND 라고 씀.
 - OR : 그냥 OR이라고 씀. 
 - 오라클에선 &&가 AND가 아니라 스캐너고, 
   ||가 OR이 아니라 문자열 결합임. 
===> 크롤링할 때 주소 안에 & 있으면 스캐너 띄워버림... 
==> 이런거 크롤링 할 때 &를 ^로 바꿨다가 다시 또 &로 바꿔줘야함...
ex) http://img1.daumcdn.net/thumb/C236x340/?fname=
4. NULL 연산자
 - 반드시 IS NULL 또는 IS NOT NULL 사용해야. 
 ex) comm=null (X)
5. BETWEEN ~ AND : 범위, 기간 
ex) SELECT * FROM emp WHERE empno BETWEEN 7369 AND 7521;
6. LIKE : 유사문자열 검색
ex) SELECT * FROM emp WHERE ename LIKE '%S%'; 
7. IN : 포함된 데이터를 가지고 올 때 => OR가 여러개일 때 많이 사용. 
ex) SELECT * FROM emp
WHERE deptno=10 OR deptno=20 OR deptno=30;
==> SELECT * FROM emp
    WHERE deptno IN(10,20,30);
위아래 같은 문장임.
ex) SELECT * FROM emp WHERE sal IN(1500,3000,1600);
8. NOT : 부정 
NOT IN()
ex) SELECT * FROM emp WHERE sal NOT IN(1500,3000,1600);
NOT BETWEEN ~ AND
ex) SELECT * FROM emp WHERE empno NOT BETWEEN 7369 AND 7521;
*/

SELECT 10+20,10-5,10*20,10/3 FROM DUAL;  -- DUAL : 연산 연습용 테이블. 정수/정수=실수.
SELECT 10+20,10-5,10*20,10/0 FROM DUAL;  -- Error. 0으로 나눌 수 없다. 

-- NULL은 연산하면 NULL
SELECT NULL+1 FROM DUAL;
SELECT NULL*100 FROM DUAL;

/*
<WHERE 문장의 형식>
 - SELECT ~~ FROM table명
   WHERE 컬럼명 연산자 값 
 - WHERE은 한 문장에 한 번 밖에 못 쓴다. (JOIN할 경우 제외)
ex) 이름이 SCOTT인 사원의 모든 정보를 가져와라
SELECT * FROM emp WHERE ename='SCOTT';
ex) 부서가 20번인 직원의 이름과 급여를 출력
SELECT ename,sal FROM emp WHERE deptno=20;
ex) 부서가 30번이 아닌 직원의 정보 모두 가져와라. 
SELECT * FROM emp WHERE deptno NOT IN(30);
SELECT * FROM emp WHERE deptno!=30;
SELECT * FROM emp WHERE deptno<>30;
*/

/*
<NULL 관련>
1. NVL : NUll값일 때 다른 값으로 바꾸는 함수. 
SELECT ename,sal as 월급 ,comm as 상여금,sal+comm as 총급여 FROM emp; -- comm이 NULL이면 총급여가 NULL로 나옴. 
SELECT ename,sal as 월급 ,comm as 상여금,sal+NVL(comm,0) as 총급여 FROM emp; -- 이렇게 써야 총급여 제대로 나온다. 
2. ' ' : 가능. '' : 불가능. ''은 NULL로 인식, 오류난다.  
3. NULL을 연산 시키면 안된다 ==> IS NULL, IS NOT NULL 사용해야.
ex) 성과급을 받는 사원의 모든 정보를 출력
SELECT * FROM emp WHERE comm IS NOT NULL AND comm<>0; -- (O) 이게 제일 정확. 
SELECT * FROM emp WHERE comm IS NOT NULL; -- (△). comm=0인 사람도 나옴. 
SELECT * FROM emp WHERE comm!=Null; -- (X). 이렇게 하면 안 됨. 
*/

/*
<LIKE>
 - 유사문자열 찾기
 - % : 문자열. (글자 수는 알 수 없음) vs  _ : 한 글자. (글자수를 알 때) 
 - 요즘은 LIKE보다 정규식이 더 많이 쓰이기도 함. 
   ex) REGEXP_LIKE(ename,'^A$')
1.A% : A로 시작하는 모든 문자열 
 - ex) 이름이 A로 시작하는 모든 사원 
       SELECT * FROM emp WHERE ename LIKE 'A%';
 - Java의 'startsWith'와 유사 
2.%A : A로 끝나는 모든 문자열 
 - ex) 이름이 N으로 끝나는 모든 사원 
       SELECT * FROM emp WHERE ename LIKE '%N';
 - Java의 'EndsWith'와 유사
3.%A% : A를 포함하는 모든 문자열. (A로 시작, 중간에 A 있거나, A로 끝나거나) ex) ABCD, BACD, DCBA, AABB
 - ex) 이름에 N이 들어가는 모든 사원 
       SELECT * FROM emp WHERE ename LIKE '%N%';
4.__A% : 3번째 글자가 A인 모든 문자열 
5.__O__ : 총 5글자. 그 중 3번쨰 글자가 O인 문자열. 
 - ex) S로 시작하는, 이름이 총 5글자인 사람의 정보 
       SELECT * FROM emp WHERE ename LIKE 'S____';
 - ex) 2번째 글자가 A인 모든 사람의 정보 
       SELECT * FROM emp WHERE ename LIKE '_A%';
*/

/* 서브쿼리 
ex) 
SELECT * FROM emp
WHERE sal>(SELECT AVG(sal) FROM emp);
ex2) SELECT를 칼럼명으로 사용했음 
SELECT ename,(SELECT deptno FROM emp WHERE ename='KING') FROM emp;
ex3) ex2의 칼럼명을 as(alias) 써서 짧게 줄여줬음 
SELECT ename,(SELECT deptno FROM emp WHERE ename='KING') as deptno FROM emp;
*/

/* 
<SELECT 사용처>
1. 데이터 검색
 - SELECT 칼럼명 FROM 테이블명; 
2. 칼럼 대신 사용
 - SELECT (SELECT~), (SELECT~) FROM emp; ==> 별칭을 주는 것이 좋다. 
 - ex) SELECT ename,(SELECT deptno FROM emp WHERE ename='KING') FROM emp;
 - ex) SELECT ename,(SELECT deptno FROM emp WHERE ename='KING') as deptno FROM emp;
3. 조건에 해당되는 값을 가지고 올 때 
 - SELECT ~~ FROM table명 
   WHERE sal=(SELECT ~~)
 - ex) SELECT * FROM emp WHERE sal>(SELECT AVG(sal) FROM emp);
4. 테이블 대신 사용 
 - SELECT ~~ 
   FROM (SELECT~~)
*/

SELECT * FROM emp
WHERE TO_CHAR(hiredate,'YY/MM/DD')='20/01/07';

-- 이런식으로도 문자열 비교도 사용 가능. ==> K보다 큰 ename을 가져온다. 
SELECT * FROM emp
WHERE ename>='KING';

SELECT first_name||' '||last_name,hire_date FROM employees
WHERE hire_date<'06/01/03'; --06년보다 더 이전에 입사한 애들. 

-- ex) 2005에 입사한 모든 사람들의 이름과 입사일을 출력하라. 
-- 방법1.
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE hire_date BETWEEN '05/01/01' AND '05/12/31'; -- BETWEEN AND는 이상/이하(O). 초과/미만(X).
-- 방법2. 
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE hire_date>='05/01/01' AND hire_date<='05/12/31';
-- 방법3. 
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE hire_date LIKE '05%'; --날짜를 문자열로 저장되니까 이렇게도 가능!☆

-- 문자 제어 함수 예시 - INITCAP 함수
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE first_name=INITCAP('John'); 
SELECT first_name||' '||last_name,hire_date FROM employees 
WHERE first_name=INITCAP('john'); --맨 첫글자만 대문자로 바꿔주는 함수

-- 오라클에서 &는 Scanner(사용자 입력값 받을 경우), ||는 문자열 결합임.
SELECT * FROM emp
WHERE empno=&no; -- 인풋창 뜨는 데다가 사번 입력 시 해당 사번인 직원 정보 알려줌 

/*
SELECT
FROM
WHERE
ORDER BY

형식)
ORDER BY 칼럼명(ASC|DESC)
         ename DESC
         ename ASC ==> 생략 가능 (ASC가 디폴트라서)
 - 따로 ORDER BY 한게 아니면 걍 테이블에 insert한 순으로 데이터 들어가있음. 

*/












