<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		int num = (int)request.getAttribute("num");
		int notice = (int)request.getAttribute("notice");
	%>
	<form action="<%= request.getContextPath()%>/board/boardModify.do?num=<%=num%>&notice=<%= notice%>" method="post">
		제목 : <input type="text" name="title" required>
		내용 : <input type="text" name="content" required>
		<input type="submit" value="글수정">
	</form>
	<a href="<%= request.getContextPath()%>/board/board1.do?notice=<%=notice%>"><button>뒤로가기</button></a>
</body>
</html>