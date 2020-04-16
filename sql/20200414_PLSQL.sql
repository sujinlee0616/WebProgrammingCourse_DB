--2020.04.14(ȭ) PL/SQL
/* 
    [PL/SQL�� ����]
    - PROCEDURE, FUNCTION, PACKAGE, TRIGGER
    
    DECLARE (�͸�)
        - DECLARE�� �͸����� �� ��. ������. DECLARE(������)�� �ƴ� �� �Ʒ��� ���� ����. 
        - CREATE PROCEDURE pro_name()
        - CREATE FUNCTION func_name:NUMBER()
        - CREATE TRIGGER tri_name 
        ����� => ����, ��� 
    BEGIN
        ������ : SQL 
    EXCEPTION : ����ó�� 
    
    - ERP���� ���� ���. (�ߺ��� SQL�� ����, ������ �ɷ��־..) 
*/
-- =================================================================================================
/*
    - %TYPE: ������ ���̺��� ������ �ִ� ���������� �о�� ��.
    - ���̺��.�÷���%TYPE
    - emp.job%TYPE �̶�� ���� ���� ���������� VARCHAR2(20)�� �˾Ƽ� ������ ��. 
*/
-- =================================================================================================
/*
    ������ �б� CRUD
    SELECT empno,ename ==> ������ �����ؼ� ���
           =========== INTO vempno,vename : ����. ������ �����͸� �־ ������ �� �� ����. �� ������ JAVA ������ ���������� �ϳ��� ���� ���� ����. 
    FROM emp
    WHERE empno=7788
*/
-- =================================================================================================
/* [��Ÿ]
    JSP == React
    MVC == Redix
    Spring == mobx 
    
    [��Ÿ]
    �Լ�(�޼ҵ�) ==> ����+������+��� 
*/
-- =================================================================================================
-- [%TYPE]
SET SERVEROUTPUT ON
DECLARE -- ���� 
    -- ����� ���� ����
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vdname dept.dname%TYPE;
    vloc dept.loc%TYPE;
BEGIN
    -- ���� : BEGIN�� END ���� 
    SELECT empno,ename,job,dname,loc 
    INTO vempno,vename,vjob,vdname,vloc  -- SELECT���� ������ ���� �� �����鿡�ٰ� �־�� 
    FROM emp,dept
    WHERE emp.deptno=dept.deptno
    AND empno=7788;
    
    -- ��� 
    DBMS_OUTPUT.put_line('****** ��� ****** '); --sysout�� ������ ��� (�ٹٲ� ��)
    DBMS_OUTPUT.put_line('���: '||vempno);
    DBMS_OUTPUT.put_line('�̸�: '||vename);
    DBMS_OUTPUT.put_line('����: '||vjob);
    DBMS_OUTPUT.put_line('�μ���: '||vdname);
    DBMS_OUTPUT.put_line('�ٹ���: '||vloc);
END;
/  -- '/' ���߸��� �ȵ�!!! '/'�� �����ٴ� ��.

-- =================================================================================================
-- ex) [%TYPE ����] �̸�,����,�Ի���,�޿�,�μ���,�ٹ����� ����϶�. 
SET SERVEROUTPUT ON
DECLARE
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vhiredate emp.hiredate%TYPE;
    vsal emp.sal%TYPE;
    vdname dept.dname%TYPE;
    vloc dept.loc%TYPE;
BEGIN
    SELECT ename,job,hiredate,sal,dname,loc
    INTO vename,vjob,vhiredate,vsal,vdname,vloc
    FROM emp,dept
    WHERE emp.deptno=dept.deptno
    AND empno=7788; -- �䷸�� �� ���� �÷� ���������� ������ ����������?! �ֳĸ� ������ �� ���ε� ����� �������̸� ���� ���� ���ݾ�...
    
    -- ��� 
    DBMS_OUTPUT.put_line('****** ��� ****** '); --sysout�� ������ ��� (�ٹٲ� ��)
    DBMS_OUTPUT.put_line('�̸�: '||vename);
    DBMS_OUTPUT.put_line('����: '||vjob);
    DBMS_OUTPUT.put_line('�Ի���: '||vhiredate);
    DBMS_OUTPUT.put_line('�޿�: '||vsal);
    DBMS_OUTPUT.put_line('�μ���: '||vdname);
    DBMS_OUTPUT.put_line('�ٹ���: '||vloc);
    
