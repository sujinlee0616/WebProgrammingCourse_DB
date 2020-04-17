--2020.04.17 자유게시판_PL/SQL사용

--기존에 게시판 테이블 만들어놨었음 
DESC board;
/*
NO      NOT NULL NUMBER         
NAME    NOT NULL VARCHAR2(50)   
SUBJECT NOT NULL VARCHAR2(1000) 
CONTENT NOT NULL CLOB           
PWD     NOT NULL VARCHAR2(10)   
REGDATE          DATE           
HIT              NUMBER    
*/
SELECT * FROM board;


-- [게시판 목록 가지고 오기]
-- IN변수: pStart,pEnd 2개 --NUMBER니까 스칼라변수임.
-- Java로 치면, pStart,pEnd를 받아서(IN) 결과값은 VO로 리턴 (OUT)
CREATE OR REPLACE PROCEDURE boardListData(
    pStart NUMBER,
    pEnd NUMBER,
    pResult OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN pResult FOR
        SELECT no,subject,name,regdate,TO_CHAR(regdate,'YYYY-MM-DD') as dbday,hit,num
        FROM (SELECT no,subject,name,regdate,hit,rownum as num 
        FROM (SELECT no,subject,name,regdate,hit
        FROM board ORDER BY no DESC))
        WHERE num BETWEEN pStart AND pEnd;
END;
/


-- [총 페이지 구하기]
-- SELECT CEIL(COUNT(*)/10.0) INTO pTotal: pTotal 변수에다가 저 앞에 SELECT 문 실행한 값을 넣어라 
CREATE OR REPLACE PROCEDURE boardTotalPage(
    pTotal OUT NUMBER
)
IS
BEGIN
    SELECT CEIL(COUNT(*)/10.0) INTO pTotal
    FROM board;
END;
/

-- [글쓰기]
-- OUT변수는 없고 IN 변수만 있음 
-- IS~BEGIN 사이에서 변수 잡는다 
-- 오토커밋 아니라서 커밋 적어줘야함 
CREATE OR REPLACE PROCEDURE boardInsertData(
    pName board.name%TYPE,
    pSubject board.subject%TYPE,
    pContent board.content%TYPE,
    pPwd board.pwd%TYPE
)
IS
    pMax NUMBER:=0;
BEGIN
    SELECT NVL(MAX(no)+1,1) INTO pMax
    FROM board;
    
    INSERT INTO board VALUES(
        pMax,pName,pSubject,pContent,pPwd,SYSDATE,0
    );
    COMMIT;
END;
/

-- 참고) 모든 곳에 다 프로시저를 사용하지 않는 게 아니라, 보통 반복이 많은 곳에 사용함 
-- ex) 댓글 <== 댓글 사용하는데가 매우 많기 때문 
-- ex) 페이지 나누기 <== 이거 프로시저로 만들어놓으면 진짜 편하겠네!!!! ★★★


-- [상세보기,수정화면에서 보여줄 데이터 가져오기]
-- 글 수정할 떄도 수정화면에서 해당 글의 정보 다 받아와서 보여줘야하니까, 이 프로시저 만들어놓고 상세보기랑 수정하기 둘 다에서 쓰자.
-- 얘는 VO로 받아올 수 없으니까 CURSOR로 받아온다. 
-- 자바의 VO = 오라클의 CURSOR 
-- pType써서, 내용보기 할 때만 조회수 증가시키도록. (수정하기 할 때는 조회수 증가하지 않도록)
-- pType 1:상세보기, 2:수정하기
CREATE OR REPLACE PROCEDURE boardInfoData(
     pNo board.no%TYPE,
     pType NUMBER,
     pResult OUT SYS_REFCURSOR
)
IS
BEGIN
    IF(pType=1) THEN
        UPDATE board SET
        hit=hit+1
        WHERE no=pNo;
        COMMIT;
    END IF;
    
    OPEN pResult FOR
        SELECT no,name,subject,content,regdate,hit
        FROM board
        WHERE no=pNo;
END;
/

-- [수정하기] 
-- 매개변수에는 글자수 안 줌 ex) VARCHAR2(O) / VARCHAR2(10) (X)
-- IS~BEGIN 사이: 새로운 변수를 선언하는 곳. 
CREATE OR REPLACE PROCEDURE boardUpdate(
    pNo board.no%TYPE,
    pName board.name%TYPE,
    pSubject board.subject%TYPE,
    pContent board.content%TYPE,
    pPwd board.pwd%TYPE,
    pResult OUT VARCHAR2
)
IS
    db_pwd board.pwd%TYPE;
BEGIN
    SELECT pwd INTO db_pwd
    FROM board
    WHERE no=pNo;
    
    IF(db_pwd=pPwd) THEN
        pResult:='true';
        UPDATE board SET
        name=pName,
        subject=pSubject,
        content=pContent
        WHERE no=pNo;
        COMMIT;
    ELSE
        pResult:='false';
    END IF;
        
END;
/

SELECT * FROM board;

-- [글 삭제]
CREATE OR REPLACE PROCEDURE boardDeleteData(
    pNo board.no%TYPE,
    pPwd board.pwd%TYPE,
    pResult OUT VARCHAR2
)
IS
    db_pwd board.pwd%TYPE;
BEGIN
    SELECT pwd INTO db_pwd
    FROM board
    WHERE no=pNo;
    
    IF(pPwd=db_pwd) THEN
        pResult:='true';
        DELETE FROM board
        WHERE no=pNo;
        COMMIT;
    ELSE
        pResult:='false';
    END IF;
END;
/














