<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="min-height: 800px;">
	<%-- <jsp:include page="/WEB-INF/views/content_header.jsp">
		<jsp:param value="자유게시판" name="subject"/>
		<jsp:param value="등록" name="item"/>
	</jsp:include> --%>
	
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: 950px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">글등록</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="registBtn" >등 록</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="regist.do" name="registForm">
							<div class="form-group">
								<label for="pc_no">공정 번호</label>
								<input type="text" id="pc_no" name="pc_no" class="form-control" placeholder="제목을 입력하세요.">
							</div>
							<div class="form-group">
								<label for="pc_name">공정 이름</label>
								<input type="text" id="pc_name" name="pc_name" class="form-control" value="">
							</div>
							<div class="form-group">
								<label for="pc_order">공정순번</label>
								<textarea class="textarea" name="pc_order" id="pc_order" rows="10" placeholder="1000자 내외로 작성하세요." style="display: block; width: 100%"></textarea>
							</div>
						</form>
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
			
			if($('#pc_no').val() == "") {
				alert("제목을 입력하시게..");
				return;
			}
			
			if($('#pc_order').length > 1000){
				alert("글자수가 100자를 초과할 수 없습니다.");
				return;
			}
			
			form.submit();
		});
		
		// 취소버튼 클릭
		$('#cancelBtn').on('click', function() {
			window.opener.location.href="list.do" 	// 윈도우 창을 띄운 부모 페이지를 list.do로 향하게 한다.
			window.close();							// 윈도우 창을 닫는다.
		});
	}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>