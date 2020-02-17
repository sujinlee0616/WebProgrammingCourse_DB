package com.sist.dao;
import java.util.*;

import oracle.net.aso.r;

import java.sql.*; 

public class MusicDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	// 1. 드라이버 등록
	public MusicDAO() {
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception ex)
		{
			System.out.println(ex.getMessage());
		}
	}
	// 2. 연결
	public void getConnection()
	{
		try 
		{
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch (Exception ex) {}
	}
	// 3. 연결 해제 
	public void disConnection()
	{
		try 
		{
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch (Exception ex) {}
	}
	
	// =========================== 여기까지 계속 동일하므로 나중에 .jar 파일로 만들어버리자 =========================== 
	
	// 4. 기능구현 - 음악싸이트
	
	// 1) 순위,state,idcrement,poster,title,가수명,album 출력 
	// 여러개 출력 ==> VO가 여러개 ==> ArrayList 
	public ArrayList<MusicVO> musicListData(int page){
		ArrayList<MusicVO> list = new ArrayList<MusicVO>();
		try {
			getConnection();
			String sql="SELECT rank,state,idcrement,poster,title,singer,album,mno "
					+"FROM music_genie "
					+"ORDER BY rank ASC"; //순위 1위에서 점점 증가 ==> 오름차순
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			int rowSize=15;
			int pageStart=rowSize*(page-1); //pageStart: 특정 페이지가 시작하는 게시물의 번호. 			
			
			int i=0; 
			int j=0;
			while(rs.next())
				{
					if(i<rowSize && j>=pageStart) 
					{	// i: 50개씩 나눠줌. 0-49 도니까 50개씩 실행함. 
						// j: 테이블을 한 행씩 읽어나감. 행 넘버랑 똑같음. ==> while문이 돌아가는 횟수.
						// pageStart:  
						// ex) 2페이지 ==> pageStart=50 ==> j>=50 에서 시작해서 i가 0~49까지 50번 돌아서 j=50~99까지 가져온다. 
						MusicVO vo=new MusicVO();
						vo.setRank(rs.getInt(1));
						vo.setState(rs.getString(2));
						vo.setIdcrement(rs.getInt(3));
						vo.setPoster(rs.getString(4));
						vo.setTitle(rs.getString(5));
						vo.setSinger(rs.getString(6));
						vo.setAlbum(rs.getString(7));
						vo.setMno(rs.getInt(8));
						list.add(vo);
						i++;
					}
					j++;
				}
				
				
			} catch (Exception ex) {
				System.out.println(ex.getMessage());
			}
			finally 
			{
				disConnection();
			}
			return list;
		}
		
		// ■ 음악리스트 총 페이지수 구하기 
		public int musicTotalPage()
		{
			int total=0;
			try
			{
				getConnection();
				String sql="SELECT CEIL(COUNT(*)/15.0) FROM music_genie"; // (총 게시물 수 / 한 페이지당 게시물 갯수)를 올림하면 총 페이지 수.
				ps=conn.prepareStatement(sql); // 오라클 전송 
				ResultSet rs=ps.executeQuery();
				rs.next();
				total=rs.getInt(1);
				rs.close();
			}catch(Exception ex)
			{
				System.out.println(ex.getMessage());
			}
			finally
			{
				disConnection();
			}
			return total;
		}
		
		// 2) 음악 상세화면
		// rank,state,idcrement,title,singer,poster,key,mno
		public MusicVO musicDetailData(int no)
		{
			MusicVO vo=new MusicVO();
			try {
				getConnection();
				String sql="SELECT rank,state,idcrement,title,singer,poster,key,mno,album "
						+"FROM music_genie "
						+"WHERE mno=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, no);
				ResultSet rs=ps.executeQuery();
				rs.next();
				vo.setRank(rs.getInt(1));
				vo.setState(rs.getString(2));
				vo.setIdcrement(rs.getInt(3));
				vo.setTitle(rs.getString(4));
				vo.setSinger(rs.getString(5));
				vo.setPoster(rs.getString(6));
				vo.setKey(rs.getString(7));
				vo.setMno(rs.getInt(8));
				vo.setAlbum(rs.getString(9));
				rs.close();
				
			} 
			catch (Exception ex) {
				ex.getMessage();
			}
			finally 
			{
				disConnection();
			}
			return vo;
		}	
	
		
		
		// =========================================================================================================
		
		// 2) 로그인 
		public String isLogin(String id,String pwd)
		{
			String result = "";
			try 
			{
				getConnection();
				String sql="SELECT COUNT(*) FROM music_member "
						+"WHERE id=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, id);
				ResultSet rs = ps.executeQuery();
				rs.next();
				int count = rs.getInt(1);
				rs.close();
				
				if(count==0)
				{
					result="NOID";
				}
				else
					sql="SELECT pwd, name FROM music_member "
					+ "WHERE id=?";
				ps=conn.prepareStatement(sql);
				ps.setString(1, id);
				rs=ps.executeQuery();
				rs.next();				
				String db_pwd=rs.getString(1);
				String name=rs.getString(2);
				rs.close();
				
				if(db_pwd.equals(pwd)){
					result=name;
				}
				else
				{
					result="NOPWD";
				}
					
			} 
			catch (Exception ex) {
				ex.printStackTrace();
			}
			finally{
				disConnection();
			}
			
			return result;
			
		}
		
		
		// 3) 댓글쓰기 INSERT 
		// 4) 댓글수정 UPDATE
		// 5) 댓글삭제 DELETE 
		// 6) 댓글보기 SELECT => WHERE
		
	
}













