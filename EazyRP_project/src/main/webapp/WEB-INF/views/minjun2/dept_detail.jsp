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
						<h3 class="card-title p-1">부서 상세보기</h3>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="modifyDept.do" name="registForm" enctype="multipart/form-data">
							<div class="form-group col-sm-12 row">
								<label for="dept_no" class="col-sm-2">부서코드</label>
								<input type="text" id="dept_no" name="dept_no" class="form-control col-sm-3" value="${dept.DEPT_NO}" placeholder="부서코드" readonly>
								<div class="col-sm-1"></div>
								<label for="dname" class="col-sm-2">부서명</label>
								<input type="text" id="dname" name="dname" class="form-control col-sm-4 dept1" value="${dept.DNAME }" placeholder="부서명을 입력하세요">
							</div>
						</form>
					</div>
					<div class="card-footer card-tools">
						<button type="button" class="btn btn-primary" id="modifyBtn" >수 정</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-danger" id="deleteBtn">삭 제</button>
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

		// 수정버튼 클릭
		$('#modifyBtn').on('click', function() {
			
			if($('.dept1').val() == ""){
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
		
		// 삭제버튼 클릭
		$('#deleteBtn').on('click', function() {
			if(confirm("정말 삭제하시겠습니까?")){
				
				form.attr({
					'action' : 'deleteDept.do',
					'method' : 'post' 
				});
				
				form.submit();
			};
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