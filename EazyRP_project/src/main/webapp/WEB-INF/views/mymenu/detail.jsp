<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<meta charset="UTF-8">
<title>쪽지보기</title>
<style>
	#downloadBtn{
		width : 150px;
	}
</style>
</head>
<body>
<div style="min-width: 420px; min-height: 800px; margin: 0 auto;">
	<section class="content container-fluid">
		<div class="row">	<!-- row Start -->
			<div class="col-md-12">
				<div class="card card-outline card-info">
					<div class="card-header">
						<label for="title">쪽지 확인</label>
					</div>
					<div class="card-body">	<!-- card body Start -->
						<div class="form-group col-sm-12">
							<label for="title">제 목</label>
							<input type="text" class="form-control" id="title" value="${note.title }" readonly style="background-color : white;">
						</div>
						<div class="row" style="align-items: center; justify-content: space-evenly;">
							<div class="form-group col-sm-3">
								<label for="writer">보낸 사람</label>
								<input type="text" style="background-color : white;" class="form-control" id="writer" value="${note.callerName }" readonly>
							</div>
							<div class="form-group col-sm-4">
								<label for="regdate">보낸 날짜</label>
								<input type="text" class="form-control" style="background-color : white;" id="regdate" 
									value="${note.senddate }" readonly>
							</div>
							<div class="form-group col-sm-4">
								<label for="viewcnt">업체명</label>
								<input type="text" class="form-control" style="background-color : white;" id="viewcnt" value="${note.c_cname }" readonly>
							</div>
						</div>
						<div class="form-group col-sm-12">
							<label for="content">내 용</label>
							<div style="background-color: white; border: 1px solid #afafaf; border-radius: 5px; min-height: 100px;">
								<div id="content">${note.con }</div>
							</div>

						</div>
						<div class="form-group col-sm-12">
							<div class="card card-outline card-success">
								<div class="card-header">
								</div>
								<div class="card-footer">
									<div class="row">
									<p>첨부파일 :</p> 
											<div class="info-box" style="align-self: center;">
												<div class="info-box-content" style="display: flex; justify-content: center; align-items: center;">
													<span class="info-box-number" style="display: inline;">${note.realFileName}</span>
													${note.realFileName != null ? "<button type='button' id='downloadBtn' class='btn btn-primary'>다운로드</button>" : "없음"}
												</div>
											</div>
									</div>
								</div>
							</div>
						</div>
					</div>	<!-- card body End -->
					<div class="card-footer">
						<c:if test="${send eq 'N'}">
							<button type="button" id="replyBtn" class="btn btn-warning">답장하기</button>
							<button type="button" id="deleteBtn" class="btn btn-danger">삭제하기</button>
						</c:if>
						<button type="button" id="cancelBtn" class="btn btn-primary">닫기</button>
					</div>	<!-- card footer End -->
				</div>
			</div>
		</div>	<!-- row End -->
	</section>
	
</div>
<form action ="" method="post" id="submitForm">
	<input type="hidden" name="n_no" value="${note.n_no}">
	<input type="hidden" name="caller" value="${note.caller }">
	<input type="hidden" name="callerName" value="${note.callerName }">
	<input type="hidden" name="files" value="${note.files }">
</form>
</body>
</html>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script>
	$('#cancelBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	})
	$('#deleteBtn').on('click', function(){
		if(confirm("정말로 삭제하시겠습니까?")){
			$('#submitForm').attr('action', '/mymenu/deleteNote.do');
			$('#submitForm').submit();
		}
	});
	$('#replyBtn').on('click', function(){
		$('#submitForm').attr('action', '/mymenu/replyNote.do');
		$('#submitForm').submit();
	});
	$('#downloadBtn').on('click', function(){
		if(confirm("다운로드하시겠습니까?")){
			$('#submitForm').attr('action', '/mymenu/download.do');
			$('#submitForm').submit();
		}
	});
</script>