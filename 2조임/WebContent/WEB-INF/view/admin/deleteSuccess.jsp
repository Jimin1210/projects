<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String u_no = (String)request.getAttribute("u_no");
%>
    
	<script>		
		alert("<%=u_no%>번님이 삭제되었습니다");
		location.href="<%=request.getContextPath()%>/admin.do"
	</script>