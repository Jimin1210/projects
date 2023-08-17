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
						<h3 class="card-title p-1">거래처 수정/삭제</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="modifyBtn">수 정</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-danger" id="deleteBtn">삭 제</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="modifyContact.do" name="detailForm">
							<input type="hidden" value="${contact.C_NO }" name="c_no" >
							<input type="hidden" value="${contact.ACCOUNT }" name="account" >
							<div class="form-group col-sm-12 row">
								<label for="c_name" class="col-sm-3">업체명</label>
								<input type="text" id="c_name" name="c_name" class="form-control col-sm-9 c_name mch1" value="${contact.C_NAME }" style="background-color: white;">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="c_rname" class="col-sm-3">대표자 명</label>
								<input type="text" id="c_rname" name="c_rname" class="form-control col-sm-9 c_rname mch2" value="${contact.C_RNAME}" style="background-color: white;">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="c_tel" class="col-sm-3">전화번호</label>
								<input type="text" id="c_tel" name="c_tel" class="form-control col-sm-9 mch3" value="${contact.C_TEL}" >
							</div>
							<div class="form-group col-sm-12 row">
								<label for="c_phone" class="col-sm-3">핸드폰번호</label>
								<input type="text" id="c_phone" name="c_phone" class="form-control col-sm-9 mch4" value="${contact.C_PHONE }">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="keyword" class="col-sm-3">취급품목</label>
								<input type="text" id="keyword" name="keyword" class="form-control col-sm-9 mch4" value="${contact.KEYWORD}">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="account" class="col-sm-3">거래 계좌</label>
								<input type="text" id="account" name="acc" class="form-control col-sm-9 mch4" value="${contact.ACC}">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="addr" class="col-sm-3">주 소</label>
								<input type="text" id="addr" name="addr" class="form-control col-sm-9 mch4" value="${contact.ADDR}">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

<script>
	window.onload = function(){

		let form = $('form[role="form"]');

		
		// 수정버튼 클릭
		$('#modifyBtn').on('click', function() {
			
			for(let i = 0; i < $('input[type="text"]').get().length; i++){
				if($('input[type="text"]').eq(i).val() == "" || $('input[type="text"]').eq(i).val() == null) {
					alert("값을 입력해 주세요.");
					return;
				}
			}
			
			form.submit();
		});
		
		// 삭제버튼 클릭
		$('#deleteBtn').on('click', function(){
			
			if(confirm("삭제하시겠습니까?")){
				form.attr({
					'action' : 'deleteContact.do',
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

}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>