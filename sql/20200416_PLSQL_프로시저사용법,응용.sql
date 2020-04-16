--2020.04.16(��) ���ν��� ����

/*
    �ڹ�: �޼ҵ�
    ����Ŭ: ���ν���
    �� [����] ����Ŭ���� '���ν���'�� '�Լ�'�� ����
     - ���ν���: ��� ó��. ������ ����O.
     - �Լ�: �ݺ������� �Ǵ� ���. ������ ����X. �ַ� SELECT �ڿ� �ٴ´�. 
            ex) SELECT AVG(math) FROM student;
                Hakbun  name    kor     eng     math 
                1       ȫ�浿1    90      80     70 
                2       ȫ�浿2    80      80     70 
                3       ȫ�浿2    70      80     70 
*/

/*
    [PL/SQL�� ����]
    
    1. ���� ===> ��������, �Ű������� ��� 
     - �Ϲݺ���: ������ ��������(NUMBER,VARCHAR2,DATE...): ��Į�� ���� 
       ex) SELECT CEIL(COUNT(*)/30.0) FROM chef 
           : �̷��ֵ��� CEIL������ %TYPE �̷��ַ� �޾ƿ� �� ���ݾ� ==> �̷� �ֵ��� ��Į�� ������ �޴´�. 
     - ���� ���̺��� ���������� ���� ��: %TYPE
       ����) ���̺��.�÷�%TYPE
     - ���̺� ��ü �����͸� ���� ��: %ROWTYPE
       ����) ���̺��%ROWTYPE ==> VOó�� ����� �� �ִ�.  
     - ����� ����: TYPE ������ IS RECORD()
       ex) subquery�� join �ɷ����� ��
     - CURSOR: �������� RECORD�� ������ ��� 
     
    2. ������
     - ���������: +,-,*,/
     - ��������: AND, OR, NOT
     - �񱳿�����: =, !=(<>), <, >, <=, >=
     - ���ڿ�����: ||
     - NULL������: IS NULL, IS NOT NULL
     - �Ⱓ, ����: BETWEEN ~ AND 
     - ���� ���ڿ�: LIKE (%,_)
     - ����������NOT
     
    3. ���
    1) IF ���� THEN 
        ���౸��
       END IF;
    2) IF ���� THEN
        ���౸��
       ELSE
        ���౸��
       END IF;
    3) IF ���� THEN
        ���౸��
       ELSIF ���� THEN
        ���౸��
       END IF;
    4) LOOP
    5) WHILE
    6) FOR
*/

/*
    [PROCEDURE, FUNCTION, TRIGGER]
    1. PROCEDURE
     - ���ó�� (�޼ҵ�). �������� �������� �ʴ´�.
       => �Ű������� �̿��ؼ� �����͸� �޾ƿ��� �����Ѵ�. 
     1) ���� 
        (1)IN ����(����Ʈ) ==> Call By Value 
          - DML�� IN������� �����ϸ� �ȴ�. INSERT, UPDATE, DELETE ���� �� ���� �� ���� �ֵ�.
        (2)OUT ���� ==> Call By Reference 
          - SELECT�� ������ OUT���� ���ٰ� �����ϸ� �ȴ�. 
        (3)INOUT ���� ==> Call By Value + Call By Reference 
     2) ����
        (1) ���� 
          - CREATE PROCEDURE ���ν�����(�Ű�����, �Ű�����, ...)  -- <== ���� (DECLARE ���)
            IS
                �������� ���� 
            BEGIN
                SQL �������� ����
            END;
            /
        (2) ����
         - CREATE [OR REPLACE] PROCEDURE ���ν�����(�Ű�����, �Ű�����, ...)  -- ������ �ִ� ���ν������ ������ ���ν������� ����, ���� ���ν����� ���ư��� ���� ����� ���ν����� ��ü�ȴ�. 
            IS
                �������� ���� 
            BEGIN
                SQL �������� ����
            END;
            /
        (3) ���� 
*/

CREATE TABLE pro_test(
    no NUMBER,
    name VARCHAR2(34),
    kor NUMBER,
    eng NUMBER,
    math NUMBER
);


