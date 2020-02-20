<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,com.sist.dao.*"%>
<%
	MusicDAO dao = new MusicDAO();
	ArrayList<MusicVO> list = dao.musicListData();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h1 class="text-center">지니뮤직 TOP100</h1>
		<div class="row">
			<table class="table table-hover">
				<tr class="success">
					<th class="text-center">순위</th>
					<th class="text-center"></th>
					<th class="text-center"></th>
					<th class="text-center">곡명</th>
					<th class="text-center">가수명</th>
				</tr>
				<%
					for(int i=0;i<50;i++)
					{
						MusicVO vo = list.get(i);
						String s="";
						if(vo.getState().equals("유지"))
							s="-";
						if(vo.getState().equals("상승"))
							s="<font color=red>▲</font>";
						if(vo.getState().equals("하강"))
							s="<font color=blue>▼</font>";
				%>
					<tr>
						<td class="text-center"><%=vo.getMno() %></td>
						<td class="text-center"><%=s+" "+(vo.getIdcrement()!=0?vo.getIdcrement():"") %></td>
						<td class="text-center">
							<img src="<%=vo.getPoster() %>" width=30 height=30>
						</td>
						<td><%=vo.getTitle() %></td>
						<td><%=vo.getSinger() %></td>
					</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
</body>
</html>