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
						<h3 class="card-title p-1">근태 등록</h3>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="/management/insertWork.do" name="registForm" enctype="multipart/form-data">
							<div class="form-group col-sm-12 row">
								<label for="w_no" class="col-sm-2">근태기록번호</label>
								<input type="text" id="w_no" name="" class="form-control col-sm-3" value="" placeholder="근태기록번호" readonly>
								<div class="col-sm-1"></div>
								<label for="e_name" class="col-sm-2">사원명</label>
								<input type="text" id="e_name2" name="e_name" class="form-control col-sm-4 e_name work1" value="" placeholder="사원명">
								<input type="hidden" id="emp_no2" name="emp_no" value="">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="wdate" class="col-sm-2">근무일자</label>
								<input type="date" id="wdate" name="wdate" class="form-control col-sm-4 work3" value="" placeholder="근무일자">
								<div class="col-sm-1"></div>
								<label for="ep_name" class="col-sm-2">수당명</label>
								<input type="text" id="ep_name" name="ep_name" class="form-control col-sm-3 ep_name work2" value="" placeholder="수당명" >
								<input type="hidden" id="ep_no" name="ep_no" value="" class="ep_no">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="wtime" class="col-sm-2">근무시간</label>
								<input type="text" id="wtime" name="wtime" class="form-control col-sm-3 work4" value="" placeholder="근무시간" >
								<div class="col-sm-1"></div>
								<input type="hidden" id="c_no" name="c_no" value="${c_no }">
							</div>
							</form>
						</div>
					</div>
					<div class="card-footer card-tools">
						<button type="button" class="btn btn-primary" id="registBtn" >등 록</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
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
			if($('.work1').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.work3').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.work4').val() == ""){
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
		
		$(document).on('click', '.e_name', function(){
			let c_no = $('#c_no').val();
			let openWin = OpenWindow("/management/findEmp.do?c_no=" + c_no, "사원 찾기", 500, 500);
			
		});
		
		$(document).on('click', '.ep_name', function(){
			let openWin = OpenWindow("/management/findExtrapay.do", "수당 찾기", 500, 500);
			
		});

	}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>