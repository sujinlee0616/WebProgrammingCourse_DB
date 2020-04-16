-- 2020.04.16 PL/SQL ���(�ݺ���)

/*
    1. Loop��
    ����) LOOP
            ó��
            EXIT [����] ==> ����
         END LOOP 

    2. WHILE��
    ����) WHILE ���� LOOP
            ó������ => PL/SQL
         END LOOP
        
    3. FOR�� 
    ����) FOR ���� IN (REVERSE) start..end LOOP
                     ========
                        REVERSE�� ������ �������� �����Ѵ�. end���� start���� -1�� �����ϸ� �����. 
                        <==> IN: start���� �����ؼ� 1�� �����ؼ� end ���� ����ȴ�.
                             ex) FOR i IN 1..9 LOOP 
                                 for(int i=1; i<=9; i++)
                                 ���� �� ������ �����ϴ�.
                             ex2) for(int i=10;i>1;i--)
                                  FOR i IN REVERSE 10..1 LOOP
            ó������ => PL/SQL
         END LOOP
*/

-- ====================================================================================
-- PL/SQL

SET SERVEROUTPUT ON
DECLARE 
    no NUMBER:=1;
    sum1 NUMBER:=0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(no);
        sum1:=sum1+no;
        no:=no+1;
        EXIT WHEN no>10;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1~10���� ���� '||sum1);
END;
/
-- �����̸� sum���� �ָ� �����Լ����̶� �� ��.

-- ====================================================================================
-- [WHILE��] 
DECLARE
    no NUMBER:=1;
BEGIN
    WHILE no<=10 LOOP
        DBMS_OUTPUT.PUT_LINE('no='||no);
        no:=no+1;
    END LOOP;
END;
/
-- ��״� ++�� ��� no:=no+1; �䷱�����θ� �������

-- ====================================================================================
-- [FOR��] 
BEGIN 
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE ('i='||i);
    END LOOP;
END;
/

BEGIN 
    FOR i IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE ('i='||i);
    END LOOP;
END;
/

-- ������ �б�
-- �����Ͱ� �������� ��� => ArrayList, [] 
-- ����Ŭ => ArrayList�� ���� ���� => CURSOR

/*
    CURSOR�� �ڹ��� ResultSet!! 
    ==> �ڿ���Ŭ�� CURSOR�� �����ϸ� �ڹٿ����� ResultSet���� �޾Ƽ� ó���Ѵ�.��
               ==================================
                ROW(RECORD)�� ����
                BIT ==> WORD ==> RECORD ==> TABLE 
                CHAR    String   �� �� ���ڿ�  file
                
                 - ���̺��� ������ �� �� �� ���� ���ڵ� �Ǵ� row��� �����. 
                 
    �� ����(table)
    ===================================
        ID      NAME        SEX     =====> Column, Attribute: ������� 
    ===================================
        aaa     ȫ�浿       ����     =====> ROW, TUPLE, Record =====
    ===================================                           ��
        bbb     ��û��       ����     =====> ROW, TUPLE, Record =======> �� �� �� �� ���� �������� ���� �� 'CURSOR'
    ===================================                           ��
        ccc     �ڹ���       ����     =====> ROW, TUPLE, Record =====
    ===================================
    
    
    [CURSOR ����]
    1. CURSOR ����: ADD 
     - ����)
        CURSOR Ŀ���� IS
        SELECT ����  <== ���⼭ ������ ������ CURSOR�� ����
     - ex) 
        CURSOR cursor1 IS
        SELECT * FROM emp
    2. CURSOR ����: �޸� �Ҵ� 
     - ����) 
        Ŀ���� OPEN 
    3. CURSOR�� �ִ� ������ ����: get(), for(MovieVO vo:list)
     - ����)
        FETCH
    4. CURSOR �ݱ� 
     - ����) 
        Ŀ���� CLOSE
*/

-- ��� �������� �� �ʿ��ϸ� %ROWTYPE�� ���ϰ�,
-- JOIN �ɸ��� RECORD �����ϴ°� ���� 
-- ��CURSOR�� �̿��ϸ� ���� ���ϴ� ������ŭ�� �����͸� �� ���� �� �� �ִ�!!��

DECLARE 
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    CURSOR emp_cur IS
        SELECT empno,ename,job
        FROM emp;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO vempno,vename,vjob;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vempno||' '||vename||' '||vjob);
    END LOOP;
    CLOSE emp_cur;
END;
/
--%NOTFOUND: �� �̻� ������ ������ ���� ��.
    
-- ====================================================================================
-- [FOR��]: �Ϲ� for��... 
-- for(int i=1;i<list.size();i++) ���� �ڵ�.
DECLARE
    vemp emp%ROWTYPE;  --JAVA������ VO ����� ����
    CURSOR emp_cur IS
        SELECT *
        FROM emp;
BEGIN
    OPEN emp_cur;
    LOOP
        FETCH emp_cur INTO vemp;
        EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job);
    END LOOP;
    CLOSE emp_cur;
END;
/

-- ====================================================================================
-- [FOR�� �̿�]: for each ���� 
-- for(EmpVO vemp:list) �� ���� �ڵ�.
DECLARE
    vemp emp%ROWTYPE;
    CURSOR emp_cur IS
        SELECT * FROM emp;
BEGIN
    FOR vemp IN emp_cur LOOP
    EXIT WHEN emp_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(vemp.empno||' '||vemp.ename||' '||vemp.job);
    END LOOP;
END;
/




















