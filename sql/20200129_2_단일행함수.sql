-- *** ǥ��: �ݵ�� ����� ��!

--�����Լ�
/*
ROUND : �ݿø� (�Ǽ�,�Ҽ������� �ڸ���) ==> �ݿø����Ѽ� �Ҽ������� �ڸ��� �󸶱����� ���ܶ�.
        ROUND(12345.6789, 1) ==> 12345.7 ==> �ݿø����Ѽ� �Ҽ������� 1�ڸ������� ���ܶ�. 
        ROUND(12345.6789, 2) ==> 12345.68
TRUNC : ���� (�Ǽ�, �Ҽ������� �ڸ���)
        TRUNC(12345.6789,1) ==> 12345.6
        TRUNC(12345.6789,2) ==> 12345.67
CEIL : �ø� (�Ǽ�) ==> �ø��� ���� ��� 
       CEIL(11/10) ==> 1.1�� �ø��� ���� ��� ==> 2
       - �Խ��� ���� ��, �� ������ ����� �� ���� �����. 
       - (�Խù� ��ü ���� / �� �������� �����Ű�� ����) �� ���� CEIL �ϸ� �� ������ ������ ��.
MOD : ������. 
      MOD(����, ������) ==> MOD(10,3) ==> Java�� 10%3�� ������. 
*/
-- ex) ���� ���� ����
SELECT ROUND(12345.6789, 1),ROUND(12345.6789, 2), TRUNC(12345.6789,1), TRUNC(12345.6789,2), CEIL(11/10) FROM DUAL;
-- ex) ����� ¦���� �ֵ鸸 ���
SELECT empno,ename,job,sal FROM emp
WHERE MOD(empno,2)=0;

--��¥�Լ�
/*
***SYSDATE
***MONTHS_BETWEEN
***ADD_MONTHS
LAST_DAY
NEXT_DAY
*/
SELECT SYSDATE FROM DUAL;
SELECT SYSDATE-1,SYSDATE,SYSDATE+1 FROM DUAL; --����/����/���� ��¥ 

--��ȯ�Լ�
/*
***TO_CHAR
TO_NUMBER
TO_DATE
*/

--��Ÿ�Լ�(�Ϲ��Լ�)
/*
***NVL
CASE
***DECODE
*/

--������ movie ���̺� ���� 
CREATE TABLE movie(
    mno NUMBER(4), --������. ���� () �� ���� NUMBER�θ� ���� 14�ڸ����� �Է� ����.
    title VARCHAR2(1000), --VARCHAR �������̴ϱ� ����൵ �������. 
    score NUMBER(4,2), --double. ��ü ���ڴ� 4��. 2���� �Ҽ���. 
    genre VARCHAR2(100), -- ����) VARCHAR�� 4000Byte���� ���� ����.
    regdate VARCHAR2(100),
    time VARCHAR2(10),
    grade VARCHAR2(100),
    director VARCHAR2(200),
    actor VARCHAR2(200),
    story CLOB, --CLOB�� 4G���� ���� ����. �굵 ��������. �����Ͱ� �����¸�ŭ�� �޸� ����. 
    type NUMBER -- �����:1, ��������:2, �ڽ����ǽ� �ְ�:3, ����:4, ����:5    
);








