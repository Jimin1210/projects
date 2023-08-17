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
				<th width="100px" style="text-align: center;">창고 이름</th>
				<th width="100px" style="text-align: center;">주소 </th>
				<th width="100px" style="text-align: center;">소유 업체명</th>
			</tr>
			<c:forEach items="${warehouse }" var="wh">
				<tr class="trHover">
					<td style="text-align: center;" id="wh_name">${wh.wh_name }</td>
					<td style="text-align: center;" id="addr">${wh.addr }</td>
					<td style="text-align: center;" id="c_name">${wh.c_name }</td>
				<input type="hidden" id="wh_no" value="${wh.wh_no }">
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
			console.log(gbVal);
			console.log(parentInputId);
			
			$('tr').on('click', function(){
				let wh_noName = $(this).find('#wh_name').text();	// 창고명
				let wh_no = $(this).find('#wh_no').val();			// 창고번호
				let price = $(this).find('.cost').val();
				
					
					if(gbVal == 'A'){
					// 견적서 사용 부분		
					let parentEl = $("#" + parentInputId, opener.document);
					parentEl.val(wh_noName);
					parentEl.parents('tr').find('input.wh_names').val(wh_noName);
					parentEl.parents('tr').find('input[name="wh_no"]').val($(this).find('#wh_no').val());
					$('#wh_no', opener.document).val($(this).find('#wh_name').text() + " / " + $(this).find('#addr').text());
					window.close();
					
					} else if(gbVal == 'B'){
						// 출하지시서 사용 부분
						let parentElSi = $('#si_whname', opener.document);
						parentElSi.val(wh_noName);
						let parentElWhNo = $('input[name=wh_no]', opener.document);
						parentElWhNo.val(wh_no)
						$('#wh_no', opener.document).val($(this).find('#wh_name').text() + " / " + $(this).find('#addr').text());
						window.close();
						
					} else if(gbVal == 'C'){
						
						// 창고이동 사용 부분 (희성)
						let parentEl_give = $('#give_wh_name', opener.document);	// 보낸 창고
						let parentEl_give_no = $('input[name=wh_no]', opener.document);
						
						let parentEl_take = $('#take_wh_name', opener.document);	// 받는 창고
						let parentEl_take_no = $('input[name=wh_no2]', opener.document);
						
						if (parentInputId == 'give_wh_name') {	// 보낸 창고
							parentEl_give.val(wh_noName);
							parentEl_give_no.val(wh_no);
						} else if (parentInputId == 'take_wh_name') {	// 받는 창고
							parentEl_take.val(wh_noName);
							parentEl_take_no.val(wh_no);
						} else {
							alert('예외 발생 (findWareHouse.jsp)');
						}
						
						window.close();
					
					}
			
				$('#wh_no', opener.document).val($(this).find('#wh_name').text() + " / " + $(this).find('#addr').text());
				window.close();
				
			})
			
			
		})
	
	
	
	
</script>