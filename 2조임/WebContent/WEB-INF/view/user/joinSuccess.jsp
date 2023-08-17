<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%
	String nick = (String)request.getAttribute("nick");
%>
	<script>
		$(function(){
			alert("<%=nick%> 회원님 가입을 축하합니다!!");
			
			location.href="<%= request.getContextPath() %>/main.do";
		});
	</script>

