--2020.04.17 �����Խ���_PL/SQL���

--������ �Խ��� ���̺� ���������� 
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


-- [�Խ��� ��� ������ ����]
-- IN����: pStart,pEnd 2�� --NUMBER�ϱ� ��Į�󺯼���.
-- Java�� ġ��, pStart,pEnd�� �޾Ƽ�(IN) ������� VO�� ���� (OUT)
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


-- [�� ������ ���ϱ�]
-- SELECT CEIL(COUNT(*)/10.0) INTO pTotal: pTotal �������ٰ� �� �տ� SELECT �� ������ ���� �־�� 
CREATE OR REPLACE PROCEDURE boardTotalPage(
    pTotal OUT NUMBER
)
IS
BEGIN
    SELECT CEIL(COUNT(*)/10.0) INTO pTotal
    FROM board;
END;
/

-- [�۾���]
-- OUT������ ���� IN ������ ���� 
-- IS~BEGIN ���̿��� ���� ��´� 
-- ����Ŀ�� �ƴ϶� Ŀ�� ��������� 
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

-- ����) ��� ���� �� ���ν����� ������� �ʴ� �� �ƴ϶�, ���� �ݺ��� ���� ���� ����� 
-- ex) ��� <== ��� ����ϴµ��� �ſ� ���� ���� 
-- ex) ������ ������ <== �̰� ���ν����� ���������� ��¥ ���ϰڳ�!!!! �ڡڡ�


-- [�󼼺���,����ȭ�鿡�� ������ ������ ��������]
-- �� ������ ���� ����ȭ�鿡�� �ش� ���� ���� �� �޾ƿͼ� ��������ϴϱ�, �� ���ν��� �������� �󼼺���� �����ϱ� �� �ٿ��� ����.
-- ��� VO�� �޾ƿ� �� �����ϱ� CURSOR�� �޾ƿ´�. 
-- �ڹ��� VO = ����Ŭ�� CURSOR 
-- pType�Ἥ, ���뺸�� �� ���� ��ȸ�� ������Ű����. (�����ϱ� �� ���� ��ȸ�� �������� �ʵ���)
-- pType 1:�󼼺���, 2:�����ϱ�
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

-- [�����ϱ�] 
-- �Ű��������� ���ڼ� �� �� ex) VARCHAR2(O) / VARCHAR2(10) (X)
-- IS~BEGIN ����: ���ο� ������ �����ϴ� ��. 
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

-- [�� ����]
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














