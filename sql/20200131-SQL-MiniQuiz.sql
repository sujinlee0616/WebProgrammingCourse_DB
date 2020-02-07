--2020-01-31 변환함수, 일반함수 

/*
<변환함수>
TO_CHAR★ => 날짜 => 시간 출력 (댓글) ===> 날짜변환, 숫자. 많이 사용됨.
 1)년도: YYYY, YYY, YY (RRRRR,RR)
 2)월: MM, M
 3)일: DD, D
 4)시간: HH(=H12), HH12, HH24 ==> HH24가 더 많이 쓰임. 
 5)분: MI (월이 M이라서 분은 M이 아니라 MI로 표현) 
 6)초: SS
 7)숫자:
   천자리 앞에 콤마: 999,999 
   숫자 앞에 $ 붙이기: $999,999
   숫자 앞에 원 붙이기: L999,999
TO_NUMBER : Java에서 Integer.parseInt()하는게 더 편함. 잘 안 씀.
TO_DATE : Java에서 new Date()하는게 더 편함. 잘 안 씀. 
NVL★ : NULL값을 다른 값으로 변경 
 - NVL(칼럼명, null일 경우 넣어줄 값) 
DECODE : Java의 swtich~case 문
CASE : 다중조건문 

<문자함수>
LENGTH : 문자의 갯수
SUBSTR : 문자를 자를 경우
INSTR : 문자의 위치
RPAD : 문자가 많은 경우에 암호화

<숫자함수>
ROUND : 반올림
TRUNC : 버림
CEIL : 올림
MOD : 나머지

<날짜함수>
SYSDATE : 시스템의 시간을 읽어옴 
MONTH_BETWEEN : 기간의 개월수 
*/
SELECT last_name, hire_date, salary FROM employees;
-- 날짜 변환 (2020-01-31 형식으로)
SELECT last_name,TO_CHAR(hire_date,'YYYY-MM-DD'), salary FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY-MM-DD HH24:MI:SS'), salary FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"년도"-MM"월" DD"일"'), salary FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"년도"-MM"월" DD"일"') as hiredate, salary FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"년도"-MM"월" DD"일"') as hiredate, TO_CHAR(salary,'999,999') FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"년도"-MM"월" DD"일"') as hiredate, TO_CHAR(salary,'$999,999') FROM employees;
SELECT last_name,TO_CHAR(hire_date,'YYYY"년도"-MM"월" DD"일"') as hiredate, TO_CHAR(salary,'L999,999') FROM employees;

--NVL
SELECT last_name,hire_date,salary,commission_pct FROM employees; --null값이 많음 ==> null값을 다른 값으로 바꿔야 제어가 쉽다.. ex) commission과 salary를 합쳐서 총소득을 만든다던지...
SELECT last_name,hire_date,salary,commission_pct,salary+commission_pct FROM employees;
SELECT last_name,hire_date,salary,NVL(commission_pct,0),salary+(salary*NVL(commission_pct,0)) FROM employees; --NULL값은 위험하니까 NVL 사용

/*
ex) 우편번호 검색 => 번지가 없는 경우(null) => 브라우저에서는 null => NVL(bunji,' ') : 번지가 null이면 공백으로 처리 
cf) '': null vs ' ': 공백 
*/

--DECODE
SELECT * FROM emp;
/*
1. DECODE
DECODE(deptno,10,'영업부',
              20,'기획부',
              30,'개발부',
              '신입사원') as dept
2. CASE
CASE deptno WHEN 10 THEN '영업부'  --콤마(,) 안 찍는다!!
            WHEN 20 THEN '기획부'
            WHEN 30 THEN '기획부'
            ELSE '신입사원'
            END "dept"
3. 기타
- DECODE는 CASE로도 변경할 수 있다. 
- DECODE는 Java에서의 switch 문과 똑같음.
switch(deptno)
{
    case 10:
    case 20:
    case 30:
}

*/
--DECODE ex)
SELECT empno,ename, DECODE(deptno,10,'영업부',
                                  20,'기획부',
                                  30,'개발부',
                                  '신입사원') as dept 
