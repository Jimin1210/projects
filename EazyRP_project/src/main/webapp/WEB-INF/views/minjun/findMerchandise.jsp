<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 찾기</title>
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
		<form id="searchForm" method="post" action="/erp5/findMerchandise.do" style="display: contents;">
			<select class="form-control" name="searchType" id="searchType" style="font-size: 0.8em; width: 30%;">
				<option value="cw" ${searchType eq 'cw' ? 'selected' : '' }>전  체</option>
				<option value="w" ${searchType eq 'w' ? 'selected' : '' }>상품 코드</option>
				<option value="c" ${searchType eq 'c' ? 'selected' : '' }>쇼핑몰 이름</option>
				<option value="d" ${searchType eq 'd' ? 'selected' : '' }>제품 이름</option>
			</select>
			<input class="form-control" type="text" name="keyword" style="width: 50%; font-size: 0.8em" placeholder="검색어를 입력하세요." value="${keyword}">
			<button class="btn btn-primary" type="button" id="searchBtn">
				<i class="fa fa-fw fa-search" style="font-size: 0.8em; padding: 0px;"></i>
			</button>
		</form>
	</div>
	<div>	
		<table id="tab" style="font-size: 0.8em;" class="table table-borderd text-center">
			<tr>
				<th width="100px" style="text-align: center;">상품 코드</th>
				<th width="100px" style="text-align: center;">제품 이름</th>
				<th width="100px" style="text-align: center;">쇼핑몰 이름</th>
				<th width="100px" style="text-align: center;">수량</th>
				<th width="100px" style="text-align: center;">판매가격</th>
				<th width="100px" style="text-align: center;">단가</th>
			</tr>
			<c:forEach items="${merchandise}" var="mch">
				<tr>
					<td style="text-align: center;" class="sp_no">${mch.SP_NO}</td>
					<td style="text-align: center;" class="pr_name">${mch.PR_NAME }</td>
					<td style="text-align: center;" class="s_name">${mch.S_NAME}</td>
					<td style="text-align: center;" class="sp_q">${mch.SP_Q}</td>
					<td style="text-align: center;" class="price">${mch.PRICE}</td>
					<td style="text-align: center;" class="price">${mch.UNITPRICE}</td>
				</tr>
			</c:forEach>
		</table>
		<input type="hidden" value="" id="cnt">
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
			$('#name', opener.document).val($(this).find('.pr_name').text());
			$('#sp_no_receiver', opener.document).val($(this).find('.sp_no').text());
			$('#hiddenquantity', opener.document).val($(this).find('.sp_q').text());
			$('#quantity', opener.document).attr('placeholder', '남은 수량 : ' + $(this).find('.sp_q').text());
			
			
			window.close();
		})
	
		$('#searchBtn').on('click', function(){
			$('#searchForm').submit();
		})
	});
</script>
