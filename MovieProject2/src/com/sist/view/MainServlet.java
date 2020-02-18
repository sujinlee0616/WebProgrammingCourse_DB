package com.sist.view;

import java.io.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/MainServlet")
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// 변경할 서블릿 파일명
		// 맨 처음에는 mode가 지정이 안 된 상태이므로 mode=1로 줬음 
		String mode=request.getParameter("mode");
		if(mode==null)
			mode="1";
		int n=Integer.parseInt(mode);
		String sname=""; //sname:서블릿 name
		switch(n)
		{
			case 1:
				sname="ReleasedServlet";
				break;
			case 2:
				sname="ScheduledServlet";
				break;
			case 3:
				sname="NewsServlet";
				break;
			case 4:
				sname="WeeklyServlet";
				break;
			case 5:
				sname="MonthlyServlet";
				break;
			case 6:
				sname="YearlyServlet";
				break;
		}
		
		String menu="<nav class=\"navbar navbar-inverse\">"
					+ "<div class=\"container-fluid\">"
					  +"<div class=\"navbar-header\">"
					    +"<a class=\"navbar-brand\" href=\"#\">SIST MC</a>"
					      +"</div>"
					    +"<ul class=\"nav navbar-nav\">"
					    +"<li class=\"active\"><a href=\"MainServlet\">현재상영</a></li>"
					      +" <li class=\"dropdown\"><a class=\"dropdown-toggle\" data-toggle=\"dropdown\" href=\"#\">박스오피스<span class=\"caret\"></span></a>"
					     +"<ul class=\"dropdown-menu\">"
					        +"<li><a href=\"MainServlet?mode=4\">주간</a></li>"
					          +"<li><a href=\"MainServlet?mode=5\">월간</a></li>"
					          +"<li><a href=\"MainServlet?mode=6\">연간</a></li>"
					          // 주의) a href는 파일명으로 보내는게 아니라, MainServlet으로 보내고, 무슨 파일인지는 mode로 구분한다.
					          // 왜냐면, MainServlet이 bootstrap css/js 호출하는 부분과 헤더(GNB)를 가지고 있기 때문에,
					          // MainServlet 안에서 불러야 bootstrap/js 적용된다. 
					          +"</ul>"
					        +"</li>"
					      +"<li><a href=\"MainServlet?mode=2\">개봉예정</a></li>"
					      +"<li><a href=\"MainServlet?mode=3\">뉴스</a></li>"
					      +"</ul>"
					    +"</div>"
					  +"</nav>";
		out.println("<html>");
		out.println("<head>");
		out.println("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css\">");
		out.println("<script src=\"https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js\"></script>");
		out.println("<script src=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js\"></script>");
		out.println("</head>");
		out.println("<body>");
		out.println(menu);	
		out.println("<body>");
		out.println("<div class=\"container\">"); 
	
		RequestDispatcher rd=request.getRequestDispatcher(sname);
		rd.include(request, response); 
		// ★★★★★★★★★★★★★★★ 다른 Servlet 파일들의 내용이 들어오는 부분  ★★★★★★★★★★★★★★★★★★
		// ★★★ include: 관련된 파일을 붙여넣기 해줌. ★★★
		// 이렇게 파일만 바꿔치기 하면 메뉴는 고정이고 메뉴 클릭 시에 메뉴에 따른 화면을 넣어줄 수 있다.
		// 감동 ㅠㅠㅠㅠ 이렇게 하는 거였구나!!! 진짜 감동이다 ㅜ_ㅜ 프론트만 알 때랑은 비교할 수 없는 감동이다 진짜...ㅠㅠ 
		// JSP에서는 문법이 쪼끔 다르지만 어쨌든 비슷하게 작동한다. 
		// <jsp:include page="/WEB-INF/views/include/header.jsp"/> <== JSP에서는 이런식으로 씀.
		// 앞으로는 CSS, js, jQuery 불러오는 건 메인에만 넣어두면 된다. 다른 페이지들은 include로 body 부분만 불러오면 되니까. 
		// ★★★★★★★★★★★★★★★ 다른 Servlet 파일들의 내용이 들어오는 부분  ★★★★★★★★★★★★★★★★★★
		
		out.println("</div>");
		out.println("</body>");
		
		out.println("</html>");
		
	}

}