FROM emp; 
--CASE ex)
SELECT empno,ename, CASE deptno WHEN 10 THEN '영업부'  
                    WHEN 20 THEN '기획부'
                    WHEN 30 THEN '기획부'
                    ELSE '신입사원'
                    END "dept"
FROM emp; 

/* Mini Test를 위한 테이블 생성/데이터 insert 
DROP TABLE emp;

create table dept(
  deptno number,
  dname  varchar2(14),
  loc    varchar2(13),
  constraint pk_dept primary key (deptno)
);
  
create table emp(
  empno    number,
  ename    varchar2(10),
  job      varchar2(9),
  mgr      number(4,0),
  hiredate date,
  sal      number(7,2),
  comm     number(7,2),
  deptno   number
);

insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');
COMMIT;

DELETE FROM dept;
COMMIT;

insert into emp values( 7839, 'KING', 'PRESIDENT', null, '96/11/17', 5000, null, 10);
insert into emp values( 7698, 'BLAKE', 'MANAGER', 7839, '91/01/05', 2850, null, 30);
insert into emp values( 7782, 'CLARK', 'MANAGER', 7839, '99/09/06', 2450, null, 10);
insert into emp values( 7566, 'JONES', 'MANAGER', 7839, '01/02/04', 2975, null, 20);
insert into emp values( 7788, 'SCOTT', 'ANALYST', 7566, '17/03/06', 3000, null, 20);
insert into emp values( 7902, 'FORD', 'ANALYST', 7566, '81/03/12', 3000, null, 20);
insert into emp values( 7369, 'SMITH', 'CLERK', 7902, '07/12/01', 800, null, 20);
insert into emp values( 7499, 'ALLEN', 'SALESMAN', 7698, '81/02/20', 1600, 300, 30);
insert into emp values( 7521, 'WARD', 'SALESMAN', 7698, '81/02/22', 1250, 500, 30);
insert into emp values( 7654, 'MARTIN', 'SALESMAN', 7698, '81/09/28', 1250, 1400, 30);
insert into emp values( 7844, 'TURNER', 'SALESMAN', 7698, '81/08/09', 1500, 0, 30);
insert into emp values( 7876, 'ADAMS', 'CLERK', 7788, '87/07/13', 1100, null, 20);
insert into emp values( 7900, 'JAMES', 'CLERK', 7698, '81/03/21', 950, null, 30);
insert into emp values( 7934, 'MILLER', 'CLERK', 7782, '03/01/23', 1300, null, 10);
COMMIT;
*/
SELECT * FROM dept;
SELECT * FROM emp;

