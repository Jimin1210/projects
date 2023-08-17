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
<title>공장 목록</title>
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
					<th width="100px" style="text-align: center;">공장 코드</th>
					<th width="100px" style="text-align: center;">공장 이름</th>
				</tr>
				<c:forEach items="${factoryList }" var="factory">
					<tr class="trHover">
						<td style="text-align: center;" id="fac_no">${factory.fac_no }</td>
						<td style="text-align: center;" id="fac_name">${factory.fac_name }</td>
						<input type="hidden" id="wh_no" value="${wh.wh_no }">
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
		
		// registForm과 detail에서 열었을때를 구분해서 사용해야 하므로 if문으로 구분해주었다.
		let sort = opener.$('input[type=hidden]#sort');
		
		$('tr').on('click', function(){
			
			let fac_noName = $(this).find('#fac_name').text();
			let parentInputId = opener.$("#cnt").val();
			let parentEl = $("#" + parentInputId, opener.document);
		
			if (sort.val() == 'registForm') {
				
				
				
				/* 	생산입고 registForm에서 제품 추가를 하여 여러개의 td들을 추가하고 생산 공장들을 각각 선택해도
					마지막에 선택한 생산 공장의 벨류로 모두 바뀌어서 보내지기 때문에 모두 같은 정보가 DB에 등록된다.	*/
				
				
				if (parentEl.attr('id') == 0) {		// 제품을 추가하지 않은 경우
					
					parentEl.parents('tr').find('input.fac_names').val(fac_noName);
					parentEl.parents('tr').find('input[type="hidden"]#fac_no0').val($(this).find('#fac_no').text());
					
				} else {	// 제품을 추가한 경우
					
					parentEl.parents('tr').find('input[type="text"]#' + parentInputId).val(fac_noName);
					parentEl.parents('tr').find('input[type="hidden"]#' + parentInputId).val($(this).find('#fac_no').text());
					
				}
				
				window.close();
				
			} else if (sort.val() == 'detail') {
				
// 				if (parentEl.attr('id') == 1) {		// 제품을 추가하지 않은 경우
					
// 					parentEl.parents('tr').find('input.fac_names').val(fac_noName);
// 					parentEl.parents('tr').find('input[type="hidden"]#1').val($(this).find('#fac_no').text());
					
// 				} else {	// 제품을 추가한 경우

					parentEl.parents('tr').find('input[type="text"]#' + parentInputId).val(fac_noName);
					parentEl.parents('tr').find('input[type="hidden"]#' + parentInputId).val($(this).find('#fac_no').text());
					
// 				}
				
				window.close();
			
			} else {
				
				alert('예외 발생');
				return;
				
			}
			
		})
		
	})

</script>