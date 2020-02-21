// <JDBC + DBCP>
// 1. JDBC 사용 부분
// - FoodDAO 생성자 + getConnection의 try 부분의 conn 부분 ===> 데이터 수집 이후 주석처리했음.
// - FoodManager가 웹프로그래밍이 아니라서 데이터 수집 시 DBCP 쓸 수 X ==> JDBC 사용했음. 
// 2. DBCP 사용 부분
// - 나머지 다 

package com.sist.dao;
import java.util.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;
import com.sist.manager.*;

public class FoodDAO {
	private Connection conn;
	private PreparedStatement ps;
	private static FoodDAO dao; //싱글톤-DAO 객체를 하나만 만들거다. 
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	// [JDBC 코드] - JDBC 사용하지 않고 DBCP 써야 할 때는 주석처리 할 것 
	// JDBC 사용해서 Application 돌려서 데이터 수집한 부분  
	/*public FoodDAO()
	{
		try 
		{
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} 
		catch (Exception ex) 
		{
			System.out.println(ex.getMessage());
		}
	}*/
	
	// [DBCP]
	// 1. 연결-getConnection() 2. disConnection(), 3. DAO newInstance() 4.기능
	
	// 1. 연결: 이미 생성된되어 있는 Connection 객체를 얻어온다. 	
	public void getConnection()
	{
		try 
		{
			//[JDBC 코드] - JDBC 사용하지 않고 DBCP 써야 할 때는 주석처리 할 것 
			//conn=DriverManager.getConnection(URL,"hr", "happy");
			
			//[DBCP 코드] - DBCP 사용하지 않고 JDBC 써야 할 때는 주석처리 할 것 (아래 4줄)
			Context init=new InitialContext(); // JNDI reg
			Context c=(Context)init.lookup("java://comp//env");
			DataSource ds=(DataSource)c.lookup("jdbc/oracle");
			conn=ds.getConnection();
			
		} 
		catch (Exception ex) 
		{
			ex.printStackTrace();
		}
	}
	// 2. 반환 
	public void disConnection() 
	{
		try {
			// 닫기 => ps,conn
			// close는 예외처리 안 하면 오류남 (compile exception)
			if(ps!=null) ps.close();
			if(conn!=null) conn.close();
		} 
		catch (Exception ex) {}
		
	}
	
	// 3.DAO를 각 사용자당 한 개만 사용이 가능하게 만든다. ==> 싱글톤 
	public static FoodDAO newInstance()
	{
		if(dao==null)
			dao=new FoodDAO();
		return dao;
	}
	
