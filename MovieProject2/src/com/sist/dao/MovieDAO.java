package com.sist.dao;
import java.util.*;
import com.sist.vo.MovieVO;
import com.sist.vo.NewsVO;

import java.sql.*;

public class MovieDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	private static MovieDAO dao;
	
	// 드라이버 등록
	public MovieDAO()
	{
		try
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}
	}
	
	// 싱글톤 - 객체를 한 번만 생성한다! 
	// newInstance나오면 싱글톤임.
	public static MovieDAO newInstance()
	{
		if(dao==null)
			dao=new MovieDAO();
		return dao;
	}
	
	public void getConnection()
	{
		try 
		{
			conn=DriverManager.getConnection(URL,"hr","happy");
		} catch (Exception ex) {}
	}
	
	public void disConnection()
	{	
		try {
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} catch (Exception ex) {}
		
	}
	
	
	// ===============================  movie 테이블에 데이터를 집어넣는다. ========================================================
	public void movieInsert(MovieVO vo) //
	{
		/* DESC movie;
		 * 
		 *  MNO      NOT NULL NUMBER(4)      
			TITLE    NOT NULL VARCHAR2(1000) 
			POSTER   NOT NULL VARCHAR2(1000) 
			SCORE             NUMBER(4,2)    
			GENRE    NOT NULL VARCHAR2(100)  
			REGDATE           VARCHAR2(100)  
			TIME              VARCHAR2(10)   
			GRADE             VARCHAR2(100)  
			DIRECTOR          VARCHAR2(200)  
			ACTOR             VARCHAR2(200)  
			STORY             CLOB           
			TYPE              NUMBER         
		 */
		try {
			getConnection();
			String sql="INSERT INTO movie VALUES("
					+"(SELECT NVL(MAX(mno)+1,1) FROM movie),"
					+"?,?,?,?,?,?,?,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getPoster());
			ps.setDouble(3, vo.getScore());
			ps.setString(4, vo.getGenre()); 
			ps.setString(5, vo.getRegdate()); 
			ps.setString(6, vo.getTime());
			ps.setString(7, vo.getGrade());
			ps.setString(8, vo.getDirector());
			ps.setString(9, vo.getActor());
			ps.setString(10, vo.getStory());
			ps.setInt(11, vo.getType());
			
			
			ps.executeUpdate();		
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			
		}
	}
	
	
	// =============================== movieList 라는 ArrayList에다가 데이터 집어넣음  ========================================================
	public ArrayList<MovieVO> movieListData(int page, int type)
	{
		ArrayList<MovieVO> list = new ArrayList<MovieVO>();
		try 
		{
			getConnection();
			int rowSize=12;
			int start = (page*rowSize) - (rowSize-1);
			// 1page: start=1*12-11=1
			// 2page: start=2*12-11=13
			int end = page * rowSize;
			// 1page: end=1*12=12
			// 2page: end=2*12=24
			String sql="";
			if(type<3)
			{
				sql="SELECT mno,title,poster,score,regdate,num " // 상세보기로 넘어가려면 mno알아야 하므로 mno 들고와야 
				    	+"FROM (SELECT mno,title,poster,score,regdate,rownum as num "
								+"FROM (SELECT mno,title,poster,score,regdate "
										+"FROM movie WHERE type=? ORDER BY mno ASC)) "
						+"WHERE num BETWEEN ? AND ?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, type);
				ps.setInt(2, start);
				ps.setInt(3, end);
			}
			else
			{
				sql="SELECT mno,title,poster,score,regdate " 
				    		+"FROM movie WHERE type=? ORDER BY mno ASC ";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, type);
			}
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) //rs.next하면서 한 행씩 계속... 왔다갔다하면서 값 읽고 값 가져옴
			{
				MovieVO vo = new MovieVO();
				vo.setMno(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setPoster(rs.getString(3));
				vo.setScore(rs.getDouble(4));
				vo.setRegdate(rs.getString(5));
				
				list.add(vo);
				
			}
			rs.close();
			
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally 
		{
			disConnection();
		}

		return list;
		
	}
	
	
	// =============================== news테이블에 데이터를 집어넣는다 ========================================================
	public void newsInsert(NewsVO vo) //
	{
		
		try {
			getConnection();
			String sql="INSERT INTO news VALUES("
					+"?,?,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getTitle());
			ps.setString(2, vo.getPoster());
			ps.setString(3, vo.getLink());
			ps.setString(4, vo.getAuthor()); 
			ps.setString(5, vo.getRegdate()); 
			ps.setString(6, vo.getContent());
			
			
			ps.executeUpdate();		
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
		finally
		{
			disConnection();
		}
	}
	
}


/*
 * <디자인 패턴>
 *  - 총 23개의 패턴을 가짐.
 * 1. 싱글톤패턴 ★
 *  - Spring!!☆
 *  - 전역 변수를 사용하지 않고 ★객체를 하나만 생성★ 하도록 하며, 생성된 객체를 어디에서든지 참조할 수 있도록 하는 패턴
 *  - 애플리케이션이 시작될 때 어떤 클래스가 최초 한번만 메모리를 할당하고(Static) 그 메모리에 인스턴스를 만들어 사용하는 디자인패턴.
 *  - 생성자가 여러 차례 호출되더라도 실제로 생성되는 객체는 하나고 최초 생성 이후에 호출된 생성자는 최초에 생성한 객체를 반환한다.
 *  - 고정된 메모리 영역을 얻으면서 한번의 new로 인스턴스를 사용하기 때문에 메모리 낭비를 방지할 수 있음
 * 2. 팩토리 패턴★
 *  - 객체를 생성하기 위한 인터페이스를 정의하는데, 어떤 클래스의 인스턴스를 만들지는 서브클래스에서 결정하게 만든다. 
 *  - 즉, 팩토리 메소드 패턴을 이용하면 클래스의 인스턴스를 만드는 일을 서브클래스에게 맡기는 것. 
 * 3. MV 패턴
 * 4. MVC 패턴
 * 5. 옵저버 패턴
 *  - 클릭하면 시스템이 감지하게 하게끔. 윈도우에서 많이 사용함.  
 * 6. 어댑터 패턴
 *  - 자동으로 형변환 시켜주는 패턴. POJO와 관련. 
 * 7. 프로토타입
 *  - 오브젝트 할 때 복제(clone)하는 게 프로토타입 패턴임. 
 * 
 */














