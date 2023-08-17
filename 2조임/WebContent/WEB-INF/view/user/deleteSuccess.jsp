<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
   <script
	src="<%=request.getContextPath()%>/assets/plugins/jquery/jquery.js"></script>
<script>
	$(function(){
		alert("계정 삭제가 완료되었습니다.");
		location.href="<%=request.getContextPath()%>/main.do"
	})
</script>