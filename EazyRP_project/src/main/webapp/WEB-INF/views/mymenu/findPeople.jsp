<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사람찾기</title>
<style>
	.trHover:hover{
		background-color: #dfdfdf;
		transition-propety: background-color;
		transition-duration: 1s;
	}
</style>
</head>
<body>
<div class="card-body pad">
	<div>
	<div class="input-group row" style="width: 100%; margin: 0px 0px 20px 0px; justify-content: center;">
		<form method="post" id="searchForm" action="/mymenu/findPeople.do" style="display: contents;">
			<select class="form-control" name="searchType" id="searchType" style="font-size: 0.8em; width: 30%;">
				<option value="cw" ${searchType eq 'cw' ? 'selected' : '' }>전  체</option>
				<option value="w" ${searchType eq 'w' ? 'selected' : '' }>이  름</option>
				<option value="c" ${searchType eq 'c' ? 'selected' : '' }>업  체</option>
			</select>
			<input class="form-control" type="text" name="keyword" style="width: 50%; font-size: 0.8em" placeholder="검색어를 입력하세요." value="${keyword}">
				<button class="btn btn-primary" type="button" id="searchBtn">
					<i class="fa fa-fw fa-search" style="font-size: 0.8em; padding: 0px;"></i>
				</button>
		</form>
		</div>
	<div>	
		<table style="font-size: 0.8em;" class="table table-borderd text-center">
			<tr>
				<th width="100px" style="text-align: center;">이름</th>
				<th width="100px" style="text-align: center;">업체명</th>
			</tr>
				<c:forEach items="${emp }" var="emp">
				<tr class="trHover">
					<td style="text-align: center;" id="name">${emp.e_name }</td>
					<td style="text-align: center;" id="c_name">${emp.c_name }<input type="hidden" id="emp_no" value="${emp.emp_no }"></td>
				</tr>
				</c:forEach>
		</table>
	</div>
</div>
</div>
</body>
</html>
 <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script>
	$('tr').on('click', function(){
		$('#name', opener.document).val($(this).find('#c_name').text() + " / " + $(this).find('#name').text());
		$('#receiver', opener.document).val($(this).find("#emp_no").val());
		window.close();
	})

	$('#searchBtn').on('click', function(){
		$('#searchForm').submit();
	})
</script>