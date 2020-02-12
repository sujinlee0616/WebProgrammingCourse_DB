package com.sist.board;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sist.dao.*;

@WebServlet("/BoardUpdate")
public class BoardUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// [doGet] form띄워서 유저가 입력한 값 받고 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8"); 
		PrintWriter out=response.getWriter();
		
		// ===============================================================
		// 1. HTML 출력하기 전에 받아야 할 정보를 받는다. 
		// ===============================================================
		
		// 1) 사용자가 요청한 번호를 받는다.		
		// ex) http://localhost/BoardProject/BoardUpdate?no=13
		String no=request.getParameter("no");
		BoardDAO dao=new BoardDAO();
		BoardVO vo=dao.boardUpdateData(Integer.parseInt(no));
		
		
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
		out.println("<h1>수정하기</h1>");
		
		out.println("<form method=post action=BoardUpdate>"); 
		out.println("<table id=\"table_content\" width=500>");
		// 0) no - 수정할 때 no 넘겨줘야하니까★★★
		out.println("<input type=hidden name=no value="+vo.getNo()+">");//hidden ★★
		// hidden: 눈에 보이지는 않지만 데이터를 넘긴다.
		// 1) 이름
		out.println("<tr>");
		out.println("<th width=15% align=right>이름</th>");
		out.println("<td width=85%>");
		out.println("<input type=text name=name size=15 required value="+vo.getName()+">"); //value ★★
		// name이 있어야만 값 받을 수 있다. 
		out.println("</td>");
		out.println("</tr>");
		// 2) 제목
		out.println("<tr>");
		out.println("<th width=15% align=right>제목</th>");
		out.println("<td width=85%>");
		out.println("<input type=text name=subject size=50 required value=\""+vo.getSubject()+"\">"); 
		// value에 "" 써야: 제목 등과 같이 공백이 있는 애들은, 공백 포함해서 출력시켜주려면, 반드시 따옴표 줘야함!★
		out.println("</td>");
		out.println("</tr>");
		// 3) 내용보기 
		out.println("<tr>");
		out.println("<th width=15% align=right valign=top>내용</th>");
		out.println("<td width=85%>");
		out.println("<textarea rows=8 cols=55 name=content required>"+vo.getContent()+"</textarea>");
		out.println("</td>");
		out.println("</tr>");
		// 4) 비밀번호 입력
		out.println("<tr>");
		out.println("<th width=15% align=right>비밀번호</th>");
		out.println("<td width=85%>");
		out.println("<input type=password name=pwd size=10 required>"); 
		out.println("</td>");
		out.println("</tr>");
		// 5) 수정완료,취소 버튼 
		out.println("<tr>");
		out.println("<td colspan=2 align=center>");
		out.println("<input type=submit value=수정완료>");  //type=submit이어야
		out.println("<input type=button value=취소 onclick=\"javascript:history.back()\">"); // onclick="javascript:histroy.back()" : 이전으로 돌아가는 함수.
		out.println("</td>");
		out.println("</tr>");
		
		out.println("</table>");
		out.println("</form>");
		
		out.println("</center>");
		out.println("</body>");
		out.println("</html>");
	}
	
	
	//[doPost] 처리 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		// 1. 사용자가 보내준 값을 저장 
		try {
			request.setCharacterEncoding("UTF-8"); //한글 인코딩
		} catch (Exception ex) {}
		
		// 2. 저장된 값을 DAO로 전송
		String no=request.getParameter("no");
		String name=request.getParameter("name");
		String subject=request.getParameter("subject");
		String content=request.getParameter("content");
		String pwd=request.getParameter("pwd");

		BoardVO vo=new BoardVO();
		vo.setNo(Integer.parseInt(no));
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		vo.setPwd(pwd);
		
		// 3. 처리 ==> DAO에서 처리. 
		BoardDAO dao=new BoardDAO();
		boolean bCheck=dao.boardUpdate(vo);
		
		// 4. 이동: 상세보기로 이동.
		if(bCheck==true) 
		{
			response.sendRedirect("BoardDetailServlet?no="+no);
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
