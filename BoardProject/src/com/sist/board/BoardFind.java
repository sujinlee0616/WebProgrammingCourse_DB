//===미완성=======================================================================================
package com.sist.board;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sist.dao.BoardDAO;
import com.sist.dao.BoardVO;

@WebServlet("/BoardFind")
public class BoardFind extends HttpServlet {
	private static final long serialVersionUID = 1L;	
	
	//[doPost] 처리 
		protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out=response.getWriter();
			
			// 1. 사용자가 보내준 값을 저장 
			//한글 인코딩
			try {
				request.setCharacterEncoding("UTF-8"); 
			} catch (Exception ex) {}
			
			
			
			// 2. 저장된 값을 DAO로 전송
			
			// 3. 처리 ==> DAO에서 처리. 
			
			// 4. 이동: 상세보기로 이동.
			
		}


}