	// 4. 기능(오라클 연동) 
	// 1) category 테이블에 삽입할 데이터 준비
	// JDBC 사용 (FoodManager.java에서 메인에서 돌아가니까)
	public void categoryInsert(CategoryVO vo)
	{
		try 
		{
			/* [category  테이블] 
			 *  CATENO  NOT NULL NUMBER        
				TITLE   NOT NULL VARCHAR2(200) 
				SUBJECT NOT NULL VARCHAR2(200) 
				POSTER  NOT NULL VARCHAR2(200) 
				LINK    NOT NULL VARCHAR2(200)
			 */
			getConnection();
			String sql="INSERT INTO category VALUES(?,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getCateno());
			ps.setString(2, vo.getTitle());
			ps.setString(3, vo.getSubject());
			ps.setString(4, vo.getPoster());
			ps.setString(5, vo.getLink());
			
			ps.executeUpdate(); //INSERT ==> executeUpdate()
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
	
	// 2) FoodMainServlet 리스트에 나와야 하는 데이터들 준비 
	public ArrayList<CategoryVO> categoryAllData()
	{
		ArrayList<CategoryVO> list = new ArrayList<CategoryVO>();
		try 
		{
			getConnection();
			String sql="SELECT cateno,title,subject,poster "
					+ "FROM category "
					+ "ORDER BY cateno ASC";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery(); //INSERT 없으니까 updateQuery아님. SELECT니까 executeQuery임.   
			while(rs.next())
			{
				CategoryVO vo=new CategoryVO();
				vo.setCateno(rs.getInt(1));
				vo.setTitle(rs.getString(2));
				vo.setSubject(rs.getString(3));
				vo.setPoster(rs.getString(4));
				
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
	
	// 3) foodhouse 테이블에 삽입할 데이터 준비
	// JDBC 사용 (FoodManager.java에서 메인에서 돌아가니까)
	public void foodHouseInsert(FoodHouseVO vo)
	{
		try 
		{
			/*  [foodhouse  테이블] 
			 * 	NO      NOT NULL NUMBER         
				CNO              NUMBER         
				TITLE   NOT NULL VARCHAR2(200)  
				SCORE   NOT NULL NUMBER(2,1)    
				ADDRESS NOT NULL VARCHAR2(200)  
				TEL     NOT NULL VARCHAR2(30)   
				TYPE    NOT NULL VARCHAR2(100)  
				PRICE            VARCHAR2(100)  
				IMAGE   NOT NULL VARCHAR2(2000) 
				GOOD             NUMBER         
				SOSO             NUMBER         
				BAD              NUMBER         
				TAG              VARCHAR2(2000) 
			 */
			getConnection();
			String sql="INSERT INTO foodhouse VALUES("
					+ "foodhouse_no_seq.nextval,?,?,?,?,"
					+ "?,?,?,?,?,?,?,'none')";
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, vo.getCno());
			ps.setString(2, vo.getTitle());
			ps.setDouble(3, vo.getScore());
			
			ps.setString(4, vo.getAddress());
			ps.setString(5, vo.getTel());
			ps.setString(6, vo.getType());
			ps.setString(7, vo.getPrice());
			ps.setString(8, vo.getImage());
			
			ps.setInt(9, vo.getGood());
			ps.setInt(10, vo.getSoso());
			ps.setInt(11, vo.getBad());
			
			ps.executeUpdate(); //INSERT ==> executeUpdate()
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
	
	// 4) 리스트페이지에 들어갈 데이터들 준비 - (2) 음식점 정보들 가져옴
	// - 리스트페이지: 하나의 카테고리에 해당하는 맛집들 노출
	public ArrayList<FoodHouseVO> foodHouseListData(int cno)
	{
		ArrayList<FoodHouseVO> list = new ArrayList<FoodHouseVO>();
		try 
		{
			getConnection();
			String sql="SELECT image,title,score,address,no "
					+ "FROM foodhouse "
					+ "WHERE cno=?";
			ps=conn.prepareStatement(sql);
			// ?에 값을 채운다
			ps.setInt(1, cno); 
			// 결과값 받기
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{
				FoodHouseVO vo=new FoodHouseVO();
				String img=rs.getString(1);
				vo.setImage(img.substring(0,img.indexOf("^"))); //이미지 한 개만 출력하면 됨 
				// image 컬럼 데이터값형태: https://mp-seoul-image-production-s3.mangoplate.com/881793_1512208063612527.jpg?fit=around|512:512&crop=512:512;*,*&output-format=jpg&output-quality=80^https://mp-seoul-image-production-s3.mangoplate.com/271137/1574936_1581699273835_3693?fit=around|512:512&crop=512:512;*,*&output-format=jpg&output-quality=80^https://mp-seoul-image-production-s3.mangoplate.com/1571476_1581229631033206.jpg?fit=around|512:512&crop=512:512;*,*&output-format=jpg&output-quality=80^https://mp-seoul-image-production-s3.mangoplate.com/1571476_1581229631569746.jpg?fit=around|512:512&crop=512:512;*,*&output-format=jpg&output-quality=80^https://mp-seoul-image-production-s3.mangoplate.com/271137/408430_1580567310369_8530?fit=around|512:512&crop=512:512;*,*&output-format=jpg&output-quality=80
				// String.substring(start,end) //문자열  start위치 부터 "end전까지" 문자열 발췌
				// ==> ^위치 전까지 String 값 잘라옴 
				vo.setTitle(rs.getString(2));
				vo.setScore(rs.getDouble(3));
				vo.setAddress(rs.getString(4));
				vo.setNo(rs.getInt(5));
				
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
	
	// 4) 리스트페이지에 들어갈 데이터들 준비 - (1) 카테고리명(테마명), 카테고리설명(테마 설명)
	// - ex) 튀김 맛집 베스트 35곳 / “바사삭 소리까지 맛있어!”
	public CategoryVO categoryInfoData(int cno)//두 개만 가져오면 되니까 VO 썼음.
	{
		CategoryVO vo=new CategoryVO();
		try 
		{
			getConnection();
			String sql="SELECT title,subject "
					+ "FROM category "
					+ "WHERE cateno=?";
			ps=conn.prepareStatement(sql);
			//?에 값을 채운다
			ps.setInt(1, cno);
			// 결과값 받는다
			ResultSet rs=ps.executeQuery();
			
			rs.next(); // 데이터가 하나만 나오면 되니까 while문 안 돌림
			vo.setTitle(rs.getString(1));
			vo.setSubject(rs.getString(2));
			
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
		return vo;
	}
	
	// 5) 상세페이지 데이터 준비 - (1) 정보
	public FoodHouseVO foodDetailData(int no)
	{
		FoodHouseVO vo=new FoodHouseVO();
		
		try 
		{
			getConnection();
			String sql="SELECT image,title,score,address,tel,type,price,good,soso,bad "
					+ "FROM foodhouse "
					+ "WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setImage(rs.getString(1));
			vo.setTitle(rs.getString(2));
			vo.setScore(rs.getDouble(3));
			vo.setAddress(rs.getString(4));
			vo.setTel(rs.getString(5));
			vo.setType(rs.getString(6));
			vo.setPrice(rs.getString(7));
			vo.setGood(rs.getInt(8));
			vo.setSoso(rs.getInt(9));
			vo.setBad(rs.getInt(10));
			
			rs.close();
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		finally
		{
			disConnection();
		}
		
		return vo;
	}
	
	// 5) 상세페이지 데이터 준비 - (2) 주변인기식당 Top5
	public ArrayList<FoodHouseVO> foodLocationData(String loc) // 동을 받아서 그 동에 해당하는 가게 출력
	{
		ArrayList<FoodHouseVO> list=new ArrayList<FoodHouseVO>(); 
		
		try 
		{
			getConnection();
			String sql="SELECT image,title,score,address,tel,type,price,rownum " //가게 5개 잘라오려고 rownum줬음
					+ "FROM (SELECT image,title,score,address,tel,type,price "
							+ "FROM foodhouse " 
							+ "WHERE address LIKE '%'||?||'%' "
							+ "ORDER BY score DESC) "
					+ "WHERE rownum<=5";  
			ps=conn.prepareStatement(sql);
			ps.setString(1, loc);
			ResultSet rs=ps.executeQuery();
			while(rs.next())
			{	
				FoodHouseVO vo=new FoodHouseVO();
				vo.setImage(rs.getString(1));
				vo.setTitle(rs.getString(2));
				vo.setScore(rs.getDouble(3));
				vo.setAddress(rs.getString(4));
				vo.setTel(rs.getString(5));
				vo.setType(rs.getString(6));
				vo.setPrice(rs.getString(7));
				list.add(vo);
			}	
			
			rs.close();
			
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		finally
		{
			disConnection();
		}
		
		return list;
	}

}


/*
 * 2020.02.20 (목) 
 * 
 * [참고] MyBatis
 *   - MyBatis에서는 <dataSource type="POOLED"> 이런식으로 쓴다. 
 *     ==> getConnection, disConnection 만들 필요 없음. 
 *   - MyBatis에서는 POOLED랑 UNPOOLED가 있음. 
 *   
 */

/*
 * 2020.02.21 (금)
 * <JDBC/DBCP>
 * 1) 연결
 * 2) SQL 전송
 * 3) 결과값 받기
 * 4) 닫기
 */



