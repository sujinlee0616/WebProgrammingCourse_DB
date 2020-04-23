--2020.04.23 댓글게시판_댓글,대댓글 만들기

--[댓글 게시판 테이블 만들기]
CREATE TABLE freeboard_reply(
	no NUMBER,
    bno NUMBER,
    id VARCHAR2(20),
    name VARCHAR2(34) CONSTRAINT free_name_nn NOT NULL,
    msg CLOB CONSTRAINT fr_msg_nn NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    group_id NUMBER,
    group_step NUMBER DEFAULT 0,
    group_tab NUMBER DEFAULT 0,
    root NUMBER DEFAULT 0,
    depth NUMBER DEFAULT 0,
    CONSTRAINT fr_no_pk PRIMARY KEY(no),
    CONSTRAINT fr_bno_fk FOREIGN KEY(bno)
    REFERENCES board(no),
    CONSTRAINT fr_id_fk FOREIGN KEY(id)
    REFERENCES member(id)
);

SELECT * FROM board;
SELECT * FROM member;
DESC freeboard_reply;



-- [댓글 리스트]
-- pStart,pEnd,pBno: 넣어주는 변수. IN변수. 
CREATE OR REPLACE PROCEDURE replyListData(
    pStart NUMBER,
    pEnd NUMBER,
    pBno freeboard_reply.bno%TYPE,
    pResult OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN pResult FOR 
        SELECT no,bno,id,name,msg,regdate,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday,group_tab,num
        FROM (SELECT no,bno,id,name,msg,regdate,group_tab,rownum as num
        FROM (SELECT no,bno,id,name,msg,regdate,group_tab
        FROM freeboard_reply 
        WHERE bno=pBno ORDER BY group_id DESC,group_step ASC))
        WHERE num BETWEEN pStart AND pEnd;
END;
/

-- [댓글 쓰기] 
-- pMax: 자동증가번호 만든 것.
-- IS~BEGIN 사이: IN/OUT 변수가 아닌 필요한 변수 만드는 곳.
-- 디폴트 있는 컬럼은 INSERT 하지 않았음. 알아서 채워지니까...
-- 아직 대댓글 다는건 구현 안 했음
CREATE OR REPLACE PROCEDURE replyInsert(
    pBno freeboard_reply.bno%TYPE,
    pId member.id%TYPE,
    pName member.name%TYPE,
    pMsg freeboard_reply.msg%TYPE    
)
IS
    pMax freeboard_reply.no%TYPE;
BEGIN
    SELECT NVL(MAX(no)+1,1) INTO pMax
    FROM freeboard_reply;
    INSERT INTO freeboard_reply(no,bno,id,name,msg,group_id) VALUES(
        pMax,pBno,pId,pName,pMsg,
        (SELECT NVL(MAX(group_id)+1,1) FROM freeboard_reply)
    );
    COMMIT;
END;
/

-- [댓글 totalpage]
CREATE OR REPLACE PROCEDURE replyTotalPage(
    pBno freeboard_reply.bno%TYPE,
    pTotal OUT NUMBER    
)
IS
BEGIN
    SELECT CEIL(COUNT(*)/10.0) INTO pTotal
    FROM freeboard_reply
    WHERE bno=pBno;
END;
/


-- 댓글 하나 넣어보자...
INSERT INTO freeboard_reply(no,bno,id,name,msg,group_id) VALUES(
        1,34,'shim','심청이','댓글을 올립니다1',
        (SELECT NVL(MAX(group_id)+1,1) FROM freeboard_reply)
);
INSERT INTO freeboard_reply(no,bno,id,name,msg,group_id) VALUES(
        2,34,'shim','심청이','댓글을 올립니다2',
        (SELECT NVL(MAX(group_id)+1,1) FROM freeboard_reply)
);
INSERT INTO freeboard_reply(no,bno,id,name,msg,group_id) VALUES(
        3,34,'shim','심청이','댓글을 올립니다3',
        (SELECT NVL(MAX(group_id)+1,1) FROM freeboard_reply)
);
COMMIT;

-- 함수 호출해서 insert하는게 훨씬 편하네 
CALL replyInsert(34,'hong','홍길동','댓글올릭 완료');

SELECT * FROM freeboard_reply;















