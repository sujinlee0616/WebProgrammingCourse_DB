package com.sist.board;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sist.dao.*;

@WebServlet("/BoardDetailServlet")  //url주소가 'root/BoardDetailServlet' 이면 아래의 내용을 실행 
public class BoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//step1. 사용자한테 응답하는 콘텐츠의 타입을 정해줌: HTML
		response.setContentType("text/html; charset=UTF-8");
		
		//step2. 여기다가 출력하니까 갖고가라고 함. getWriter(): 브라우저가 읽어가는 메모리 위치. 
		PrintWriter out=response.getWriter();   
		
		// ===============================================================
		// 1. HTML 출력하기 전에 받아야 할 정보를 받는다. 
		// ===============================================================
		
		// 1) 게시물 번호 
		String no=request.getParameter("no");  
		// 오라클 => 데이터를 가지고 온다. 
		BoardDAO dao=new BoardDAO();
		BoardVO vo=dao.boardDetailData(Integer.parseInt(no));
		
		
		// ===============================================================
		// 2. HTML 출력한다. 
		// ===============================================================
				
		out.println("<html>");
		out.println("<head>");
		out.println("<link rel=stylesheet href=\"css/table.css\">");
		out.println("</head>");
		out.println("<body>");
		out.println("<center>");
		out.println("<h1>내용보기</h1>");
		
		// [게시글 상세내용]
		out.println("<table id=\"table_content\" width=700>");
		// 1) 첫줄: 글번호, 작성일
		out.println("<tr>");
		out.println("<th width=20%>번호</th>"); //th는 원래 가운데 정렬이라서 따로 center 안 줬음 
		out.println("<td width=30% align=center>"+vo.getNo()+"</td>");
		out.println("<th width=20%>작성일</th>"); 
		out.println("<td width=30% align=center>"+vo.getRegdate()+"</td>");
		out.println("</tr>");
		// 2) 둘째줄: 이름, 조회수 
		out.println("<tr>");
		out.println("<th width=20%>이름</th>");  
		out.println("<td width=30% align=center>"+vo.getName()+"</td>");
		out.println("<th width=20%>조회수</th>"); 
		out.println("<td width=30% align=center>"+vo.getHit()+"</td>");
		out.println("</tr>");
		// 3) 셋째줄: 제목 
		out.println("<tr>");
		out.println("<th width=20%>제목</th>");  
		out.println("<td colspan=3>"+vo.getSubject()+"</td>"); //제목 기니까 td가 3개 열만큼의 width를 다 차지하게..
		out.println("</tr>");
		// 4) 넷째줄: 내용
		out.println("<tr>");
		out.println("<td colspan=4 align=left valign=top height=200>"+vo.getContent()+"</td>"); //내용출력. 내용 기니까 td가 4개 열만큼의 width를 다 차지하게..
		out.println("</tr>");		
		
		// [수정, 삭제, 목록 버튼] 
		out.println("<tr>");
		out.println("<td colspan=4 align=right>");
		out.println("<a href=\"BoardUpdate?no="+vo.getNo()+"\">수정</a>&nbsp;");
		out.println("<a href=\"BoardDelete?no="+vo.getNo()+"\">삭제</a>&nbsp;");
		out.println("<a href=\"BoardListServlet\">목록</a>&nbsp;");
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
	}

}
