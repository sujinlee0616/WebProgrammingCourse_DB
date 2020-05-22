--2020.05.22(��) Trigger

/* 
 [Trigger]
 - �����ͺ��̽��� �̸� ���س��� ������ �����ϸ� �ڵ����� ������ �Ǵ� �̺�Ʈ 
 - �ڱ� ���̺��� �ƴ϶�, �ٸ� ���̺��� ���� 
 - INSERT/UPDATE/DELETE�� ����. (SELECT�� Trigger ����X) 
 - ����Ŀ��. (�������� COMMIT �Ұ�) 
 - ����) �ڹٿ��� Ȯ���� ���� ����.
 - ����) ����
   CREATE [OR REPLACE] TRIGGER trigger_name
   BEFORE|AFTER (INSERT,UPDATE,DELETE) ON table_name 
   BEGIN
        SQL��(�ٸ� ���̺� ���� SQL ==> ����) 
   END;
   /
 - ����) ����
   DROP TRIGGER trigger_name 
 - �� ���ν���/Ʈ���Ÿ� ���� �� CREATE/DROP �� ����Ŀ���̹Ƿ� ���� Ŀ�Գ��� �ʿ� ����. 
 
*/

CREATE TABLE �԰�(
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER
);
CREATE TABLE ���(
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER
);
DROP TABLE ���;
CREATE TABLE ���(
    ǰ�� NUMBER,
    ���� NUMBER,
    �ݾ� NUMBER,
    �ѱݾ� NUMBER
);

-- ==================== [Trigger] �԰��ϸ� ��� ���̺� ���� ��Ű�� ==================== 
-- INSERT �԰� VALUES(1,5,500) 
CREATE OR REPLACE TRIGGER �԰�_Trigger
AFTER INSERT ON �԰� -- �԰� insert �ǰ� �� ���Ŀ� 
FOR EACH ROW
DECLARE
    -- ���� ���� 
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt 
    FROM ���
    WHERE ǰ��=:NEW.ǰ��;
    
    IF(v_cnt=0) THEN
        INSERT INTO ��� VALUES(:NEW.ǰ��,:NEW.����,:NEW.�ݾ�,:NEW.����*:NEW.�ݾ�);
    ELSE 
        UPDATE ��� SET
        ����=����+:NEW.����,
        �ѱݾ�=�ѱݾ�+(:NEW.����*:NEW.�ݾ�)
        WHERE ǰ��=:NEW.ǰ��;
    END IF;
END;
/

-- �԰� �����͸� �־��,����� �����Ͱ� ������ ���� �� �� �ִ�. 
INSERT INTO �԰� VALUES(1,5,1000);
COMMIT;
SELECT * FROM �԰�;
SELECT * FROM ���;

INSERT INTO �԰� VALUES(1,2,1000);
COMMIT;
SELECT * FROM �԰�; --�԰�: �԰� �����丮 
SELECT * FROM ���; --���: ǰ���ȣ�� ���� ������/�ݾ�


-- ==================== [Trigger] ����ϸ� ��� ���̺� ���� ��Ű�� ==================== 
CREATE OR REPLACE TRIGGER ���_Trigger
AFTER INSERT ON ��� 
FOR EACH ROW
DECLARE 
    v_cnt NUMBER;
BEGIN
    SELECT ����-:NEW.���� INTO v_cnt
    FROM ���
    WHERE ǰ��=:NEW.ǰ��;
    
    IF(v_cnt=0) THEN
        DELETE FROM ���
        WHERE ǰ��=:NEW.ǰ��;
    ELSE
        UPDATE ��� SET
        ����=����-:NEW.����,
        �ѱݾ�=�ѱݾ�-(:NEW.����*:NEW.�ݾ�)
        WHERE ǰ��=:NEW.ǰ��;
    END IF;
END;
/

-- �԰�/��� �����͸� �־��,��� �����Ͱ� ����Ǵ� ���� �� �� �ִ�. 
INSERT INTO �԰� VALUES(2,10,2000);
COMMIT;
SELECT * FROM �԰�;
SELECT * FROM ���;

INSERT INTO ��� VALUES(2,5,2000);
COMMIT;
SELECT * FROM ���;
SELECT * FROM ���;

INSERT INTO ��� VALUES(1,7,1000);
COMMIT;
SELECT * FROM ���;
SELECT * FROM ���;




-- ====================================== SpringSessionProject1 ======================================

SELECT * FROM music_reply;

-- [���̺� ����] ���� ��� ���̺� ���� 
CREATE TABLE music_reply2(
    no NUMBER PRIMARY KEY,
    mno NUMBER,
    id VARCHAR2(20) NOT NULL,
    msg CLOB NOT NULL,
    regdate DATE DEFAULT SYSDATE,
    group_id NUMBER,
    group_step NUMBER DEFAULT 0,
    group_tab NUMBER DEFAULT 0,
    root NUMBER  DEFAULT 0,
    depth NUMBER DEFAULT 0,
    CONSTRAINT mr2_mno_fk FOREIGN KEY(mno)
    REFERENCES music_genie(mno)
);

-- hit �ø��� Trigger ���� 
CREATE OR REPLACE TRIGGER music_trigger
AFTER INSERT ON music_reply2
FOR EACH ROW
BEGIN
    UPDATE music_genie SET
    hit=hit+1
    WHERE mno=:NEW.mno;
END;
/

-- ==================== [Transaction] ==================== 
CREATE TABLE trans_member(
    no NUMBER PRIMARY KEY,
    name VARCHAR2(20) NOT NULL,
    sex VARCHAR2(10) CHECK(sex IN('��','��'))
);
INSERT INTO trans_member VALUES(1,'ȫ�浿','��');
INSERT INTO trans_member VALUES(2,'ȫ�浿','��');
COMMIT;

DELETE FROM trans_member;
COMMIT;

SELECT * FROM trans_member;













