-- 2020.04.13 PL/SQL
/*
    PL => ����Ŭ �ȿ��� �Լ��� ���� �� ����ϴ� ��� (�������� ���) 
          ========== ĳ�� �޸𸮿� ����. => �ӵ��� ������.
          1) �Լ� vs �޼ҵ�? ������? 
           - �������� "Ŭ���� ���� ����". Ŭ���� �ȿ� ������ �޼ҵ�, Ŭ���� �ۿ� ������ �Լ���� ��. 
             ==> �ڹٴ� Ŭ���� �ȿ� ��������ϱ� �޼ҵ��� �ϰ�, C�� Ŭ���� �ۿ� ����ϱ� �Լ���� ��. 
          2) �Լ� vs ���ν���? ������?
           - �������� "������ ���翩��".
           - �Լ�(Function), ���ν���(Procedure) => Call By Reference 
             1. �Լ� 
              - ex) SUBSTR, MAX, ... : SELECT �ڿ��� ���. 
              - �뵵) ������� ���� ����. 
             2. ���ν���
              - ex) 
              - �뵵) ������ ����� ���� ����.
              - ����) 
                (1) ������ �پ��. 
                (2) Ʈ����� ��� ����. 
                (3) �ݺ��� ����. 
                
        Ʈ���Ŷ� �����ΰ�... 
*/

/*
    [PL ����]
    
    1. �ڵ����
     - ��ȣ ����
     - ����) 
        DECLARE
            ��������
        BEGIN
            ó�� ���(SQL)
        EXCEPTION
            ����ó��
        END; 
        
    2. ���� ����
     - 1)~4)�� �ܼ�, 5)�� ���� 
     1) ��Į�� ����: �Ϲݺ���.
        ex) id VARCHAR2(10)
     2) TYPE ���� 
        - ���̺��� ���� ���������� ������ �� ��.
        ex) empno emp.empno%TYPE
        ex) ename emp.ename%TYPE: emp ���̺��� ename �÷��� ���� ���������� ������ �Ͷ�. 
     3) ROW ����
        - �÷��� ���ִ� ���������� ��� ������. VOó��. 
        ex) emp emp%ROWTYPE :emp ���̺��� �ִ� 8�� �÷��� ���������� ��� ������ �Ͷ�. 
     4) RECORD ���� 
        - ����� ���� ����. JOIN�̰ų� SUBQUERY �� �� ���. 
        - ���� ���, �� �� ���̺� JOIN �ɾ�����, �� ���� VO �����;� 
     5) CURSOR ���� 
        - ����. ResultSet ó��. 
     
    3. ���
     1) IF��
      - ����) ���� IF�� 
        IF (���ǹ�)
            ó��
        END IF;
      - ����) IF ELSE��
        IF (���ǹ�)
            ó��
        ELSIF (���ǹ�)
            ó��
        ELSIF (���ǹ�)
            ó��
        END IF;
      - END IF�� ������ ���� ����! ��ȣ�� ���� ������ END IF�� ������ ������ ��������.
     2) �ݺ���: FOR, WHILE,LOOP
      - FOR i IN 1..9 ('..'�� ��𼭺��� �������� �ǹ���. '1..9' ==> 1���� 9����) 

    4. SQL 

*/
SET SERVEROUT ON
DECLARE
    vempno NUMBER(4);
    vename VARCHAR2(20);
    vjob VARCHAR2(20);
BEGIN
    SELECT empno,ename,job INTO vempno,vename,vjob --������ ���� �޴´� 
    FROM emp 
    WHERE empno=7788;
    DBMS_OUTPUT.put_line('���:'||vempno); --����Ŭ�� sysout�� ������ �뵵. '||'�� JAVA������ ���ڿ����� '+'�� ����.
    DBMS_OUTPUT.put_line('�̸�:'||vename);
    DBMS_OUTPUT.put_line('����:'||vjob);
END;
/







