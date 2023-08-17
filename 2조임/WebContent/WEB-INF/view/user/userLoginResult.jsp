<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script>
	<%
		UserVO vo = (UserVO)session.getAttribute("userVO");
		int result = (int)request.getAttribute("result");
		String nick = (String)request.getAttribute("nick");
		if(result == 1){
	%>
			alert("<%= nick %>님 환영합니다!!");
			location.href="<%= request.getContextPath() %>/main.do?u_no=<%=vo.getU_no()%>";
	<%	}else{	%>
			alert("아이디 혹은 비밀번호가 일치하지 않습니다.");
			history.go(-1);
	<%	}	%>
    </script>