--[Mini Test]
--ex1) 사원번호, 이름, 월급을 출력하시오.
SELECT empno,ename,sal FROM emp;
--ex2) 이름 월급 직업 입사일을 출력하시오.
SELECT ename,sal,job,hiredate FROM emp;
--ex3) 이름, 월급, 커미션, 월급 + 커미션을 출력하시오.
SELECT ename,sal,comm,sal+NVL(comm,0) FROM emp;
/*
<NVL>
 - 형식) 
   NVL(문자,대체문자) 
   NVL(숫자,대체숫자)
 - NULL값일 경우 연산처리가 안되므로 NVL 써서 NULL값을 다른 값으로 바꿔준다. 
 - NVL 안에 데이터형이 같아야 한다! ex) 74번 ex)참고 
*/
--ex4) 사원이름과 월급을 출력하는데, 이름의 컬럼명을 employee라고 하고 월급의 컬럼명을 salary라고 하시오.
SELECT ename as "employee",sal as "salary" FROM emp; --칼럼명이 소문자로 나옴 
-- "" 붙여야 내가 입력한 대소문자가 반영됨 ==> 왠만하면 "" 붙이자. 
SELECT ename as employee,sal as salary FROM emp; --칼럼명이 대문자로 나옴 
/*
<별칭>
 - 형식) 
   컬럼명 "별칭"
   컬럼명 as "별칭"
   컬럼명 as 별칭
 - as는 생략 가능. 
 - 컬럼명이 길 때 별칭 사용한다. 
*/
--ex5) 사원이름과 입사일을 출력하는데 사원이름의 컬럼명이 employee name으로 출력되게 하시오.
SELECT ename as "employee name",hiredate FROM emp;
--ex6) 직업을 출력하시오. (distinct : 중복제거 키워드)
SELECT DISTINCT job FROM emp;
--설명) DISTINCT ==> 장르, 물품종류 등에 많이 사용됨. 
--ex7) 부서번호를 출력하는데 중복제거해서 출력하시오
SELECT DISTINCT deptno FROM emp;
--ex8) 사원번호가 7788번인 사원의 사원번호와 이름을 출력하시오.
SELECT empno,ename FROM emp WHERE empno=7788;
/*
<데이터형>
1. 문자형 
 1) CHAR(고정바이트, 1~2000byte)
 2) VARCHAR2(가변바이트, 1~4000byte)
 3) CLOB (가변바이트, 4G) => String
 ※ 한글은 1글자에 2~3byte 차지함. 
2. 숫자형 
 1) NUMBER, NUMBER(자리수) => int
 2) NUMBER(자리수, 소수점자리수) => double 
3. 날짜형 
 1) DATE
 2) TIMESTAMP(기록 경주에 많이 사용) 
4. 기타형 
 - 사진, 동영상, 애니메이션 등에 많이 사용. 4G.
 1) BLOB : binary(2진법)으로 저장 
 2) BFILE : 파일 형식으로 저장
5. 참고
 1) 테이블 구조 궁금할 때 : DESC table명; 

<연산자>
 - NULL이 있는 경우에는 연산이 불가능하므로 반드시 NVL 사용해서 NULL을 다른 대체값으로 변경해줘야함. 
1. 산술연산자 (+,-,*,/)
 - 0으로 나눌 수 없다
 - 정수/정수=실수 
 - SELECT에서 많이 사용 
2. 비교연산자 (=,!=,<>,<,>,>=,<=) 
 - 결과값이 boolean 
 - WHERE에서 많이 사용
3. 논리연산자 (AND, OR)
 - ||, && 는 'OR', 'AND'가 아니라 '문자열결합', 'Scanner'이다. 
 - 참고) 
   오라클은 대소문자 구분이 없다. (약속: 키워드는 대문자를 사용한다)
   *** 데이터는 대소문자를 구분한다. 
 - WHERE에서 많이 사용
4. 대입연산자 (=)
 - 대입연산자로서의 '='는 UPDATE 에서만 쓰임.
 - WHERE 뒤에 '='가 있다면 비교연산자, WHERE 밖에 '='가 있다면 대입연산자로 쓰인 것. 
 -  ex) UPDATE emp SET
        ename='홍길동' -- <== '='은 대입연산자 
        WHERE empno=7788; -- <== '='은 비교연산자 
5. NULL 연산자
 - IS NULL : NULL일 경우
 - IS NOT NULL : NULL이 아닐 경우 
 - null인지 null이 아닌지를 판별하기 위해서는 반드시 NULL 연산자를 사용해야 한다.
 - comm=null 이런식으로는 null 여부를 판별할 수 없다. 
6. BETWEEN ~ AND 
 - 범위, 기간 설정 시 
 - '이상' '이하'이다. ex) BETWEEN 1~10 : 1이상 10이하
 - 페이지 나누기, 예매기간, 체크인/체크아웃 등에 많이 사용된다. 
7. LIKE
 - 유사문자열 검색
 1) % : 문자열 갯수를 알 수 없을 때
 2) _ : 문자 1개 
8. NOT : 부정 
 1) NOT IN
 2) NOT BETWEEN 
 3) NOT LIKE
9. IN : 포함
 - OR를 여러개 사용해야 할 경우 OR 여러개 대신 IN 사용
*/
--ex9) 월급이 3000인 사원들의 이름과 월급을 출력하시오
SELECT ename,sal FROM emp WHERE sal=3000;
--ex10) 이름이 scott인 사원의 이름과 직업을 출력하시오.
SELECT ename,job FROM emp WHERE ename='SCOTT';
--ex11) 월급이 3000 이상인 사원들의 이름과 월급을 출력하시오.
SELECT ename,sal FROM emp WHERE sal>=3000;
--ex12) 직업이 SALESMAN이 아닌사원들의 이름과 직업을 출력하시오.
--부정 : !=, <>, ^=
SELECT ename,job FROM emp WHERE job!='SALESMAN';
SELECT ename,job FROM emp WHERE job<>'SALESMAN';
SELECT ename,job FROM emp WHERE job^='SALESMAN';
SELECT ename,job FROM emp WHERE NOT(job='SALESMAN');
SELECT ename,job FROM emp WHERE job NOT IN ('SALESMAN');
--ex13) 월급이 1000에서 3000 사이인 사원들의 이름과 월급을 출력하는데, 컬럼명을 Employee, Salary로 출력하시오. (between A and B : A이상 B이하 사이의 데이터)
--별칭) 1) as "별칭" 2) "별칭" 3) 별칭 
SELECT ename as "Employee", sal as "Salary" FROM emp WHERE sal BETWEEN 1000 AND 3000;
SELECT ename "Employee", sal "Salary" FROM emp WHERE sal BETWEEN 1000 AND 3000;
SELECT ename as "Employee", sal as "Salary" FROM emp WHERE sal>= 1000 AND sal<=3000; --부등호가 BETWEEN보다 속도 더 빠름 
--ex14) 사원이름과 월급을 출력하는데 월급이 낮은 사원부터 높은 사원순으로 출력하시오. (order by)
--정렬) ORDER BY 컬럼명/컬럼숫자 ASC|DESC;
SELECT ename,sal FROM emp ORDER BY sal ASC;
SELECT ename,sal FROM emp ORDER BY 2 ASC;
--ex15) 이름과 입사일을 출력하는데 가장 최근에 입사한 사원부터 출력하시오.
SELECT ename,hiredate FROM emp ORDER BY hiredate DESC;
--ex16) 직업이 SALESMAN인 사원들의 이름과 월급과 직업을 출력하는데, 월급이 높은 사원부터 출력하시오.
SELECT ename,job FROM emp WHERE job='SALESMAN' ORDER BY sal DESC;
--순서) SELECT - FROM - WHERE - GROUP BY - HAVING - ORDER BY 
--ex17) 월급이 1000 이상인 사원들의 이름과 월급을 출력하는데 월급이 낮은 사원부터 높은 사원순으로 출력하시오.
SELECT ename,sal FROM emp WHERE sal>=1000 ORDER BY sal ASC;
--ex18) 연봉(셀러리*12)이 36000 이상인 사원들의 이름과 연봉을 출력하고 컬럼명의 별칭은 "연봉"으로 하시오.
SELECT ename,sal as "연봉" FROM emp WHERE sal*12>=36000;
--ex19) 월급이 1000에서 3000사이가 아닌 사원들의 이름과 월급을 출력하시오.
SELECT ename,sal FROM emp WHERE sal NOT BETWEEN 1000 AND 3000;
--ex20) 이름의 첫 글자가 s로 시작하는 사원들의 이름을 출력하시오.
SELECT ename FROM emp WHERE ename LIKE 'S%';
--ex21) 이름의 끝 글자가 T로 끝나는 사원들의 이름을 출력하시오.
SELECT ename FROM emp WHERE ename LIKE '%T';
--ex22) 이름의 두번째 철자가 m인 사원들의 이름을 출력하시오.
 SELECT ename FROM emp WHERE ename LIKE '_M%';
