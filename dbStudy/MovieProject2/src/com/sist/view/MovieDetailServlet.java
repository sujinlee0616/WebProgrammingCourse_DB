package com.sist.view;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.sist.vo.*;
import com.sist.dao.*;

@WebServlet("/MovieDetailServlet")
public class MovieDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// ===============================================================
		// 1. HTML 출력하기 전에 받아야 할 정보를 받는다. 
		// ===============================================================
		String mno=request.getParameter("mno");
		
		// ===============================================================
		// 2. DAO 연결 - 요청에 해당되는 DAO 연결.
		// ===============================================================
		
		MovieDAO dao = MovieDAO.newInstance();
		MovieVO vo=dao.movieDetailData(Integer.parseInt(mno));
				
		// ===============================================================
		// 3. HTML 출력한다. 
		// ===============================================================
		
		out.println("<html>");
		out.println("<head>");
		out.println("<style type=text/css>");
		
		out.println(".row{");
		out.println("margin: 0px auto;");
		out.println("width: 1200px;");
		out.println("}");
		out.println("</style>");
		out.println("</head>");
		out.println("<body>");	//이미 MainServlet에 body안에 container만들어 놨음 ==> 또 container 줄 필요 없다. 
		
		out.println("<div class=row>");
		out.println("<table class=\"table- table-hover\">");
		out.println("<tr>");
		out.println("<td colspan=2 class=text-center><h3>"+vo.getTitle()+" 상세보기</h3></td>");
		out.println("</tr>");
		
		// [좌측] 1) 이미지...... 
		// [우측] 1) 영화제목
		out.println("<tr>");
		out.println("<td width=30% class=\"text-center\" rowspan=7>");
		out.println("<img src="+vo.getPoster()+" width=100%>");
		out.println("</td>");
		out.println("<td width=80%>"+vo.getTitle()+"</td>");
		out.println("</tr>");
		
		// [우측] 2) 별점(score)
		out.println("<tr>");
		out.println("<td width=80%>"+vo.getScore()+"</td>");
		out.println("</tr>");
		
		// [우측] 3) 장르
		out.println("<tr>");
		out.println("<td width=80%>"+vo.getGenre()+"</td>");
		out.println("</tr>");
		
		// [우측] 4-1) 개봉일(regdate), 4-2) 시간 4-3) 관람가능나이(grade)
		out.println("<tr>");
		out.println("<td width=80%>"+vo.getRegdate()+"|"+vo.getTime()+","+vo.getGrade()+"</td>");
		out.println("</tr>");
		
		// [우측] 5) 감독 
		out.println("<tr>");
		out.println("<td width=80%>(감독)"+vo.getDirector()+"</td>");
		out.println("</tr>");
		
		// [우측] 6) 배우
		out.println("<tr>");
		out.println("<td width=80%>(주연)"+vo.getActor()+"</td>");
		out.println("</tr>");
		
		// [우측] 7) 목록 버튼 (예매하기 버튼 대신)
		out.println("<tr>");
		out.println("<td width=80% class=text-center>");
		out.println("<a href=\"javascript:history.back()\" class=\"btn btn-sm btn-danger\">목록</a>");
		out.println("</td>");
		out.println("</tr>");
		
		// [하단] 줄거리
		out.println("<tr>");
		out.println("<td colspan=2>"+vo.getStory()+"</td>");
		out.println("</tr>");
		
		out.println("</table>");
		out.println("</div>");
		
		out.println("</body>");
		out.println("</html>");
		
	}

}

/*
 *  - JSP JSTL방식으로 코딩할 예정.
 *  ex) <c:forEach>
 *  		<c:if> ....
 */
