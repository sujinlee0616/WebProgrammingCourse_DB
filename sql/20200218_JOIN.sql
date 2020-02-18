--2020.02.18(화) 
/*
<JOIN>
 - 데이터를 모아서 처리 ===> JOIN 
 - 주의) 컬럼명이 일치하지 않을 수도 있다. 단, 같은 값을 가지고 있어야 한다.
   ex) emp => mgr. empno : 컬럼명은 다르지만 같은 값을 가지고 있음. 
 
 1. INNER JOIN (교집합)
  - 많이 사용됨. 
  - NULL값을 처리할 수 없다. 
  1) EQUI-JOIN: '=' 연산자를 사용
    ⅰ) 오라클 조인
        SELECT A.a B.b 
        FROM A,B
        WHERE A.c=B.c
    ⅱ) 표준화된 조인(ANSI JOIN)
        SELECT A.a,B.b
        FROM A (INNER) JOIN B
        ON A.c=B.c
  2) NON-EQUI-JOIN: '='이 아닌 다른 연산자를 사용. 비교연산자, BETWEEN ~ AND, IN
    ⅰ) 오라클 조인
        SELECT A.a, B.b 
        FROM A,B
        WHERE A.c BETWEEN AND B.C1 AND B.C2
    ⅱ) 표준화된 조인(ANSI JOIN)
        SELECT A.a, B.b 
        FROM A JOIN B
        WHERE A.c BETWEEN AND B.C1 AND B.C2
  
 2. OUTER JOIN 
  - NULL을 포함해서 데이터를 가지고 올 수 있다. 
  1) LEFT OUTER JOIN
    ⅰ) 오라클 조인
        SELECT A.a,B.b
        FROM A,B
        WHERE A.c=B.c(+)
    ⅱ) 표준 조인
        SELECT A.a,B.b
        FROM A LEFT OUTER JOIN B
        ON A.c=B.c

  2) RIGHT OUTER JOIN
    ⅰ) 오라클 조인
        SELECT A.a,B.b
        FROM A,B
        WHERE A.c(+)=B.c
    ⅱ) 표준 조인
        SELECT A.a,B.b
        FROM A RIGHT OUTER JOIN B
        ON A.c = B.c
  3) FULL OUTER JOIN - 표준조인만 있음. 
    ⅰ) 표준 조인
        SELECT A.a,B.b
        FROM A FULL OUTER JOIN B
        ON A.c = B.c
*/

/*
<SubQuery>
 - SQL 문장을 여러개 모아서 처리

 1. 단일행 서브쿼리: 결과값이 한 개 (SELECT 뒤에 컬럼 1개 사용) 
    ex) 10
  1) 형식) Main SQL ==> 실행 
          WHERE 컬럼명 연산자 (SubQuery)
                            ========= 실행 결과값
     ex)  SELECT * 
          FROM emp
          WHERE sal<(SELECT AVG(sal) FROM emp) ==> TRIGGEER          

 2. 다중행 서브쿼리: 결과값이 한 개 씩인데 여러줄이 나오는 것. (SELECT 뒤에 컬럼 1개 사용)
    ex) 10
        20
        30
  1) 형식) 
  2) 연산자: IN, ANY, ALL 3개 연산자를 가지고 있다. 
   - ANY, ALL 보다는 IN, MAX, MIN을 더 많이 사용함
     ex)  emp에 distinct한 sal이 100,200,300,400,500일 때 
          SELECT * 
          FROM emp
          WHERE deptno IN(SELECT DISTINCT deptno FROM emp); -- ==> 10,20,30
                       > ANY(SELECT DISTINCT deptno FROM emp); -- ==> 10보다 큰 애는 다 나옴 ==> deptno=20,30
                       < ANY(SELECT DISTINCT deptno FROM emp); -- ==> 30보다 작은 애는 다 나옴 ===> deptno=10,20
                       <= ALL(SELECT DISTINCT deptno FROM emp); -- ==> deptno=10 
                       >= ALL(SELECT DISTINCT deptno FROM emp); -- ==> 모든 deptno보다 크거나 같은 애 ==> 최대값 ==> deptno=30  
                       <= (SELECT MIN(deptno) FROM emp); -- ===> 최소값보다 작거나 같은 애 ==> 최소값 ==> deptno=10
                       >= (SELECT MAX(deptno) FROM emp);  -- ===> 최대값보다 크거나 같은 애 ==> 최대값 ==> deptno=30
        
 3. 스칼라 서브쿼리: 컬럼을 대신해서 사용 
  - 장점: 속도가 빠름. (속도가 빨라서 조인 대신 사용하기도 한다)
  - 단점: SQL 문장이 길어진다. 

 4. 인라인뷰: 테이블을 대신해서 사용
  - FROM 다음 SELECT가 들어감 
  - 보안이 필요한 곳, 페이징 기법, TOP-N에 많이 사용. 
*/

-- ex1) KING의 부서에서 근무하는 사원의 이름, 입사일, 직위를 가져와라. 
SELECT * FROM emp;
SELECT ename, hiredate, job
FROM emp
WHERE deptno=(SELECT deptno FROM emp WHERE ename='KING'); 

-- ex2) DALLAS에서 근무하는 사원의 모든 정보를 출력해라. (emp, dept 테이블) 
SELECT * FROM dept;
SELECT * 
FROM emp
WHERE deptno=(SELECT deptno FROM dept WHERE loc='DALLAS');

