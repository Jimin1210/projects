<%@page import="kr.or.dw.reply.vo.ReplyVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script
	src="<%=request.getContextPath()%>/assets/plugins/jquery/jquery.js"></script>
<%
	int num = (int)request.getAttribute("num");
	int u_no = (int)request.getAttribute("u_no");
	int notice = (int)request.getAttribute("notice");
%>
	<script>
		$(function(){
			alert("댓글 등록이 완료되었습니다.");
			<% if(notice == 5){%>
			location.href="<%= request.getContextPath()%>/board/board1.do?notice=5&u_no=<%= u_no%>";
			<%} else {%>
			location.href="<%=request.getContextPath()%>/board/boardView.do?num=<%=num%>&u_no=<%=u_no%>&notice=<%= notice%>";
			<%} %>
		});
	</script>