--ex23) 이름의 세번째 철자가 L인 사원의 이름을 출력하시오.
SELECT ename FROM emp WHERE ename LIKE '__L%';
--ex24) 이름의 두번째 철자가 C인 사원의 이름을 출력하시오.
SELECT ename FROM emp WHERE ename LIKE '_C%';
--ex25) 이름의 두번째 철자 A와 세번째 철자가 R인 사원들의 이름을 출력하시오
SELECT ename FROM emp WHERE ename LIKE '_AR%';
--ex26) 이름의 첫번째 철자가 S 가 아닌 사원들의 이름을 출력하시오.
SELECT ename FROM emp WHERE ename NOT LIKE 'S%';
--ex27) 사원 번호가 7788, 7902, 7369번인 사원들의 사원번호와 이름을 출력하시오.
SELECT empno,ename FROM emp WHERE empno IN(7788,7902,7369);
--ex28) 직업이 SALESMAN ANALYST가 아닌 사원들의 이름과 직업을 출력하시오.
SELECT ename,job FROM emp WHERE job NOT IN('SALESMAN', 'ANALYST');
--ex29) 커미션이 null인 사원들의 이름과 커미션을 출력하시오.
SELECT ename,comm FROM emp WHERE comm IS NULL; 
--ex30) 커미션이 null이 아닌 사원들의 이름과 커미션을 출력하시오.
SELECT ename,comm FROM emp WHERE comm IS NOT NULL; 
--ex31) 월급이 1000에서 3000 사이인 사원들의 이름과 월급을 출력하는데 월급이 높은  사원부터 출력하시오
SELECT ename,sal FROM emp WHERE sal BETWEEN 1000 AND 3000 ORDER BY sal DESC;
--ex32) 1981년 8월 9일에 입사한 사원들의 이름과 입사일을 출력하시오.
SELECT ename,hiredate FROM emp WHERE hiredate='81/08/09';
SELECT ename,hiredate FROM emp WHERE TO_CHAR(hiredate,'YYYY"년" MM"월" DD"일"')='1981년 08월 09일'; --☆
--ex33) 1981년 2월 20일에 입사한 사원들의 이름과 입사일을 출력하시오.
SELECT ename,hiredate FROM emp WHERE hiredate='81/02/20';
--ex34) 1981년도에 입사한 사원들의 이름과 입사일을 출력하시오.
SELECT ename,hiredate FROM emp 
WHERE hiredate BETWEEN '81/01/01' AND '81/12/31';  --☆ 권장O
SELECT ename,hiredate FROM emp WHERE hiredate LIKE '81%'; --권장X. 속도 느림. 
SELECT ename,hiredate FROM emp WHERE SUBSTR(hiredate,1,2)=81; -- 권장O.
--ex35) 연결연산자를 이용해서 이름과 월급을 연결해서 출력하시오.
SELECT ename||' '||sal FROM emp;
SELECT CONCAT (ename,sal) FROM emp;
--ex36) 쿼리를 사용해 "SCOTT의 직업은 ANALYST 입니다."와 같은 결과를 출력하시오.
SELECT ename||'의 직업은 '||job||' 입니다.' FROM emp;
--☆☆ex037) 아래의 쿼리 결과를 출력하시오. (이미지 참고) 
SELECT ename,job,sal FROM emp ORDER BY job ASC, sal ASC;
--ex38) 직업이 SALESMAN인 사원들의 이름과 연봉을 출력하는데 연봉이 높은 사원부터 출력하고 아래과 같이 결과를 출력하시오. "ALLEN 의 연봉은 36000 입니다."
SELECT ename||'의 연봉은 '||sal*12||' 입니다' FROM emp WHERE job='SALESMAN' ORDER BY sal DESC; 
--ex39) 이름은 대문자로 직업은 소문자로, 이름의 첫글자를 대문자 나머지는 소문자로 출력하시오.
SELECT UPPER(ename), LOWER(job), INITCAP(ename) FROM emp;
--ex40) 이름이 scott인 사원의 이름과 월급을 출력하는데 where절에 scott의 소문자로 검색해서 출력하시오.
SELECT ename,sal FROM emp WHERE ename=UPPER('scott');
--e041) 아래의 쿼리 결과를 출력하시오. (이미지 참고) 
SELECT ename,SUBSTR(ename,1,3) as "SUBSTR" FROM emp;
--ex42) 이름의 첫번째 철자만 대문자로 출력, 나머지는 소문자로 출력되게 하시오.
SELECT INITCAP(ename) FROM emp;
--ex43) upper, lower, substr, || 를 사용해서 아래와 같은 결과를 출력하시오. (이미지 참고. Smith, Allen,...) 
SELECT UPPER(SUBSTR(ename,1,1))||LOWER(SUBSTR(ename,2,LENGTH(ename))) FROM emp;
--ex44) 이름에 M자를 포함하고있는 사원들의 이름과 월급을 출력하시오.
SELECT ename,sal FROM emp WHERE ename LIKE '%M%';
SELECT ename,sal FROM emp 
WHERE regexp_like(ename,'M'); --정규식★
--ex45) 이름에 EN 또는 IN을 포함하고 있는 사원들의 이름과 입사일을 출력하는데 최근에 입사한 순서로 출력하시오.
SELECT ename,hiredate FROM emp WHERE ename LIKE '%EN%' OR ename LIKE '%IN%' ORDER BY hiredate DESC;
SELECT ename,hiredate FROM emp 
WHERE regexp_like(ename,'EN|IN')
ORDER BY hiredate DESC; --정규식★
--ex46) 직업이 SALESMAN인 사원들의 사원 이름과 직업과 월급을 출력하는데 월급이 높은 사원부터 출력하시오.
--설명) 오라클 내부 순서는 from, where, select, order by 순으로 진행된다. 이 진행 순서에 따라서 as 별칭을 인식하고 못하는 절 이 있다.
SELECT ename,job,sal FROM emp WHERE job='SALESMAN' ORDER BY sal DESC;
--ex47) 이름의 첫글자가 A로 시작하는 사원들의 이름과 월급과 직업을 출력하시오. 
SELECT ename,sal,job FROM emp WHERE ename LIKE 'A%';
--ex48) 월급이 1000에서 3000 사이인 사원들의 이름과 월급과 입사일을 출력하는데, 입사일을 먼저 입사한 사원부터 출력되게 하시오.
SELECT ename,sal,hiredate FROM emp WHERE sal BETWEEN 1000 AND 3000 ORDER BY hiredate;
--ex49) 1981년도에 입사한 사원들의 이름과 입사일을 출력하시오. 
SELECT ename,hiredate FROM emp WHERE hiredate LIKE '81%';
--ex50) 이름에 M자를 포함하고 있는 사원들의 이름을 출력하시오. 
SELECT ename FROM emp WHERE ename LIKE '%M%';
--설명) 단일행함수 : 문자, 숫자, 날짜, 변환, 일반
--설명) 복수행 함수 : MAX, MIN, AVG, SUM, COUNT
--설명) 문자 함수 : upper, lower, initcap, substr, instr, lpad, rpad, trim, replace
--☆ex52) instr 함수를 이용해서 이름에 A자를 포함하고 있는 사원들의 이름을 출력하시오. 
SELECT ename FROM emp 
WHERE INSTR(ename,'A',1)>=1;
--설명) INSTR('문자', '비교하고자하는 값', 시작할 위치, 결과의 순번)
--ex54) 이름과 월급을 출력하는데 월급을 전체 10자리로 출력하고 나머지 자리는 *로 출력하시오! 
--설명)  RPAD("값", "총 문자길이", "채움문자")
SELECT ename,LPAD(sal,10,'*') FROM emp;
--참고) 아이디찾기, 비밀번호 찾기 => RPAD 이용, JavaMail
--☆ex55) 이름과 월급을 출력하는데 월급을 전체 10자리로 출력하고 나머지 자리는 공백으로 출력하시오. 
SELECT ename,LPAD(sal,10,' ') FROM emp;
--ex56) length 함수를 이용해서 이름과 이름의 철자의 갯수(이름 글자 길이)를 출력하시오. 
SELECT ename,LENGTH(ename) FROM emp;
--☆ex57) 이름, 입사한 날짜부터 오늘까지 총 몇일 근무했는지 소수점 뒤에는 잘라서 출력하시오.
SELECT ename,TRUNC(SYSDATE-hiredate) FROM emp;
/* 설명) 
1. round : 반올림하는 함수(지정한 자릿수까지 반올림해서 표시)
2. trunc : 그냥 버리는 함수(지정한 자릿수까지 버림해서 표시)
3. mod : 나누기 연산 후 나머지 값 
*/
--ex058) 이름, 입사한 날짜부터 오늘까지 총 몇달 근무했는지 소수점 뒤에는 잘라서 출력하시오. 
SELECT ename,TRUNC(MONTHS_BETWEEN(SYSDATE,hiredate)) FROM emp;
/*
설명) 오늘 날짜 확인하는 방법 : select sysdate from dual;
날짜함수) 
 1. months_between : 날짜와 날짜 사이의 개월수 출력
  - 날짜 + 날짜 = 날짜
  - 날짜 - 숫자 = 날짜
  - 날짜 - 날짜 = 숫자
 2. add_months : 날짜에서 개월수를 더한 날짜
 3. next_day : 지정된 날짜에서 앞으로 돌아올 요일의 날짜를 출력
 4. last_day : 지정된 날짜에서 마지막 날짜를 출력
*/
--ex59) 오늘부터 100달 뒤의 날짜를 출력하시오.
SELECT SYSDATE, ADD_MONTHS(SYSDATE,100) FROM DUAL;
--ex60) 오늘부터 앞으로 돌아올 월요일의 날짜를 출력하시오. 
SELECT NEXT_DAY(SYSDATE,'월요일') FROM DUAL;
SELECT NEXT_DAY(SYSDATE,'월') FROM DUAL;
--ex61) 오늘부터 100달뒤 돌아올 금요일의 날짜를 출력하시오. 
SELECT NEXT_DAY(ADD_MONTHS(SYSDATE,100),'금요일') FROM DUAL;
SELECT NEXT_DAY(ADD_MONTHS(SYSDATE,100),'금') FROM DUAL;
--ex62) 이번달 말일의 날짜를 출력하시오. 
SELECT LAST_DAY(SYSDATE) FROM DUAL;
--ex63) 오늘부터 요번달 말일까지 총 몇일남았는지 출력하시오! 
SELECT LAST_DAY(SYSDATE)-SYSDATE FROM DUAL;
--SYSDATE: 숫자형임 
/*
※ 데이터 타입을 변환하는 함수
1. 문자로 형변환 :to_char
2. 숫자로 형변환 :to_number
3. 날짜로 형변환 :to_date
*/ 
--ex64) 오늘이 무슨 요일인지 출력하시오. 
SELECT TO_CHAR(SYSDATE,'day') FROM DUAL; --금요일
SELECT TO_CHAR(SYSDATE,'dy') FROM DUAL; --금
SELECT TO_CHAR(SYSDATE,'d') FROM DUAL; --6
SELECT TO_CHAR(SYSDATE,'DAY') FROM DUAL;
--ex65) 이름, 입사한 요일을 출력하시오. 
SELECT ename,TO_CHAR(hiredate,'day') FROM emp;
/*설명) 
날짜 포멧스트링(기초1의 볼륨1 4-12)
요일 : day, dy
년도 : YYYY, YY, RRRR, RR, year
달 : mm, mon, month
일 : dd
주 : ww, w, iw
시간 : hh, hh24
분 : mi
초 : ss
*/
--ex66) 오늘부터 200달 뒤에 돌아오는 날짜의 요일을 출력 
SELECT TO_CHAR(ADD_MONTHS(sysdate,200),'day') FROM DUAL;
--ex67) 이름과 입사한 년도를 출력하시오.
SELECT ename,TO_CHAR(hiredate,'YYYY') FROM emp;
--ex68) 1981년도에 입사한 사원들의 이름과 입사일을 출력하시오.
SELECT ename,hiredate FROM emp WHERE TO_CHAR(hiredate,'YYYY')=1981;
--ex69) 목요일에 입사한 사원들의 이름과 입사일, 입사한 요일을 출력하시오.
SELECT ename,TO_CHAR(hiredate,'day') FROM emp WHERE TO_CHAR(hiredate,'day')='목요일';
--☆ex71) 이름과 월급을 출력하는데 월급에 천단위를 부여하시오! (예: 3000 -> 3,000)
SELECT ename,TO_CHAR(sal,'999,999') FROM emp;
--ex72) 이름과 월급 * 5400을 출력하는데, 천단위와 백만단위를 콤마로 구분하시오.
SELECT ename,TO_CHAR(sal*5400,'999,999,999') FROM emp;
/* 설명) 
일반함수
1. nvl
2. decode
3. case
*/
SELECT CONCAT('안녕','하세요') FROM DUAL;
--ex73) 이름과 커미션을 출력하는데 커미션이 null인 사원들은 0으로 출력하시오.
SELECT ename,NVL(comm,0) FROM emp;
--설명) nvl 함수는 argument 양쪽의 데이터 타입을 맞춰야 한다.
--☆ex74) 이름과 커미션을 출력하는데 커미션이 null인 사원들은 no comm 이란 글씨로 출력하시오.
SELECT ename,NVL(comm,'no comm') FROM emp; --Error  --왜냐면 NVL(문자열,대체문자열) or NVL(숫자,대체숫자) 이렇게 NVL은 같은 데이터형끼리만 처리 가능하기 때문
SELECT ename,NVL(TO_CHAR(comm),'no comm') FROM emp; --정상수행

