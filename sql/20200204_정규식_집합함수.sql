-- 2020-02-04 Á¤±Ô½Ä ÇÔ¼ö (REGEXP_LIKE) 
/*
<Á¤±Ô½Ä ±âÈ£>
 ^ : ½ÃÀÛ ==> A%
 $ : ³¡ ==> %A
 . : ÀÓÀÇÀÇ ÇÑ ±ÛÀÚ ==> _
 ? : ¾ÕÀÇ ±ÛÀÚ°¡ Æ÷ÇÔÀÌ µÇ°í, ¹ÌÆ÷ÇÔ ( ) 
 * : ¿©·¯ ±ÛÀÚ (±ÛÀÚ¼ö°¡ 0ÀÏ¼öµµ ÀÖÀ½) 
 + : ¿©·¯ ±ÛÀÚ (±ÛÀÚ¼ö°¡ 1ÀÌ»ó) 
     ex) [°¡-ÆR]* : ÇÑ±Û ¿©·¯±ÛÀÚ. ÇÑ±ÛÀÌ 0±ÛÀÚÀÏ ¼öµµ ÀÖÀ½. 
         [°¡-ÆR]+ : ÇÑ±Û 1±ÛÀÚ ÀÌ»ó 
     ex) ¸ÀÀÖ´Â ¸ÀÀÖ°Ô ¸ÀÀÖ°í ¸ÀÀÖ 
         ^[¸ÀÀÖ]* ==> ¸ÀÀÖ´Â ¸ÀÀÖ°Ô ¸ÀÀÖ°í ¸ÀÀÖ 
         ^[¸ÀÀÖ]+ ==> ¸ÀÀÖ´Â ¸ÀÀÖ°Ô ¸ÀÀÖ°í 
     ex) Â¥°í Â¥´Ù Â¥¼­ Â¥
         ^[Â¥]* ==> Â¥°í Â¥´Ù Â¥¼­ Â¥
         ^[Â¥]+ ==> Â¥°í Â¥´Ù Â¥¼­ 
 []: ÇØ´ç¹®ÀÚ Æ÷ÇÔ 
     ex) [A]: A Æ÷ÇÔ
         [A-Z]: ´ë¹®ÀÚ Æ÷ÇÔ
         [a-z]: ¼Ò¹®ÀÚ Æ÷ÇÔ 
         [°¡-ÆR]: ÇÑ±Û Æ÷ÇÔ
         [0-9]: ¼ýÀÚ Æ÷ÇÔ 
 [^] : ¹ÌÆ÷ÇÔ 
 | : OR
 {}: °¹¼ö 
     ex) {3}: 3°³
         {1-3}: 1-3°³
 \: ¿À¶óÅ¬¿¡¼­ »ç¿ëÇÏ´Â ¹®ÀÚµé(. ? &) ÀÚÃ¼¸¦ °¡Áö°í ¿À°í ½ÍÀ» ¶§ 
     ex) [\.] : '.'À» Æ÷ÇÔÇÏ´Â ¾Ö 
     
 
*/

--ex) A·Î ½ÃÀÛÇÏ´Â key°ª
SELECT key FROM music_genie 
WHERE REGEXP_LIKE (key, '^A');
SELECT key FROM music_genie 
WHERE key LIKE 'A%';

--ex) ´ë¹®ÀÚ·Î ½ÃÀÛÇÏ´Â key°ª
SELECT key FROM music_genie 
WHERE REGEXP_LIKE (key, '^[A-Z]');

--ex) ¿µ¾î·Î ½ÃÀÛÇÏ´Â key°ª 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^[A-Za-z]');

--ex) ¼ýÀÚ·Î ½ÃÀÛÇÏ´Â key°ª
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^[0-9]');

--ex) °ø¹éÀ¸·Î ½ÃÀÛÇÏ´Â key°ª ==> ¾ø´Ù. 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^[[:space:]]'); 

--ex) _°¡ µé¾î°£ key°ª 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '_'); 

--ex) ¼ýÀÚ·Î ³¡³ª´Â key°ª 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '[0-9]$'); 

--ex) '-' ¶Ç´Â '--'¸¦ Æ÷ÇÔÇÏ´Â key°ª 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '-|--'); 

