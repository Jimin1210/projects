<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css"
	rel="stylesheet">
 <style>
        table {
            text-align: center;
            font-size: 80%;
            align-content: center;
        }
        th,
        td {
            border: 1px solid #ccc;
           
        }
        th {
            background-color: #f2f2f2;
            vertical-align: middle;
            color: blue;
        }
        td {
            vertical-align: middle;
            padding: 0px;
        }
        input {
       		width:100%; 
        	border: none; 
        	text-align: center; 
        	vertical-align: middle;
        }
</style> 
<div style="min-height: 100%;">
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-12" style="max-width: 1500px;">
				<div class="card card-outline card-info">
					<div class="card-body pad">
						<form role="form" method="post" action="registSal.do" name="registForm" enctype="multipart/form-data">
							<div class="card-header d-flex justify-content-center" style="">
								<h1><input type="month" id="salmonth" name="salmonth" style="width: 400px;"></h1>
								<div class="d-flex" style="vertical-align:center; margin-left: auto; align-content: center; align-items: center;">
									<label for="saldate" class="" style="vertical-align:center;  float:right; text-align: center; margin-bottom: 0px; align-content: center;">지급일</label>
									<input class="" type="date" id="saldate" name="saldate" style="width: 120px;">
								</div>
							</div>
							<table class="table">
								<thead>
									<tr>
										<th style="width: 7%">성명</th>
										<th style="width: 8%">부서명</th>
										<th style="width: 7%">기본급</th>
									<c:forEach items="${extrapayList }" begin="0" end="2" var="exp" varStatus="loop">
										<th style="width: 8%">
											<input type="text"  id="ep_name" name="ep_name" value="${exp.EP_NAME }" style="color: blue; font-weight:bold;" readonly>
											<input type="hidden" id="ep_no" name="ep_no" value="${exp.EP_NO }">
											<input type="hidden" id="calc" name="calc" value="${exp.CALC }">
										</th>
									</c:forEach>
										<th rowspan="2" style="vertical-align: middle; width: 8%">지급총액</th>
									<c:forEach items="${deductionList }" begin="0" end="2" var="ded" varStatus="loop">
										<th style="width: 8%">
											<input type="text"  id="ded_name" name="ded_name" value="${ded.DED_NAME }" style="color: blue; font-weight:bold;" readonly>
											<input type="hidden" id="ded_no" name="ded_no" value="${ded.DED_NO }">
											<input type="hidden" id="calc" name="calc" value="${ded.CALC }">
										</th>
									</c:forEach>
										<th rowspan="2" style="vertical-align: middle; width: 8%" class="dedpay">공제총액</th>
										<th rowspan="2" style="vertical-align: middle; width: 8% ">실지급액</th>
										<th rowspan="2" style="vertical-align: middle; width: 6% ">비고</th>
									</tr>
									<tr>
										<th style="width: 6%">사원번호</th>
										<th style="width: 8%">직위/직급명</th>
										<th ></th>
									<c:forEach items="${extrapayList }" begin="3" end="5" var="exp" varStatus="loop">
										<th style="width: 7%">
											<input type="text"  id="ep_name" name="ep_name" value="${exp.EP_NAME }" style="color: blue;  font-weight:bold;" readonly>
											<input type="hidden" id="${exp.EP_NO }" name="ep_no" value="${exp.EP_NO }">
											<input type="hidden" id="calc" name="calc" value="${exp.CALC }">
										</th>
									</c:forEach>
										<th></th>
									<c:forEach items="${deductionList }" begin="3" end="5" var="ded" varStatus="loop">
										<th style="width: 8%">
											<input type="text"  id="ded_name" name="ded_name" value="${ded.DED_NAME }" style="color: blue; font-weight:bold;" readonly>
											<input type="hidden" id="ded_no" name="ded_no" value="${ded.DED_NO }">
											<input type="hidden" id="calc" name="calc" value="${ded.CALC }">
										</th>
									</c:forEach>
									</tr>
								</thead>
								<tbody>
								<input type="hidden" value="" id="cnt">
								<input type="hidden" value="A" id="A">
									<tr>
										<td><input type="text" id="e_name0" name="e_name" value="직원" style="" readonly></td>
										<td><input type="text"  id="dname0" name="dname" value="부서" style="" readonly></td>
										<td ><input type="text"  id="e_sal0" name="e_sal" value="기본급" class="sumpay" style="" readonly></td>
										<c:forEach items="${extrapayList }" begin="0" end="2" var="exp" varStatus="loop">
											<td style="width: 8%">
												<input type="text"  id="ep_name0" name="${exp.EP_NAME }" class="sumpay" value="" style="color: blue; font-weight:bold;" readonly>
												<input type="hidden" id="${exp.EP_NO }" name="${exp.EP_NO }" value="${exp.EP_NO }">
												<input type="hidden" id="calc" name="calc" value="${exp.CALC }">
											</td>
										</c:forEach>
										<td id="sumExtrapay" rowspan="2" style="vertical-align: middle;"></td>
										<c:forEach items="${deductionList }" begin="0" end="2" var="ded" varStatus="loop">
										<td style="width: 8%">
											<input type="text"  id="${ded.DED_NAME}" name="ded_name" class="dedApply" value="" style="" readonly placeholder="적용하기">
											<input type="hidden" id="ded_no" name="${ded.DED_NO }" value="x">
											<input type="hidden" id="calc" name="calc" value="${ded.CALC }">
										</td>
										</c:forEach>
										<td rowspan="2" style="vertical-align: middle;" class="dedpay" id="sumDedpay"></td>
										<td rowspan="2" style="vertical-align: middle;"><input type="text"  id="realSumSal" name="realsumsal" value="" style="" readonly></td>
										<td rowspan="2" style="vertical-align: middle;"><button type="button" id="cancelBtn">삭제</button></td>
									</tr>
									<tr>
										<td><input type="text"  id="emp_no0" name="emp_no" value="사원번호" style="" readonly></td>
										<td><input type="text"  id="e_rank0" name="e_rank" value="직급" style="" readonly></td>
										<td></td>
										<c:forEach items="${extrapayList }" begin="3" end="5" var="exp" varStatus="loop">
											<td style="width: 7%">
												<input type="text"  id="ep_name0" name="${exp.EP_NAME }" class="sumpay" value="" style="color: blue;  font-weight:bold;" readonly>
												<input type="hidden" id="${exp.EP_NO }" name="${exp.EP_NO }" value="${exp.EP_NO }">
												<input type="hidden" id="calc" name="calc" value="${exp.CALC }">
											</td>
										</c:forEach>
										<td></td>
										<c:forEach items="${deductionList }" begin="3" end="5" var="ded" varStatus="loop">
										<td style="width: 8%">
											<input type="text"  id="${ded.DED_NAME}" name="ded_name" class="dedApply" value="" style="" readonly placeholder="적용하기">
											<input type="hidden" id="ded_no" name="${ded.DED_NO }" value="x">
											<input type="hidden" id="calc" name="calc" value="${ded.CALC }">
										</td>
										</c:forEach>
									</tr>
								</tbody>
								<tfoot>
									<tr class="total">
										<td rowspan="2" colspan="2" align="center" style="vertical-align: middle;">총합계</td>
										<td id="total_e_sal"></td>
										<td id="total_야근수당"></td>
										<td id="total_주말근무수당"></td>
										<td id="total_연차수당"></td>
										<td rowspan="2" id="total_지급총액" style="vertical-align: middle;"></td>
										<td id="total_건강보험"></td>
										<td id="total_장기요양보험"></td>
										<td id="total_소득세"></td>
										<td rowspan="2" id="total_sumDedpay" style="vertical-align: middle;"></td>
										<td rowspan="2" style="vertical-align: middle;"><input type="text"  id="totalamount" name="totalamount" class="" value="" style="" readonly placeholder=""></td>
										<td rowspan="2"></td>
									</tr>
									<tr class="total">
										<td></td>
										<td id="total_초과수당"></td>
										<td id="total_출산보육수당"></td>
										<td></td>
										<td id="total_지방소득세"></td>
										<td id="total_국민연금"></td>
										<td id="total_고용보험"></td>
									</tr>
								</tfoot>
							</table>
								<button type="button" id="addPutBtn" class="btn btn-primary">직원 추가</button>
								<button type="button" id="addAllPutBtn" class="btn btn-primary">직원 전체 추가</button>
						</form>
					</div>
					<div class="card-footer card-tools">
						<button type="button" class="btn btn-primary" id="registBtn">등 록</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-warning" id="CancelBtn">취 소</button>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script>
	window.onload = function() {
		
		$('#salmonth').on('change', function(){
			$('tbody').find('tr').remove();
			$('#addPutBtn').click();
			$('.total').children().text('');
			$('.total').children().val('');
		});
		
		let form = $('form[role="form"]');

		// 등록버튼 클릭
		$('#registBtn').on('click', function() {
			if($('#saldate').val() == ''){
				alert("지급일을 입력해주세요.");
				return;
			}
			
			for(let i = 0; i < $('input[id="realSumSal"]').get().length; i++) {
				if($('input[id="realSumSal"]').eq(i).val() == '') {
					alert("공제정보를 확인해주세요.");
					return;
				}	
			}
			
			if($('#totalamount').val() == '' || $('#totalamount').val() == 0){
				alert('사원 정보를 입력해주세요.');
				return;
			}
			
			
			form.submit();
		});

		// 취소버튼 클릭
		$('#CancelBtn').on('click', function() {
			window.opener.location.reload(true);
			window.close(); // 윈도우 창을 닫는다.
		});

		// 삭제버튼 클릭
		$('#deleteBtn').on('click', function() {
			if (confirm("정말 삭제하시겠습니까?")) {

				form.attr({
					'action' : 'deleteWork.do',
					'method' : 'post'
				});

				form.submit();
			}
			;
		});

		function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight) {
			winleft = (screen.width - WinWidth) / 2;
			wintop = (screen.height - WinHeight) / 2;
			var win = window
					.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth
							+ ", " + "height=" + WinHeight + ",top=" + wintop
							+ ",left=" + winleft + ",resizable=yes,status=yes");
			win.focus();
			return win;
		}
		;
		
		// 사원 전체 추가
		$('#addAllPutBtn').on('click', function(){
			if(confirm("전체 직원을 추가하시겠습니까?")){
				if($('#salmonth').val() == ""){
					alert('달을 먼저 선택하세요.');
					return;
				}
				$('tbody').find('tr').remove();
				
				let data = {
						"salmonth" : $("#salmonth").val()
				};
				
				$.ajax({
					url : "<%=request.getContextPath()%>/management/addAllEmp",
					type : "post",
					data : JSON.stringify(data),
					dataType: 'json',
					contentType : "application/json;charset=utf-8",
					success : function(data){
						$.each(data, function(index, emp){
							let cnt = 0;
							addEmp();
							
							$('input[name="e_name"]').eq(index).val(emp.E_NAME);
							$('input[name="emp_no"]').eq(index).val(emp.EMP_NO);
							$('input[name="e_rank"]').eq(index).val(emp.E_RANK);
							$('input[name="e_name"]').eq(index).val(emp.E_NAME);
							$('input[name="e_sal"]').eq(index).val(Math.floor(emp.E_SAL / 12));
							
							$.each(emp.extrapayList, function(index1, exp){
								$('input[name="e_name"]').eq(index).parents('tr').find('input[name='+ exp.EP_NO +']').parents('td').find('input[type="text"]').val(exp.EXTRAPAY);
								$('input[name="e_name"]').eq(index).parents('tr').next('tr').find('input[name='+ exp.EP_NO +']').parents('td').find('input[type="text"]').val(exp.EXTRAPAY);								
							
							});
							
							let sum = 0;
							for (let i = 0; i < $('input[name="e_name"]').eq(index).parents('tr').find('input[class="sumpay"]').get().length; i++ ){
								sum += Number($('input[name="e_name"]').eq(index).parents('tr').find('input[class="sumpay"]').eq(i).val());
							}
							
							for (let i = 0; i < $('input[name="e_name"]').eq(index).parents('tr').next('tr').find('input[class="sumpay"]').get().length; i++ ){
								sum += Number($('input[name="e_name"]').eq(index).parents('tr').next('tr').find('input[class="sumpay"]').eq(i).val());
							}
							$('input[name="e_name"]').eq(index).parents('tr').find('#sumExtrapay').text(sum);
							
							// 토탈금액
							let e_sal_sum = 0;
							for(let i = 0; i < $('tbody').find('input[name="e_sal"]').get().length; i++) {
								e_sal_sum += Number($('tbody').find('input[name="e_sal"]').eq(i).val());
							}			
							$('#total_e_sal').text(e_sal_sum);
							
							let sum_야근수당 = 0;
							for(let i = 0; i < $('tbody').find('input[name="야근수당"]').get().length; i++) {
								sum_야근수당 += Number($('tbody').find('input[name="야근수당"]').eq(i).val());
							}			
							$('#total_야근수당').text(sum_야근수당);
							
							let sum_초과수당 = 0;
							for(let i = 0; i < $('tbody').find('input[name="초과수당"]').get().length; i++) {
								sum_초과수당 += Number($('tbody').find('input[name="초과수당"]').eq(i).val());
							}			
							$('#total_초과수당').text(sum_초과수당);

							let sum_출산보육수당 = 0;
							for(let i = 0; i < $('tbody').find('input[name="출산보육수당"]').get().length; i++) {
								sum_출산보육수당 += Number($('tbody').find('input[name="출산보육수당"]').eq(i).val());
							}			
							$('#total_출산보육수당').text(sum_출산보육수당);
							
							let sum_주말근무수당 = 0;
							for(let i = 0; i < $('tbody').find('input[name="주말근무수당"]').get().length; i++) {
								sum_주말근무수당 += Number($('tbody').find('input[name="주말근무수당"]').eq(i).val());
							}			
							$('#total_주말근무수당').text(sum_주말근무수당);
							
							let sum_연차수당 = 0;
							for(let i = 0; i < $('tbody').find('input[name="연차수당"]').get().length; i++) {
								sum_연차수당 += Number($('tbody').find('input[name="연차수당"]').eq(i).val());
							}			
							$('#total_연차수당').text(sum_연차수당);

							let sum_지급총액 = 0;
							for(let i = 0; i < $('tbody').find('td[id="sumExtrapay"]').get().length; i++) {
								sum_지급총액 += Number($('tbody').find('td[id="sumExtrapay"]').eq(i).text());
							}			
							$('#total_지급총액').text(sum_지급총액);
						});
					},
					error : function(error){
						alert("실패" + error.status);
					}
				});
			
			
			
			};
			
		});	
		
		let cnt = 0;
		
		function addEmp(){
			cnt++;
			
			$('tbody').append(
			'<tr>'
			+	'<td><input type="text" id="e_name' + cnt + '" name="e_name" value="직원" style="" readonly></td>'
			+	'<td><input type="text"  id="dname' + cnt + '" name="dname" value="부서" style="" readonly></td>'
			+	'<td><input type="text"  id="e_sal' + cnt + '" name="e_sal" value="기본급" class="sumpay" style="" readonly></td>'
			    <c:forEach items="${extrapayList }" begin="0" end="2" var="exp" varStatus="loop">
				+	'<td style="width: 8%"><input type="text"  id="ep_name' + cnt + '" name="${exp.EP_NAME }" value="" class="sumpay" style=" font-weight:bold;" readonly>'
				+ 	'<input type="hidden" id="${exp.EP_NO }" name="${exp.EP_NO }" value="${exp.EP_NO }"></td>'
				 </c:forEach>
			+	'<td rowspan="2" id="sumExtrapay" style="vertical-align: middle;"></td>'
				<c:forEach items="${deductionList }" begin="0" end="2" var="ded" varStatus="loop">
				+	'<td style="width: 8%"><input type="text"  id="${ded.DED_NAME}" name="ded_name" class="dedApply" value="" style="" readonly placeholder="적용하기">'
				+	'<input type="hidden" id="ded_no" name="${ded.DED_NO }" value="x">'
				+	'<input type="hidden" id="calc" name="calc" value="${ded.CALC }"></td>'
				 </c:forEach>
			+	'<td rowspan="2" style="vertical-align: middle;" class="dedpay" id="sumDedpay"></td>'
			+	'<td rowspan="2" style="vertical-align: middle;"><input type="text"  id="realSumSal" name="realsumsal" value="" style="" readonly></td>'
			+ 	'<td rowspan="2" style="text-align : center; vertical-align: middle;"><button type="button" id="cancelBtn">삭제</button></td>'
			+'</tr>'
			+'<tr>'
			+	'<td><input type="text"  id="emp_no' + cnt + '" name="emp_no" value="사원번호" style="" readonly></td>'
			+	'<td><input type="text"  id="e_rank' + cnt + '" name="e_rank" value="직급" style="" readonly></td>'
			+	'<td></td>'
				<c:forEach items="${extrapayList }" begin="3" end="5" var="exp" varStatus="loop">
				+	'<td style="width: 7%"><input type="text"  id="ep_name' + cnt + '" name="${exp.EP_NAME }" value="" class="sumpay" style=""  font-weight:bold;" readonly>'
				+	'<input type="hidden" id="${exp.EP_NO }" name="${exp.EP_NO }" value="${exp.EP_NO }"></td>'
				</c:forEach>
			+	'<td></td>'
				<c:forEach items="${deductionList }" begin="3" end="5" var="ded" varStatus="loop">
			+	'<td style="width: 8%"><input type="text"  id="${ded.DED_NAME}" name="ded_name" class="dedApply" value="" style="" readonly placeholder="적용하기">'
			+	'<input type="hidden" id="ded_no" name="${ded.DED_NO }" value="x">'
			+	'<input type="hidden" id="calc" name="calc" value="${ded.CALC }"></td>'
				 </c:forEach>
			+'</tr>'
			);
		}
		
		// 사원 추가 버튼
		$('#addPutBtn').on('click',  function (){
				
				cnt++;
			
				$('tbody').append(
				'<tr>'
				+	'<td><input type="text" id="e_name' + cnt + '" name="e_name" value="직원" style="" readonly></td>'
				+	'<td><input type="text"  id="dname' + cnt + '" name="dname" value="부서" style="" readonly></td>'
				+	'<td><input type="text"  id="e_sal' + cnt + '" name="e_sal" value="기본급" class="sumpay" style="" readonly></td>'
				    <c:forEach items="${extrapayList }" begin="0" end="2" var="exp" varStatus="loop">
					+	'<td style="width: 8%"><input type="text"  id="ep_name' + cnt + '" name="${exp.EP_NAME }" value="" class="sumpay" style=" font-weight:bold;" readonly>'
					+ 	'<input type="hidden" id="${exp.EP_NO }" name="${exp.EP_NO }" value="${exp.EP_NO }"></td>'
					 </c:forEach>
				+	'<td rowspan="2" id="sumExtrapay" style="vertical-align: middle;"></td>'
					<c:forEach items="${deductionList }" begin="0" end="2" var="ded" varStatus="loop">
					+	'<td style="width: 8%"><input type="text"  id="${ded.DED_NAME}" name="ded_name" class="dedApply" value="" style="" readonly placeholder="적용하기">'
					+	'<input type="hidden" id="ded_no" name="${ded.DED_NO }" value="x">'
					+	'<input type="hidden" id="calc" name="calc" value="${ded.CALC }"></td>'
					 </c:forEach>
				+	'<td rowspan="2" style="vertical-align: middle;" class="dedpay" id="sumDedpay"></td>'
				+	'<td rowspan="2" style="vertical-align: middle;"><input type="text"  id="realSumSal" name="realsumsal" value="" style="" readonly></td>'
				+ 	'<td rowspan="2" style="text-align : center; vertical-align: middle;"><button type="button" id="cancelBtn">삭제</button></td>'
				+'</tr>'
				+'<tr>'
				+	'<td><input type="text"  id="emp_no' + cnt + '" name="emp_no" value="사원번호" style="" readonly></td>'
				+	'<td><input type="text"  id="e_rank' + cnt + '" name="e_rank" value="직급" style="" readonly></td>'
				+	'<td></td>'
					<c:forEach items="${extrapayList }" begin="3" end="5" var="exp" varStatus="loop">
					+	'<td style="width: 7%"><input type="text"  id="ep_name' + cnt + '" name="${exp.EP_NAME }" value="" class="sumpay" style=""  font-weight:bold;" readonly>'
					+	'<input type="hidden" id="${exp.EP_NO }" name="${exp.EP_NO }" value="${exp.EP_NO }"></td>'
					</c:forEach>
				+	'<td></td>'
					<c:forEach items="${deductionList }" begin="3" end="5" var="ded" varStatus="loop">
				+	'<td style="width: 8%"><input type="text"  id="${ded.DED_NAME}" name="ded_name" class="dedApply" value="" style="" readonly placeholder="적용하기">'
				+	'<input type="hidden" id="ded_no" name="${ded.DED_NO }" value="x">'
				+	'<input type="hidden" id="calc" name="calc" value="${ded.CALC }"></td>'
					 </c:forEach>
				+'</tr>'
				);
			});
		
		// 사원찾기 
		$(document).on('click', 'input[name=e_name]', function(){
			if($('#salmonth').val() == ""){
				alert('달을 먼저 선택하세요.');
				return;
			}
			let c_no = $('#c_no').val();
			let idVal = $(this).attr("id");
			$('#cnt').val(idVal);
			let openWin = OpenWindow("/management/findEmp.do?c_no=" + c_no, "사원 찾기", 600, 700);
		});
		
		//첫번째 tr 사원삭제버튼
		$('tbody').on('click', '#firstcancelBtn', function(){
			$(this).parent('td').parent('tr').next('tr').remove();
			$(this).parent('td').parent('tr').remove();
			$('#addPutBtn').click();
			
			// 토탈금액
			let e_sal_sum = 0;
			for(let i = 0; i < $('tbody').find('input[name="e_sal"]').get().length; i++) {
				e_sal_sum += Number($('tbody').find('input[name="e_sal"]').eq(i).val());
			}			
			$('#total_e_sal').text(e_sal_sum);
			
			let sum_야근수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="야근수당"]').get().length; i++) {
				sum_야근수당 += Number($('tbody').find('input[name="야근수당"]').eq(i).val());
			}			
			$('#total_야근수당').text(sum_야근수당);
			
			let sum_초과수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="초과수당"]').get().length; i++) {
				sum_초과수당 += Number($('tbody').find('input[name="초과수당"]').eq(i).val());
			}			
			$('#total_초과수당').text(sum_초과수당);

			let sum_출산보육수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="출산보육수당"]').get().length; i++) {
				sum_출산보육수당 += Number($('tbody').find('input[name="출산보육수당"]').eq(i).val());
			}			
			$('#total_출산보육수당').text(sum_출산보육수당);
			
			let sum_주말근무수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="주말근무수당"]').get().length; i++) {
				sum_주말근무수당 += Number($('tbody').find('input[name="주말근무수당"]').eq(i).val());
			}			
			$('#total_주말근무수당').text(sum_주말근무수당);
			
			let sum_연차수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="연차수당"]').get().length; i++) {
				sum_연차수당 += Number($('tbody').find('input[name="연차수당"]').eq(i).val());
			}			
			$('#total_연차수당').text(sum_연차수당);

			let sum_지급총액 = 0;
			for(let i = 0; i < $('tbody').find('td[id="sumExtrapay"]').get().length; i++) {
				sum_지급총액 += Number($('tbody').find('td[id="sumExtrapay"]').eq(i).text());
			}			
			$('#total_지급총액').text(sum_지급총액);
			
			let sum_건강보험 = 0;
			for(let i = 0; i < $('tbody').find('input[id="건강보험"]').get().length; i++) {
				sum_건강보험 += Number($('tbody').find('input[id="건강보험"]').eq(i).val());
			}			
			$('#total_건강보험').text(sum_건강보험);
			
			let sum_장기요양보험 = 0;
			for(let i = 0; i < $('tbody').find('input[id="장기요양보험"]').get().length; i++) {
				sum_장기요양보험 += Number($('tbody').find('input[id="장기요양보험"]').eq(i).val());
			}			
			$('#total_장기요양보험').text(sum_장기요양보험);
			
			let sum_소득세 = 0;
			for(let i = 0; i < $('tbody').find('input[id="소득세"]').get().length; i++) {
				sum_소득세 += Number($('tbody').find('input[id="소득세"]').eq(i).val());
			}			
			$('#total_소득세').text(sum_소득세);
			
			let sum_지방소득세 = 0;
			for(let i = 0; i < $('tbody').find('input[id="지방소득세"]').get().length; i++) {
				sum_지방소득세 += Number($('tbody').find('input[id="지방소득세"]').eq(i).val());
			}			
			$('#total_지방소득세').text(sum_지방소득세);
			
			let sum_국민연금 = 0;
			for(let i = 0; i < $('tbody').find('input[id="국민연금"]').get().length; i++) {
				sum_국민연금 += Number($('tbody').find('input[id="국민연금"]').eq(i).val());
			}			
			$('#total_국민연금').text(sum_국민연금);
			
			let sum_고용보험 = 0;
			for(let i = 0; i < $('tbody').find('input[id="고용보험"]').get().length; i++) {
				sum_고용보험 += Number($('tbody').find('input[id="고용보험"]').eq(i).val());
			}			
			$('#total_고용보험').text(sum_고용보험);

			let sum_sumDedpay = 0;
			for(let i = 0; i < $('tbody').find('td[id="sumDedpay"]').get().length; i++) {
				sum_sumDedpay += Number($('tbody').find('td[id="sumDedpay"]').eq(i).text());
			}			
			$('#total_sumDedpay').text(sum_sumDedpay);
			
			let sum_totalamount = 0;
			for(let i = 0; i < $('tbody').find('input[id="realSumSal"]').get().length; i++) {
				sum_totalamount += Number($('tbody').find('input[id="realSumSal"]').eq(i).val());
			}			
			$('#totalamount').val(sum_totalamount);
			
		});
		
		// 사원 삭제 버튼
		$('tbody').on('click', '#cancelBtn', function(){
			$(this).parent('td').parent('tr').next('tr').remove();
			$(this).parent('td').parent('tr').remove();
			
			// 토탈금액
			let e_sal_sum = 0;
			for(let i = 0; i < $('tbody').find('input[name="e_sal"]').get().length; i++) {
				e_sal_sum += Number($('tbody').find('input[name="e_sal"]').eq(i).val());
			}			
			$('#total_e_sal').text(e_sal_sum);
			
			let sum_야근수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="야근수당"]').get().length; i++) {
				sum_야근수당 += Number($('tbody').find('input[name="야근수당"]').eq(i).val());
			}			
			$('#total_야근수당').text(sum_야근수당);
			
			let sum_초과수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="초과수당"]').get().length; i++) {
				sum_초과수당 += Number($('tbody').find('input[name="초과수당"]').eq(i).val());
			}			
			$('#total_초과수당').text(sum_초과수당);

			let sum_출산보육수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="출산보육수당"]').get().length; i++) {
				sum_출산보육수당 += Number($('tbody').find('input[name="출산보육수당"]').eq(i).val());
			}			
			$('#total_출산보육수당').text(sum_출산보육수당);
			
			let sum_주말근무수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="주말근무수당"]').get().length; i++) {
				sum_주말근무수당 += Number($('tbody').find('input[name="주말근무수당"]').eq(i).val());
			}			
			$('#total_주말근무수당').text(sum_주말근무수당);
			
			let sum_연차수당 = 0;
			for(let i = 0; i < $('tbody').find('input[name="연차수당"]').get().length; i++) {
				sum_연차수당 += Number($('tbody').find('input[name="연차수당"]').eq(i).val());
			}			
			$('#total_연차수당').text(sum_연차수당);

			let sum_지급총액 = 0;
			for(let i = 0; i < $('tbody').find('td[id="sumExtrapay"]').get().length; i++) {
				sum_지급총액 += Number($('tbody').find('td[id="sumExtrapay"]').eq(i).text());
			}			
			$('#total_지급총액').text(sum_지급총액);
			
			let sum_건강보험 = 0;
			for(let i = 0; i < $('tbody').find('input[id="건강보험"]').get().length; i++) {
				sum_건강보험 += Number($('tbody').find('input[id="건강보험"]').eq(i).val());
			}			
			$('#total_건강보험').text(sum_건강보험);
			
			let sum_장기요양보험 = 0;
			for(let i = 0; i < $('tbody').find('input[id="장기요양보험"]').get().length; i++) {
				sum_장기요양보험 += Number($('tbody').find('input[id="장기요양보험"]').eq(i).val());
			}			
			$('#total_장기요양보험').text(sum_장기요양보험);
			
			let sum_소득세 = 0;
			for(let i = 0; i < $('tbody').find('input[id="소득세"]').get().length; i++) {
				sum_소득세 += Number($('tbody').find('input[id="소득세"]').eq(i).val());
			}			
			$('#total_소득세').text(sum_소득세);
			
			let sum_지방소득세 = 0;
			for(let i = 0; i < $('tbody').find('input[id="지방소득세"]').get().length; i++) {
				sum_지방소득세 += Number($('tbody').find('input[id="지방소득세"]').eq(i).val());
			}			
			$('#total_지방소득세').text(sum_지방소득세);
			
			let sum_국민연금 = 0;
			for(let i = 0; i < $('tbody').find('input[id="국민연금"]').get().length; i++) {
				sum_국민연금 += Number($('tbody').find('input[id="국민연금"]').eq(i).val());
			}			
			$('#total_국민연금').text(sum_국민연금);
			
			let sum_고용보험 = 0;
			for(let i = 0; i < $('tbody').find('input[id="고용보험"]').get().length; i++) {
				sum_고용보험 += Number($('tbody').find('input[id="고용보험"]').eq(i).val());
			}			
			$('#total_고용보험').text(sum_고용보험);

			let sum_sumDedpay = 0;
			for(let i = 0; i < $('tbody').find('td[id="sumDedpay"]').get().length; i++) {
				sum_sumDedpay += Number($('tbody').find('td[id="sumDedpay"]').eq(i).text());
			}			
			$('#total_sumDedpay').text(sum_sumDedpay);
			
			let sum_totalamount = 0;
			for(let i = 0; i < $('tbody').find('input[id="realSumSal"]').get().length; i++) {
				sum_totalamount += Number($('tbody').find('input[id="realSumSal"]').eq(i).val());
			}			
			$('#totalamount').val(sum_totalamount);
			
		});
		
		// 공제 적용하기
		$(document).on('click', 'input[class=dedApply]', function(){
				
			if($(this).parents('tr').find('input[name=e_name]').val() == "직원" || $(this).parents('tr').find('input[name=emp_no]').val() == "사원번호"){
				alert("직원을 먼저 선택하세요");
				return;
			}else{
				if($(this).parents('tr').find('td[id=sumExtrapay]').text() != ""){
					let calc = $(this).parents('td').find('input[id=calc]').val();
					$(this).val(Math.floor($(this).parents('tr').find('td[id=sumExtrapay]').text() * calc));
					
					let sum = 0;
					for (let i = 0; i < $(this).parents('tr').find('input[class="dedApply"]').get().length; i++ ){
						sum += Number($(this).parents('tr').find('input[class="dedApply"]').eq(i).val());
					}
					
					for (let i = 0; i < $(this).parents('tr').next('tr').find('input[class="dedApply"]').get().length; i++ ){
						sum += Number($(this).parents('tr').next('tr').find('input[class="dedApply"]').eq(i).val());
					}
					
					$(this).parents('tr').find('#sumDedpay').text(sum);
					
					let realsal = Number($(this).parents('tr').find('td[id=sumExtrapay]').text()) - Number($(this).parents('tr').find('#sumDedpay').text());
					$(this).parents('tr').find('#realSumSal').val(realsal)
					
				}else{
					let calc = $(this).parents('td').find('input[id=calc]').val();
					$(this).val(Math.floor($(this).parents('tr').prev('tr').find('td[id=sumExtrapay]').text() * calc));
					
					let sum = 0;
					for (let i = 0; i < $(this).parents('tr').find('input[class="dedApply"]').get().length; i++ ){
						sum += Number($(this).parents('tr').find('input[class="dedApply"]').eq(i).val());
					}
					
					for (let i = 0; i < $(this).parents('tr').prev('tr').find('input[class="dedApply"]').get().length; i++ ){
						sum += Number($(this).parents('tr').prev('tr').find('input[class="dedApply"]').eq(i).val());
					}
					
					$(this).parents('tr').prev('tr').find('#sumDedpay').text(sum);
					
					let realsal = Number($(this).parents('tr').prev('tr').find('td[id=sumExtrapay]').text()) - Number($(this).parents('tr').prev('tr').find('#sumDedpay').text());
					$(this).parents('tr').prev('tr').find('#realSumSal').val(realsal)
				}
				
				let sum_건강보험 = 0;
				for(let i = 0; i < $('tbody').find('input[id="건강보험"]').get().length; i++) {
					sum_건강보험 += Number($('tbody').find('input[id="건강보험"]').eq(i).val());
				}			
				$('#total_건강보험').text(sum_건강보험);
				
				let sum_장기요양보험 = 0;
				for(let i = 0; i < $('tbody').find('input[id="장기요양보험"]').get().length; i++) {
					sum_장기요양보험 += Number($('tbody').find('input[id="장기요양보험"]').eq(i).val());
				}			
				$('#total_장기요양보험').text(sum_장기요양보험);
				
				let sum_소득세 = 0;
				for(let i = 0; i < $('tbody').find('input[id="소득세"]').get().length; i++) {
					sum_소득세 += Number($('tbody').find('input[id="소득세"]').eq(i).val());
				}			
				$('#total_소득세').text(sum_소득세);
				
				let sum_지방소득세 = 0;
				for(let i = 0; i < $('tbody').find('input[id="지방소득세"]').get().length; i++) {
					sum_지방소득세 += Number($('tbody').find('input[id="지방소득세"]').eq(i).val());
				}			
				$('#total_지방소득세').text(sum_지방소득세);
				
				let sum_국민연금 = 0;
				for(let i = 0; i < $('tbody').find('input[id="국민연금"]').get().length; i++) {
					sum_국민연금 += Number($('tbody').find('input[id="국민연금"]').eq(i).val());
				}			
				$('#total_국민연금').text(sum_국민연금);
				
				let sum_고용보험 = 0;
				for(let i = 0; i < $('tbody').find('input[id="고용보험"]').get().length; i++) {
					sum_고용보험 += Number($('tbody').find('input[id="고용보험"]').eq(i).val());
				}			
				$('#total_고용보험').text(sum_고용보험);

				let sum_sumDedpay = 0;
				for(let i = 0; i < $('tbody').find('td[id="sumDedpay"]').get().length; i++) {
					sum_sumDedpay += Number($('tbody').find('td[id="sumDedpay"]').eq(i).text());
				}			
				$('#total_sumDedpay').text(sum_sumDedpay);
				
				let sum_totalamount = 0;
				for(let i = 0; i < $('tbody').find('input[id="realSumSal"]').get().length; i++) {
					sum_totalamount += Number($('tbody').find('input[id="realSumSal"]').eq(i).val());
				}			
				$('#totalamount').val(sum_totalamount);
				$(this).next('input').val('o');
				
			}
		});
	}
</script>
<%@ include file="../include/footer_js.jsp" %>
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>