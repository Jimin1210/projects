<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String num = (String)request.getAttribute("num");
%>
    <script
	src="<%=request.getContextPath()%>/assets/plugins/jquery/jquery.js"></script>
<script>
$(function(){
	if(confirm("정말로 삭제하시겠습니까?")){
		location.href="<%=request.getContextPath()%>/admin/delete.do?num=<%=num%>";
	} else {
		location.href= "<%=request.getContextPath()%>/admin/BugerMenu.do";
	}
})
</script>