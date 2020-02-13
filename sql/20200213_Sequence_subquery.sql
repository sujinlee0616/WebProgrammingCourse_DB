--2020-02-13_Sequence_subquery
--������ VIEW ��� ����
/*
<SEQEUNCE>: �ڵ� ���� ��ȣ ����
0. ��������?
 - �ڵ����� ���������� �����ϴ� ������ ��ȯ�ϴ� �����ͺ��̽� ��ü
 - ���� PK���� �ߺ����� �����ϱ����� �����. 
1. �ɼ�
 1) start with
    - ���۹�ȣ. 
 2) increment by
    - ���� ����. �������ڰ� ����� ���� ������ ����. ����Ʈ�� 1.
 3) cache | nocache
    - �޸𸮿� ���������� �̸� �Ҵ��� ������ �� ������ 
 4) cycle | nocycle
    - ������ ���� �ִ밪���� �����ǰ� ���� START WITH���� ������ ���� ������ �������� �ٽ� ������ ������.
    - CYCLE ������ �ִ밪�� �����ϸ� �ּҰ����� �ٽ� ���� NOCYCLE ������ �ִ밪 ���� �� ������ ������ �����Ѵ�.
 5) max_value: �������� �ִ밪�� ����
 6) min_value: �������� �ּҰ��� ����
2. CURRVAL, NEXTVAL
 - CURRVAL: ���� �������� Ȯ���Ѵ�.
 - NEXTVAL: �ش� �������� ���� ������Ų��.
 - ���ǻ���)��
   SELECT �ϴ� ��ȸ������ NEXTVAL�� ���� ��� ��������ü�� ���� �������Ŀ� �״�� �����Ȱ����� ���´�.
   (���̺�� �������� ������ �����̱� ����.)
3. ����
 1) ���� 
 CREATE SEQUENCE seq��   ===> seq��: table��_�÷���_seq 
    START WIH 1         : 1���� ����
    INCREMENT BY 1      : 1�� ���� 
    NOCACHE             : cache ���x
    NOCYCLE             : ���ѹݺ� (�ִ밪�� �����Ƿ� ������ ���� ���� ������ ����==>���ѹݺ�)
 2) ���� 
 DROP SEQUENCE seq��     
4. ������ ��ȸ
 1) ��ü ������ ��ȸ 
    SELECT * FROM USER_SEQUENCES;
 2) �ش� ������ ��ȸ
    SELECT �������� FROM DUAl;
    ex) SEELCT 
      
*/
CREATE TABLE board3(
    no NUMBER PRIMARY KEY,
    name VARCHAR2(20) NOT NULL
);

CREATE SEQUENCE board3_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;

INSERT INTO board3 VALUES(board3_no_seq.nextval,'ȫ�浿'); --1�� 
SELECT board3_no_seq.currval FROM DUAL; --���� seq��ȣ: 1
SELECT board3_no_seq.nextval FROM DUAL; --���� seq��ȣ: 2
INSERT INTO board3 VALUES(board3_no_seq.nextval,'��û��'); --seq��ȣ: 3 �� 
--===> ���ٿ��� nextval �� seq�� 2�� �ƴ϶� 3�� ���´� ==> �Ժη� nextval ���� �� �ȴ�.
--NEXTVAL ���� �������� �����Ǵϱ�..
SELECT * FROM board3;
DELETE FROM board3 WHERE no=3;
INSERT INTO board3 VALUES(board3_no_seq.nextval,'�ڹ���'); --seq��ȣ: 4 �� 
-- ���� �����Ѵٰ� �ؼ� �������� 1�� �������� �̷��� �ʴ´�.
-- �������� ��� �����ϱ⸸ �Ѵ�. 
SELECT * FROM board3;

DROP TABLE board3;
DROP SEQUENCE board3_no_seq;
--�������� ������!
--���̺� ����ٰ��ؼ� �������� �ڵ����� �������� �׷��� ����
--������ �̸��� ���̺��� ���ý��Ѽ� ������ �� ��� �������� �׳� ���������� ���ڰ� �����ϴ� ��...
--����, ���̺��� �������� ȣ���� ������ ���ڰ� �����ϱ�� �ϰ�����. 


CREATE SEQUENCE board3_no_seq
    START WITH 1
    INCREMENT BY 1
    NOCYCLE
    NOCACHE;
SELECT board3_no_seq.nextval FROM DUAL; --seq=1
SELECT board3_no_seq.nextval FROM DUAL; --seq=2
SELECT board3_no_seq.nextval FROM DUAL; --seq=3
SELECT board3_no_seq.nextval FROM DUAL; --seq=4
SELECT board3_no_seq.nextval FROM DUAL; --seq=5

CREATE TABLE board3(
    no NUMBER PRIMARY KEY,
    name VARCHAR2(20) NOT NULL
);

INSERT INTO board3 VALUES(board3_no_seq.nextval,'aaa'); --seq=6
SELECT * FROM board3;

DESC student;
TRUNCATE TABLE student;
CREATE SEQUENCE std_hakbun_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
SELECT * FROM student;

INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿1',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿1',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿1',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿4',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿5',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿6',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿7',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿8',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿9',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿1-',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿1-',90,80,70,SYSDATE,'��');
INSERT INTO student VALUES(std_hakbun_seq.nextval,'ȫ�浿1-',90,80,70,SYSDATE,'��');
COMMIT;
SELECT * FROM student;

SELECT * FROM emp;

--[�������� ������]
--ex) emp���� ���� ���� ������� 5�� �����Ͷ� 
--�Ʒ��� ���� �ϸ� ���޼����� ����� ��� �� ����. 
SELECT ename,sal,rownum
FROM emp
WHERE rownum<=5
ORDER BY sal DESC;
--�̷��� �ؾ� ��� ����� ����. 
SELECT ename,sal,rownum
FROM (SELECT ename,sal FROM emp ORDER BY sal DESC)
WHERE rownum<=5;
