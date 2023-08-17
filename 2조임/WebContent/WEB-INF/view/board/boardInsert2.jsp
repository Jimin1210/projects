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
	<% UserVO vo = (UserVO)session.getAttribute("userVO");
		int notice = (int)request.getAttribute("notice");
	%>
	<form action="<%= request.getContextPath()%>/board/boardInsert.do?u_no=<%=vo.getU_no()%>" method="post">
		제목 : <input type="text" name="title" required>
		내용 : <input type="text" name="content" required>
		<input type="text" name="notice" value="<%=notice%>" hidden>
		<input type="submit" value="글작성">
	</form>
	<a href="<%= request.getContextPath()%>/board/board1.do?notice=<%=notice%>"><button>뒤로가기</button></a>
</body>
</html>