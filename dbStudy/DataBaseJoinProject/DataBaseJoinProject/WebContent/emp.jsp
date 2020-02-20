<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.sist.dao.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul>
	<%
	EmpDAO dao=new EmpDAO();
	ArrayList<EmpVO> list=dao.empJoinData();
	
	for(EmpVO vo:list) {
		out.println("<li>"+vo.getEmpno()+" "
				+vo.getEname()+" "
				+vo.getJob()+" "
				+vo.getHiredate().toString()+" "
				+vo.getSal()+" "
				+vo.getDvo().getDname()+" "
				+vo.getDvo().getLoc()+" "
				+vo.getSvo().getGrade()+"</li>");
	}
	%>
	</ul>
</body>
</html>