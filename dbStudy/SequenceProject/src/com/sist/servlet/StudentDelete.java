package com.sist.servlet;

import java.io.*; //io.*로 변경 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//추가 import
import com.sist.student.dao.*;

@WebServlet("/delete.do") //꼭 파일명과 일치할 필요 없음. 
public class StudentDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String hakbun=request.getParameter("hakbun"); 
		// 파라미터의 명칭 hakbun이 StudentListServlet.java에서 아래와 같이 준 이름과 동일해야함에 주의
		// out.println("<td><a href=delete.do?hakbun="+vo.getHakbun()+">삭제</a></td>");
		StudentDAO dao = new StudentDAO();
		dao.stdDelete(Integer.parseInt(hakbun));
		response.sendRedirect("list.do");
		
	}

}
