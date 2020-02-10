package com.sist.dao;
import java.util.*;
import java.sql.*;

public class ZipcodeDAO {
	// 연결도구 Connection (Socket)
	private Connection conn;
	// 입출력 => InputStream, OutputStream
	private PreparedStatement ps;
	// URL 주소 고정
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	//1. 드라이버 등록
	// - 한 번 수행 
	public ZipcodeDAO()
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
	
	public ArrayList<ZipcodeVO> postFind(String dong){
		ArrayList<ZipcodeVO> list=new ArrayList<ZipcodeVO>();
		try {
			getConnection();
			String sql="SELECT zipcode,sido,gugun,dong,NVL(bunji,' ') "
					+"FROM zipcode "
					+"WHERE dong LIKE '%'||?||'%'";
				// 컬럼 중에 NULL인 데이터를 가지는 컬럼이 있으므로 SELECT * 쓸 수 없다. 
				// NULL인 bunji가 있어서 처리해줘야함 ==> 처리 안 해주면 브라우저에서 진짜 'null'번지로 뜸. 
			ps=conn.prepareStatement(sql);
			ps.setString(1, dong);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) 
			{
				ZipcodeVO vo=new ZipcodeVO();
				vo.setZipcode(rs.getString(1));
				vo.setSido(rs.getString(2));
				vo.setGugun(rs.getString(3));
				vo.setDong(rs.getString(4));
				vo.setBunji(rs.getString(5));
				
				list.add(vo);
			}
			rs.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		finally
		{
			disConnection();
		}
		return list;
	}

}
