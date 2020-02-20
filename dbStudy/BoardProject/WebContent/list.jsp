<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
out.println("<html>");
out.println("<head>");
out.println("<link rel=stylesheet href=\"css/table.css\">");
out.println("</head>");
out.println("<body>");
out.println("<center>");
out.println("<h1>자유게시판</h1>");
out.println("<table id=\"table_content\" width=700>");
out.println("<tr>");
out.println("<th width=10% >번호</th>"); //<== %를 Java 코딩하겠다는 신호로 인식하지 않게 % 뒤에 한 칸 띄워줬음.  
out.println("<th width=45% >제목</th>");
out.println("<th width=15% >이름</th>");
out.println("<th width=20% >작성일</th>");
out.println("<th width=10% >조회수</th>");
out.println("</tr>");
out.println("</table>");
out.println("</center>");
out.println("</body>");
out.println("</html>");
%>