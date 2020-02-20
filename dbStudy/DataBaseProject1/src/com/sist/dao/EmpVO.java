package com.sist.dao;
//SQLplus에서 테이블 드래그 후 엔터 ==> 복사된다. 
/*
 EMPNO                                              NUMBER ==> int
 ENAME                                              VARCHAR2(10) ==> String 
 JOB                                                VARCHAR2(9) ==> String 
 MGR                                                NUMBER(4) ==> int 
 HIREDATE                                           DATE ==> Date
 SAL                                                NUMBER(7,2) ==> int 
 COMM                                               NUMBER(7,2) ==> int 
 DEPTNO                                             NUMBER ==> int
 ※ SAL과 COMM은 데이터형은 소숫점 2자리까지여도 실제 데이터는 모두 정수였음.. ==> int로 잡았다. 
*/

/*<오라클 데이터형>
 *1. 문자형 
 * - CHAR, VARCHAR2, CLOB ==> String
 *2. 숫자형 
 * - NUMBER 
 * 		┗ NUMBER(4), NUMBER ==> int
 * 		┗ NUMBER(7.2) ==> double, int 
 *3. 날짜형 
 * - DATE ==> java.util.Date 
 */
import java.util.*;
public class EmpVO {
	// DB 컬럼명과 일치하게 변수 설정 
	private int empno;
	private String ename;
	private String job;
	private int mgr;
	private Date hiredate;
	private int sal;
	private int comm;
	private int deptno;
	// 한 명에 대한 데이터. 캡슐화 방식. 
	// get ==> 출력. set ==> 오라클에서 값을 가져옴. 
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public int getMgr() {
		return mgr;
	}
	public void setMgr(int mgr) {
		this.mgr = mgr;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	public int getSal() {
		return sal;
	}
	public void setSal(int sal) {
		this.sal = sal;
	}
	public int getComm() {
		return comm;
	}
	public void setComm(int comm) {
		this.comm = comm;
	}
	public int getDeptno() {
		return deptno;
	}
	public void setDeptno(int deptno) {
		this.deptno = deptno;
	}
}






