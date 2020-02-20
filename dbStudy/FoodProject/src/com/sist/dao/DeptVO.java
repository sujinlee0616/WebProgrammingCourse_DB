package com.sist.dao;

public class DeptVO {
	
	private int deptno;
	private String dname;
	private String loc;
	
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
	

}

/*
 * 2020.02.19 (수) 
 * <VIEW>
 *  - 가상테이블
 *  - 보안에 뛰어나다
 *  - 반드시 원래 테이블이 있어야 만들 수 있음
 *  - DBCP는 웹에서만 실행할 수 있다. ==> 함부로 DBCP 쓰면 안 된다. 
 *  - Servlet이나 JSP가 구동이 되어야만 톰캣이 작동  
 *    ==> Main에서는 실행 불가  
 *    
 */