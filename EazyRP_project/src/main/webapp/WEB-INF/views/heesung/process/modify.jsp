<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<div style="min-width: 420px; min-height: 800px; margin: 0 auto;">
	
	<section class="content container-fluid">
		<div class="row">	<!-- row Start -->
			<div class="col-md-12">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title">공정 수정하기</h3>
					</div>
					<form role="form" method="post" action="modify.do" name="modifyForm">
						<div class="card-body" style="padding-bottom:0">	<!-- card body Start -->
							<div class="form-group col-sm-12 row">
								<label for="title" class="col-sm-2">코드</label>
								<input type="text" class="form-control col-sm-10" id="pc_code" name="pc_code" value="${process.pc_code }">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="writer" class="col-sm-2">공정명</label>
								<input type="text" class="form-control col-sm-10" id="pc_name" name="pc_name" value="${process.pc_name }">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="regdate" class="col-sm-2">순번</label>
								<input type="text" class="form-control col-sm-10" id="pc_order" name="pc_order" value="${process.pc_order }">
							</div>
						</div>	<!-- card body End -->
					</form>
					<div class="card-footer">
						<button type="button" id="modifyBtn" class="btn btn-warning">수정 완료</button>
						<button type="button" id="cancelBtn" class="btn btn-primary">취소</button>
					</div>	<!-- card footer End -->
				</div>
			</div>
		</div>	<!-- row End -->
	</section>
</div>

<form role="form">
	<input type="hidden" name="pc_code" value="${process.pc_code }">
</form>

<script>
	window.onload = function(){
		
		$('#modifyBtn').on('click', function() {
			let code = $('input[name="pc_code"]');
			if (code.val() == '') {
				alert("공정 코드는 필수입니다.");
				code.focus();
				return;
			};
			$('form[name="modifyForm"]').submit();
		});
		
		// 취소버튼 클릭
		$('#cancelBtn').on('click', function() {
			history.go(-1);
		});
	}
</script>

<%-- <%@ include file="/WEB-INF/views/common/summernote.jsp" %> --%>