package com.sist.student.dao;
import java.sql.Date;

/*
 *  HAKBUN  NOT NULL NUMBER       
	NAME    NOT NULL VARCHAR2(30) 
	KOR     NOT NULL NUMBER       
	ENG     NOT NULL NUMBER       
	MATH    NOT NULL NUMBER       
	REGDATE          DATE         
	SEX              VARCHAR2(10) 
*/


public class StudentVO {
	private int hakbun;
	private String name;
	private int kor;
	private int eng;
	private int math;
	private Date regdate;
	private String sex;
	public int getHakbun() {
		return hakbun;
	}
	public void setHakbun(int hakbun) {
		this.hakbun = hakbun;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getKor() {
		return kor;
	}
	public void setKor(int kor) {
		this.kor = kor;
	}
	public int getEng() {
		return eng;
	}
	public void setEng(int eng) {
		this.eng = eng;
	}
	public int getMath() {
		return math;
	}
	public void setMath(int math) {
		this.math = math;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	
}







