<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Font Awesome Icons -->
<link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작업지시서 목록</title>
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
					<th width="100px" style="text-align: center;">작업지시서 코드</th>
					<th width="100px" style="text-align: center;">작업지시서 제목</th>
				</tr>
				<c:forEach items="${woList }" var="wo">
					<tr class="trHover">
						<input type="hidden" name="wo_no" value="${wo.wo_no }">
						<td style="text-align: center;" id="wo_no">${wo.wo_no }</td>
						<td style="text-align: center;" id="e_name">${wo.wo_name }</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

<script>

	$('#searchBtn').on('click',function(){
		$('#searchForm').submit();
	})
		
	$(document).ready(function() {
		
		$('tr').on('click', function(){
			
			let wo_no = $(this).find('#wo_no').text();		// 클릭한 작업지시서의 번호
			let e_name = $(this).find('#e_name').text();	// 클릭한 작업지시서의 담당자
			let parentEl = $("#wo_no", opener.document);	// 번호가 입력 될 부모창의 태그
			
			parentEl.parents('tr').find('input#wo_no').val(wo_no);
			parentEl.parents('tr').find('input#wo_name').val(e_name);
			window.close();
			
		})
		
	})

</script>