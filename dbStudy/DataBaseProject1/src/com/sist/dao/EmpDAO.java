 package com.sist.dao;
// DAO - 오라클 DB 연동 ==> SQL(오라클 실행) ==> Java 
/*
 * 1. 드라이버 등록
 * 2. 연결
 * 3. 해제
 * 4. 기능설정   ==> SQL 전송, 결과값 받는다. 
 * 				 ========
 */
// SQL에서는 테이블들을 Join할 수 있지만, 자바에서는 테이블마다 VO를 가지고 와서.... 한다. 
import java.util.*;
import java.sql.*;
public class EmpDAO {
	// 연결 도구 Connection (Sockeet)
	private Connection conn;
	// 입출력 => InputStream, OutputStream
	private PreparedStatement ps;
	// URL 주소 고정
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	//1. 드라이버 등록
	// - 한 번 수행 
	public EmpDAO()
	{
		try 
		{
			Class.forName("oracle.jdbc.driver.OracleDriver"); //메모리 할당
		} catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	//2. 연결
	public void getConnection()
	{
		try 
		{
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch (Exception ex) {}
	}
	
	//3. 해제
	public void disConnection()
	{
		try
		{
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		}catch (Exception ex) {}
	}
	
	//4. 기능설정(기능수행)
	// - 1~3번은 계속 공통으로 쓰고.... 4 기능설정만 바꾸면 됨... 
	
	// ex1) SELECT로 전체 데이터 읽어오는 것 만들어봐라. 
	// 	   전체 데이터 ==> 14개의 행(VO)가 들어오는 것 ==> 리턴형: ArrayList 
	public ArrayList<EmpVO> empAllData()
	{
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		try 
		{
			// (1) 연결
			getConnection();
			// (2) SQL 문장 만들고
			String sql="SELECT * " //공백 잊으면 안된다 ㅠㅠ!!
						+"FROM emp "//공백 잊으면 안된다 ㅠㅠ!!
						+"ORDER BY empno"; //ORDER BY는 가급적이면 쓰면 안 됨 ==> 나중에 얘를 INDEX로 바꿔야함. 	
			// (3) 오라클로 전송
			ps=conn.prepareStatement(sql); // ==> (2)에서 만든 SQL문장이 오라클로 넘어갔다. 
			// (4) 결과값 받기 
			ResultSet rs=ps.executeQuery();
			// (5) 결과값 받은 것을 list에 첨부 
			while(rs.next())
			{
				// rs.next() : 결과값에서 첫 행에 커서를 두고 처음 행을 읽음 ==> 커서를 한 행씩 뒤로 이동하면서 다음줄 데이터를 한 줄 한 줄 읽음...
				// ※ rs.previous()의 경우 맨 끝행에 커서를 두고 끝 행 읽고 아래에서 위로 한 줄씩 읽는다... 
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setMgr(rs.getInt(4));
				vo.setHiredate(rs.getDate(5));
				vo.setSal(rs.getInt(6));
				vo.setComm(rs.getInt(7));
				vo.setDeptno(rs.getInt(8));
				
				list.add(vo); //14개를 모아서 전송
			}
			rs.close();
		} catch (Exception ex) 
		{
			// 에러처리 
			ex.printStackTrace();
		}
		finally
		{
			// 연결 해제 
			disConnection();
		}
		return list;
	}
	
	// ex2) SELECT로 원하는 컬럼만 읽는다.
	//    하나의 행(VO)가 들어옴 ==> 리턴형 : VO
	
	// ex3) SELECT, WHERE 문장 이용
	//		사용자가 empno 입력하면 데이터 뽑아오게 (결과 1줄. 1명 것만) 만들어봐라. 
	public EmpVO empDetailData(int empno) 
	{
		EmpVO vo = new EmpVO();
		
		try 
		{
			// (1) 연결
			getConnection();
			// (2) SQL 문장 만들고
			String sql="SELECT * " 
						+"FROM emp "
						+"WHERE empno=?"; 
			// (3) 오라클로 전송
			ps=conn.prepareStatement(sql); 
			ps.setInt(1, empno);
			// (4) 결과값 받기 
			ResultSet rs=ps.executeQuery();
			// (5) 결과값 받은 것을 list에 첨부 
			rs.next();
			vo.setEmpno(rs.getInt(1));
			vo.setEname(rs.getString(2));
			vo.setJob(rs.getString(3));
			vo.setMgr(rs.getInt(4));
			vo.setHiredate(rs.getDate(5));
			vo.setSal(rs.getInt(6));
			vo.setComm(rs.getInt(7));
			vo.setDeptno(rs.getInt(8));
				
			rs.close();
		} catch (Exception ex) 
		{
			// 에러처리 
			ex.printStackTrace();
		}
		finally
		{
			// 연결 해제 
			disConnection();
		}
		
		return vo; 
	}
				
	// ex4) SELECT => 연산자 사용 방법 
	// ex5) SELECT => 함수 이용 
	// ex6) SELECT => GROUP BY 이용 
	
	// ex7) 철자 입력받아서 나오게 검색결과 나오게 만들어봐라. empFindData
	// 리턴형, 매개변수 뭐 줄거냐 
	// SELECT * FROM emp WHERE ename LIKE '%K%';
	// 결과값이 3개 ==> 리턴형 : ArrayList 
	public ArrayList<EmpVO> empFindData(String ename)
	{
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		try 
		{
			// (1) 연결
			getConnection();
			// (2) SQL 문장 만들고
			String sql="SELECT * " 
						+"FROM emp "
						+"WHERE ename LIKE '%'||?||'%'"; 	//<==오라클이랑 SQL 구문 좀 다르라
			// (3) 오라클로 전송
			ps=conn.prepareStatement(sql); 
			ps.setString(1, ename);
			// (4) 결과값 받기 
			ResultSet rs=ps.executeQuery();
			// (5) 결과값 받은 것을 list에 첨부 
			while(rs.next())
			{
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setMgr(rs.getInt(4));
				vo.setHiredate(rs.getDate(5));
				vo.setSal(rs.getInt(6));
				vo.setComm(rs.getInt(7));
				vo.setDeptno(rs.getInt(8));
				
				list.add(vo); //14개를 모아서 전송
			}
			rs.close();
		} catch (Exception ex) 
		{
			// 에러처리 
			ex.printStackTrace();
		}
		finally
		{
			// 연결 해제 
			disConnection();
		}
		return list;
	}
	
	// ex8) 사용자가 hiredate 년도 입력하면 해당하는 사람 리스트 뽑아내는거 만들어봐라. 
	// SELECT * FROM emp WHERE hiredate BETWEEN '81/01/01' AND '81/12/31';
	// 결과 : 여러줄 ==> 리턴형 : ArrayList
	public ArrayList<EmpVO> empRangeData(int year)
	{
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		try 
		{
			// (1) 연결
			getConnection();
			// (2) SQL 문장 만들고
			String sql="SELECT * " 
						+"FROM emp "
						+"WHERE hiredate BETWEEN ? AND ?"; 	//<==오라클이랑 SQL 구문 좀 다르라
			// (3) 오라클로 전송
			ps=conn.prepareStatement(sql); 
			ps.setString(1, year+"/01/01");
			ps.setString(2, year+"/12/31");
			// (4) 결과값 받기 
			ResultSet rs=ps.executeQuery();
			// (5) 결과값 받은 것을 list에 첨부 
			while(rs.next())
			{
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setMgr(rs.getInt(4));
				vo.setHiredate(rs.getDate(5));
				vo.setSal(rs.getInt(6));
				vo.setComm(rs.getInt(7));
				vo.setDeptno(rs.getInt(8));
				
				list.add(vo); //14개를 모아서 전송
			}
			rs.close();
		} catch (Exception ex) 
		{
			// 에러처리 
			ex.printStackTrace();
		}
		finally
		{
			// 연결 해제 
			disConnection();
		}
		return list;
	}
	
	
}









