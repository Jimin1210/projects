<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="min-height: ;">
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: ;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">쇼핑몰 상세보기</h3>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="modifyShop.do" name="registForm">
							<div class="form-group col-sm-12 row">
								<label for="sp_no" class="col-sm-3">쇼핑몰 코드</label>
								<input type="text" id="s_no" name="s_no" class="form-control col-sm-9"  value="${shop.S_NO}" readonly>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="s_name" class="col-sm-3">쇼핑몰 이름</label>
								<input type="text" id="s_name" name="s_name" class="form-control col-sm-9" value="${shop.S_NAME}" placeholder="쇼핑몰명을 입력하세요.">
							</div>
						</form>
					</div>
					<div class="card-footer card-tools">
						<button type="button" class="btn btn-primary" id="modifyBtn" >수 정</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-danger" id="deleteBtn" >삭 제</button>
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
		/* SmartEditor_summernote($('#content')); */
		
		let form = $('form[role="form"]');
		
		// 수정버튼 클릭
		$('#modifyBtn').on('click', function() {
			let form = $('form[role="form"]');
			
			if($('#s_name').val() == "") {
				alert("쇼핑몰 이름을 입력하세요");
				return;
			}
			
			form.submit();
		});
		
		// 취소버튼 클릭
		$('#cancelBtn').on('click', function() {
			window.opener.location.reload(true); 	
			window.close();							
		});
		
		// 삭제버튼 클릭
		$('#deleteBtn').on('click', function(){
			
			if(confirm("쇼핑몰에 있는 상품까지 모두 삭제됩니다. 삭제하시겠습니까?")){
				form.attr({
					'action' : 'deleteShop.do',
					'method' : 'post'
				});
				form.submit();
			}
		});
	}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>