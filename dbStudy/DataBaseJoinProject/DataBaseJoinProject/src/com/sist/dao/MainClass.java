package com.sist.dao;
//  JSP => 사용자가 보는 화면
import java.util.*;
public class MainClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		EmpDAO dao=new EmpDAO();
		ArrayList<EmpVO> list=dao.empJoinData();
		
		for(EmpVO vo:list) {
			System.out.println(vo.getEmpno()+" "
					+vo.getEname()+" "
					+vo.getJob()+" "
					+vo.getHiredate().toString()+" "
					+vo.getSal()+" "
					+vo.getDvo().getDname()+" "
					+vo.getDvo().getLoc()+" "
					+vo.getSvo().getGrade());
		}
	}

}
