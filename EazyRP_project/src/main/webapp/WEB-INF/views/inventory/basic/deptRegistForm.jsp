<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="height: 50px"></div>
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: 600px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">부서 등록</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="registBtn">등 록</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="registDept.do" name="detailForm">
							<input type="hidden" id="emp_no" value="${emp_no }" name="emp_no" >
							<div class="form-group col-sm-12 row">
								<label for="dname" class="col-sm-3">부서명</label>
								<input type="text" id="dname" name="dname" class="form-control col-sm-9 mch1" value="" style="background-color: white;">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="dnoment" class="col-sm-3">추가내용</label>
								<input type="text" id="dnoment" name="dnoment" class="form-control col-sm-9 mch2" value="" style="background-color: white;">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

<script>
	window.onload = function(){

		let form = $('form[role="form"]');

		
		// 등록버튼 클릭
		$('#registBtn').on('click', function() {

			if($('#dname').val() == "" || $('#dname').val() == null) {
				alert("값을 입력해 주세요.");
				return;
			}

			
			form.submit();
		});

		// 취소버튼 클릭
		$('#cancelBtn').on('click', function() {
			window.opener.location.reload(true);
			window.close();
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