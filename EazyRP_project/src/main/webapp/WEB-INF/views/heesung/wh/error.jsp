<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>생산입고 상세보기</title>
<style>
	input {
		border: none;
		text-size: 100%;
		
	}
	
	html {
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 0.7em;
	}
	
	body {
		font-family: Arial, sans-serif;
		margin: 5em;
		align-items: center;
		justify-content: center;
	}
	
	h2 {
		color: #333;
		text-align: center;
		margin-bottom: 30px;
	}
	
	table {
		width: 100%;
		border-collapse: collapse;
		margin-bottom: 20px;
	}
	
	th, td {
		padding: 1em;
		border: 1px solid #ccc;
	}
	
	th {
		background-color: #f2f2f2;
		text-align: center;
	}
	
	td {
		vertical-align: middle;
	}
	
	.total, .files {
		font-weight: bold;
	}
	
	.note {
		font-style: italic;
	}
</style>
</head>
	

<body>
    <h2>불량제품 등록</h2>
<form role="form" method="post" enctype="multipart/form-data" action="/erp4/insertError2.do">
	<div class="card-footer">
		<button type="submit" id="errorBtn" class="btn btn-primary">등록</button>
		<button type="button" id="closeBtn" class="btn btn-warning">닫기</button>
	</div>
		<input type="hidden" name="wo_no" id="wo_no" class="wo_no" value="${wh.WO_NO }">
		<input type="hidden" name="wh_no" id="wo_no" class="wo_no" value="${wh.WH_NO }">
		<table>
	    </table>
    <table>
    	<thead>
	        <tr>
	            <th align="center" style="width: 14%;">품목</th>
				<th align="center" style="width: 14%;">생산 공장</th>
				<th align="center" style="width: 14%;">생산 수량</th>
				<th align="center" style="width: 14%;">불량 발생 수량</th>
	       	</tr>
       	</thead>
    	<tbody id="prInput">
	       	<c:forEach items="${whDetail }" var="whDetail" varStatus="loop">
		        <tr id="trChk">
					<input type="hidden" class="rownum" value="${whDetail.ROWNUM }">
					<input type="hidden" name="detail_no" id="dtail_no" value="${whDetail.DETAIL_NO }">
					<input type="hidden" name="pr_delete" value="o">
		        	<td>								
						<input type="text" ${wh.PROGRESS ne '0' ? 'readonly' : ''} id="${whDetail.ROWNUM }" class="pr_names" name="pr_name" style="width: 100%;" value="${whDetail.PR_NAME }">
						<input type="hidden" name="pr_no" value="${whDetail.PR_NO }">
					</td>
					<td>	
						<input type="text" id="fac_no${whDetail.ROWNUM }" readonly class="fac_names" name="fac_name" style="width: 100%;" value="${whDetail.FAC_NAME }">
						<input type="hidden" name="fac_no" id="fac_no${whDetail.ROWNUM }" value="${whDetail.FAC_NO }">
					</td>
					<td>
						<input type="text" id="a${loop.index }" class="quantity2" name="quantity2" style="width: 100%;" value="${whDetail.QUANTITY }" readonly>
					</td>
					<td>
						<input type="text" id="${loop.index }" class="quantity" name="quantity" style="width: 100%;" value="0" placeholder="불량 발생 수량">
					</td>
		        </tr>
	        </c:forEach>
        </tbody>
    </table>
</form>
</body>

<script>
window.onload = function(){
	
	let formObj = $('form[role="form"]');

	$('#errorBtn').on('click', function(){
		formObj.submit();
	});

	$('button#closeBtn').on('click', function(){
		window.close();
	});
	
	$('input[name="quantity"]').on('change', function(){
		var a = $(this).attr('id');
		var b = $('#a'+a).val();
		var c = $(this).val();
		if(Number(c) > Number(b)) {
			alert('생산 수량보다 적게 입력해주세요.');
			$(this).val('0');
		}
	})
	
	
}

</script>

</html>
