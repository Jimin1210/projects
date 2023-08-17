<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div style="margin: 1em;">
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: ;">
				<div class="card card-outline card-info">
					
					<div class="card-header">
						<h3 class="card-title p-1">공정 등록</h3>
					</div>
					
					<div class="card-body pad">
						<form role="form" method="post" action="regist.do" name="registForm">
							<div class="form-group col-sm-12 row">
								<label for="sp_no" class="col-sm-3">공정 코드</label>
								<input type="text" id="pc_code" name="pc_code" class="form-control col-sm-9" placeholder="코드는 자동으로 입력됩니다." readonly>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="s_name" class="col-sm-3">공정명</label>
								<input type="text" id="pc_name" name="pc_name" class="form-control col-sm-9" value="" placeholder="공정명을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="pc_order" class="col-sm-3">순번</label>
								<input type="text" id="pc_order" name="pc_order" class="form-control col-sm-9" value="" placeholder="순번을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="pc_content" class="col-sm-3">내용</label>
								<input type="text" id="pc_content" name="pc_content" class="form-control col-sm-9" value="" placeholder="해당 공정에 대한 내용을 20자 이내로 입력하세요.">
							</div>
						</form>
					</div>
					
					<div class="card-footer card-tools">
						<button type="button" class="btn btn-primary" id="registBtn" >등 록</button>
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
		
		// 등록버튼 클릭
		$('#registBtn').on('click', function() {
			
			let form = $('form[role="form"]');
			
			if ($('#pc_name').val() == "") {
				
				alert("공정명을 입력하세요.");
				$('#pc_name').focus();
				return;
				
			} else if ($('#pc_order').val() == "") {
				
				alert("순번을 입력하세요.");
				$('#pc_order').focus();
				return;
				
			} else if ($('#pc_content').val() == "") {
				
				alert("내용을 입력하세요.");
				$('#pc_content').focus();
				return;
				
			} else {
				
				form.submit();
			
			}
			
		});
		
		// 취소버튼 클릭
		$('#cancelBtn').on('click', function() {
			window.close();							// 윈도우 창을 닫는다.
		});
		
	}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>