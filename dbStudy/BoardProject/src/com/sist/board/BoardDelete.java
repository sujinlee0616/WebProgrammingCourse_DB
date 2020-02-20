package com.sist.board;

import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.BoardDAO;
import com.sist.dao.BoardVO;

@WebServlet("/BoardDelete")
public class BoardDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//[doGet] 사용자가 입력한 데이터 받고 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		// ===============================================================
		// 1. HTML 출력하기 전에 받아야 할 정보를 받는다. 
		// ===============================================================
		
		// 1) 사용자가 요청한 번호를 받는다. - 어떤 게시물 삭제할지.. no로...
		// ex) http://localhost/BoardProject/BoardDelte?no=13
		String no=request.getParameter("no");
		
		
		// ===============================================================
		// 2. HTML 출력한다. 
		// ===============================================================
		
		out.println("<!DOCTYPE html>"); 
		out.println("<html>");
		out.println("<head>");
		out.println("<link rel=stylesheet href=\"css/table.css\">");
		out.println("</head>");
		out.println("<body>");
		out.println("<center>");
		out.println("<h1>삭제하기</h1>");
		
		out.println("<form method=post action=BoardDelete>"); 
		// 만약 method=post action=BoardDelete ===> 이 파일의 doPost를 호출
		// 만약 method=get action=BoardDelete ===> 이 파일의 doGet을 호출
		out.println("<table id=\"table_content\" width=300>");
		
		// 0) no - 삭제할 때 no 넘겨줘야하니까 ★★★
		out.println("<input type=hidden name=no value="+no+">");//hidden ★★
		// hidden: 눈에 보이지는 않지만 데이터를 넘긴다.
		// 1) 비밀번호 입력창
		out.println("<tr>");
		out.println("<th width=35% align=right>비밀번호</th>");
		out.println("<td width=65%>");
		out.println("<input type=password name=pwd size=15 required>"); 
		out.println("</td>");
		out.println("</tr>");
		// 2) 삭제하기/취소 버튼 
		out.println("<tr>");
		out.println("<td colspan=2 align=center>");
		out.println("<input type=submit value=삭제하기>");  //type=submit이어야
		// submit: input, select, textarea 
		out.println("<input type=button value=취소 onclick=\"javascript:history.back()\">"); // onclick="javascript:histroy.back()" : 이전으로 돌아가는 함수.
		out.println("</td>");
		out.println("</tr>");
		
		out.println("</table>");
		out.println("</center>");
		out.println("</body>");
		out.println("</html>");
	}

	//[doPost] 처리 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
			
		// 비번은 한글 아니니까 한글인코딩 설정 안 해줘도 됨

		String no=request.getParameter("no");
		String pwd=request.getParameter("pwd");
		
		// VO 안 쓰는 이유? 매개변수 수가 적으니까...
		// 3개 이상이면 VO 쓰고 미만이면 굳이 VO 쓸 이유가 없음...
		
		// 3. 처리 ==> DAO에서 처리. 
		BoardDAO dao=new BoardDAO();
		boolean bCheck=dao.boardDelete(Integer.parseInt(no), pwd); 
		
		// 4. 이동: 글 목록으로 이동
		if(bCheck==true) 
		{
			response.sendRedirect("BoardListServlet");
		}
		else
		{
			out.println("<html>");
			out.println("<head>");
			out.println("<script type=\"text/javascript\">");
			out.println("alert(\"비밀번호가 틀립니다!!\");");
			out.println("history.back();"); 
			// 히스토리백하면 이전 창인 doGet으로 이동함. 
			// 이걸 위해서 doPost에서  response.setContentType("text/html; charset=UTF-8"); 줬었음.
			out.println("</script>");
			out.println("</head>");
			out.println("</html>");
		}
	}

}
