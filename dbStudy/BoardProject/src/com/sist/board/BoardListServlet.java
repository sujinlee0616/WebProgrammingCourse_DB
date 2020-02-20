package com.sist.board;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sist.dao.*;
import java.util.*;

@WebServlet("/BoardListServlet") //url주소가 'root/BoardListServlet' 이면 아래의 내용을 실행 
public class BoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		* request: 요청: 사용자한테 값 보내달라고 하는 것. 즉, 사용자가 보내주는 값을 받을 때 사용. 
		* response: 응답: 사용자한테 응답할 때 사용.  ex) HTML/XML을 만들어서 사용자에게 전송할 때 사용. 
		*	
		* http://localhost/BoardProject/BoardInsert
		* 	===========================  =========
		* 				root				Servlet에서 요 파라미터들 케이스마다 동작 지정해줌 
		*/  
		
		response.setContentType("text/html; charset=UTF-8");
		// setContentType: HTML로 보낼거냐 XML로 보낼거냐 컨텐트타입을 알려줌.
		PrintWriter out=response.getWriter(); 
		// 어디에다가 저장할지. 브라우저에서 읽어가는 위치.  
		
		// ===============================================================
		// 1. HTML 출력하기 전에 받아야 할 정보를 받는다. 
		// ===============================================================
		
		// 1) 사용자가 요청한 페이지
		String strPage=request.getParameter("page");
		if(strPage==null) { // 사용자가 요청한 페이지 값이 없으면 디폴트값 1로 줌.  
			strPage="1";
		}
		int curpage=Integer.parseInt(strPage);
		
		BoardDAO dao=new BoardDAO();
		ArrayList<BoardVO> list=dao.boardListData(curpage);
		
		// 2) 총 페이지 수 받는다. 
		int totalpage=dao.boardTotalPage();
		
		
		// ===============================================================
		// 2. HTML 출력한다. 
		// ===============================================================
		
		out.println("<html>");
		out.println("<head>");
		out.println("<link rel=stylesheet href=\"css/table.css\">");
		out.println("</head>");
		out.println("<body>");
		out.println("<center>");
		out.println("<h1>자유게시판</h1>");
		
		// 검색어 가져오기 위해서 테이블을 form으로 감쌌다. --post 방식으로 넘겨야함!
		// submit하면 form있어야!
		out.println("<form method=post action=BoardFind>");
		
		// [테이블1]: '새 글' a 태그
		out.println("<table id=\"table_content\" width=700>");
		out.println("<tr>");
		out.println("<td align=left>");
		out.println("<a href=\"BoardInsert\">새글</a>");
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
		
		// [테이블2]: 게시판 
		// th
		out.println("<table id=\"table_content\" width=700>");
		out.println("<tr>");
		out.println("<th width=10%>번호</th>");
		out.println("<th width=45%>제목</th>");
		out.println("<th width=15%>이름</th>");
		out.println("<th width=20%>작성일</th>");
		out.println("<th width=10%>조회수</th>");
		out.println("</tr>");
		// td - 데이터 출력 
		for(BoardVO vo:list) //VO에서 10번 돌리게 해놨음 
		{
			out.println("<tr class=dataTr>"); //dataTr 클래스로 스타일 입혀줌 
			// (1) 게시물 번호
			out.println("<td width=10% align=center>"+vo.getNo()+"</td>");
			// (2) 게시물 제목 ★★★
			// 게시물 제목 클릭하면 게시물 번호(No) 받아와서 해당 게시물의 상세보기 (URL: root/BoardDetailServlet?no=게시물번호) 화면으로 넘겨줌★★★
			out.println("<td width=45% align=left>");
			out.println("<a href=BoardDetailServlet?no="+vo.getNo()+">");    
			out.println(vo.getSubject()+"</a>"); 
			out.println("</td>");
			// (3) 작성자
			out.println("<td width=15% align=center>"+vo.getName()+"</td>");
			// (4) 작성일
			out.println("<td width=20% align=center>"+vo.getRegdate()+"</td>");
			// (5) 조회수 
			out.println("<td width=10% align=center>"+vo.getHit()+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		
		// [테이블3]: 검색 기능, 페이지 수 출력 
		out.println("<table id=\"table_content\" width=700>");
		out.println("<tr>");
		out.println("<td align=left>");
		out.println("Search:");
		out.println("<select name=fs>"); //콤보박스
		// 검색구분이 뭔지 알기 위해 value값을 줬다. 
		out.println("<option value=name>이름</option>");
		out.println("<option value=subject>제목</option>");
		out.println("<option value=title>내용</option>");
		out.println("</select>");
		out.println("<input type=text size=15>"); //인풋
		// 검색어를 보내기 위해  type=submit으로 바꿈 ===> submit있으니까 form으로 보내야...
		out.println("<input type=submit value=찾기>");  

		out.println("</td>");
		out.println("<td align=right>");
		out.println("<a href=\"BoardListServlet?page="+(curpage>1?curpage-1:curpage)+"\">&lt;이전&gt;</a>");  
		// 삼항연산자로 현재 페이지가 1페이지면 페이지-1 하지 않고 현재페이지(1) 노출시키도록 함  
		out.println(curpage+"page / "+totalpage+"pages"); 
		out.println("<a href=\"BoardListServlet?page="+(curpage<totalpage?curpage+1:curpage)+"\">&lt;다음&gt;</a>");  
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
		/*
		 *  [특수문자]
		 *  사용법	의미
		 *  &nbsp;	공백
		 *  &lt;	 <
		 *  &gt;	 >
		 *  \"       "
		 */
		
		out.println("</center>");
		out.println("</body>");
		out.println("</html>");
		// 메모리에 저장된 애를 브라우저가 읽어가서 출력함 
		// jsp에서 초록색으로 나오는 애들은 사실 앞에 out.println이 생략된 것.
		// 복잡... ==> HTML 출력할 땐 Servlet 잘 안 씀. 보안을 요구하거나 할 때만 사용함. 
		// 다만, Spring이 Servlet으로 되어 있으므로 잘 기억할 것. 
		
	}

}
