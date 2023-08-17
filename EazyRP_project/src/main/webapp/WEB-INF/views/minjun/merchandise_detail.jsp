<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="height: 50px"></div>
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: 600px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">상품 상세보기</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="modifyBtn">수 정</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-danger" id="deleteBtn">삭 제</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="modifyMerchandise.do" name="registForm">
							<input type="hidden" value="${merchandise.SP_NO }" name="sp_no" >
							<div class="form-group col-sm-12 row">
								<label for="s_name" class="col-sm-3">쇼핑몰 이름</label>
								<input type="text" id="shname" name="s_name" class="form-control col-sm-9 s_name mch1" value="${merchandise.S_NAME}" placeholder="쇼핑몰코드를 입력하세요." readonly style="background-color: white;">
								<input type="hidden" id="s_no_receiver" name="s_no" value="${merchandise.S_NO}">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="pr_name" class="col-sm-3">제품 이름</label>
								<input type="text" id="name" name="pr_name" class="form-control col-sm-9 pr_no mch2" value="${merchandise.PR_NAME}" placeholder="제품이름을 입력하세요." readonly style="background-color: white;">
								<input type="hidden" id="pr_no_receiver" name="pr_no" value="${merchandise.PR_NO}">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="sp_q" class="col-sm-3">수량</label>
								<input type="text" id="sp_q" name="sp_q" class="form-control col-sm-9 mch3" value="${merchandise.SP_Q}" placeholder="수량을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="price" class="col-sm-3">판매가격</label>
								<input type="text" id="price" name="price" class="form-control col-sm-9 mch4" value="${merchandise.PRICE}" placeholder="판매가격을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="unitprice" class="col-sm-3">단가</label>
								<input type="text" id="unitprice" name="unitprice" readonly class="form-control col-sm-9 pr_inprice_receiver" value="${merchandise.UNITPRICE}" placeholder="단가를 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="status" class="col-sm-3">판매상태</label>
								<div class="col-sm" style="padding-left:0px; padding-right:0px;">
									<select name="status" class="form-select mch5" id="status">
										<option value="판매중">판매중</option>
										<option value="판매중지">판매중지</option>
									</select>
								</div>
<%-- 								<input type="text" id="status" name="status" class="form-control col-sm-9 mch5" value="${merchandise.STATUS}" placeholder="판매상태를 입력하세요."> --%>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="stperiod" class="col-sm-3">판매시작일</label>
								<c:set var="startperiod">
									<fmt:formatDate value="${merchandise.STARTPERIOD }" pattern="yyyy-MM-dd"></fmt:formatDate>
								</c:set>
								<input type="date" id="stperiod" name="startperiod" class="form-control col-sm-9 mch6" value="${startperiod }" placeholder="판매시작일을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="endperiod" class="col-sm-3">판매종료일</label>
								<c:set var="endperiod">
									<fmt:formatDate value="${merchandise.ENDPERIOD }" pattern="yyyy-MM-dd"></fmt:formatDate>
								</c:set>
								<input type="date" id="endperiod" name="endperiod" readonly class="form-control col-sm-9 " value="${endperiod }" placeholder="판매종료일을 입력하세요.">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

<script>
	window.onload = function(){
		/* SmartEditor_summernote($('#content')); */

		let form = $('form[role="form"]');
		
		let status = "${merchandise.STATUS}";
		$('#status').val(status);
		
		
		let sp_no = $('input[name="sp_no"]').val();
		let test = opener.$('td').attr('id', sp_no).text();
		if( $('td[id="progress"]', opener.document).text() == '배송완료'){
			$('input').prop('disabled', true);
			$('select').prop('disabled', true);
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
			if($('.mch5').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch6').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			form.submit();
		});
		
		// 삭제버튼 클릭
		$('#deleteBtn').on('click', function(){
			
			if(confirm("삭제하시겠습니까?")){
				form.attr({
					'action' : 'deleteShop.do',
					'method' : 'post'
				});
				form.submit();
			}
		});
		
		// 취소버튼 클릭
		$('#cancelBtn').on('click', function() {
			window.opener.location.reload(true);
			window.close();
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


	$(document).on('click', '.pr_no', function(){
		
		let openWin = OpenWindow("/erp5/findProduct.do", "제품 찾기", 700, 500);
		
	});
	
	$(document).on('click', '.s_name', function(){
		
		let openWin = OpenWindow("/erp5/findShop.do", "쇼핑몰 찾기", 500, 500);
		
	});
}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>