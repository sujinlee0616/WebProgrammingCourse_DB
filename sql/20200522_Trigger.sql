--2020.05.22(금) Trigger

/* 
 [Trigger]
 - 데이터베이스에 미리 정해놓은 조건을 만족하면 자동으로 수행이 되는 이벤트 
 - 자기 테이블이 아니라, 다른 테이블에서 수행 
 - INSERT/UPDATE/DELETE만 적용. (SELECT는 Trigger 적용X) 
 - 오토커밋. (수동으로 COMMIT 불가) 
 - 단점) 자바에서 확인할 수가 없다.
 - 형식) 생성
   CREATE [OR REPLACE] TRIGGER trigger_name
   BEFORE|AFTER (INSERT,UPDATE,DELETE) ON table_name 
   BEGIN
        SQL문(다른 테이블에 대한 SQL ==> 실행) 
   END;
   /
 - 형식) 삭제
   DROP TRIGGER trigger_name 
 - ※ 프로시저/트리거를 만들 때 CREATE/DROP 은 오토커밋이므로 따로 커밋날릴 필요 없음. 
 
*/

CREATE TABLE 입고(
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);
CREATE TABLE 출고(
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER
);
DROP TABLE 재고;
CREATE TABLE 재고(
    품번 NUMBER,
    수량 NUMBER,
    금액 NUMBER,
    총금액 NUMBER
);

-- ==================== [Trigger] 입고하면 재고 테이블 변경 시키기 ==================== 
-- INSERT 입고 VALUES(1,5,500) 
CREATE OR REPLACE TRIGGER 입고_Trigger
AFTER INSERT ON 입고 -- 입고에 insert 되고 난 이후에 
FOR EACH ROW
DECLARE
    -- 변수 선언 
    v_cnt NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_cnt 
    FROM 재고
    WHERE 품번=:NEW.품번;
    
    IF(v_cnt=0) THEN
        INSERT INTO 재고 VALUES(:NEW.품번,:NEW.수량,:NEW.금액,:NEW.수량*:NEW.금액);
    ELSE 
        UPDATE 재고 SET
        수량=수량+:NEW.수량,
        총금액=총금액+(:NEW.수량*:NEW.금액)
        WHERE 품번=:NEW.품번;
    END IF;
END;
/

-- 입고에 데이터를 넣어보면,재고에도 데이터가 들어오는 것을 볼 수 있다. 
INSERT INTO 입고 VALUES(1,5,1000);
COMMIT;
SELECT * FROM 입고;
SELECT * FROM 재고;

INSERT INTO 입고 VALUES(1,2,1000);
COMMIT;
SELECT * FROM 입고; --입고: 입고 히스토리 
SELECT * FROM 재고; --재고: 품목번호별 최종 재고수량/금액


-- ==================== [Trigger] 출고하면 재고 테이블 변경 시키기 ==================== 
CREATE OR REPLACE TRIGGER 출고_Trigger
AFTER INSERT ON 출고 
FOR EACH ROW
DECLARE 
    v_cnt NUMBER;
BEGIN
    SELECT 수량-:NEW.수량 INTO v_cnt
    FROM 재고
    WHERE 품번=:NEW.품번;
    
    IF(v_cnt=0) THEN
        DELETE FROM 재고
        WHERE 품번=:NEW.품번;
    ELSE
        UPDATE 재고 SET
        수량=수량-:NEW.수량,
        총금액=총금액-(:NEW.수량*:NEW.금액)
        WHERE 품번=:NEW.품번;
    END IF;
END;
/

-- 입고/출고 데이터를 넣어보면,재고 데이터가 변경되는 것을 볼 수 있다. 
INSERT INTO 입고 VALUES(2,10,2000);
COMMIT;
SELECT * FROM 입고;
SELECT * FROM 재고;

INSERT INTO 출고 VALUES(2,5,2000);
COMMIT;
SELECT * FROM 출고;
SELECT * FROM 재고;

INSERT INTO 출고 VALUES(1,7,1000);
COMMIT;
SELECT * FROM 출고;
SELECT * FROM 재고;




-- ====================================== SpringSessionProject1 ======================================

SELECT * FROM music_reply;

-- [테이블 생성] 음악 댓글 테이블 생성 
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

-- hit 올리는 Trigger 생성 
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
    sex VARCHAR2(10) CHECK(sex IN('남','여'))
);
INSERT INTO trans_member VALUES(1,'홍길동','남');
INSERT INTO trans_member VALUES(2,'홍길동','남');
COMMIT;

DELETE FROM trans_member;
COMMIT;

SELECT * FROM trans_member;