--ex) '-' ¶Ç´Â ¼ýÀÚ¸¦ Æ÷ÇÔÇÏ´Â key°ª 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '-|[0-9]'); 

--ex) .ÀÇ ¿ë¹ý ==> .ÀÌ ÀÓÀÇÀÇ ±ÛÀÚ¸¦ ÀÇ¹ÌÇÏ¹Ç·Î 200Çà ÀüÃ¼°¡ ´Ù ³ª¿È
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '.'); 

--ex) .ÀÌ¶ó´Â ±ÛÀÚ°¡ Æ÷ÇÔµÈ µ¥ÀÌÅÍ¸¦ ¿øÇÑ´Ù¸é \. À¸·Î ½á¾ß. 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '\.'); 

--ex) ´ë¹®ÀÚ 2±ÛÀÚ·Î ½ÃÀÛÇÏ´Â key°ª
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^[A-Z]{2}'); 

--ex) ¼Ò¹®ÀÚ 3±ÛÀÚ·Î ³¡³ª´Â key°ª 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '[a-z]{3}$'); 

--ex) ¼ýÀÚ 2°³·Î ³¡³ª´Â key°ª 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '[0-9]{2}$'); 

--ex) µÎ¹øÂ° ¹®ÀÚ°¡ P°Å³ª pÀÎ key°ª 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^.(P|p)'); 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^.[P|p]'); 
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '^.[Pp]'); 

--ex) '_B' ¶Ç´Â 'a_'¸¦ Æ÷ÇÔÇÏ°í ÀÖ´Â key°ª
SELECT key FROM music_genie
WHERE REGEXP_LIKE (key, '(_B|a_)'); 

SELECT title FROM music_genie;

--ex) '?'°¡ Æ÷ÇÔµÈ Á¦¸ñ
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '\?'); 

SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '\?|\.');

--ex) '&'ÀÌ Æ÷ÇÔµÈ Á¦¸ñ 
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '\&'); 

--ex) ')'ÀÌ Æ÷ÇÔµÈ Á¦¸ñ
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '\)'); 

--ex) 
SELECT singer,title FROM music_genie
WHERE REGEXP_LIKE (singer, '¾ÆÀÌÀ¯'); 

--ex) °¡³ª´Ù¶ó¸¶¹Ù»ç °¡ Æ÷ÇÔµÈ Á¦¸ñ
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '°¡|³ª|´Ù|¶ó|¸¶|¹Ù|»ç');

--ex) Á¦¸ñÀÌ ¤¡-¤¤ Æ÷ÇÔ?
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title, '[°¡-³ª]');

--¡Ú ex) ³ë·¡ Á¦¸ñ¿¡ °ø¹é ¾ø´Â °Í 
SELECT title FROM music_genie
WHERE NOT REGEXP_LIKE (title,'[[:space:]]');

--¡Ú ex) Á¦¸ñÀÌ ¿µ¾î·Î¸¸ µÈ ³ë·¡ (ÇÑ±Û,¼ýÀÚX)
SELECT title FROM music_genie
WHERE NOT REGEXP_LIKE (title,'[°¡-ÆR0-9]');
--ÇÑÀÚ´Â ¾È ºüÁü... 'WINTER FLOWER (àäñéØÞ) (Feat. RM)' ´Â ¾îÂ¿ ¼ö ¾ø´ç..

--ex) Mo ¶Ç´Â Ma·Î ½ÃÀÛÇÏ´Â ³ë·¡ Á¦¸ñ
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title,'^(Mo|Ma)');

--ex) MÀ¸·Î ½ÃÀÛÇÏ°í µÎ¹øÂ° ±ÛÀÚ°¡ o ¶Ç´Â a·Î ½ÃÀÛÇÏ´Â ³ë·¡
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title,'^M(a|o)');

--ex) Á¦¸ñ¿¡ Ma¶Ç´Â Mo°¡ Æ÷ÇÔµÈ ³ë·¡ 
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title,'(Mo|Ma)');

--ex) ÇÑ±Û·Î ½ÃÀÛÇÏ´Â ³ë·¡¸¸ 
SELECT title FROM music_genie
WHERE REGEXP_LIKE (title,'^[°¡-ÆR]');

