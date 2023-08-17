<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="min-height: 100%;">
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10" style="max-width: 950px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">공제 등록</h3>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="/management/insertDeduction.do" name="registForm" enctype="multipart/form-data">
							<div class="form-group col-sm-12 row">
								<label for="ded_no" class="col-sm-2">공제코드</label>
								<input type="text" id="ded_no" name="ded_no" class="form-control col-sm-3" value="" placeholder="공제코드" readonly>
								<div class="col-sm-1"></div>
								<label for="ded_name" class="col-sm-2">공제명</label>
								<input type="text" id="ded_name" name="ded_name" class="form-control col-sm-4 ded1" value="" placeholder="공제명을 입력하세요">
							</div>
							<div class="form-group col-sm-12 row " >
<!-- 								<label for="ded_order" class="col-sm-2">표시순서</label> -->
<!-- 								<input type="text" id="ded_order" name="ded_order" class="form-control col-sm-3 ded2" value="" placeholder="표시순서를 입력하세요 "> -->
<!-- 								<div class="col-sm-1"></div> -->
								<label for="calc" class="col-sm-2">계산식</label>
								<input type="text" id="calc" name="calc" class="form-control col-sm-3 ded3" value="" placeholder="계산식을 입력하세요">
								<div class="col-sm-1"></div>
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

		let form = $('form[role="form"]');

		// 등록버튼 클릭
		$('#registBtn').on('click', function() {
			
			if($('.ded1').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
// 			if($('.ded2').val() == ""){
// 				alert("빈 항목이 있습니다.");
// 				return;
// 			}
			if($('.ded3').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			
			form.submit();
		});
		
		// 취소버튼 클릭
		$('#cancelBtn').on('click', function() {
			window.opener.location.reload(true);
			window.close();						// 윈도우 창을 닫는다.
		});
		

		function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
			winleft = (screen.width - WinWidth) / 2;
			wintop = (screen.height - WinHeight) / 2;
			var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
									+ "height=" + WinHeight + ",top="+ wintop + ",left="
									+ winleft + ",resizable=yes,status=yes");
			win.focus();
			return win;
		};

	}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>