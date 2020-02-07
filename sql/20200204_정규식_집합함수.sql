-- 2020-02-04 ���Խ� �Լ� (REGEXP_LIKE) 
/*
<���Խ� ��ȣ>
 ^ : ���� ==> A%
 $ : �� ==> %A
 . : ������ �� ���� ==> _
 ? : ���� ���ڰ� ������ �ǰ�, ������ ( ) 
 * : ���� ���� (���ڼ��� 0�ϼ��� ����) 
 + : ���� ���� (���ڼ��� 1�̻�) 
     ex) [��-�R]* : �ѱ� ��������. �ѱ��� 0������ ���� ����. 
         [��-�R]+ : �ѱ� 1���� �̻� 
     ex) ���ִ� ���ְ� ���ְ� ���� 
         ^[����]* ==> ���ִ� ���ְ� ���ְ� ���� 
         ^[����]+ ==> ���ִ� ���ְ� ���ְ� 
     ex) ¥�� ¥�� ¥�� ¥
         ^[¥]* ==> ¥�� ¥�� ¥�� ¥
         ^[¥]+ ==> ¥�� ¥�� ¥�� 
 []: �ش繮�� ���� 
     ex) [A]: A ����
         [A-Z]: �빮�� ����
         [a-z]: �ҹ��� ���� 
         [��-�R]: �ѱ� ����
         [0-9]: ���� ���� 
 [^] : ������ 
 | : OR
 {}: ���� 
     ex) {3}: 3��
         {1-3}: 1-3��
 \: ����Ŭ���� ����ϴ� ���ڵ�(. ? &) ��ü�� ������ ���� ���� �� 
     ex) [\.] : '.'�� �����ϴ� �� 
     
 
*/

--ex) A�� �����ϴ� key��
SELECT key FROM music_genie 
WHERE REGEXP_LIKE (key, '^A');
SELECT key FROM music_genie 
WHERE key LIKE 'A%';

--ex) �빮�ڷ� �����ϴ� key��
SELECT key FROM music_genie 
WHERE REGEXP_LIKE (key, '^[A-Z]');

--ex) ����� �����ϴ� key�� 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^[A-Za-z]');

--ex) ���ڷ� �����ϴ� key��
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^[0-9]');

--ex) �������� �����ϴ� key�� ==> ����. 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^[[:space:]]'); 

--ex) _�� �� key�� 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '_'); 

--ex) ���ڷ� ������ key�� 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '[0-9]$'); 

--ex) '-' �Ǵ� '--'�� �����ϴ� key�� 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '-|--'); 

--ex) '-' �Ǵ� ���ڸ� �����ϴ� key�� 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '-|[0-9]'); 

--ex) .�� ��� ==> .�� ������ ���ڸ� �ǹ��ϹǷ� 200�� ��ü�� �� ����
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '.'); 

--ex) .�̶�� ���ڰ� ���Ե� �����͸� ���Ѵٸ� \. ���� ���. 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '\.'); 

--ex) �빮�� 2���ڷ� �����ϴ� key��
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^[A-Z]{2}'); 

--ex) �ҹ��� 3���ڷ� ������ key�� 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '[a-z]{3}$'); 

--ex) ���� 2���� ������ key�� 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '[0-9]{2}$'); 

--ex) �ι�° ���ڰ� P�ų� p�� key�� 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^.(P|p)'); 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^.[P|p]'); 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^.[Pp]'); 

--ex) '_B' �Ǵ� 'a_'�� �����ϰ� �ִ� key��
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '(_B|a_)'); 

SELECT title FROM music_genie;

--ex) '?'�� ���Ե� ����
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '\?'); 

SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '\?|\.');

--ex) '&'�� ���Ե� ���� 
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '\&'); 

--ex) ')'�� ���Ե� ����
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '\)'); 

--ex) 
SELECT singer,title FROM music_genie
WHERE REGEXP_LIKE (singer, '������'); 

--ex) �����ٶ󸶹ٻ� �� ���Ե� ����
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '��|��|��|��|��|��|��');

--ex) ������ ��-�� ����?
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '[��-��]');

