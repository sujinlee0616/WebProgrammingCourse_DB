-- DDL, DML 
/*
<DML>: Data Manipulation Language, 데이터 조작. 
 1. 데이터 검색 
    SELECT (SQL의 핵심!)
        1) 형식 2) 연산자,함수 3) JOIN, 4) Subquery 
 2. 데이터 추가
    INSERT 
    => INSERT INTO table명 VALUES(값1, 값2, ...)
 3. 데이터 수정
    UPDATE
    => UPDATE table명 SET 
       컬럼명=값, 컬럼명=값...
       WHERE 해당조건 => 중복이 없는 값이 들어가야. (ex.empno) 
 4. 데이터 삭제 
    DELETE
    => DELETE FROM table명
       WHERE 해당조건 => 중복이 없는 값이 들어가야. (ex.empno) 
    
    ==> 테이블에는 반드시 중복이 없는 값이 하나가 있어야 한다! (ex.empno) 
    
<테이블> : 저장 공간
 - 테이블명 규칙
   1) 알파벳이나 한글로 시작한다.
      영어 알파벳 대소문자 상관 없다. 
   2) 숫자 사용 가능 => 단, 맨 앞에는 올 수 없다. 
      ex) 2emp(X) emp2(O)
   3) 키워드는 사용 금지 (ex. 테이블명으로 order 사용 불가)
   4) 특수문자 사용 가능. ('_', '$'만 사용 가능) 
      ex) _emp (O) emp_dept (O)
   5) 테이블명의 길이는 제한이 없다. 단, 보통 3~10글자 정도로 짓는다. 
 - 테이블명 => 메모리 저장 공간 => 저장된 것을 볼 수는 없다 (이미지)  

<DDL> : Data Definition Language, 데이터 정의 
 - ROLLBACK이 없다. (사용자가 COMMMIT 안 해도 AUTOCOMMIT됨) 
 - ex. 테이블 잘못 만들면 ROLLBACK이 아니라 지우고 다시 만들어야.

1. 형식
   CREATE TABLE table명 )
        컬럼명 데이터형 [제약조건], ==> 제약조건 (column 레벨) 
        컬럼명 데이터형 [제약조건],
        컬럼명 데이터형 [제약조건],
        컬럼명 데이터형 [제약조건].
        [제약조건] ==> table 레벨
   )
   ※ 제약조건은 있어도/없어도 됨. 
2. 데이터형
   1) 문자형 : CHAR, VARCHAR2, CLOB 
    - CHAR : byte 단위 => 1~2000 byte. 고정 메모리. 
             ex) CHAR(10)='A'. ==> 한 글자밖에 안 되지만 고정 메모리라서 무조건 10Byte 사용한다. 
               ===============
               A \0 \0 \0 \0    => 글자수가 동일할 때 사용하면 편하다. (ex. Y/N, 남자/여자, 주민번호..)  
               ===============
    - VARCHAR2 : byte 단위 => 1~4000 byte. 가변 메모리. 
                 ex) VARCHAR2(5) ==> 'A' 저장 시 
                 ===
                  A 
                 ===
    - CLOB : byte 단위. => 4G 저장 가능. 가변 메모리. ==> 자기소개, 내용, 줄거리 등은 CLOB으로 저장. 
    
    - CLOB
   2) 숫자형 : NUMBER : 정수, 실수
    - NUMBER : 14자리 정수
    - NUMBER(4) : 4자리 정수까지 사용. 0~9999
    - NUMBER(7,2) : 총 자리수는 7자리 => 그 중 2자리가 실수. 
   3) 날짜형 
    - DATE : 날짜 => ★문자형으로 저장된다★ ==> '2020/02/07'과 같이 '' 붙여서 쓴다.
      일반적으로 많이 사용된다. 
    - TIMESTAMP : 데이터를 보완하기 위해 많이 사용 [  
   4) 기타형 : 이미지, 증명사진 ,동영상 => 폴더 => 경로명과 파일명만 저장 => 4G만 저장 가능. 
    - 파일형태 : BFILE
    - Binary 형태 : BLOB 
3. 제약조건
    1) PRIMARY KEY : 중복이 없는 값. NULL값을 허용하지 않는다. UNIQUE와 NOT NULL이 합쳐진 것. 
    2) UNIQUE : 중복이 없는 값. 그러나 NULL값을 허용한다. => '후보키'라고 불린다. 
    3) NOT NULL : 반드시 입력값이 존재. 
       ex) 회원가입시 '*'된 부분은 필수 입력사항입니다.
    4) FOREIGN KEY : 참조키. 참조 시 사용. 
       ex1) PRIMARY에 존재하는 값을 참조할 때 
       게시판 ==> 댓글 : 게시판의 번호를 참조
       예약 ==> 회원가입의 ID를 참조.
    5) CHECK ==> 원하는 데이터만 입력되게 하는 것
       ex) 성별 : CHECK(sex IN('남자','여자'))
       ex) 콤보박스UI/라디오버튼 데이터 저장 시 
    6) DEFAULT ==> 값이 없는 경우 지정된 값을 집어넣음. 
       ex) 날짜 등록 시 디폴트값을 SYSDATE로...
4. 추가, 수정 (ALTER)
    1) 추가 ADD
       ALTER TABLE table명 ADD 컬럼명 데이터형 [제약조건] ==> 제약조건 
       (※ 제약조건을 걸 때, NOT NULL, FOREIGN KEY, CHECK를 집어넣는건 불가능할 수도 있음. 
           예를 들어 이미 기존 데이터가 있는 상태에서는 제약조건이 안 걸릴 수도 있다...) 
    2) 수정 MODIFY 
       ALTER TABLE table명 MODIFY 컬럼 데이터형 
                                 ==== 반드시 테이블에 존재하는 컬럼
    3) 삭제 DROP
       ALTER TABLE table명 DROP COLUMN 컬럼명 
        
5. 삭제 (테이블 삭제)
    DROP TABLE table명 
    
6. 테이블, 컬럼명을 변경 
    RENAME TABLE '이전테이블명' TO '변경테이블명' 

    ==> 테이블 제작 
    1) 사용자 정의
    2) 기존 테이블 복사 
*/

