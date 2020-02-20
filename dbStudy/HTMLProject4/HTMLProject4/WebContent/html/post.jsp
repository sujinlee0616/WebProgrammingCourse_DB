<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.sist.dao.*, java.util.*"%>
<!-- %와 % 사이에 Java를 코딩한다. -->
<%
	try
	{
		request.setCharacterEncoding("UTF-8");	
	}catch(Exception ex){}
	String dong=request.getParameter("dong");
	//안에 있는 input 태그의 dong 값을 받는다. 
	//System.out.println(dong);
	ArrayList<ZipcodeVO> list=null;
	if(dong!=null) //입력값이 있다면
	{
		ZipcodeDAO dao=new ZipcodeDAO();
		list=dao.postFind(dong);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="table.css">
<script type="text/javascript">
function send(){
	var dong=document.frm.dong.value;
	if(dong==""){
		document.frm.dong.focus();
		return;
	}
	document.frm.submit(); //데이터 전송
}
function ok(zip,addr){
	opener.frm.post.value=zip;
	opener.frm.addr1.value=addr;
	self.close();
}
</script>
<style type="text/css">
th,td{
	font-size: 8pt;
}
</style>
</head>
<body>
	<center>
		<h3>우편번호 검색</h3>
		<table id="table_content" width=420>
			<tr>
				<td width=15% class="tdright">입력</td>
				<td>
					<form method=post action="post.jsp" name=frm>
						<!-- 자기 자신한테 넘어가는 것 당연히 됨  -->
						<!--  insert, update, delete : 받는 애가 따로 있어야 함 -->
						<!--  select : 자기 자신이 받아도 됨. -->
						<input type=text name=dong size=15>
						<!-- name값이 있어야 데이터 넘겨줄 수 있다. -->
						<input type="button" value="검색" onclick="send()">
						<!--  button이 submit이어야 전송이 됨 -->
					</form>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="tdcenter">
					<sup><font color="red">※ 동/읍/면을 입력하세요. ※</font></sup>
				</td>
			</tr>
		</table>
		<%
			if(list!=null)
			{
		%>
			<table id="table_content" width=420>
				<tr>
					<th width=25%>우편번호</th>
					<th width=75%>주소</th>
				</tr>
				<%
					for(ZipcodeVO vo:list)
					{
				%>
					<tr>
						<td width=25% align="center"><%=vo.getZipcode() %></td>
						<td width=75% align="left">
							<a href="javascript:ok('<%=vo.getZipcode() %>','<%=vo.getAddress() %>')"><%=vo.getAddress() %></td>
					</tr>
				<%		
					}
				%>
			</table>
		<%
			}
		%>		
	</center>
</body>
</html>