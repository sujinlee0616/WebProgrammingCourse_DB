// 리스트 페이지 - 하나의 카테고리를 선택하면 그 카테고리에 해당하는 맛집들 노출 
package com.sist.view;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import com.sist.dao.*;
import com.sist.manager.CategoryVO;
import com.sist.manager.FoodHouseVO;

@WebServlet("/FoodListServlet")
public class FoodListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out=response.getWriter(); 
		
		String cno=request.getParameter("cno");
		
		FoodDAO dao=FoodDAO.newInstance();
		
		//FoodDAO 파일에서 
		ArrayList<FoodHouseVO> list=dao.foodHouseListData(Integer.parseInt(cno)); // 4) 리스트페이지에 들어갈 데이터들 준비 - (2) 음식점 정보들 가져옴 
		CategoryVO vo=dao.categoryInfoData(Integer.parseInt(cno)); // 4) 리스트페이지에 들어갈 데이터들 준비 - (1) 카테고리명(테마명), 카테고리설명(테마 설명)
		
		out.println("<html>");
		out.println("<head>");
		out.println("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css\">");
		out.println("<style type=text/css>");
		out.println(".row{");
		out.println("margin: 0px auto;");
		out.println("width: 1200px;");
		out.println("}");
		out.println("</style>");
		out.println("</head>");
		out.println("<body>");
		out.println("<div class=container>");
		out.println("<div class=row>");
		out.println("<h1 class=text-center>"+vo.getTitle()+"</h1>");
		out.println("<h3 class=text-center style=\"color: gray;\">"+vo.getSubject()+"</h3>");
		out.println("<table class=\"table table-striped\">");
		out.println("<tr>");
		out.println("<td>");
		int i=1;
		for(FoodHouseVO fvo:list) //위에서 이미 vo 써서 여기선 이름 fvo로 바꿔줬음
		{
			out.println("<table class=\"table\">");
			// 1st tr: td 이미지 + td 음식점 이름
			out.println("<tr>");
			out.println("<td width=30% rowspan=2 class=text-center>");
			out.println("<a href=\"FoodDetailServlet?no="+fvo.getNo()+"\">");
			out.println("<img src=\""+fvo.getImage()+"\" width=180 height=100 class=img-rounded>");
			out.println("</a>");
			out.println("</td>");
			out.println("<td width=70%>");
			out.println("<h2>"+i+".&nbsp;<a href=\"FoodDetailServlet?no="+fvo.getNo()+"\">"+fvo.getTitle()+"</a>&nbsp;&nbsp;<font color=orange>"+fvo.getScore()+"</font></h2>");
			out.println("</td>");
			out.println("</tr>");
			// 2nd tr: td 주소
			out.println("<tr>");
			out.println("<td width=70%>"+fvo.getAddress().substring(0,fvo.getAddress().indexOf("지번"))+"</td>");
			out.println("</tr>");
			out.println("</table>");
			i++;
		}
		out.println("</td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("</div>");
		out.println("</div>");
		out.println("</body>");
		out.println("</html>");
		
	}

}
