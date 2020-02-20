package com.sist.servlet;

import java.io.*; //java.io.*로 변경 
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// 추가로 import 
import java.util.*;
import com.sist.student.dao.*;

@WebServlet("/list.do") //url주소가 'root/list.jsp' 이면 아래의 내용을 실행 (뒤에 파라미터 붙은 것도 당연히 인식함ㅋ)  
public class StudentListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		String strPage=request.getParameter("page");
		if(strPage==null)
			strPage="1";
		int curpage=Integer.parseInt(strPage);
		StudentDAO dao=new StudentDAO();
		ArrayList<StudentVO> list = dao.stdAllData(curpage);
		
		out.println("<html>");
		out.println("<body>");
		out.println("<center>");
		out.println("<h1>성적관리</h1>");
		
		// [테이블1]
		out.println("<table border=1 width=500>");
		out.println("<tr>");
		out.println("<th>번호</th>");
		out.println("<th>이름</th>");
		out.println("<th>국어</th>");
		out.println("<th>영어</th>");
		out.println("<th>수학</th>");
		out.println("<th></th>");
		out.println("</tr>");
		
		int count=dao.stdRowCount();
		count=count-((curpage*10)-10); //순차적으로 처리 
		int totalpage=(int)Math.ceil(count/10.0); //총페이지 구하기 
		
		for(StudentVO vo:list)
		{
			out.println("<tr>");
			out.println("<td>"+(count--)+"</td>"); //예를 들어 dao가 10줄 ==> 반복문 돌면서 count=10,9,8,...1 이렇게 된다.  
			out.println("<td>"+vo.getName()+"</td>");
			out.println("<td>"+vo.getKor()+"</td>");
			out.println("<td>"+vo.getEng()+"</td>");
			out.println("<td>"+vo.getMath()+"</td>");
			out.println("<td><a href=delete.do?hakbun="+vo.getHakbun()+">삭제</a></td>");
			// a태그는 get방식만 사용할 수 있다. ==> post 방식 못 쓰므로
			/*
			 * <HTML/Java를 이용한 화면 이동>
			 * [HTML]
			 * 		1. a: GET방식만 사용 가능
			 * 		2. form: GET/POST 둘 다 사용 가능
			 * [Java] sendRedirect(): GET방식만 사용 가능.
			 * [JavaScript] location.href: GET방식만 사용 가능.
			 * 
			 * - POST 방식으로 보낼 수 있는 애는 form태그 뿐!!★
			 * ==> 위의 줄에서 a태그는 post방식 사용 불가 ==>  doPost 호출 불가 
			 * ==> get방식으로 하기 위해서 delete.do라는 애를 또 만들어야함.. 
			*/
			out.println("</tr>");
		}		
		out.println("</table>");
		
		
		//[테이블2]: 이전/다음 페이지 버튼 
		out.println("<table width=500>");
		out.println("<tr>");
		out.println("<td align=center>");
		out.println("<a href=list.do?page="+(curpage>1?curpage-1:curpage)+">이전</a>");
		out.println(curpage+" page / "+totalpage+" pages"); 
		out.println("<a href=list.do?page="+(curpage<totalpage?curpage+1:curpage)+">다음</a>");
		out.println("</tr>");
		out.println("</td>");
		out.println("</table>");
		
		out.println("</center>");
		out.println("</body>");
		out.println("</html>");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}


/*
 * 	String temp=request.getRequestURI();
 *	System.out.println(temp); 
 *	결과: SequenceProject/list.jsp 
 * 	http://localhost/list.jsp?no=10
 * 	=========================URL
 * 					========URI : 파일. ?앞까지가 URI다. 
 */