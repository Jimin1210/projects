<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>창고 재고 조회</title>
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
		<form method="post" id="searchForm" action="/erp4/findWareHouse.do" style="display: contents;">
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
		<table id = "tab" style="font-size: 0.8em;" class="table table-borderd text-center">
			<tr>
				<th width="100px" style="text-align: center;">품목코드</th>
				<th width="100px" style="text-align: center;">품목명 </th>
				<th width="100px" style="text-align: center;">재고량</th>
			</tr>
			<c:if test="${empty whtWareHouseList }">
				<tr>
					<td colspan="7">
						<strong>해당 창고에 재고가 없습니다.</strong>
					</td>
				</tr>
			</c:if>
			<c:forEach items="${whtWareHouseList }" var="whtWareHouseList">
				<tr class="trHover">
					<td style="text-align: center;" id="pr_no">${whtWareHouseList.PR_NO }</td>
					<td style="text-align: center;" id="pr_name">${whtWareHouseList.PR_NAME }</td>
					<td style="text-align: center;" id="quantity">${whtWareHouseList.QUANTITY }</td>
				<input type="hidden" id="wh_no" value="${whtWareHouseList.WH_NO }">
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
	




	$('#searchBtn').on('click',function(){
		$('#searchForm').submit();
	})

	$(document).ready(function() {
		
		let parentInputId = opener.$("#cnt").val();
		let gbVal = opener.$("#A").val();
		
		$('tr').on('click', function(){
			let pr_no = $(this).find('#pr_no').text();		
			let pr_name = $(this).find('#pr_name').text();
			let quantity = $(this).find('#quantity').text();
			
			let parentEl = $('#' + parentInputId, opener.document);
			
			parentEl.parents('tr').find('input[name="pr_no"]').val(pr_no);
			parentEl.parents('tr').find('input[name="pr_name"]').val(pr_name);
			parentEl.parents('tr').find('input[name="possible_quantity"]').val(quantity);
			
			window.close();
				
		})
		
	});
	
	
	
	
</script>