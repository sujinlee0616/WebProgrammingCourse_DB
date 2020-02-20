package com.sist.dao;
import java.util.*;

public class MainClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		// Error.
		// 톰캣이 작동하려면 Servlet이나 JSP가 작동해야지만 Connection Pool을 사용할 수 있다. 
		EmpDAO dao = new EmpDAO();
		ArrayList<EmpVO> list=dao.empAllData();
		for(EmpVO vo:list)
		{
			System.out.println(vo.getEname()+" "+vo.getDvo().getDname());
		}
	}

}
