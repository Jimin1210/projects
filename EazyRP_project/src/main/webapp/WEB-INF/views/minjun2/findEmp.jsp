<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원 리스트</title>
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
	<div class="input-group row " style="width: 100%; margin: 0px 0px 10px 0px; justify-content: center;">
		<form id="searchForm" method="post" action="/management/findEmp.do" style="display: contents;">
			<select class="form-control" name="searchType" id="searchType" style="font-size: 0.8em; width: 20%;">
				<option value="cw" ${searchType eq 'cw' ? 'selected' : '' }>전  체</option>
				<option value="w" ${searchType eq 'w' ? 'selected' : '' }>사원 코드</option>
				<option value="c" ${searchType eq 'c' ? 'selected' : '' }>사원 이름</option>
			</select>
			<input class="form-control" type="text" name="keyword" style="width: 40%; font-size: 0.8em" placeholder="검색어를 입력하세요." value="${keyword}">
			<button class="btn btn-primary" type="button" id="searchBtn">
				<i class="fa fa-fw fa-search" style="font-size: 0.8em; padding: 0px;"></i>
			</button>
		</form>
	</div>
	<div>	
		<table id="tab" style="font-size: 0.8em;" class="table table-borderd text-center">
			<tr>
				<th width="50px" style="text-align: center;">사원 코드</th>
				<th width="50px" style="text-align: center;">사원 이름</th>
				<th width="50px" style="text-align: center;">직급</th>
				<th width="50px" style="text-align: center;">부서명</th>
			</tr>
			<tr id="zero">
				<td style="text-align: center;" class="emp_no">0</td>
				<td style="text-align: center;" class="e_name">없음</td>
				<td style="text-align: center;" class="e_rank">없음</td>
				<td style="text-align: center;" class="dname">없음</td>
			</tr>
			<c:forEach items="${emp}" var="emp">
				<tr>
					<td style="text-align: center;" class="emp_no">${emp.emp_no}</td>
					<td style="text-align: center;" class="e_name">${emp.e_name}</td>
					<td style="text-align: center;" class="e_rank">${emp.e_rank}</td>
					<td style="text-align: center;" class="dname">${emp.dname}</td>
					<td style="display: none;" class="e_sal">${emp.e_sal}</td>
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
		
		
		
		let gbVal = opener.$("#A").val();
		if(gbVal =='A'){
			$('#zero').remove();
		}
		let parentInputId = opener.$("#cnt").val();

		$('td').on('click', function(){
			
			let emp_noChk = $(this).parents('tr').find('.emp_no').text();
			
			for(let i = 0; i < opener.$('tbody').find('input[name="emp_no"]').get().length; i ++) {
				if($('tbody', opener.document).find('input[name="emp_no"]').eq(i).val() == emp_noChk){
					alert('이미 입력된 사원입니다.');
					return;
				};	
			}
			
			
				if(gbVal == 'A'){
					
					let parentE1 = $('#' + parentInputId, opener.document);
					// 성명 부서명 기본급
					parentE1.parents('tr').find('input[name="e_name"]').val($(this).parents('tr').find('.e_name').text());
					parentE1.parents('tr').find('input[name="dname"]').val($(this).parents('tr').find('.dname').text());
					parentE1.parents('tr').find('input[name="e_sal"]').val(Math.floor($(this).parents('tr').find('.e_sal').text() / 12));
					// 사원번호, 직위직급명
					parentE1.parents('tr').next('tr').find('input[name="emp_no"]').val($(this).parents('tr').find('.emp_no').text());
					parentE1.parents('tr').next('tr').find('input[name="e_rank"]').val($(this).parents('tr').find('.e_rank').text());
			
					let data = {
							"emp_no" : $(this).parents('tr').find('.emp_no').text(),
							"salmonth" : opener.$("#salmonth").val(),
							"e_sal" : $(this).parents('tr').find('.e_sal').text()
							
					};
					
					$.ajax({
						url : "<%=request.getContextPath()%>/management/calextrapay",
						type : "post",
						data : JSON.stringify(data),
						dataType: 'json',
						contentType : "application/json;charset=utf-8",
						success : function(data){
							$.each(data, function(index, exp){
								parentE1.parents('tr').find('input[name='+ exp.EP_NO +']').parents('td').find('input[type="text"]').val(exp.EXTRAPAY);
								parentE1.parents('tr').next('tr').find('input[name='+ exp.EP_NO +']').parents('td').find('input[type="text"]').val(exp.EXTRAPAY);
							});
							
							let sum = 0;
							for (let i = 0; i < parentE1.parents('tr').find('input[class="sumpay"]').get().length; i++ ){
								sum += Number(parentE1.parents('tr').find('input[class="sumpay"]').eq(i).val());
							}
							
							for (let i = 0; i < parentE1.parents('tr').next('tr').find('input[class="sumpay"]').get().length; i++ ){
								sum += Number(parentE1.parents('tr').next('tr').find('input[class="sumpay"]').eq(i).val());
							}
							parentE1.parents('tr').find('#sumExtrapay').text(sum);
							
							
							// 토탈금액
							let e_sal_sum = 0;
							for(let i = 0; i < $('tbody', opener.document).find('input[name="e_sal"]').get().length; i++) {
								e_sal_sum += Number($('tbody', opener.document).find('input[name="e_sal"]').eq(i).val());
							}			
							$('#total_e_sal', opener.document).text(e_sal_sum);
							
							let sum_야근수당 = 0;
							for(let i = 0; i < $('tbody', opener.document).find('input[name="야근수당"]').get().length; i++) {
								sum_야근수당 += Number($('tbody', opener.document).find('input[name="야근수당"]').eq(i).val());
							}			
							$('#total_야근수당', opener.document).text(sum_야근수당);
							
							let sum_초과수당 = 0;
							for(let i = 0; i < $('tbody', opener.document).find('input[name="초과수당"]').get().length; i++) {
								sum_초과수당 += Number($('tbody', opener.document).find('input[name="초과수당"]').eq(i).val());
							}			
							$('#total_초과수당', opener.document).text(sum_초과수당);

							let sum_출산보육수당 = 0;
							for(let i = 0; i < $('tbody', opener.document).find('input[name="출산보육수당"]').get().length; i++) {
								sum_출산보육수당 += Number($('tbody', opener.document).find('input[name="출산보육수당"]').eq(i).val());
							}			
							$('#total_출산보육수당', opener.document).text(sum_출산보육수당);
							
							let sum_주말근무수당 = 0;
							for(let i = 0; i < $('tbody', opener.document).find('input[name="주말근무수당"]').get().length; i++) {
								sum_주말근무수당 += Number($('tbody', opener.document).find('input[name="주말근무수당"]').eq(i).val());
							}			
							$('#total_주말근무수당', opener.document).text(sum_주말근무수당);
							
							let sum_연차수당 = 0;
							for(let i = 0; i < $('tbody', opener.document).find('input[name="연차수당"]').get().length; i++) {
								sum_연차수당 += Number($('tbody', opener.document).find('input[name="연차수당"]').eq(i).val());
							}			
							$('#total_연차수당', opener.document).text(sum_연차수당);

							let sum_지급총액 = 0;
							for(let i = 0; i < $('tbody', opener.document).find('td[id="sumExtrapay"]').get().length; i++) {
								sum_지급총액 += Number($('tbody', opener.document).find('td[id="sumExtrapay"]').eq(i).text());
							}			
							$('#total_지급총액', opener.document).text(sum_지급총액);
							
							window.close();
						},
						error : function(error){
							alert("실패" + error.status);
						}
					});
				}else{
					//  다른페이지 emp찾기
					$('#emp_no2', opener.document).val($(this).parents('tr').find('.emp_no').text());
					$('#e_name2', opener.document).val($(this).parents('tr').find('.e_name').text());
					window.close();
				}
				
			});
	
		$('#searchBtn').on('click', function(){
			$('#searchForm').submit();
		});
	});
</script>
