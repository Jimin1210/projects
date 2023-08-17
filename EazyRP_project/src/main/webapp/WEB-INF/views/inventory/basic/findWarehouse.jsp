<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 찾기</title>
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
				<option value="w" ${searchType eq 'w' ? 'selected' : '' }>창고명</option>
				<option value="a" ${searchType eq 'a' ? 'selected' : '' }>주소</option>
				<option value="g" ${searchType eq 'g' ? 'selected' : '' }>가동여부</option>
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
				<th width="100px" style="text-align: center;">창고명</th>
				<th width="100px" style="text-align: center;">주 소</th>
				<th width="100px" style="text-align: center;">가동여부</th>
				<th width="100px" style="text-align: center;">소유회사</th>
			</tr>
				<c:forEach items="${warehouseList }" var="warehouse">
				<tr class="trHover">
					<td style="text-align: center;" id="wh_name">${warehouse.WH_NAME }</td>
					<td style="text-align: center;" id="addr">${warehouse.ADDR }<input type="hidden" id="wh_no" value="${warehouse.WH_NO }"></td>
					<td style="text-align: center;" id="wh_gb">${warehouse.WH_GB eq 'Y' ? '가동중' : '사용 중지' }</td>
					<td style="text-align: center;" id="c_name">${warehouse.C_NAME }</td>
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
			$('#wh_name', opener.document).val($(this).find('#wh_name').text());
			$('#wh_no', opener.document).val($(this).find('#wh_no').val());
			window.close();
		})
	
		$('#searchBtn').on('click', function(){
			$('#searchForm').submit();
		})
	});
</script>
