// News: 뉴스
package com.sist.view;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.MovieDAO;
import com.sist.vo.MovieVO;

@WebServlet("/NewsServlet")
public class NewsServlet extends HttpServlet {
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
		out.println("<body>");
		out.println("<h1>뉴스</h1>");
		
		out.println("</body>");
		out.println("</html>");
		
	}
}