--�� ex) �뷡 ���� ���� ���� �� 
SELECT title FROM music_genie
WHERE NOT REGEXP_LIKE (title,'[[:space:]]');

--�� ex) ������ ����θ� �� �뷡 (�ѱ�,����X)
SELECT title FROM music_genie
WHERE NOT REGEXP_LIKE (title,'[��-�R0-9]');
--���ڴ� �� ����... 'WINTER FLOWER (������) (Feat. RM)' �� ��¿ �� ����..

--ex) Mo �Ǵ� Ma�� �����ϴ� �뷡 ����
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title,'^(Mo|Ma)');

--ex) M���� �����ϰ� �ι�° ���ڰ� o �Ǵ� a�� �����ϴ� �뷡
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title,'^M(a|o)');

--ex) ���� Ma�Ǵ� Mo�� ���Ե� �뷡 
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title,'(Mo|Ma)');

--ex) �ѱ۷� �����ϴ� �뷡�� 
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title,'^[��-�R]');

/*
<�����Լ�>
 - COUNT, MAX, AVG, MIN, RANK, SUM
 - SELECT FROM
   WHERE
   ===========
   GROUP BY      <==������ GROUP BY �� HAVING ��� ����!
   HAVING
   ===========
   ORDER
*/

/*
<GROUP BY>
 - HAVING�� GROUP BY �ڿ� ���;�. HAVING ȥ�� �ܵ����� �� �� ����. 
 
*/
SELECT * FROM emp ORDER BY deptno;

--ex) �μ��� �ο���, ���� ��, ���� ��� 
SELECT deptno, COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY deptno;

--ex) ������ �ο���, ���� �ִ밪, ���� �ּҰ�
SELECT job, COUNT(*), MAX(sal), MIN(sal) FROM emp
GROUP BY job;

--��ex) �Ի�⵵���� �ο���, �޿��� ��, �޿� ��� ��� 
SELECT TO_CHAR(hiredate,'YYYY') AS "�Ի�⵵", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');
SELECT SUBSTR(hiredate,1,2) AS "�Ի�⵵", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY SUBSTR(hiredate,1,2);

--��ex) �Ի��� ���Ϻ� �ο���, �޿���, �޿���� ��� 
SELECT TO_CHAR(hiredate,'Day') AS "�Ի����", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY TO_CHAR(hiredate,'Day'); --'�ݿ���' ����
SELECT TO_CHAR(hiredate,'DY') AS "�Ի����", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY TO_CHAR(hiredate,'DY'); --'��' ����
SELECT TO_CHAR(hiredate,'D') AS "�Ի����", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY TO_CHAR(hiredate,'D'); --'1' ���� (1:�Ͽ���, 7:�����)

--��ex) 2�� �׷� 
SELECT deptno, job, SUM(sal), AVG(sal) FROM emp
GROUP BY deptno,job
ORDER BY deptno ASC;

--��ex) 2�߱׷� - �μ��� �⵵���� 
SELECT deptno, TO_CHAR(hiredate,'YYYY'), COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY deptno, TO_CHAR(hiredate,'YYYY')
ORDER BY deptno ASC;

--�̷��� �ϸ� ��� �Ұ�!! 
SELECT deptno, TO_CHAR(hiredate,'YYYY'), job FROM emp
GROUP BY deptno, TO_CHAR(hiredate,'YYYY')
ORDER BY deptno ASC;
--�̷��Դ� ���� : 3�� 
SELECT deptno, TO_CHAR(hiredate,'YYYY'), job FROM emp
GROUP BY deptno, TO_CHAR(hiredate,'YYYY'), job
ORDER BY deptno ASC;

--ex) �׷� ����
SELECT deptno,COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY deptno;
--ex) �׷� ���� 
SELECT deptno,COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY deptno
HAVING AVG(sal)<=2000;

--ROLLUP
SELECT deptno, job, COUNT(*),ROUND(AVG(sal),2) FROM emp
GROUP BY ROLLUP(deptno,job);

--CUBE   
SELECT deptno, job, COUNT(*),ROUND(AVG(sal),2) FROM emp
GROUP BY CUBE(deptno,job);















