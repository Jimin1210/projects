<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<div style="height: 50px"></div>
<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: 600px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">기안문 수정</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="registBtn">수 정</button>
							&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
					
							<div class="form-group">
								<label for="title">제 목</label>
								<input type="text" value="${draft.title }" id="title" name="title" class="form-control" placeholder="제목을 입력하세요.">
							</div>
							
							<div class="form-group">
							<form id="downloadForm" method="post" action="/management/documentDown.do">
								<label for="writer">기안문 구분&nbsp;&nbsp;&nbsp;&nbsp;</label>
								<select class="form-control col-md-2" name="document" id="document" style="font-size: 0.8em; width: 30%; display: inline;">
									<option value="B" ${draft.dg_no eq 'D001' ? 'selected' : ''}>휴가신청서</option>
									<option value="A" ${draft.dg_no eq 'D002' ? 'selected' : ''}>출장보고서</option>
									<option value="C" ${draft.dg_no eq 'D003' ? 'selected' : ''}>발주보고서</option>
									<option value="D" ${draft.dg_no eq 'D004' ? 'selected' : ''}>지출결의서</option>
								</select>
								<input type="submit" id="downloadBtn" class="btn btn-primary"style="margin-left: 5px" value="양식 다운로드">
							</form>
								<label for="writer">결재라인&nbsp;&nbsp;&nbsp;&nbsp;</label>
								<select class="form-control col-md-2" name="pl_no" id="pl_no" style="font-size: 0.8em; width: 30%; display: inline;">
									<option value="P0001" ${draft.pl_no eq 'P0001' ? 'selected' : ''}>휴가신청결재라인</option>
									<option value="P0002" ${draft.pl_no eq 'P0002' ? 'selected' : ''}>출장보고결재라인</option>
									<option value="P0003" ${draft.pl_no eq 'P0003' ? 'selected' : ''}>발주보고결재라인</option>
									<option value="P0004" ${draft.pl_no eq 'P0004' ? 'selected' : ''}>지출결의결재라인</option>
								</select>
							</div>
							<form id="registForm2" method="post" action="/management/modifyDocument.do" enctype="multipart/form-data">
								<input type="hidden" id="dg_no" name="dg_no" value="${draft.dg_no}">
								<input type="hidden" name="title" id="titleHidden" value="${draft.title }">
								<input type="hidden" id="gb" name="gb" value="${draft.gb}">
								<input type="hidden" id="pl_noHidden" name="pl_no" value="${draft.pl_no}">
								<input type="hidden" id="dr_noHidden" name="dr_no" value="${draft.dr_no}">
								<div class="form-group">
									<label for="content">내 용</label>
									<textarea class="textarea" name="con" id="con" rows="10" 
										placeholder="내용을 작성하세요." style="display: block; width:100%;">${draft.con }</textarea>
								</div>
								<div class="form-group">
									<label for="file">기안문 첨부</label>
									<input type="file" id="file" name="file" value="" accept=".xlsx, .xls"> 
									<input type="hidden" id="fileName" name="fileName" value="">
									<input type="hidden" id="fileName" name="deleteFileName" value="${draft.files }">
								</div>
							</form>
					</div>
				</div>
			</div>
		</div>
	</section>
	
<script>

	$('#registBtn').on('click', function(){
		$('#fileName').val($('#file').val());
		if($('#document').val() == 'B'){
			$('#dg_no').val('D001')
			$('#gb').val('휴가신청서')
		} else if($('#document').val() == 'A'){
			$('#dg_no').val('D002')
			$('#gb').val('출장보고서')
		} else if($('#document').val() == 'C'){
			$('#dg_no').val('D003')
			$('#gb').val('발주보고서')
		} else if($('#document').val() == 'D'){
			$('#dg_no').val('D004')
			$('#gb').val('지출결의서')
		}
		$('#pl_noHidden').val($('#pl_no').val());
		$('#titleHidden').val($('#title').val());
		$('#registForm2').submit();
	})
	
	
	$('#cancelBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	})
</script>