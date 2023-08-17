<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
	<script>
		$(function(){
			alert("로그인 후 이용해주세요.");
			
			location.href="<%= request.getContextPath() %>/user/userLoginForm.do";
		});
	</script>