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
		<form id="searchForm" method="post" action="/erp4/findProduct.do" style="display: contents;">
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
		<table id="tab" style="font-size: 0.8em;" class="table table-borderd text-center">
			<tr>
				<th width="100px" style="text-align: center;">제품이름</th>
				<th width="100px" style="text-align: center;">업체명</th>
				<th width="100px" style="text-align: center;">금액</th>
				<th width="100px" style="text-align: center;">보관 창고</th>
			</tr>
			<c:forEach items="${product}" var="pro">
				<tr>
					<td style="text-align: center;" class="pr_name">${pro.pr_name}</td>
					<td style="text-align: center;" class="c_name">${pro.c_name}</td>
					<td style="text-align: center;" class="pr_exprice">${pro.pr_exprice }</td>
					<td style="text-align: center;" class="pr_whname">${pro.wh_name }</td>
					<input type="hidden" class="cost" value="${pro.pr_exprice }">
					<input type="hidden" id="pr_no" value="${pro.pr_no}">
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
		let parentInputId = opener.$("#cnt").val();
		
		
		
		$('#tab').on('click', 'tr', function() {
			
			let pr_noChk = $(this).find('#pr_no').val();
			
			for(let i=0; i < opener.$('tbody').find('input[name="pr_no"]').get().length; i++){
				if($('tbody', opener.document).find('input[name="pr_no"]').eq(i).val() == pr_noChk){
					alert('입력된 제품입니다.');
					return;
				};
			}
			
			let pr_noName = $(this).find('#pr_no').val();
			let productName = $(this).find('.pr_name').text();
			let companyName = $(this).find('.c_name').text();
			let siProductName = $(this).find('.pr_names2').text();
			
			let price = $(this).find('.cost').val();
			let parentEl = $("#" + parentInputId, opener.document);
			
			console.log(parentEl.parents('tr').find('input#cost'))
			console.log(parentEl)
			
			parentEl.val(productName);
			
			$('#c_name', opener.document).val(companyName);
			parentEl.parents('tr').find('input#cost').val(price);
			$('#pr_no', opener.document).val(pr_noName);
			parentEl.parents('tr').find('input[name="pr_no"]').val(pr_noName);
			$('#pr_name').parents('tr').find('input[name="pr_name"]').val(siProductName);
			let quantity = parentEl.parents('tr').find('input[name="quantity"]').val();
			parentEl.parents('tr').find('input[name="amount"]').val(quantity * price);
			
			
			
			let sum = Number(0);
			let inputAmount = opener.$('input[name="amount"]').get();
			for(let i = 0; i < inputAmount.length; i++){
				sum += Number(opener.$('input[name="amount"]').eq(i).val());
			}
			debugger;
			opener.$('#totalAmount').val(sum);
			
			window.close();
		});
		
		$('#searchBtn').on('click', function(){
			$('#searchForm').submit();
		
		})

	});
</script>
