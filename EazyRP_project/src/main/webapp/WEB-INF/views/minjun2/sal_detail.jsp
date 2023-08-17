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
							<div class="card-header d-flex justify-content-center">
								<h2><input type="month" id="salmonth" name="salmonth" style="width: 400px;" readonly value="<fmt:formatDate value="${sal.SALMONTH }" pattern="yyyy-MM"/>"></h2>
								<div class="d-flex" style="vertical-align:center; margin-left: auto; align-content: center; align-items: center;">
									<label for="saldate" class="" style="vertical-align:center;  float:right; text-align: center; margin-bottom: 0px; align-content: center;">지급일</label>
									<input class="" type="date" id="saldate" name="saldate" style="width: 120px;" readonly value="<fmt:formatDate value="${sal.SALDATE }" pattern="yyyy-MM-dd"/>">
								</div>
								<div class="d-flex" style="vertical-align:center; align-content: center; align-items: center; font-weight:bold;">
									${sal.PAYMENTSTATUS eq "지급완료" ? '지급완료' : "미지급" }
								</div>
								<input type="hidden" value="${sal.SAL_NO }" name="sal_no_a">
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
								<c:forEach items="${saldetail }" var="detail" varStatus="loop">
									<tr>
										<td><input type="text" id="e_name0" name="e_name" value="${detail.E_NAME }" style="" readonly></td>
										<td><input type="text"  id="dname0" name="dname" value="${detail.DNAME }" style="" readonly></td>
										<td ><input type="text"  id="e_sal0" name="e_sal" value="${detail.E_SAL }" class="sumpay" style="" readonly></td>
										<c:forEach items="${extrapayList }" begin="0" end="2" var="exp" varStatus="loop2">
												<c:set var="epname">${exp.EP_NAME }</c:set>
												<c:set var="i">${loop.index }</c:set>
												<c:set var="calepname"></c:set>
												<c:set var="sumExtrapay">0</c:set>
												<c:forEach items="${CalcExtrapayList[i] }" var="calexp" varStatus="status">
													<c:set var="sumExtrapay">${sumExtrapay + calexp.EXTRAPAY }</c:set>
													<c:if test="${calexp.EP_NO eq exp.EP_NO}">
														<c:set var="calepname">${calexp.EP_NO }</c:set>
														<c:set var="expay">${calexp.EXTRAPAY }</c:set>
													</c:if>
												</c:forEach>
											<td style="width: 8%">
												<input type="text"  id="ep_name0" name="${exp.EP_NAME }" class="sumpay" value="${calepname != '' ? expay : ''}" style="" readonly>
												<input type="hidden" id="${exp.EP_NO }" name="${exp.EP_NO }" value="${exp.EP_NO }">
												<input type="hidden" id="calc" name="calc" value="${exp.CALC }">
											</td>
										</c:forEach>
										<td id="sumExtrapay" rowspan="2" style="vertical-align: middle;">${sumExtrapay + detail.E_SAL }</td>
										<c:forEach items="${deductionList }" begin="0" end="2" var="ded" varStatus="loop3">
										<c:set var="no">${ded.DED_NO }</c:set>
										<c:set var="dedcal">
											<fmt:formatNumber groupingUsed="false" type="number" maxFractionDigits="0"  value="${(sumExtrapay + detail.E_SAL) * ded.CALC }"/>										
										</c:set>
										<td style="width: 8%">
											<input type="text"  id="${ded.DED_NAME}" name="ded_name" class="dedApply" value="${detail[no] eq 'o' ? dedcal : '' }" style="" readonly>
											<input type="hidden" id="ded_no" name="ded_no" value="${ded.DED_NO }">
											<input type="hidden" id="calc" name="calc" value="${ded.CALC }">
										</td>
										</c:forEach>
										<c:set var="sumdedpay">0</c:set>
										<c:forEach items="${deductionList }" var="ded">
											<c:set var="no">${ded.DED_NO }</c:set>
											<c:set var="fmtnum">0</c:set>
											<c:if test="${detail[no] eq 'o'}">
												<c:set var="fmtnum">
													<fmt:formatNumber groupingUsed="false" type="number" maxFractionDigits="0"  value="${(sumExtrapay + detail.E_SAL) * ded.CALC }"/>
												</c:set>
											<c:set var="sumdedpay">
												${sumdedpay + fmtnum }
											</c:set>
											</c:if>
										</c:forEach>
										<td rowspan="2" style="vertical-align: middle;" class="dedpay" id="sumDedpay">${sumdedpay }</td>
										<td rowspan="2" style="vertical-align: middle;"><input type="text"  id="realSumSal" name="realsumsal" value="${sumExtrapay + detail.E_SAL - sumdedpay}" style="" readonly></td>
									</tr>
									<tr>
										<td><input type="text"  id="emp_no0" name="emp_no" value="${detail.EMP_NO }" style="" readonly></td>
										<td><input type="text"  id="e_rank0" name="e_rank" value="${detail.E_RANK }" style="" readonly></td>
										<td></td>
										<c:forEach items="${extrapayList }" begin="3" end="5" var="exp" varStatus="loop2">
											<c:set var="epname">${exp.EP_NAME }</c:set>
											<c:set var="i">${loop.index }</c:set>
											<c:set var="calepname"></c:set>
											<c:forEach items="${CalcExtrapayList[i] }" var="calexp" varStatus="status">
												<c:if test="${calexp.EP_NO eq exp.EP_NO}">
													<c:set var="calepname">${calexp.EP_NO }</c:set>
													<c:set var="expay">${calexp.EXTRAPAY }</c:set>
												</c:if>
											</c:forEach>
											<td style="width: 7%">
												<input type="text"  id="ep_name0" name="${exp.EP_NAME }" class="sumpay" value="${calepname != '' ? expay : ''}" style="" readonly>
												<input type="hidden" id="${exp.EP_NO }" name="${exp.EP_NO }" value="${exp.EP_NO }">
												<input type="hidden" id="calc" name="calc" value="${exp.CALC }">
											</td>
										</c:forEach>
										<td></td>
										<c:forEach items="${deductionList }" begin="3" end="5" var="ded" varStatus="loop3">
										<c:set var="no">${ded.DED_NO }</c:set>
										<c:set var="dedcal">
											<fmt:formatNumber groupingUsed="false" type="number" maxFractionDigits="0"  value="${(sumExtrapay + detail.E_SAL) * ded.CALC }"/>										
										</c:set>
										<td style="width: 8%">
											<input type="text"  id="${ded.DED_NAME}" name="ded_name" class="dedApply" value="${detail[no] eq 'o' ? dedcal : '' }" style="" readonly>
											<input type="hidden" id="ded_no" name="ded_no" value="${ded.DED_NO }">
											<input type="hidden" id="calc" name="calc" value="${ded.CALC }">
										</td>
										</c:forEach>
									</tr>
								</c:forEach>
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
						</form>
					</div>
					<div class="card-footer card-tools">
						<button type="button" class="btn btn-danger" id="deleteBtn">삭 제</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script>
	window.onload = function() {
		// 토탈금액 계산
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
		
		let form = $('form[role="form"]');
		
//--------------------------------------------------------------------------------------------------------------------------
		
		// 수정버튼 클릭
		$('#modifyBtn').on('click', function() {
			if (confirm("수정하시겠습니까?")) {

				form.attr({
					'action' : 'modifySal.do',
					'method' : 'post'
				});

				form.submit();
			}
			;
		});

		// 취소버튼 클릭
		$('#cancelBtn').on('click', function() {
			window.opener.location.reload(true);
			window.close(); // 윈도우 창을 닫는다.
		});

		// 삭제버튼 클릭
		$('#deleteBtn').on('click', function() {
			if (confirm("정말 삭제하시겠습니까?")) {

				form.attr({
					'action' : 'deleteSal.do',
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
		};
		
	}
</script>
<%@ include file="../include/footer_js.jsp" %>
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>