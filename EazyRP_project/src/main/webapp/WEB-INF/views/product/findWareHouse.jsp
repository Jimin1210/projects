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
		</div>
	<div>	
		<table id = "tab" style="font-size: 0.8em;" class="table table-borderd text-center">
			<tr>
				<th width="140px" style="text-align: center;">창고 이름</th>
				<th width="80px" style="text-align: center;">주소 </th>
				<th width="100px" style="text-align: center;">제품명 </th>
				<th width="100px" style="text-align: center;">재고 수량 </th>
				<th width="100px" style="text-align: center;"></th>
			</tr>
			<c:forEach items="${whList }" var="wh">
				<tr class="trHover">
					<td style="text-align: center;" id="wh_name">${wh.wh_name }</td>
					<td style="text-align: center;" id="addr">${wh.addr }</td>
					<td style="text-align: center;" id="pr_name">${wh.pr_name }</td>
					<td style="text-align: center;" id="quantity">${wh.quantity }</td>
					<td style="text-align: center;" id="">
						<c:if test="${quantity > wh.quantity}">
							<button type="button" style="width: 50px; height: 20px; font-size: 0.5em; padding: 2px;" class="selectBtn2 btn btn-warning">선 택</button>
							<p style="position: absolute; z-index: 2; font-size: 0.5em; color: red; right: 25px;">재고 부족으로 입고 기간이 지연될 수 있습니다.</p>
						</c:if>
						<c:if test="${quantity <= wh.quantity}">
							<button type="button" style="width: 50px; height: 20px; font-size: 0.5em; padding: 2px;" class="selectBtn btn btn-primary">선 택</button>
						</c:if>
					</td>
					<input type="hidden" id="pr_no" value="${wh.pr_no }">
					<input type="hidden" id="wh_no" value="${wh.wh_no }">
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
	
	let cnt = opener.$("#cnt").val();
	
	$('.selectBtn').on('click', function(){
		let wh_no = $(this).parent().next().next().val();
		let wh_name = $(this).parent().parent().find('#wh_name').text();
		
		$('#no' + cnt, opener.document).val(wh_no);
		$('#' + cnt, opener.document).val(wh_name);
		$('#lack' + cnt, opener.document).val('N');
		window.close();
		
	})
	
	$('.selectBtn2').on('click', function(){
		let wh_no = $(this).parent().next().next().val();
		let wh_name = $(this).parent().parent().find('#wh_name').text();
		
		$('#no' + cnt, opener.document).val(wh_no);
		$('#' + cnt, opener.document).val(wh_name);
		$('#lack' + cnt, opener.document).val('Y');
		window.close();
		
	})
	
	
})
	
	
	
	
</script>