-- 기존 테이블 복사 (CATS) 
CREATE TABLE myEmp
AS SELECT empno,ename,job,hiredate,sal,deptno FROM emp;
SELECT * FROM myEmp;
DROP TABLE myEmp;

-- 테이블을 복사 하면 제약조건이 사라지기 때문에, 제약조건을 체크해야한다!  
-- ==> 복사보단 VIEW를 쓰는게 더 좋다. (특히, read-only일때!) 
CREATE TABLE myEmp
AS SELECT empno,ename,job,hiredate,sal,dname,loc,grade
FROM emp,dept,salgrade
WHERE emp.deptno=dept.deptno 
AND sal BETWEEN losal AND hisal;

SELECT * FROM myEmp;
DESC myEmp;
DESC emp;

DROP TABLE myEMP;
-- 함부로 DROP 쓰지 마라! ROLLBACK도 안 됨!

DROP TABLE member;
--ex) 사용자 정의 테이블 생성
-- 어제(2/6) 만든 회원가입 폼 기반으로 필요한 테이블 만들기
CREATE TABLE member(
    id VARCHAR2(20) PRIMARY KEY, --PRIMARY KEY : 중복허용x & NOT NULL
    name VARCHAR2(51) NOT NULL,
    pwd VARCHAR2(20) NOT NULL,--※ 영문자: 1글자에 1byte. 한글 : 1글자에 2~3byte.
    phone VARCHAR2(13), 
    hp VARCHAR2(13),
    email VARCHAR2(100) UNIQUE, --UNIQUE : 중복허용O & NOT NULL 
    --email은 후보키: id 잊어비리면 이메일로 찾을 수 있음
    info CHAR(12) CHECK(info IN ('일반기업','공공기관')), --info: 소속정보. 4글자로 항상 글자수 똑같으니까 CHAR로 만들었다. 
    post VARCHAR2(7) NOT NULL,
    addr1 VARCHAR2(500) NOT NULL,
    addr2 VARCHAR2(100),
    regdate DATE DEFAULT SYSDATE
);
DESC member;

/*
<게시판>
게시물번호
이름
이메일
제목
내용
비밀번호
작성일
조회수
*/
--ex) 게시판 테이블 만들기 (테이블명: board) 
CREATE TABLE board2(
    boardno NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100),
    title VARCHAR2(50) NOT NULL,
    content CLOB NOT NULL,
    pwd VARCHAR2(50) NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    hit NUMBER DEFAULT 0
);
DESC board2;

--ex) 맛집 서비스 상세페이지 만들기 (테이블명: food)
CREATE TABLE food(
    restno NUMBER PRIMARY KEY,
    img VARCHAR2(200),
    addr1 VARCHAR2(100) NOT NULL,
    addr2 VARCHAR2(100) NOT NULL,
    tel VARCHAR2(100) NOT NULL,
    category VARCHAR2(100),
    price VARCHAR2(100),
    parking VARCHAR2(100),
    ophr VARCHAR2(100),
    resthr VARCHAR2(100),
    lastorder VARCHAR2(100),
    website VARCHAR2(200),
    holiday VARCHAR2(100),
    menu VARCHAR2(100),    
    regdate DATE DEFAULT SYSDATE
);
DESC food;





