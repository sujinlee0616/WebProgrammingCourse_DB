--2020.02.21 (금)
--맛집서비스 만들기

SELECT * FROM category;
SELECT * FROM foodhouse;
DESC category;

--OO동 인기맛집 
SELECT * FROM foodhouse
WHERE address LIKE '%신사동%'
ORDER BY score DESC;

--OO동 인기맛집 Best5 <=== 잘못된 방법 
SELECT no,title,address,score,rownum FROM foodhouse
WHERE address LIKE '%신사동%' AND rownum<=5
ORDER BY score DESC;

--OO동 인기맛집 Best5 <=== 올바른 방법
SELECT no,title,address,score,rownum
FROM (SELECT no,title,address,score FROM foodhouse
WHERE address LIKE '%신사동%'
ORDER BY score DESC)
WHERE rownum<=5;




