<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div style="min-width: 500px; min-height: 300px; margin: 0 auto;">
	<section class="content container-fluid">
		<div class="row">	<!-- row Start -->
			<div class="col-md-12">
				<div class="card card-outline card-info">
					<div class="card-header">
						<label for="title">반려 사유 작성</label>
					</div>
					<div class="card-body">	<!-- card body Start -->
						
						<div class="form-group col-sm-12">
							<label for="content">반려 사유</label>
							<form id="submitForm" action="/management/failForm.do" method="post">
							<input type="hidden" name="dr_no" value="${dr_no }">
							<input type="hidden" name="pl_progress" value="${pl_progress }">
							<textarea class="textarea" name="failComment" id="con" rows="10" 
									placeholder="사유를 작성하세요." style="display: block; width:100%;"></textarea>
							</form>
						</div>
					</div>	<!-- card body End -->
					<div class="card-footer">
						<button type="button" id="failBtn" class="btn btn-danger">반려 진행</button>
						<button type="button" id="cancelBtn" class="btn btn-primary">반려 취소</button>
					</div>	<!-- card footer End -->
				</div>
			</div>
		</div>	<!-- row End -->
	</section>
	
</div>
</body>
</html>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script>
	$('#cancelBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	})
	
	$('#failBtn').on('click', function(){
		$('#submitForm').submit();
	});
</script>