END;
/

SELECT * FROM emp;
SELECT * FROM dept;
-- =================================================================================================
/*
    [%ROWTYPE]
    - ���� ���� ���̺����  ����ü ������������ ������ �� ��. ==> ���� emp%ROWTYPE, ���� dept%ROWTYPE
    - ���� %TYPE ó�� JOIN�ؼ� �� �� ���̺��� ������ ���� ���� �� �Ұ���. �� ���� ���̺� �����͸� ������ �� �� ����. 
    - �굵 %TYPEó�� ������ �� ���� ���� ������ �� �ִ�. 
*/
SET SERVEROUTPUT ON
DECLARE
    vemp emp%ROWTYPE;
BEGIN
    SELECT * INTO vemp
    FROM emp
    WHERE empno=7788;
    
    DBMS_OUTPUT.put_line('���: '||vemp.empno);
    DBMS_OUTPUT.put_line('�̸�: '||vemp.ename);
    DBMS_OUTPUT.put_line('����: '||vemp.job);
    DBMS_OUTPUT.put_line('������: '||vemp.mgr);
    DBMS_OUTPUT.put_line('�Ի���: '||vemp.hiredate);
    DBMS_OUTPUT.put_line('�޿�: '||vemp.sal);
    DBMS_OUTPUT.put_line('������: '||vemp.comm);
    DBMS_OUTPUT.put_line('�μ���ȣ: '||vemp.deptno);
END;
/
-- =================================================================================================
-- ex) [%ROWTYPE ����] deptno�� 10���� �����͸� ����϶�. 
SET SERVEROUTPUT ON
DECLARE
    vdept dept%ROWTYPE;
BEGIN
    SELECT * INTO vdept
    FROM dept
    WHERE deptno=10;

    DBMS_OUTPUT.put_line('�μ���: '||vdept.dname);
    DBMS_OUTPUT.put_line('�ٹ���: '||vdept.loc);
    DBMS_OUTPUT.put_line('�μ���ȣ: '||vdept.deptno);
END;
/
SELECT * FROM dept;
-- =================================================================================================
-- �ݺ��Ǵ� SQL���� ��� �Լ� ���� ���� ���� ���ϴ� 
-- ex) �Խ���: ����Ʈ�� �Խ����� 6��! �ٵ� ��� �Ȱ��� SQL�� �ݺ� �ڵ��ϱ� �����ϱ�...

-- IN: �Ϲݺ��� 
-- OUT: �� ���� �� 

/*
    C������.... 
    int a=10;
    int* p=&a;
    *p

    String ...
    CALL ....
    CREATE PROCEDURE pro_name(
        pno IN board.no%TYPE,
        pname OUT board.name%TYPE,
        pemail OUT board.email%TYPE
    )
    -- ���ν����� ����� �����ϴ� ���ε� �������� ���� 
*/

-- ����� ���� ��������.
-- JOIN �ɸ��ų� SUBQUERY�� �� ���� �Ʒ��� ���� ó���ϴ� ���� ����. 
DECLARE
    TYPE empdeptRecord IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        hiredate emp.hiredate%TYPE,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE,
        grade salgrade.grade%TYPE
    );
    -- ���� ����
    ed empdeptRecord;
BEGIN
    SELECT empno,ename,job,hiredate,dname,loc,grade INTO ed
    FROM emp,dept,salgrade
    WHERE emp.deptno=dept.deptno
    AND sal BETWEEN losal AND hisal
    AND empno=7788;
    
    DBMS_OUTPUT.PUT_LINE('****** ��� ******');
    DBMS_OUTPUT.PUT_LINE('���: '||ed.empno);
    DBMS_OUTPUT.PUT_LINE('�̸�: '||ed.ename);
    DBMS_OUTPUT.PUT_LINE('����: '||ed.job);
    DBMS_OUTPUT.PUT_LINE('�Ի���: '||ed.hiredate);
    DBMS_OUTPUT.PUT_LINE('�μ���: '||ed.dname);
    DBMS_OUTPUT.PUT_LINE('�ٹ���: '||ed.loc);
    DBMS_OUTPUT.PUT_LINE('���: '||ed.grade);
