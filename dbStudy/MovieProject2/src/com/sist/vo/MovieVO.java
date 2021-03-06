// VO(Value Object) : 계층간 데이터 교환
package com.sist.vo;
// 다음 영화에서 JSoup으로 영화 긁어와서  Class에 저장하고, 
// Class가 여러개가 나올테니 (200개..?) 클래스를 ArrayList에 집어넣고 그걸 오라클에다가 집어넣을 예정. 
// ★하나의 클래스 = 영화 1개에 대한 데이터 = 오라클 SQL 테이블의 한 행★ 
/*
 * CHAR, VARCHAR, CLOB ==> String
 * NUMBER ==> 실수(double), 정수(int)  
*/
public class MovieVO {
	private int mno;
	private String title;
	private String poster;
	private double score;
	private String genre;
	private String regdate;
	private String time;
	private String grade;
	private String director;
	private String actor;
	private String story;
	private int type;
	
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public int getMno() {
		return mno;
	}
	public void setMno(int mno) {
		this.mno = mno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getStory() {
		return story;
	}
	public void setStory(String story) {
		this.story = story;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
	
	
}
