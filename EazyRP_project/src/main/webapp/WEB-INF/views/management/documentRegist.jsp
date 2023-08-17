<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<div style="height: 50px"></div>
<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: 600px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">기안문 작성</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="registBtn">작 성</button>
							&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
					
							<div class="form-group">
								<label for="title">제 목</label>
								<input type="text" id="title" name="title" class="form-control" placeholder="제목을 입력하세요.">
							</div>
							
							<div class="form-group">
							<form id="downloadForm" method="post" action="/management/documentDown.do">
								<label for="writer">기안문 구분&nbsp;&nbsp;&nbsp;&nbsp;</label>
								<select class="form-control col-md-2" name="document" id="document" style="font-size: 0.8em; width: 30%; display: inline;">
									<c:forEach items="${draftgb}" var="dr" varStatus="loop">
										<option value="${dr.dg_no }" class="dg" id="${dr.dg_name }">${dr.dg_name }</option>
									</c:forEach>
								</select>
								<input type="submit" id="downloadBtn" class="btn btn-primary"style="margin-left: 5px" value="양식 다운로드">
							</form>
								<label for="writer">결재라인&nbsp;&nbsp;&nbsp;&nbsp;</label>
								<select class="form-control col-md-2" name="pl_no" id="pl_no" style="font-size: 0.8em; width: 30%; display: inline;">
									<c:forEach items="${plList}" var="pl" varStatus="loop">
										<option value="${pl.pl_no }" class="pl" id="${pl.pl_name }">${pl.pl_name }</option>
									</c:forEach>
								</select>
							</div>
							<form id="registForm2" method="post" action="/management/regist.do" enctype="multipart/form-data">
								<input type="hidden" id="dg_no" name="dg_no" value="D001">
								<input type="hidden" name="title" id="titleHidden">
								<input type="hidden" id="gb" name="gb" value="휴가신청서">
								<input type="hidden" id="pl_noHidden" name="pl_no" value="P0001">
								<div class="form-group">
									<label for="content">내 용</label>
									<textarea class="textarea" name="con" id="con" rows="10" 
										placeholder="내용을 작성하세요." style="display: block; width:100%;"></textarea>
								</div>
								<div class="form-group">
									<label for="file">기안문 첨부</label>
									<input type="file" id="file" name="file" accept=".xlsx, .xls"> 
									<input type="hidden" id="fileName" name="fileName" value="">
								</div>
							</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
<script>
	$('#document').on('change', function(){
		$('#dg_no').val($(this).val());
		$('#gb').val($('#document option:selected').attr('id'));
	})
	$('#registBtn').on('click', function(){
		if($('#title').val() == ""){
			alert('제목을 입력해주세요.');
			return;
		}
		if($('#con').val() == ""){
			alert('내용을 입력해주세요.');
			return;
		}
		$('#fileName').val($('#file').val());
		$('#pl_noHidden').val($('#pl_no').val());
		$('#titleHidden').val($('#title').val());
		$('#registForm2').submit()
	})
	
	$('#cancelBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	})
</script>