END;
/
-- =================================================================================================

ACCEPT pno PROMPT '���:'
DECLARE
    vdeptno emp.deptno%TYPE:=10; -- �ʱⰪ�� ���� ��: ':='
    -- PL/SQL���� '='�� '����' �̱� ������, ������ ���ؼ��� ':='�� ����Ѵ�. 
    vename emp.ename%TYPE:='Hong';
    vempno emp.empno%TYPE:=&pno; -- �Է°��� �޴� ���: '&������' 
    TYPE empdeptRecord IS RECORD(
        empno emp.empno%TYPE,
        ename emp.ename%TYPE,
        job emp.job%TYPE,
        hiredate emp.hiredate%TYPE,
        dname dept.dname%TYPE,
        loc dept.loc%TYPE,
        grade salgrade.grade%TYPE
    );
    -- ���� ����
    ed empdeptRecord;
BEGIN
    SELECT empno,ename,job,hiredate,dname,loc,grade INTO ed
    FROM emp,dept,salgrade
    WHERE emp.deptno=dept.deptno
    AND sal BETWEEN losal AND hisal
    AND empno=vempno;
    
    DBMS_OUTPUT.PUT_LINE('****** ��� ******');
    DBMS_OUTPUT.PUT_LINE('���: '||ed.empno);
    DBMS_OUTPUT.PUT_LINE('�̸�: '||ed.ename);
    DBMS_OUTPUT.PUT_LINE('����: '||ed.job);
    DBMS_OUTPUT.PUT_LINE('�Ի���: '||ed.hiredate);
    DBMS_OUTPUT.PUT_LINE('�μ���: '||ed.dname);
    DBMS_OUTPUT.PUT_LINE('�ٹ���: '||ed.loc);
    DBMS_OUTPUT.PUT_LINE('���: '||ed.grade);
END;
/
-- =================================================================================================
-- [���] 
-- : IF, FOR, LOOP 
/*
    1. IF�� 
    - ����) (���� IF��) 
      IF (���ǹ�) THEN
        ó��
      END IF;
    - ����) (IF ~ ELSE ��) 
      IF (���ǹ�)THEN
        ó��
      ELSE
        ó��
      END IF;
    - ����) (IF ~ ELSIF ��)
      IF (���ǹ�) THEN
        ó��
      ELSIF (���ǹ�) THEN
        ó��
      ELSIF (���ǹ�) THEN
        ó��
      END IF;
    - ������) '����'�� '='�̴�. '=='�� ������� �ʴ´�.
      ex) deptno=10 (O) 
      ex) deptno==10 (X) 
*/
DECLARE
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vdname dept.dname%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN
    SELECT deptno INTO vdeptno
    FROM emp 
    WHERE empno=7788;
    
    IF (vdeptno=10) THEN
        vdname:='������';
    END IF;
    IF (vdeptno=20) THEN
        vdname:='���ߺ�';
    END IF;
    IF (vdeptno=30) THEN
        vdname:='��ȹ��';
    END IF;
    DBMS_OUTPUT.PUT_LINE('****** ��� ******');
    DBMS_OUTPUT.PUT_LINE('�μ���: '||vdname);
END;
/
-- =================================================================================================
DECLARE
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vdname dept.dname%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN
    SELECT deptno,ename,job INTO vdeptno,vename,vjob
    FROM emp 
    WHERE empno=7788;
    
    IF (vdeptno=10) THEN
        vdname:='������';
    END IF;
    IF (vdeptno=20) THEN
        vdname:='���ߺ�';
    END IF;
    IF (vdeptno=30) THEN
        vdname:='��ȹ��';
    END IF;
    DBMS_OUTPUT.PUT_LINE('****** ��� ******');
    DBMS_OUTPUT.PUT_LINE('�μ���: '||vdname);
    DBMS_OUTPUT.PUT_LINE('�̸�: '||vename);
    DBMS_OUTPUT.PUT_LINE('����: '||vjob);
END;
/

-- =================================================================================================
-- empno=7499, empno=7788
DECLARE 
    vename emp.ename%TYPE;
    vcomm emp.comm%TYPE;
