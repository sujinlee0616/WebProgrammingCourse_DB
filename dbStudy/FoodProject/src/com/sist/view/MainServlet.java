// 연습용 view - 맛집서비스 아님
package com.sist.view;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;
import com.sist.dao.*;

@WebServlet("/MainServlet")
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		EmpDAO dao=new EmpDAO();
		ArrayList<EmpVO> list = dao.empAllData();
		
		//List에 있는 데이터 출력
		out.println("<html>");
		out.println("<body>");
		out.println("<center>");
		out.println("<h1>사원목록</h1>");
		out.println("<table border=1 width=800>");
		out.println("<tr>");
		out.println("<th>사번</th>");
		out.println("<th>이름</th>");
		out.println("<th>직업</th>");
		out.println("<th>입사일</th>");
		out.println("<th>급여</th>");
		out.println("<th>부서명</th>");
		out.println("<th>근무지</th>");
		out.println("</tr>");
		for(EmpVO vo:list)
		{
			out.println("<tr>");
			out.println("<td>"+vo.getEmpno()+"</td>");
			out.println("<td>"+vo.getEname()+"</td>");
			out.println("<td>"+vo.getJob()+"</td>");
			out.println("<td>"+vo.getHiredate()+"</td>");
			out.println("<td>"+vo.getSal()+"</td>");
			out.println("<td>"+vo.getDvo().getDname()+"</td>"); // 주의 
			out.println("<td>"+vo.getDvo().getLoc()+"</td>"); // 주의
			out.println("</tr>");
		}
		
		out.println("</table>");
		out.println("</center>");
		out.println("</body>");
		out.println("</html>");
		
	}

}

// 화면출력: doGet
// 사용자 입력값 받아서 처리: doPost
