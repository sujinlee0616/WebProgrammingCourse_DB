--2020-04-03 데이터베이스 

/* [RecipeVO] 
   private int no;
    private String title;
    private String poster;
    private String chef;
    private String link;
*/
CREATE TABLE recipe(
    no NUMBER,
    title VARCHAR2(300) CONSTRAINT recipe_title_nn NOT NULL,
    poster VARCHAR2(300) CONSTRAINT recipe_poster_nn NOT NULL,
    chef VARCHAR2(100) CONSTRAINT recipe_chef_nn NOT NULL,
    link VARCHAR2(200),
    CONSTRAINT recipe_no_pk PRIMARY KEY(no)
);


/* [RecipeDetailVO]
    private int no;
   private String poster;
   private String title;
   private String chef;
   private String chef_poster;
   private String chef_profile;
   private String info1,info2,info3;
   private String content;
   private String foodmake;
*/
CREATE TABLE recipe_detail(
    no NUMBER,
    poster VARCHAR2(300) CONSTRAINT rd_poster_nn NOT NULL,
    title VARCHAR2(300) CONSTRAINT rd_title_nn NOT NULL,
    chef VARCHAR2(100) CONSTRAINT rd_chef_nn NOT NULL,
    chef_poster VARCHAR2(200) CONSTRAINT rd_chef_poster_nn NOT NULL,
    chef_profile VARCHAR2(100) CONSTRAINT rd_chef_profile_nn NOT NULL,
    info1 VARCHAR2(20),
    info2 VARCHAR2(20),
    info3 VARCHAR2(20),
    content VARCHAR2(4000) CONSTRAINT rd_content_nn NOT NULL,
    foodmake CLOB,
    CONSTRAINT rd_no_pk FOREIGN KEY(no)
    REFERENCES recipe(no)
)


/* [ChefVO]
    private String poster;
    private String chef;
    private String mem_cont1;
    private String mem_cont3;
    private String mem_cont7;
    private String mem_cont2;
*/
CREATE TABLE chef(
    chef VARCHAR2(100), 
    poster VARCHAR2(200) CONSTRAINT chef_poster_nn NOT NULL,
    mem_cont1 VARCHAR2(20),
    mem_cont3 VARCHAR2(20),
    mem_cont7 VARCHAR2(20),
    mem_cont2 VARCHAR2(20),
    CONSTRAINT chef_chef_pk PRIMARY KEY(chef)
)

DESC recipe;
DESC recipe_detail;
DESC chef;

SELECT COUNT(*) FROM chef;
SELECT COUNT(*) FROM recipe;
SELECT COUNT(*) FROM recipe_detail;

SELECT COUNT(*) FROM recipe;

SELECT no,title FROM foodhouse
ORDER BY no ASC;

DESC foodhouse;
        
DESC chef;













