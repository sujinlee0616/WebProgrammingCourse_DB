// Released: 현재상영작
// ReleasedServlet 파일은 MainServlet의 rd.include(request, response); 부분에 포함되어 출력된다. (url: /MainServlet?mode=1)   
// 의문) MainServlet 에서 <body> 안에다가 ReleasedServlet (<html><head><body>...</body></head></html>)을 넣으면, 
// <body> 안에  <html><head>를 넣는데, 괜찮은가?
// 답) ㅇㅇ!! 괜찮다!!
package com.sist.view;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import com.sist.vo.*;
import com.sist.dao.*;

@WebServlet("/ReleasedServlet")
public class ReleasedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		// ===============================================================
		// 1. HTML 출력하기 전에 받아야 할 정보를 받는다. 
		// ===============================================================
		
		// 사용자에게서 페이지를 받는다.
		String strPage = request.getParameter("page");
		if(strPage==null)
			strPage="1";
		int curpage=Integer.parseInt(strPage);
		
		// DAO 연결
		MovieDAO dao = MovieDAO.newInstance();
		ArrayList<MovieVO> list = dao.movieListData(curpage, 1); //int page=curpage, int type=1(현재상영작)
		
		// ===============================================================
		// 2. HTML 출력한다. 
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
		
		// 1) 리스트
		out.println("<div class=row>");
		out.println("<h1>현재상영작</h1>");
		for(MovieVO vo:list)
		{
			// 글자 너무 길면 카드가 하나씩 밀려서 글자수 너무 크면 글자수 잘라버렸음
			String title=vo.getTitle();
			String title2="";  //title2: 글자수 조정한 타이틀ㅋ
			if(title.length()>18)
			{
				title2=title.substring(0,18)+"...";
			}
			else
			{
				title2=title;
			}
			
			out.println("<div class=\"col-md-3\">"); //한 줄에 이미지 4개 줄어오게 할 거니까 col-md-3
			out.println("<div class=\"thumbnail\">");
			out.println("<a href=\"#\">");
			out.println("<img src=\""+vo.getPoster()+"\" alt=\"Lights\" style=\"width:100%\">");
			out.println("</a>");
			out.println("<div class=\"caption\">");
			out.println("<p>"+title2+"</p>");
			out.println("<p>네티즌&nbsp;<font color=red>★"+vo.getScore()+"</font></p>");
			out.println("<p><font color=gray><sup>"+vo.getRegdate()+"</sup></font></p>");
			out.println("</div>");
			
			out.println("</div>");
			out.println("</div>");
		}
		out.println("</div>");
		
		// 2) 페이징
		out.println("<div class=\"row text-center\">");
		out.println("<ul class=\"pagination pagination-lg\">");
		out.println("<li><a href=\"MainServlet?mode=1&page=1\">1</a></li>");
		out.println("<li><a href=\"MainServlet?mode=1&page=2\">2</a></li>");
		out.println("</ul>");
		out.println("</div>");
		
		out.println("</body>");
		out.println("</html>");
	}

}
