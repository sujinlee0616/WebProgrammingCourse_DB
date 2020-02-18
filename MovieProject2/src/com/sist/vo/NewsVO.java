package com.sist.vo;

/*
 * TITLE   NOT NULL VARCHAR2(4000) 
POSTER  NOT NULL VARCHAR2(1000) 
LINK    NOT NULL VARCHAR2(300)  
AUTHOR  NOT NULL VARCHAR2(200)  
REGDATE NOT NULL VARCHAR2(100)  
CONTENT NOT NULL CLOB    	
 */

public class NewsVO {
	private String title;
	private String poster;
	private String link;
	private String author;
	private String regdate;
	private String content;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	
}
