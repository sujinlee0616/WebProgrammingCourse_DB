--2020.02.21 (��)
--�������� �����

SELECT * FROM category;
SELECT * FROM foodhouse;
DESC category;

--OO�� �α���� 
SELECT * FROM foodhouse
WHERE address LIKE '%�Ż絿%'
ORDER BY score DESC;

--OO�� �α���� Best5 <=== �߸��� ��� 
SELECT no,title,address,score,rownum FROM foodhouse
WHERE address LIKE '%�Ż絿%' AND rownum<=5
ORDER BY score DESC;

--OO�� �α���� Best5 <=== �ùٸ� ���
SELECT no,title,address,score,rownum
FROM (SELECT no,title,address,score FROM foodhouse
WHERE address LIKE '%�Ż絿%'
ORDER BY score DESC)
WHERE rownum<=5;




