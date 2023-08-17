<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="min-height: 800px;">
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10" style="max-width: 950px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">주문 상세보기</h3>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="modifyOrder.do" name="registForm">
							<div class="form-group col-sm-12 row">
								<label for="sp_no" class="col-sm-2">상품 이름</label>
								<input type="text" id="name" name="sp_name" class="form-control col-sm-3 pr_name mch1" value="${order.PR_NAME }" placeholder="상품이름을 입력하세요." readonly >
								<input type="hidden" id="sp_no_receiver" name="sp_no" value="${order.SP_NO }">
								<div class="col-sm-1"></div>
								<label for="so_no" class="col-sm-2">주문 번호</label>
								<input type="text" id="so_no" name="so_no" class="form-control col-sm-4" value="${order.SO_NO }" placeholder="주문번호는 자동으로 입력됩니다." readonly >
								<input type="hidden" id="" name="" value="">
							</div>
							<div class="form-group col-sm-12 row " >
								<label for="reciever" class="col-sm-2">수취인 이름</label>
								<input type="text" id="reciever" name="reciever" class="form-control col-sm-3 mch2" value="${order.RECIEVER }" placeholder="수취인이름을 입력하세요.">
								<div class="col-sm-1"></div>
								<label for="tel" class="col-sm-2">수취인 연락처</label>
								<input type="text" id="tel" name="tel" class="form-control col-sm-4 mch3" value="${order.TEL }" placeholder="수취인연락처를 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="addr" class="col-sm-2">주소</label>
								<input type="text" id="addr" name="addr" class="form-control col-sm-10 mch4" value="${order.ADDR }" placeholder="주소를 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="quantity" class="col-sm-2">주문수량</label>
								<input type="text" id="quantity" name="quantity" class="form-control col-sm-3 mch5" value="${order.QUANTITY }" placeholder="주문수량을 입력하세요.">
<!-- 								<input type="hidden" id="udtqtt" name="udtqtt" value=""> -->
<!-- 								<input type="hidden" id="orginqtt" name="orginqtt" value=""> -->
								<div class="col-sm-1"></div>
								<label for="oddate" class="col-sm-2">주문일</label>
								<c:set var="orderdate">
									<fmt:formatDate value="${order.ORDERDATE }" pattern="yyyy-MM-dd"></fmt:formatDate>
								</c:set>
								<input type="date" id="orderdate" name="orderdate" class="form-control col-sm-4 mch6" value="${orderdate }" placeholder="주문일을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="method" class="col-sm-2">배송방법</label>
								<input type="text" id="method" name="method" class="form-control col-sm-3 mch7" value="${order.METHOD }" placeholder="배송방법을 입력하세요.">
								<div class="col-sm-1"></div>
								<label for="invoice" class="col-sm-2">송장번호</label>
								<input type="text" id="invoice" name="invoice" class="form-control col-sm-4 mch8" value="${order.INVOICE }" placeholder="송장번호를 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="request" class="col-sm-2">배송요청사항</label>
								<textarea rows="2" id="request" name="request" class="form-control col-sm-10" placeholder="배송요청사항을 입력하세요.">${order.REQUEST }</textarea>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="delfee" class="col-sm-2">배송비</label>
								<input type="text" id="delfee" name="delfee" class="form-control col-sm-3" value="${order.DELFEE }" placeholder="배송비를 입력하세요.">
								<div class="col-sm-1"></div>
								<label for="progress" class="col-sm-2">진행상태</label>
								<select name="progress" class="form-select col-sm-4" id="progress">
								<c:if test="${order.PROGRESS eq '주문접수중' || order.PROGRESS eq '주문취소' || order.PROGRESS eq '배송중'}">
									<option value="주문접수중">주문접수중</option>
									<option value="주문취소">주문취소</option>
									<option value="배송중">배송중</option>
									<option value="배송완료">배송완료</option>
								</c:if>
								<c:if test="${order.PROGRESS eq '배송완료'}" >
									<option value="배송완료">배송완료</option>
									<option value="반품">반품</option>
								</c:if>
								<c:if test="${order.PROGRESS eq '반품'}">
									<option value="반품">반품된 주문입니다.</option>
								</c:if>
								</select>
								<input type="hidden" value="${order.PROGRESS}" name="oldprogress">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="delstartdate" class="col-sm-2">배송시작일</label>
								<c:set var="delstdate">
									<fmt:formatDate value="${order.DELSTARTDATE }" pattern="yyyy-MM-dd"></fmt:formatDate>
								</c:set>
								<input type="date" id="delstartdate" name="delstartdate" class="form-control col-sm-3 mch9" value="${delstdate }" placeholder="배송시작일을 입력하세요.">
								<div class="col-sm-1"></div>
								<label for="delenddate" class="col-sm-2">배송완료일</label>
								<c:set var="delenddate">
									<fmt:formatDate value="${order.DELENDDATE }" pattern="yyyy-MM-dd"></fmt:formatDate>
								</c:set>
								<input type="date" id="delenddate" name="delenddate" class="form-control col-sm-4 " value="${delenddate }" placeholder="배송종료일을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="failure" class="col-sm-2">반품사유</label>
								<textarea rows="2" id="failure" name="failure" class="form-control col-sm-6" placeholder="반품사유를 입력하세요.">${order.FAILURE }</textarea>
<!-- 								<label for="gb" class="col-sm-2">상태구분</label> -->
<!-- 								<select name="gb" class="form-select col-sm-2"> -->
<!-- 									<option value="없음">없음</option> -->
<!-- 									<option value="취소">취소</option> -->
<!-- 									<option value="반품">반품</option> -->
<!-- 								</select> -->
							</div>
						</form>
					</div>
					<div class="card-footer card-tools">
						<c:if test="${order.PROGRESS ne '반품'}">
						<button type="button" class="btn btn-primary" id="modifyBtn" >수 정</button>
						</c:if>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script>
	window.onload = function(){

		let form = $('form[role="form"]');
		
		let progress = "${order.PROGRESS }";
		$('#progress').val(progress);
		
		if($('#progress').val() == '반품'){
			$('input').prop('readonly', true);
			$('textarea').prop('readonly', true);
			$('select').prop('disabled', true);
		}else if($('#progress').val() == '배송완료'){
			$('input').prop('readonly', true);
			$('textarea').prop('readonly', true);
		}else if($('#progress').val() == '배송중'){
			$('input').prop('readonly', true);
			$('textarea').prop('readonly', true);
		}
		
		// 수정버튼 클릭
		$('#modifyBtn').on('click', function() {
			
			if($('.mch1').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch2').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch3').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch4').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch5').val() == "" || $('.mch5').val() == 0) {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch6').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch7').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch8').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch9').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			
			form.submit();
		});
		
		// 취소버튼 클릭
		$('#cancelBtn').on('click', function() {
			window.opener.location.reload(true);
			window.close();						// 윈도우 창을 닫는다.
		});
		

		function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
			winleft = (screen.width - WinWidth) / 2;
			wintop = (screen.height - WinHeight) / 2;
			var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
									+ "height=" + WinHeight + ",top="+ wintop + ",left="
									+ winleft + ",resizable=yes,status=yes");
			win.focus();
			return win;
		};

		if($('#progress').val() == '배송중' || $('#progress').val() == '배송완료' || $('#progress').val() == '반품'){
			$('#quantity').attr("readonly", true);
		}
		
// 		$(document).on('click', '.pr_name', function(){
// 			let openWin = OpenWindow("/erp5/findMerchandise.do", "제품 찾기", 800, 600);
			
// 		});
		
	}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>