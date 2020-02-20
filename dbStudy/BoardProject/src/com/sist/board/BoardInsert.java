package com.sist.board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.BoardDAO;
import com.sist.dao.BoardVO;


@WebServlet("/BoardInsert")
public class BoardInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// [doGet]: 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8"); 
		PrintWriter out=response.getWriter();
		
		// ===============================================================
		// 2. HTML 출력한다.
		// ===============================================================

		out.println("<!DOCTYPE html>"); // HTML5
		out.println("<html>");
		out.println("<head>");
		out.println("<link rel=stylesheet href=\"css/table.css\">");
		out.println("</head>");
		out.println("<body>");
		out.println("<center>");
		out.println("<h1>글쓰기</h1>");
		
		out.println("<form method=post action=BoardInsert>"); //아래 table에서 입력받은 값들을 보내야!! : post ★★★
		// submit할 게 있으면 form으로 감싼다. 
		// action: 누구한테 보낼건지 ==> 나 자신한테 보냄. ==> do Post에서 처리해줌. 
		// post방식으로 보내면 doPost를 호출하고,
		// get방식으로 받으면 doGet을 호출함. 
		out.println("<table id=\"table_content\" width=500>");
		// 1) 이름
		out.println("<tr>");
		out.println("<th width=15% align=right>이름</th>");
		out.println("<td width=85%>");
		out.println("<input type=text name=name size=15 required>"); // 값을 넘겨줄 때는 반드시 name이 있어야 한다. ★★★
		// name=name,subject,content,pwd는 NOT NULL이어야 ==> 얘네가 Null이면 안 보내게 처리해줘야. ==> required 준다. (HTML5에서만 사용 가능)
		out.println("</td>");
		out.println("</tr>");
		// 2) 제목
		out.println("<tr>");
		out.println("<th width=15% align=right>제목</th>");
		out.println("<td width=85%>");
		out.println("<input type=text name=subject size=50 required>"); //name이 있어야만 값 받을 수 있다. 
		out.println("</td>");
		out.println("</tr>");
		// 3) 내용보기 
		out.println("<tr>");
		out.println("<th width=15% align=right valign=top>내용</th>");
		out.println("<td width=85%>");
		out.println("<textarea rows=8 cols=55 name=content required></textarea>");
		out.println("</td>");
		out.println("</tr>");
		// 4) 비밀번호 입력
		out.println("<tr>");
		out.println("<th width=15% align=right>비밀번호</th>");
		out.println("<td width=85%>");
		out.println("<input type=password name=pwd size=10 required>"); 
		out.println("</td>");
		out.println("</tr>");
		// 5) 취소
		out.println("<tr>");
		out.println("<td colspan=2 align=center>");
		out.println("<input type=submit value=작성완료>");  //type=submit이어야
		out.println("<input type=button value=취소 onclick=\"javascript:history.back()\">"); // onclick="javascript:histroy.back()" : 이전으로 돌아가는 함수.
		out.println("</td>");
		out.println("</tr>");
		
		out.println("</table>");
		out.println("</form>");
		
		out.println("</center>");
		out.println("</body>");
		out.println("</html>");
		
	}

	// [doPost]: 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try 
		{
			request.setCharacterEncoding("UTF-8"); //한글 변환: 한글 넘어오면 깨지니까 인코딩설정부터 해줘야
		} catch (Exception ex) {} 
		
		// 사용자가 보낸 데이터 받기
		String name=request.getParameter("name");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		String pwd=request.getParameter("pwd");
//		System.out.println("name"+name);
//		System.out.println("subject"+subject);
//		System.out.println("content"+content);
//		System.out.println("pwd"+pwd);
		
		BoardVO vo=new BoardVO();
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setPwd(pwd);
		
		// 오라클 연동 => DAO 메소드를 호출 
		BoardDAO dao=new BoardDAO();
		dao.boardInsert(vo);
		// 이동 
		response.sendRedirect("BoardListServlet");
		
	}

}


/* 
 * 새 글 ==> 목록보기
 * 글 수정 ==> 상세보기
 * 글 삭제 ==> 목록보기 
 * 
 * Servlet: 순수하게 Java로만 짜는 것. 
 */