/*
<테이블>
 - 데이터 베이스 저장 공간
 - 2차원 구조를 가진다 : row + column 
<SQL>
1. DML (데이터 조작) => row 단위 조작 
 (※ 자바에서는 컬럼 여러개를 모은 것을 '레코드'라고 한다.) 
 1) 데이터 검색 (SELECT) 
  - 형식)
    SELECT *|column1,column2,...
    FROM table명
    {
        WHERE 조건식
        GROUP BY 그룹컬럼
        HAVING 그룹조건
        ORDER BY 칼럼명 ASC|DESC (ASC가 디폴트)
    }
 2) 데이터 추가 (INSERT)
 3) 데이터 수정 (UPDATE)
 4) 데이터 삭제 (DELETE)
2. DDL (데이터 정의) 
 1) CREATE (생성) => 데이터형과 제약조건을 잘 기억해야. 
 2) ALTER (수정) => 수정, 삭제, 추가
 3) DROP (삭제) => 테이블 완전 삭제.
 4) TRUNCATE (잘라내기) => 데이터만 삭제. 테이블은 그대로 있음. 
 5) RENAME => 이름변경 
3. DCL (데이터 제어) : DBA님들이 하시는 일.  
 1) 권한부여 : GRANT
 2) 권한해제 : REVOKE
4. TCL (일괄처리) : 트랜잭션
 1) COMMIT - 정상 수행(저장) 
 2) ROLLBACK - 비정상 수행(취소) 
*/

CREATE VIEW emp_view
AS SELECT * FROM emp;

DELETE FROM emp;
SELECT * FROM emp;
ROLLBACK;

--1. 원하는 컬럼만 설정해서 데이터 읽기
SELECT empno,ename,sal FROM emp;







