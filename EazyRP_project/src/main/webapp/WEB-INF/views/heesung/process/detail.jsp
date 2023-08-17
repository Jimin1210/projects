<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

<div style="min-height: ;">
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: ;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">공정 상세보기</h3>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" name="detail">
							<div class="form-group col-sm-12 row">
								<label for="title" class="col-sm-3">코드</label>
								<input type="text" class="col-sm-9 form-control" id="pc_code" name="pc_code" value="${process.pc_code }" readonly>
							</div>
							
							<div class="form-group col-sm-12 row">
								<label for="writer" class="col-sm-3">공정명</label>
								<input type="text" class="col-sm-9 form-control" id="pc_name" name="pc_name" value="${process.pc_name }">
							</div>
							
							<div class="form-group col-sm-12 row">
								<label for="regdate" class="col-sm-3">순번</label>
								<input type="text" class="col-sm-9 form-control" id="pc_order" name="pc_order" value="${process.pc_order }">
							</div>
							
							<div class="form-group col-sm-12 row">
								<label for="regdate" class="col-sm-3">내용</label>
								<input type="text" class="col-sm-9 form-control" id="pc_content" name="pc_content" value="${process.pc_content }">
							</div>
						</form>
					</div>
					<div class="card-footer card-tools">
						<button type="submit" class="btn btn-primary" id="modifyBtn">수 정</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-danger" id="removeBtn">삭 제</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-warning" id="closeBtn">닫 기</button>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<!-- <form role="form"> -->
<%-- 	<input type="hidden" name="pc_code" value="${process.pc_code }"> --%>
<!-- </form> -->

<script>
window.onload = function(){

	let formObj = $('form[role="form"]');
	
	// 수정 버튼 클릭
	$('button#modifyBtn').on('click', function(){
		
		formObj.attr({
			'action' : 'modify.do',
			'method' : 'post' 
		});
		
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
		
			if (confirm("해당 내용으로 수정하시겠습니까?")) {
				
				formObj.submit();
			
			}
			
		}
	
	});
	
	// 삭제 버튼 클릭
	$('button#removeBtn').on('click', function(){
	
		let formObj = $('form[role="form"]');
		
		if(confirm("정말 삭제하시겠습니까?")){
		
			formObj.attr({
				'action' : 'remove.do',
				'method' : 'post' 
			});
			
			formObj.submit();
		
		};
	
	});
	
	// 닫기 버튼 클릭
	$('button#closeBtn').on('click', function() {
		window.close();							
	});
	
}
</script>

<%-- <%@ include file="reply_js.jsp" %> --%>
