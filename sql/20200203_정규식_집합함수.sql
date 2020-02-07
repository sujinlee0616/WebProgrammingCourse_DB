--2020-02-03 ����Ŭ(�׷��Լ�(=�����Լ�))

/*
<�׷��Լ�(=�����Լ�)>
 - ���� : Column (������ ����) ==> �������Լ�(�׷��Լ�, �����Լ�)
   �� �������Լ� �� �����Լ� : row(���ڵ�) ���� ����. 

1. COUNT : ���� 
 - ��� ���� : �α���, ���̵� �ߺ�üũ �� ���� ����. 
 1) COUNT(*) ========> NULL ����O
 2) COUNT(�÷���) ====> NULL ����X
SELECT COUNT(*) FROM emp;
SELECT COUNT(mgr) FROM emp; --mgr:�����ȣ. �� ���� null���� ���� �ִ�. 
SELECT COUNT(comm) FROM emp; --comm:Ŀ�̼�. 10���� Ŀ�̼� ����X.
SELECT empno FROM emp WHERE empno=8000; --���: NULL
SELECT COUNT(*) FROM emp WHERE empno=8000; --�����ϴ��� �� �ϴ��� üũ�ϱ� ���ؼ� COUNT�� ����Ѵ�. 
--Java������ NULL�� ó�� �ȵǹǷ� ����Ŭ���� NULL���� �ƴ��� üũ�����. 

2. AVG : ���
 - ���� : AVG(�÷���) ==> AVG(sal) 
--����) �����Լ��� ������ �Լ�, �÷��� ���� ��� �� �� ����. �� (���� : GROUP BY ��� ��, RANK �Լ�(RANK�� �����Լ� �ƴ�)) 
SELECT AVG(sal) FROM emp; --����
SELECT AVG(sal),ename,LENGTH(ename) FROM emp; --Error.: �����Լ��� ����� 1��, �������Լ��� ����� ������ ==> ���� ���� �� ����.
SELECT ROUND(AVG(sal),1) FROM emp;

3. MAX : �ִ밪 
 - ���� : MAX(�÷���) 
 - ��� ���� : �ߺ��� ���� ��(����) => �ڵ����� �����Ǵ� �Լ� ���� �� ���� ���. 
   �� �ڵ����� �����Ǵ� �Լ� �����Ͽ� ���߿� SEQUENCE��� ���� �������, �� �������� MAX�� ����� ���̴�. 
 - ex) MAX(sal) 

4. MIN : �ּҰ�
 - ���� : MIN(�÷���) 
 - ex) MIN(sal) 
SELECT MAX(sal),MIN(sal) FROM emp;

5. SUM : �� 
 - ���� : SUM(�÷���)
 - ex) SUM(sal) 
SELECT SUM(sal),SUM(comm) FROM emp;

6. RANK : �������� 
 - ex) RANK() OVER(ORDER BY sal DESC)
        ==> �޿��� ���� ������ ������ �ű��. 
 - ������ �ű�� ��� : �����ڰ� ������ ���, �� ���� ����� ī��Ʈ �ϴ� ����� �ٸ���. 
   1) 1��,2��,2��,��4��� ��� : ��RANK��
    - ���� ����� ���� ��, �� ���� ����� �ǳʶڴ�.
   2) 1��,2��,2��,��3��� ��� : ��DENSE_RANK��
    - ���� ����� ���� ��, �� ���� ����� �ǳʶ��� �ʴ´�. 
 - RANK�Լ��� ������ �Լ��� �Բ� �� �� �ִ�. ==> RANK�� ��� �����Լ� �ƴϴ�..
SELECT ename,sal,RANK() OVER(ORDER BY sal DESC) FROM emp; --���� ���� ������ RANK �ű� --RANK : 1,2,2,4,5,...
SELECT ename,sal,DENSE_RANK() OVER(ORDER BY sal DESC) FROM emp; --DENSE_RANK : 1,2,2,3,4,...
SELECT ename,hiredate,RANK() OVER(ORDER BY hiredate ASC) FROM emp; --���ټ��� ������ RANK �ű� 

7. DENSE_RANK : �������� 
*/

/*
<���Խ�>
--ex) �޿��� ��պ��� ���� ����� ������ ����϶�. 
--���0) Error. �׷��Լ��� �����Լ��� ���� �����Ƿ� ���� �Ұ�
SELECT * FROM emp WHERE sal<=AVG(sal); 
--���1) ���� 2���� ����. 
SELECT AVG(sal) FROM emp;
SELECT * FROM emp
WHERE sal<2073;
--���2) ���� 1���� ����. �������� ���.  �������� : ��ȣ �� ==> ���� �����.
SELECT * FROM emp
WHERE sal<=(SELECT AVG(sal) FROM emp);
*/

/*
<2���� - ���Ϲ��� ũ�Ѹ��ϱ�>
mno: ������ȣ
rank: ���� 
title
singer
album
poster
idcrement : ����, ���� 
state : ���, �ϰ�, ����
key
*/

--������� ���� (���̺�) 
CREATE TABLE music_genie (
    mno NUMBER,
    rank NUMBER,
    title VARCHAR2(500),
    singer VARCHAR2(200),
    album VARCHAR2(300),
    poster VARCHAR2(260),
    idcrement NUMBER,
    state CHAR(4),
    key VARCHAR2(100)
);
SELECT * FROM music_genie;

ALTER TABLE music_genie MODIFY state CHAR(6);
DESC music_genie;

TRUNCATE TABLE music_genie; --���̺� ���� ������ ������... �ڹٿ��� Jsoup ������ �����Ͱ� �Ϻθ� ����... ������ ������. 

SELECT mno,title,singer,poster,album,idcrement,state FROM music_genie ORDER BY rank ASC;