/*
<ÁýÇÕÇÔ¼ö>
 - COUNT, MAX, AVG, MIN, RANK, SUM
 - SELECT FROM
   WHERE
   ===========
   GROUP BY      <==¿À´ÃÀº GROUP BY ¶û HAVING ¹è¿ï ¿¹Á¤!
   HAVING
   ===========
   ORDER
*/

/*
<GROUP BY>
 - HAVINGÀº GROUP BY µÚ¿¡ ³ª¿Í¾ß. HAVING È¥ÀÚ ´Üµ¶À¸·Î ¾µ ¼ö ¾ø´Ù. 
 
*/
SELECT * FROM emp ORDER BY deptno;

--ex) ºÎ¼­º° ÀÎ¿ø¼ö, ¿ù±Þ ÇÕ, ¿ù±Þ Æò±Õ 
SELECT deptno, COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY deptno;

--ex) Á÷¾÷º° ÀÎ¿ø¼ö, ¿ù±Þ ÃÖ´ë°ª, ¿ù±Þ ÃÖ¼Ò°ª
SELECT job, COUNT(*), MAX(sal), MIN(sal) FROM emp
GROUP BY job;

--¡Úex) ÀÔ»ç³âµµº°·Î ÀÎ¿ø¼ö, ±Þ¿©ÀÇ ÇÕ, ±Þ¿© Æò±Õ Ãâ·Â 
SELECT TO_CHAR(hiredate,'YYYY') AS "ÀÔ»ç³âµµ", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY');
SELECT SUBSTR(hiredate,1,2) AS "ÀÔ»ç³âµµ", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY SUBSTR(hiredate,1,2);

--¡Úex) ÀÔ»çÇÑ ¿äÀÏº° ÀÎ¿ø¼ö, ±Þ¿©ÇÕ, ±Þ¿©Æò±Õ Ãâ·Â 
SELECT TO_CHAR(hiredate,'Day') AS "ÀÔ»ç¿äÀÏ", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY TO_CHAR(hiredate,'Day'); --'±Ý¿äÀÏ' Çü½Ä
SELECT TO_CHAR(hiredate,'DY') AS "ÀÔ»ç¿äÀÏ", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY TO_CHAR(hiredate,'DY'); --'±Ý' Çü½Ä
SELECT TO_CHAR(hiredate,'D') AS "ÀÔ»ç¿äÀÏ", COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY TO_CHAR(hiredate,'D'); --'1' Çü½Ä (1:ÀÏ¿äÀÏ, 7:Åä¿äÀÏ)

--¡Úex) 2Áß ±×·ì 
SELECT deptno, job, SUM(sal), AVG(sal) FROM emp
GROUP BY deptno,job
ORDER BY deptno ASC;

--¡Úex) 2Áß±×·ì - ºÎ¼­º° ³âµµº°·Î 
SELECT deptno, TO_CHAR(hiredate,'YYYY'), COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY deptno, TO_CHAR(hiredate,'YYYY')
ORDER BY deptno ASC;

--ÀÌ·¸°Ô ÇÏ¸é Ãâ·Â ºÒ°¡!! 
SELECT deptno, TO_CHAR(hiredate,'YYYY'), job FROM emp
GROUP BY deptno, TO_CHAR(hiredate,'YYYY')
ORDER BY deptno ASC;
--ÀÌ·¸°Ô´Â °¡´É : 3Áß 
SELECT deptno, TO_CHAR(hiredate,'YYYY'), job FROM emp
GROUP BY deptno, TO_CHAR(hiredate,'YYYY'), job
ORDER BY deptno ASC;

--ex) ±×·ì Á¶°Ç
SELECT deptno,COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY deptno;
--ex) ±×·ì Á¶°Ç 
SELECT deptno,COUNT(*), SUM(sal), AVG(sal) FROM emp
GROUP BY deptno
HAVING AVG(sal)<=2000;

--ROLLUP
SELECT deptno, job, COUNT(*),ROUND(AVG(sal),2) FROM emp
GROUP BY ROLLUP(deptno,job);

--CUBE   
SELECT deptno, job, COUNT(*),ROUND(AVG(sal),2) FROM emp
GROUP BY CUBE(deptno,job);















