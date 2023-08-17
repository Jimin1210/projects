<%@page import="org.apache.commons.beanutils.BeanUtils"%>
<%@page import="kr.or.dw.admin.vo.adminVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	adminVO adminVo = (adminVO) request.getAttribute("adminVo");
	
%>
	<script>
		alert("계정 추가가 완료되었습니다.");
		location.href="<%= request.getContextPath()%>/admin/admin.do"
	</script>