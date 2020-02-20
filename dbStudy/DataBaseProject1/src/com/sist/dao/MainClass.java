package com.sist.dao;
import java.util.*;
public class MainClass {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		EmpDAO dao = new EmpDAO();
		// 실행시킬 때 우클릭 > Run As > Java Application 해라. 
		

		// ex 1) SELECT로 전체 데이터 읽어오는 것 만들어봐라.  		
		ArrayList<EmpVO> list=dao.empAllData();
		System.out.println("== ex1) SELECT로 전체 데이터를 읽어오시오 ============================");
		for(EmpVO vo:list) 
		{
			System.out.println(
					vo.getEmpno()+" "
					+vo.getEname()+" "
					+vo.getJob()+" "
					+vo.getMgr()+" "
					+vo.getHiredate().toString()+" "
					+vo.getSal()+" "
					+vo.getComm()+" "
					+vo.getDeptno()				
					);
		}
		System.out.println("== ex1) 출력 끝 ================================================\n");
		
		// ex3) SELECT, WHERE 문장 이용
		//		사용자가 empno 입력하면 데이터 뽑아오게 (결과 1줄. 1명 것만) 만들어봐라. 
		System.out.println("== ex3) 사번 입력 받은 후 결과 데이터 출력하시오. =======================");
		Scanner scan=new Scanner(System.in);
		System.out.println("사번 입력:");
		int empno=scan.nextInt();
	
		EmpVO vo=dao.empDetailData(empno);
		System.out.println(
				vo.getEmpno()+" "
				+vo.getEname()+" "
				+vo.getJob()+" "
				+vo.getMgr()+" "
				+vo.getHiredate().toString()+" "
				+vo.getSal()+" "
				+vo.getComm()+" "
				+vo.getDeptno()				
				);
		System.out.println("== ex3) 출력 끝 ================================================\n");
		
		
		// ex7) 철자 입력받아서 나오게 검색결과 나오게 만들어봐라. empFindData
		System.out.println("== ex7) 이름에 포함된 알파벡 입력받아서 검색결과 나오게 하라. ==============");
		System.out.println("이름에 포함된 알파벳 입력:");
		String ename=scan.next();
		
		list=dao.empFindData(ename.toUpperCase());
		for(EmpVO vo1:list)  //위에서 vo 쓰고 있어서 이름 바꿔야함...
		{
			System.out.println(
					vo1.getEmpno()+" "
					+vo1.getEname()+" "
					+vo1.getJob()+" "
					+vo1.getMgr()+" "
					+vo1.getHiredate().toString()+" "
					+vo1.getSal()+" "
					+vo1.getComm()+" "
					+vo1.getDeptno()				
					);
		}
		System.out.println("== ex7) 출력 끝 ================================================\n");
		
		
		// ex8) 사용자가 hiredate 년도 입력하면 해당하는 사람 리스트 뽑아내는거 만들어봐라. 
		System.out.println("== ex8) hiredate 입력받아서 해당년도 입사자 출력하라. ==================");
		System.out.println("입사 연도 입력(ex. 81):");
		int year=scan.nextInt();
		
		list=dao.empRangeData(year);
		for(EmpVO vo1:list)  //위에서 vo 쓰고 있어서 이름 바꿔야함...
		{
			System.out.println(
					vo1.getEmpno()+" "
					+vo1.getEname()+" "
					+vo1.getJob()+" "
					+vo1.getMgr()+" "
					+vo1.getHiredate().toString()+" "
					+vo1.getSal()+" "
					+vo1.getComm()+" "
					+vo1.getDeptno()				
					);
		}
		System.out.println("== ex8) 출력 끝 =================================================\n");

	}

}
