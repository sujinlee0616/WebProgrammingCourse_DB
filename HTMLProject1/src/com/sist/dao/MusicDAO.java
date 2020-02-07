package com.sist.dao;
// 오라클 연결 
import java.util.*;
import java.sql.*;
public class MusicDAO {
	private Connection conn; // 오라클 연결 
	private PreparedStatement ps; // SQL 문장 전송 
	// SELECT, INSERT, UPDATE, DELETE => 오라클에서 코딩 vs 자바에서 SQL 코딩
	// SELECT * FROM emp WHERE ename LIKE '%A%' <=========== (X) : Java에서 Error남.
	// SELECT * FROM emp WHERE ename LIKE '%'||A||'%' <===== (O) : Java에서 사용 가능
	// 연결하기 위해 주소가 필요 
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	// 드라이버 등록
	public MusicDAO()
	{
		try 
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// 리플렉션 => 클래스의 이름을 읽어 와서 메모리 할당. 
			// new, Class.forName => 메모리할당 ==> Spring에서 많이 사용하는 방식
			// ==> 장점 : 이름만 남겨주면 다 제어 가능. (메소드 호출 가능.)  
		} catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	
	//연결
	public void getConnection() {
		try
		{
			conn=DriverManager.getConnection(URL,"hr","happy");
		}catch (Exception ex) {}

	}

	// 해제
	public void disConnection() {
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch (Exception ex) {}
	}
	
	// 기능 => 저장 ==> AutoCommit()
	// 디폴트 : AutoCommit(true). 즉, Java는 코딩하면 바로 커밋 날아간다.
	// 일괄처리하려면 AutoCommit(false)로 만든다.
	public void musicInsert(MusicVO vo)
	{
		try 
		{
			getConnection();
			String sql="INSERT INTO music_genie VALUES("
					+"(SELECT NVL(MAX(mno)+1,1) FROM music_genie),?,?,?,?,?,?,?,?)"; // Oracle로 전송 
			// 위와 같은 애들을 '서브쿼리'라고 한다. 
			// mno : 번호가 1씩 자동으로 증가. 
			// NVL : null일 때 1로 대체. 
			ps=conn.prepareStatement(sql); //prepared : 미리 문장을 만들어 놓고 나중에 ?에 대한 값을 채우고 실행 요청함.
			/*
			    mno NUMBER,
			    rank NUMBER,
			    title VARCHAR2(500),
			    singer VARCHAR2(200),
			    album VARCHAR2(300),
			    poster VARCHAR2(260),
			    idcrement NUMBER,
			    state CHAR(4),
			    key VARCHAR2(100)
			*/			
			ps.setInt(1, vo.getRank());  // ※주의: Oracle은 번호 1번부터 시작!! (0번부터 시작X)
			ps.setString(2, vo.getTitle()); // 작은따옴표'' 들어가야하는 애면 setString 사용. setString에서 ''을 넣어준다. 
			ps.setString(3, vo.getSinger());
			ps.setString(4, vo.getAlbum());
			ps.setString(5, vo.getPoster());
			ps.setInt(6, vo.getIdcrement());
			ps.setString(7, vo.getState());
			ps.setString(8, vo.getKey());
			
			// 실행
			ps.executeUpdate(); //commit
			
		} catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally 
		{
			disConnection();
		}
	}
	
	public ArrayList<MusicVO> musicListData()
	{
		ArrayList<MusicVO> list = new ArrayList<MusicVO>();
		try {
			getConnection();
			String sql="SELECT mno,title,singer,poster,album,idcrement,state FROM music_genie " // 공백 까먹지 말 것 !!!
					+ "ORDER BY rank ASC";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery(); // 실행된 모든 결과를 rs에 담는다
			while(rs.next())
			{
				MusicVO vo = new MusicVO();
				vo.setMno(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setSinger(rs.getString(3));
				vo.setPoster(rs.getString(4));
				vo.setAlbum(rs.getString(5));
				vo.setIdcrement(rs.getInt(6));
				vo.setState(rs.getString(7));
				
				list.add(vo); // ==> vo 안에는 DB에서 가져온 200개가 저장되어 있다.
			}
			rs.close();
			
		} catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			disConnection();
		}
		return list;
	}
	
}






