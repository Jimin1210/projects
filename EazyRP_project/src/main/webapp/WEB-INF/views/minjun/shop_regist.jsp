<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="min-height: ;">
	<%-- <jsp:include page="/WEB-INF/views/content_header.jsp">
		<jsp:param value="자유게시판" name="subject"/>
		<jsp:param value="등록" name="item"/>
	</jsp:include> --%>
	
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: ;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">쇼핑몰 등록</h3>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="insertShop.do" name="registForm">
							<div class="form-group col-sm-12 row">
								<label for="sp_no" class="col-sm-3">쇼핑몰 코드</label>
								<input type="text" id="sp_no" name="sp_no" class="form-control col-sm-9" placeholder="쇼핑몰코드는 자동으로 입력됩니다." readonly>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="s_name" class="col-sm-3">쇼핑몰 이름</label>
								<input type="text" id="s_name" name="s_name" class="form-control col-sm-9" value="" placeholder="쇼핑몰명을 입력하세요.">
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
		/* SmartEditor_summernote($('#content')); */
		
		// 등록버튼 클릭
		$('#registBtn').on('click', function() {
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
	}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>