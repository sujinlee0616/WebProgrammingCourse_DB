-- 2020-01-30 날짜함수 

/*
1. SYSTEM : 시스템의 시간을 읽어올 때 
 - 출력은 날짜로 하지만 실제로는 숫자. ==> 연산됨 (+1, -1 등..) 
 - ex) SYSDATE+10 => 10일 후 
 - 등록할 때 많이 사용. ex) 게시판, 회원가입
 --ex) 
 SELECT SYSDATE "오늘", SYSDATE + 1 "내일", SYSDATE + 2 "모레" FROM DUAL;
 
2. MONTHS_BETWEEN : 기간의 개월수를 가지고 온다 => 숫자. 
 - 년도+월+일+시간+분+초 => 소숫점까지 나온다. 
 --ex)
 SELECT last_name,hire_Date,ROUND(MONTHS_BETWEEN(SYSDATE,hire_date),0) as "근무개월",ROUND(MONTHS_BETWEEN(SYSDATE,hire_date)/12,0) as "년차" FROM employees; 

3. NEXT_DAY : 기준일자에서 지정한 요일이 다음번에 오는게 언제인지 
 - 형식 : NEXT_DAY('기준일자', '찾을요일')
 - ex) 다음번 목요일은 몇일? 
 --ex)
 --ex) 
 SELECT NEXT_DAY(SYSDATE,'목') FROM DUAL;
 SELECT NEXT_DAY(SYSDATE,'금') FROM DUAL;

 
4. LAST_DAY : 월의 마지막 날짜
 --ex) 
 SELECT LAST_DAY(SYSDATE) FROM DUAL;
 SELECT LAST_DAY(ADD_MONTHS(SYSDATE,1)) FROM DUAL;
 --ex) 20년 8월의 마지막 날짜를 구해라
 SELECT LAST_DAY('20/08/01') FROM DUAL;
 
5. ADD_MONTHS
 - 주어진 날짜에 개월을 더함 
 --ex)
 SELECT ADD_MONTHS('19/12/02',6) FROM DUAL;
 
*/

--[Mini Quiz] 
--1) 2017년에 만들어진(영화의 제목에 (2017)되어 있는 것) 영화의 제목을 중복없이 출력
SELECT DISTINCT title FROM movie 
WHERE title LIKE '%(2017)';

--2) 장르가 코미디인 영화의 제목과 감독, 출연, 장르, 개봉일을 출력하라.  
SELECT title,director,actor,genre,regdate FROM movie 
WHERE genre LIKE '%코미디%';

--3) 현재 상영중인 영화의 모든 정보를 출력하라. 
SELECT * FROM movie
WHERE type=1;

--4) 장르가 애니메이션과 코미디인 영화의 모든 정보를 출력
SELECT * FROM movie
WHERE genre LIKE '%코미디%' AND genre LIKE '%애니메이션%';

--5) 시간이 100분 이하인 영화를 출력
SELECT * FROM movie
WHERE RTRIM(time,'분')<=100;

--6) 관람등급이 '15세이상관람가'인 영화를 출력
SELECT * FROM movie
WHERE grade='15세이상관람가';
SELECT * FROM movie
WHERE SUBSTR(grade,1,2)='15';

--6-1) 관람등급이 '15세이상관람가'이거나 그것보다 더 높은 영화를 출력  <==이거 어떻게 할 수 있을까? 


--7) 평점이 가장 높은 영화의 제목과 평점을 위에서 5개 출력 ★★★
SELECT title,score,rownum --rownum : 고정. 
FROM (SELECT title,score FROM movie ORDER BY score DESC) --From 테이블을 내림차순으로 정렬했기때문에 rownum은 점수높은순으로 번호가 매겨진다. 
WHERE rownum<=5;

--8) 영화를 만들어진 년도 오름차순으로 (영화 제목에 (2017) 있는 애, (2018), (2019) 있는 애 순으로...) 영화의 제목을 중복없이 출력
--내 방식 : LENGTH 사용 
SELECT DISTINCT title FROM MOVIE
ORDER BY SUBSTR(title,LENGTH(title)-4,4) ASC; 
--선생님 방식 : INSTR 사용  <== 다시 한 번 보자 
SELECT DISTINCT title FROM MOVIE
ORDER BY SUBSTR(title,INSTR(title,'(',1)+1,4) ASC;
--                    ================== INSTR로 숫자 가져옴
--                    ==================== SUBSTR의 시작번호 : INSTR(title,'(',1)+1
--                    INSTR('비교할 대상', '비교하고자하는 값', 비교를 시작할 위치, 검색된 결과의 순번)


--9) 2020.01.15 ~ 2020.02.20 사이에 개봉하는 영화를 출력해라.
SELECT * FROM movie
WHERE REPLACE(SUBSTR(regdate,3,8),'.','/') BETWEEN '20/01/15' AND '20/02/20';

SELECT * FROM movie;

-- 이거 왜 안됨? 
SELECT * FROM movie
WHERE 
(SUBSTR(REGDATE,1,4)='2020' AND (SUBSTR(REGDATE,6,2)='01' AND to_number(SUBSTR(REGDATE,9,2))>=15))
OR
(SUBSTR(REGDATE,1,4)='2020' AND (SUBSTR(REGDATE,6,2)='02' AND to_number(SUBSTR(REGDATE,9,2))<=20));

--10) 감독이 '김태윤'인 영화를 출력하라.
SELECT * FROM movie
WHERE LTRIM(SUBSTR(director,INSTR(director,')',1)+1,4))='김태윤';





--연습용 Bistro 테이블 생성 
CREATE TABLE bistro(
    bistroId NUMBER(4), --레스토랑 넘버 (ex. 8472275)
    title VARCHAR2(1000), --가게명 
    score NUMBER(4,1) --평점
);

ALTER TABLE bistro ADD(mno NUMBER(4));

ALTER TABLE bistro DROP COLUMN bistroId;









