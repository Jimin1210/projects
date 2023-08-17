<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 찾기</title>
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
		<form method="post" id="searchForm" action="/erp4/findCompany.do" style="display: contents;">
			<select class="form-control" name="searchType" id="searchType" style="font-size: 0.8em; width: 30%;">
				<option value="all" ${searchType eq 'all' ? 'selected' : '' }>전  체</option>
				<option value="w" ${searchType eq 'w' ? 'selected' : '' }>대표명</option>
				<option value="c" ${searchType eq 'c' ? 'selected' : '' }>업체명</option>
				<option value="a" ${searchType eq 'a' ? 'selected' : '' }>주 소</option>
				<option value="p" ${searchType eq 'p' ? 'selected' : '' }>취급품목</option>
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
				<th width="100px" style="text-align: center;">대표명</th>
				<th width="100px" style="text-align: center;">업체명</th>
				<th width="100px" style="text-align: center;">취급품목</th>
				<th width="100px" style="text-align: center;">주 소</th>
			</tr>
				<c:forEach items="${companyList }" var="company">
				<tr class="trHover">
					<td style="text-align: center;" id="name">${company.c_rname }</td>
					<td style="text-align: center;" id="c_name">${company.c_name }<input type="hidden" id="c_no" value="${company.c_no }"></td>
					<td style="text-align: center;" id="addr">${company.keyword }</td>
					<td style="text-align: center;" id="addr">${company.addr }</td>
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
	$(document).ready(function() {
	
		
	$('tr').on('click', function(){
			$('#c_name', opener.document).val($(this).find('#c_name').text());
			$('#c_no', opener.document).val($(this).find('#c_no').val());
			window.close();
		})
	
		$('#searchBtn').on('click', function(){
			$('#searchForm').submit();
		})
	});
</script>