-- �߰�
-- [����] Ư�����ڴ� _ �Ǵ� $ �ۿ� �� ����. 
CREATE PROCEDURE pro_test_insert(
    pname pro_test.name%TYPE,
    pkor pro_test.kor%TYPE,
    peng pro_test.eng%TYPE,
    pmath pro_test.math%TYPE    
)
IS
    --����
BEGIN
    --����
    INSERT INTO pro_test VALUES (
        (SELECT NVL(MAX(no)+1,1) FROM pro_test),
        pname,pkor,peng,pmath
    );
END;
/

-- �̷������� ȣ���Ѵ�!! ==> �ݺ��Ǵ� ������ ��� ���� �ʾƵ� �ȴ�. �׳� ���ν��� ���� ȣ�⸸ �ϸ� ��. 
CALL pro_test_insert('ȫ�浿',90,85,100);
CALL pro_test_insert('��û��',95,100,75);
CALL pro_test_insert('�ڹ���',90,60,60);

-- ������ Ȯ�� 
SELECT * FROM pro_test;

-- =====================================================================================

-- update�ϴ� ���ν����� ������. 
-- �Ʒ��� �ڵ忡 �ִ� ������ ��� IN �����̴�. (���� �������ִ� ����. ������ ǥ�ð� ������ ����Ʈ�� IN������. OUT������ ����Ʈ�� �ƴ϶� OUT�̶�� �������) 
CREATE OR REPLACE PROCEDURE pro_test_update(
    pno pro_test.no%TYPE, 
    pname pro_test.name%TYPE,
    pkor pro_test.kor%TYPE,
    peng pro_test.eng%TYPE,
    pmath pro_test.math%TYPE   
)
IS
BEGIN
    UPDATE pro_test SET
    name=pname,
    kor=pkor,
    eng=peng,
    math=pmath
    WHERE no=pno;
    commit;
END;
/


-- ������ Ȯ�� 
SELECT * FROM pro_test;

-- �Լ� ȣ�� 
CALL pro_test_update(1,'ȫ���',80,80,75);

-- �Լ� ȣ�⿡ ���� ����� ������ Ȯ�� 
SELECT * FROM pro_test;

-- �߸� ���� �����ߴ� �ٽ� ����...
DROP PROCEDURE pro_test_delete;

-- =====================================================================================
-- ex) DELETE ��Ű�� �Լ��� ����ÿ�. �Ű������� no �ϳ�. ��ȣ ������ �ش� ��ȣ ������ �����ϰ�. 
CREATE OR REPLACE PROCEDURE pro_test_delete(
    pno pro_test.no%TYPE 
)
IS
BEGIN
    DELETE FROM pro_test 
    WHERE no=pno;
    commit;
END;
/

-- �Լ� ȣ��
CALL pro_test_delete(1);

-- �Լ� ȣ�⿡ ���� ������ ������ Ȯ�� 
SELECT * FROM pro_test;

-- =====================================================================================

-- pno�� �ְ� pname,pkor,peng,pmath ���� �޶� 
-- ==> pname,pkor,peng,pmath: OUT ����, pno:IN���� 
CREATE OR REPLACE PROCEDURE pro_test_select(
    pno pro_test.no%TYPE, 
    pname OUT pro_test.name%TYPE,
    pkor OUT pro_test.kor%TYPE,
    peng OUT pro_test.eng%TYPE,
    pmath OUT pro_test.math%TYPE  
)
IS
BEGIN
    SELECT name,kor,eng,math INTO pname,pkor,peng,pmath
    FROM pro_test 
    WHERE no=pno;
END;
/

CALL pro_test_select(2);
SELECT * FROM pro_test;


-- =====================================================================================
-- ���� ���� 
VARIABLE pname VARCHAR2(34);
VARIABLE pkor NUMBER;
VARIABLE peng NUMBER;
VARIABLE pmath NUMBER;
EXECUTE pro_test_select(2,:pname,:pkor,:peng,:pmath); 
PRINT pname pkor peng pmath;
-- �ڡڡڡ� ':'�� ��������. �ּҰ��� �־��ش�. �ڡڡڡ�
-- 206~212�� �� ���� ���ó�� �� �����ϱ� 















