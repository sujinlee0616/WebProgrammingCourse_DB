--2020.04.23 ��۰Խ���_���,���� �����

--[��� �Խ��� ���̺� �����]
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



-- [��� ����Ʈ]
-- pStart,pEnd,pBno: �־��ִ� ����. IN����. 
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

-- [��� ����] 
-- pMax: �ڵ�������ȣ ���� ��.
-- IS~BEGIN ����: IN/OUT ������ �ƴ� �ʿ��� ���� ����� ��.
-- ����Ʈ �ִ� �÷��� INSERT ���� �ʾ���. �˾Ƽ� ä�����ϱ�...
-- ���� ���� �ٴ°� ���� �� ����
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

-- [��� totalpage]
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


-- ��� �ϳ� �־��...
INSERT INTO freeboard_reply(no,bno,id,name,msg,group_id) VALUES(
        1,34,'shim','��û��','����� �ø��ϴ�1',
        (SELECT NVL(MAX(group_id)+1,1) FROM freeboard_reply)
);
INSERT INTO freeboard_reply(no,bno,id,name,msg,group_id) VALUES(
        2,34,'shim','��û��','����� �ø��ϴ�2',
        (SELECT NVL(MAX(group_id)+1,1) FROM freeboard_reply)
);
INSERT INTO freeboard_reply(no,bno,id,name,msg,group_id) VALUES(
        3,34,'shim','��û��','����� �ø��ϴ�3',
        (SELECT NVL(MAX(group_id)+1,1) FROM freeboard_reply)
);
COMMIT;

-- �Լ� ȣ���ؼ� insert�ϴ°� �ξ� ���ϳ� 
CALL replyInsert(34,'hong','ȫ�浿','��ۿø� �Ϸ�');

SELECT * FROM freeboard_reply;















