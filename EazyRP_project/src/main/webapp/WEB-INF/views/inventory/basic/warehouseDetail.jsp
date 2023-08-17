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
						<h3 class="card-title p-1">창고 수정/삭제</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="modifyBtn">수 정</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-danger" id="deleteBtn">삭 제</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="modifyWarehouse.do" name="detailForm">
							<input type="hidden" value="${warehouse.WH_NO }" name="wh_no" >
							<input type="hidden" id="c_no" value="${warehouse.C_NO }" name="c_no" >
							<div class="form-group col-sm-12 row">
								<label for="wh_name" class="col-sm-3">창고명</label>
								<input type="text" id="wh_name" name="wh_name" class="form-control col-sm-9 mch1" value="${warehouse.WH_NAME }" style="background-color: white;">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="addr" class="col-sm-3">주소</label>
								<input type="text" id="addr" name="addr" class="form-control col-sm-9 mch2" value="${warehouse.ADDR }" style="background-color: white;">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="selectOp2" class="col-sm-3">가동여부</label>
								<select id="selectOp2" class="form-control col-sm-9 mch3" name="wh_gb">
									<option value="Y" ${warehouse.WH_GB eq 'Y' ? 'selected' : '' }>가동 중</option>
									<option value="N" ${warehouse.WH_GB eq 'N' ? 'selected' : '' }>사용중지</option>
								</select>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="c_name" class="col-sm-3">소유회사</label>
								<input type="text" id="c_name" name="c_name" class="form-control col-sm-9 mch4 c_name" value="${warehouse.C_NAME }" readonly>
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

		
		// 수정버튼 클릭
		$('#modifyBtn').on('click', function() {
			
			for(let i = 0; i < $('input[type="text"]').get().length; i++){
				if($('input[type="text"]').eq(i).val() == "" || $('input[type="text"]').eq(i).val() == null) {
					alert("값을 입력해 주세요.");
					return;
				}
			}
			
			form.submit();
		});
		
		// 삭제버튼 클릭
		$('#deleteBtn').on('click', function(){
			
			if(confirm("삭제하시겠습니까?")){
				form.attr({
					'action' : 'deleteWarehouse.do',
					'method' : 'post'
				});
				form.submit();
			}
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


// 		$(document).on('click', '.c_name', function(){
			
// 			let openWin = OpenWindow("/erp4/findCompany.do", "회사 찾기", 800, 500);
			
// 		});
		
		

	}
	
	
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>