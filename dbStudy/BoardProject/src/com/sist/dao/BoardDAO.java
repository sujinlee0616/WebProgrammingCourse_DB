package com.sist.dao;
import java.util.*; //ArrayLsit 
import java.sql.*; //Connection, PreparedStatement, ResultSet

public class BoardDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL="jdbc:oracle:thin:@localhost:1521:XE";
	
	// 1. 드라이버 등록
	public BoardDAO() {
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
	
	// 4. 기능구현 - 게시판 
	
	// 1) 게시판 목록 읽기 ==> SELECT ~ ORDER BY
	// 여러개 출력 ==> VO가 여러개 ==> ArrayList 
	public ArrayList<BoardVO> boardListData(int page){
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		try {
			getConnection();
			String sql="SELECT no,subject,name,regdate,hit "
					+"FROM board "
					+"ORDER BY no DESC"; //최신 글이 제일 최상단에 와야 하므로 no가 높은애부터 낮은애 순서로 출력 ==> DESC
			int rowSize=10;
			int pageStart=rowSize*(page-1); //pageStart: 특정 페이지가 시작하는 게시물의 번호. 
			/*
			 * 1page: 0~9   ==> pageStart = 10*0 = 0
			 * 2page: 10~19 ==> pageStart = 10*1 = 10 
			 */
			
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			
			int i=0; 
			int j=0;
			while(rs.next())
			{
				if(i<10 && j>=pageStart) 
				{	// i: 10개씩 나눠줌. 0-9 도니까 10개씩 실행함. 
					// j: 테이블을 한 행씩 읽어나감. 행 넘버랑 똑같음. ==> while문이 돌아가는 횟수.
					// pageStart:  
					// ex) 3페이지 ==> pageStart=20 ==> j>=20 에서 시작해서 10번 돌면서 10개 가져온다. 
					BoardVO vo=new BoardVO();
					vo.setNo(rs.getInt(1));
					vo.setSubject(rs.getString(2));
					vo.setName(rs.getString(3));
					vo.setRegdate(rs.getDate(4));
					vo.setHit(rs.getInt(5));
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
	// ■ 게시판 총 페이지수 구하기 
	public int boardTotalPage()
	{
		int total=0;
		try
		{
			getConnection();
			String sql="SELECT CEIL(COUNT(*)/10.0) FROM board"; // (총 게시물 수 / 한 페이지당 게시물 갯수)를 올림하면 총 페이지 수.
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
	
	// 2) 게시판 내용 보기 ==> SELECT ~ WHERE
	public BoardVO boardDetailData(int no)
	{
		BoardVO vo=new BoardVO();
		try {
			getConnection();
			
			// 2-1) 조회수 증가시킴 
			String sql="UPDATE board SET " // 우선은 조회수 증가시키고 증가된 조회수를 반영시킨 내용을 가져옴   
					+"hit=hit+1 "
					+ "WHERE no=?";
			ps=conn.prepareStatement(sql);
			// ?에 값을 채운다
			ps.setInt(1, no);
			// 실행 요청 
			ps.executeUpdate(); //<== 요 안에 commit 들어가있음
			
			// 2-2) 상세보기
			sql="SELECT no,name,subject,content,regdate,hit " //끝에 띄어쓰기 잊지 말기..!
					+"FROM board "
					+"WHERE no=?";
			ps=conn.prepareStatement(sql);
			// ?에 값을 채운다
			ps.setInt(1, no);
			// 실행 요청 
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			vo.setNo(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setSubject(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setRegdate(rs.getDate(5));
			vo.setHit(rs.getInt(6));
			
		} 
		catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		finally
		{
			disConnection();
		}
		return vo; 
	}
	
	// 3) 추가하기 ==> INSERT
	public void boardInsert(BoardVO vo) 
	{
		try {
			getConnection();
			String sql="INSERT INTO board(no,name,subject,content,pwd) "
					+"VALUES((SELECT NVL(MAX(no)+1,1) FROM board),?,?,?,?)"; 
					//NVL 넣는 이유? 만약 다 삭제하면 0개 되니까...
			//?: 채워 넣을, 사용자에게서 받은 값. 
			ps=conn.prepareStatement(sql);
			// 실행 전에 => ?에 값을 채운다
			ps.setString(1, vo.getName());
			ps.setString(2, vo.getSubject());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getPwd());
			// 실행 요청
			ps.executeUpdate(); //commit포함: executeUpdate 안에는 오토커밋 들어가있음. 
		} 
		catch (Exception ex) 
		{
			System.out.println(ex.getMessage());
		}
		finally
		{
			disConnection();
		}
	}
	
	// 4) 수정하기 ==> UPDATE
	// 4-1) 수정을 위해 입력된 데이터를 갖다줌
	public BoardVO boardUpdateData(int no)
	{
		BoardVO vo=new BoardVO();
		try {
			getConnection();
			
			String sql="SELECT no,name,subject,content " 
					+"FROM board "
					+"WHERE no=?";
			ps=conn.prepareStatement(sql);
			// ?에 값을 채운다
			ps.setInt(1, no);
			// 실행 요청 
			ResultSet rs = ps.executeQuery();
			rs.next();
			
			vo.setNo(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setSubject(rs.getString(3));
			vo.setContent(rs.getString(4));
			
			rs.close();
		} 
		catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		finally
		{
			disConnection();
		}
		return vo; 
	}
	
	// 4-2) 실제 수정 => UPDATE ~ SET 
	public boolean boardUpdate(BoardVO vo) {
		boolean bCheck=false;
		try {
			getConnection();
			
			// (1) 비밀번호를 가지고 오고
			String sql="SELECT pwd FROM board "
					+"WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, vo.getNo());
			ResultSet rs=ps.executeQuery();
			rs.next();
			String db_pwd=rs.getString(1);
			rs.close();
			
			// (2) 비밀번호가 맞으면 수정하고, 틀리면 비번 틀렸다고 알려준다. 
			if(db_pwd.equals(vo.getPwd())) 
			{
				bCheck=true;
				sql="UPDATE board SET "
						+"name=?,subject=?,content=? "
						+"WHERE no=?";
				ps=conn.prepareStatement(sql);
				//?에 값 채운다
				ps.setString(1, vo.getName());
				ps.setString(2, vo.getSubject());
				ps.setString(3, vo.getContent());
				ps.setInt(4, vo.getNo());
				//실행
				ps.executeUpdate();
			}
			else
			{
				bCheck=false;
			}
			
		} 
		catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		finally
		{
			disConnection();
		}
		return bCheck;
	}
	
	// 5) 삭제하기 ==> DELETE
	public boolean boardDelete(int no,String pwd) {
		boolean bCheck=false;
		try {
			getConnection();
			
			// (1) 비밀번호를 가지고 오고
			String sql="SELECT pwd FROM board "
					+"WHERE no=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, no);
			ResultSet rs=ps.executeQuery();
			rs.next();
			String db_pwd=rs.getString(1);
			rs.close();
			
			// (2) 비밀번호가 맞으면 수정하고, 틀리면 비번 틀렸다고 알려준다. 
			if(db_pwd.equals(pwd)) 
			{
				bCheck=true;
				sql="DELETE FROM board "
						+"WHERE no=?";
				ps=conn.prepareStatement(sql);
				//?에 값 채운다
				ps.setInt(1, no);
				//실행
				ps.executeUpdate();
			}
			else
			{
				bCheck=false;
			}
			
		} 
		catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		finally
		{
			disConnection();
		}
		return bCheck;
	}
	
	
	// 6) 찾기 ==> SELECT ~ LIKE 
	// == 미완성 ========================================================================================
	public ArrayList<BoardVO> boardFindData(String type, String q){
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		try {
			getConnection();
			String sql="SELECT no,subject,name,regdate,hit "
					+"FROM board " 
					+"ORDER BY no DESC"; //최신 글이 제일 최상단에 와야 하므로 no가 높은애부터 낮은애 순서로 출력 ==> DESC
			// 페이지 기능 하지 말자. 
			
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			
			while (rs.next()) {
				BoardVO vo = new BoardVO();
				vo.setNo(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setRegdate(rs.getDate(4));
				vo.setHit(rs.getInt(5));
				list.add(vo);
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
	
	
	
}



/*
 * # Connection: 오라클 연결
 * # PreparedStatement: SQL 문장 전송
 * # ResultSet: 결과값 저장 ===> ResultSet은 SELECT할 때만 사용. 
 * 	 1) executeQuery("SQL") 
 *      - 리턴형이 ResultSet
 *      - SQL 문장이 SELECT일 때 사용. ==> COMMIT이 포함되어 있지 않다. 
 *        (데이터 조회만 하는거니까 커밋할 필요x)  
 *   2) executeUpdate("SQL")
 *      - SQL 문장이 INSERT,UPDATE,DELETE일 때 사용. ==> COMMIT이 포함되어 있다.
 *        (데이터가 변경되는거니까 커밋해야하니까 커밋이 들어있음.) 
 *  
 * # JDBC → DBCP → ORM(MyBatis,Hibernate) → JPA 
 *   - 모두 데이터베이스 연결하는 애들임
 *   - 실무에서는 JPA 사용
 *   - 우리는 ORM까지 배운다. 
 *   
 * # JDBC: Java Database Connectivity
 *   - JDBC는 자바에서 데이터베이스에 접속할 수 있도록 하는 자바 API이다. 
 *     JDBC는 데이터베이스에서 자료를 쿼리하거나 업데이트하는 방법을 제공한다.
 * # DBCP: DataBase Connection Pool
 * # ORM: Object-relational mapping
 *   - 데이터베이스와 객체 지향 프로그래밍 언어 간의 호환되지 않는 데이터를 변환하는 프로그래밍 기법
 *   - 객체와 DB의 테이블이 매핑을 이루는 것을 말한다. 
 *     즉, 즉 객체가 테이블이 되도록 매핑 시켜주는 것
 *   - ORM을 이용하면 SQL Query가 아닌 직관적인 코드(메서드)로서 데이터를 조작할 수 있다.   
 * # JPA: 
 *   - 자바 ORM 기술에 대한 API 표준 명세.
 *   - ORM을 사용하기 위한 인터페이스를 모아둔 것이며, 
 *     JPA를 사용하기 위해서는 JPA를 구현한 Hibernate, EclipseLink, DataNucleus 같은 ORM 프레임워크를 사용해야 함.
 *     
 * <웹사이트 만드는 방법>
 * =========================
 * 1. 데이터 저장소: Oracle
 * 2. 데이터 수집: Java
 * =========================
 * 3. 자바 연동                    =====> Spring: Java 관리해주는 프로그램 (생성과 소멸을 관리해줌) 
 * =========================
 * 4. HTML로 화면 만들고
 * 5. (데이터 받은거에 따라서 적절한) HTML 데이터 출력하고
 * 6. CSS로 디자인 
 * 7. JavaScript로 이벤트 처리      
 *     
 *     
 */