BEGIN
    SELECT ename,comm INTO vename,vcomm
    FROM emp
    WHERE empno=7788; 
    
    IF(vcomm>0) THEN -- vcomm�� NULL�̸� IF�� ���� ���ؼ� ELSE �� ������ (ex. empno=7788)
        DBMS_OUTPUT.PUT_LINE(vename||'���� �������� '||vcomm||'�Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(vename||'���� �������� �����ϴ�.');
    END IF;
    -- ����) Oracle���� �����Ͱ� NULL�̸� ��� ������ �Ұ����ϴ�.    
END;
/
-- =================================================================================================

DECLARE
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
    vjob emp.job%TYPE;
    vdname dept.dname%TYPE;
    vdeptno emp.deptno%TYPE;
BEGIN
    SELECT deptno,ename,job INTO vdeptno,vename,vjob
    FROM emp 
    WHERE empno=7788;
    
    IF (vdeptno=10) THEN
        vdname:='������';
    ELSIF (vdeptno=20) THEN
        vdname:='���ߺ�';
    ELSIF (vdeptno=30) THEN
        vdname:='��ȹ��';
    END IF;
    DBMS_OUTPUT.PUT_LINE('****** ��� ******');
    DBMS_OUTPUT.PUT_LINE('�μ���: '||vdname);
    DBMS_OUTPUT.PUT_LINE('�̸�: '||vename);
    DBMS_OUTPUT.PUT_LINE('����: '||vjob);
END;
/

-- =================================================================================================
-- ex) ��ȭ��ȣ(tel) �Է� => hong => id�� �����ϸ� ho**, ���� ��� => 'ID�� �������� �ʽ��ϴ�' ���. 
SELECT * FROM member;
-- tel: 010-235-1351 
DECLARE
    vcount NUMBER;
    vid member.id%TYPE;
    vtel member.tel%TYPE:='010-235-1351';
    vresult VARCHAR2(100);
BEGIN
    SELECT COUNT(*) INTO vcount
    FROM member
    WHERE tel=vtel;
    
    IF (vcount=0) THEN
        vresult:='ID�� �������� �ʽ��ϴ�.';
    ELSE
        SELECT RPAD(SUBSTR(id,1,2),LENGTH(id),'*') INTO vid
        FROM member
        WHERE tel=vtel;
        vresult:='ID�� '||vid||'�Դϴ�';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('****** ��� ******');
    DBMS_OUTPUT.PUT_LINE(vresult);
    
END;
/
-- =================================================================================================
-- �������� procedure�� �����
CREATE PROCEDURE idFind(vtel IN member.tel%TYPE, vresult OUT VARCHAR2(100))
IS
    -- ���� ���� 
    vcount NUMBER;
    vid member.id%TYPE;
    vresult VARCHAR2(100);
BEGIN
    SELECT COUNT(*) INTO vcount
    FROM member
    WHERE tel=vtel;
    
    IF (vcount=0) THEN
        vresult:='ID�� �������� �ʽ��ϴ�.';
    ELSE
        SELECT RPAD(SUBSTR(id,1,2),LENGTH(id),'*') INTO vid
        FROM member
        WHERE tel=vtel;
        vresult:='ID�� '||vid||'�Դϴ�';
    END IF;
    DBMS_OUTPUT.PUT_LINE('****** ��� ******');
    DBMS_OUTPUT.PUT_LINE(vresult);
END;
/
-- =================================================================================================
-- ex) id�޾Ƽ� �̸��̶� ��ȭ��ȣ ������ִ� procedure �����
DROP PROCEDURE DataFind;
CREATE PROCEDURE DataFind(pid IN member.id%TYPE,pname OUT member.name%TYPE,ptel OUT member.tel%TYPE)
IS
BEGIN
    SELECT name,tel INTO pname,ptel
    FROM member 
    WHERE id=pid;
END;
/

-- VARIABLE pname VARCHAR2(25); <=== �� ������ Epname ������ ���� ä���޶�� ��
-- �Ʒ��� 4���� �ѹ��� ���ó�� �� �����Ű�� ��µ� 
VARIABLE pname VARCHAR2(25); 
VARIABLE ptel VARCHAR2(25);
EXECUTE DataFind('hong',:pname,:ptel);
PRINT pname ptel;


-- =================================================================================================
-- [�ݺ��� LOOP]
DECLARE
    
BEGIN
    
END;
/