-- ex3) IN, MAX, ANY, ALL
--IN
SELECT * FROM emp
WHERE deptno IN(SELECT DISTINCT deptno FROM emp);
--MAX
SELECT * FROM emp
WHERE deptno <(SELECT MAX(deptno) FROM emp);
--MIN
SELECT * FROM emp
WHERE deptno >(SELECT MIN(deptno) FROM emp);
-->ANY ==> 최대값??? ===> 다시 확인 deptno=20,30
SELECT * FROM emp
WHERE deptno >ANY(SELECT deptno FROM emp); 
-- <ANY ==> 최소값???? ===> 다시 확인 
SELECT * FROM emp
WHERE deptno <ANY(SELECT deptno FROM emp); 
-->=ALL ==> 최대값. deptno=30 
SELECT * FROM emp
WHERE deptno >=ALL(SELECT deptno FROM emp); 
--<=ALL ==> 최소값. deptno=10
SELECT * FROM emp
WHERE deptno <=ALL(SELECT deptno FROM emp); 


--인라인뷰: FROM 뒤에 없는 컬럼은 SELECT에서 가져올 수 없다. 
SELECT empno,ename,job,hiredate,sal,dname,loc,sal,grade
FROM (SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno
AND sal BETWEEN losal AND hisal);


--rownum
SELECT ename,job,hiredate,sal,rownum
FROM emp;

SELECT ename,job,hiredate,sal,rownum
FROM emp
WHERE rownum<=5;

--ex) 입사늦은순 1~5등 뽑기. 
--입사가 늦은 사원 5명을 출력. 이름, 직위, 급여, 입사일 출력. ==> 인라인뷰 사용. TOP-N. 
SELECT ename, job, sal, hiredate
FROM (SELECT ename, job, sal, hiredate FROM emp ORDER BY hiredate DESC)
WHERE rownum<=5;
SELECT ename, job, sal, hiredate, rownum
FROM (SELECT ename, job, sal, hiredate FROM emp ORDER BY hiredate DESC)
WHERE rownum BETWEEN 1 AND 5;

--인라인뷰를 사용하면 TOP-N은 뽑을 수 있는데 중간순위는 뽑을 수 없다. ㅠㅠ ex) 입사일 늦은 순서로 6~10번째 애들을 뽑아오고 싶음 
SELECT ename, job, sal, hiredate,rownum
FROM (SELECT ename, job, sal, hiredate FROM emp ORDER BY hiredate DESC)
WHERE rownum BETWEEN 6 AND 10; --불가능. 

--ex) 입사늦은순 6~11등 뽑기. 
--페이징에서도 쓰는 방법 ★★★
--위의 애를 서브쿼리로 쓰면, 중간순위 애들도 뽑아올 수 있다. ==> SELECT가 3개 ㅋㅋ ==> 요런식으로 페이징도 만들 수 있다. 
SELECT ename, job, sal, hiredate,num
FROM (SELECT ename, job, sal, hiredate,rownum as num
FROM (SELECT ename, job, sal, hiredate FROM emp ORDER BY hiredate DESC))
WHERE num BETWEEN 6 AND 10; 

--JOIN으로 풀기 
SELECT ename,job,dname,loc
FROM emp,dept
WHERE emp.deptno=dept.deptno;

--스칼라 서브쿼리 
--이런거 불가능. SELECT에서 갖고오는 값이 1개,1개,14개씩 이므로 매칭 불가.  
--SELECT에서 갖고 오는 값은 1개씩이어야!!
SELECT ename,job,(SELECT dname FROM emp,dept WHERE emp.deptno=dept.deptno)
FROM emp,dept;
--이렇게는 가능. JOIN 안 걸면서 다른 테이블에 있는 컬럼 갖고 오는 방법도 있음. 
SELECT ename,job,(SELECT dname FROM dept WHERE emp.deptno=dept.deptno)
FROM emp,dept;
--당연히 이렇게도 가능. 
SELECT ename,job,(SELECT dname FROM dept WHERE emp.deptno=dept.deptno),(SELECT loc FROM dept WHERE emp.deptno=dept.deptno)
FROM emp,dept;


DESC movie;
SELECT * FROM movie;

--상영영화(type=1) 페이징 처리: 1page 
SELECT poster, title, score, regdate, num
FROM (SELECT poster, title, score, regdate, rownum as num
      FROM (SELECT poster, title, score, regdate FROM movie WHERE type=1))
WHERE num BETWEEN 1 AND 12;

--상영영화(type=1) 페이징 처리: 2page
SELECT poster, title, score, regdate, num
FROM (SELECT poster, title, score, regdate, rownum as num
      FROM (SELECT poster, title, score, regdate FROM movie WHERE type=1))
WHERE num BETWEEN 13 AND 24;

SELECT * FROM movie
WHERE type=4; 
--개봉예정영화(type=2) 페이징 처리: 7page

CREATE TABLE news(
    title VARCHAR2(4000) CONSTRAINT news_title_nn NOT NULL,
    poster VARCHAR2(1000) CONSTRAINT news_poster_nn NOT NULL,
    link VARCHAR2(300) CONSTRAINT news_link_nn NOT NULL,
    author VARCHAR2(200) CONSTRAINT news_author_nn NOT NULL,
    regdate VARCHAR2(100) CONSTRAINT news_regdate_nn NOT NULL,
    content CLOB CONSTRAINT news_content_nn NOT NULL
);

DESC news;
SELECT * FROM news;
DROP TABLE news;







