<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="height: 50px"></div>
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: 900px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">품목 추가</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="registBtn">등 록</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="registItem.do" name="detailForm" enctype="multipart/form-data">
							<input type="hidden" id="wh_no" value="" name="wh_no" >
							<input type="hidden" id="c_no" value="${c_no }" name="c_no" >
							<input type="hidden" id="sp_no" value="" name="sp_no" >
							<input type="hidden" id="emp_no" value="${emp_no }" name="emp_no" >
							<div class="form-group col-sm-12 row">
								<label for="pr_name" class="col-sm-3">제품명</label>
								<input type="text" id="pr_name" name="pr_name" class="form-control col-sm-9 mch1" value="" style="background-color: white;">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="pr_gr" class="col-sm-3">그룹명</label>
								<input type="text" id="pr_gr" name="pr_gr" class="form-control col-sm-9 mch2" value="" style="background-color: white;">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="pr_st" class="col-sm-3">규 격</label>
								<input type="text" id="pr_st" name="pr_st" class="form-control col-sm-9 mch4" value="">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="pr_inprice" class="col-sm-3">입고단가</label>
								<input type="text" id="pr_inprice" name="pr_inprice" class="form-control col-sm-9 mch4" value="">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="pr_exprice" class="col-sm-3">출고단가</label>
								<input type="text" id="pr_exprice" name="pr_exprice" class="form-control col-sm-9 mch4" value="">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="quantity" class="col-sm-3">수 량</label>
								<input type="text" id="quantity" name="quantity" class="form-control col-sm-3" value="">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<label for="pr_class" class="col-sm-2">품목구분</label>
								<select id="pr_class" class="form-control col-sm-3 mch3" name="pr_class">
									<option value="음식">음식</option>
									<option value="자재">자재</option>
									<option value="전자제품">전자제품</option>
								</select>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="exdate" class="col-sm-3">유통기한</label>
								<input type="date" id="exdate" name="exdate" class="form-control col-sm-9 mch6" value="" placeholder="유통기한을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="sp_name" class="col-sm-3">특별단가</label>
								<input type="text" id="sp_name" name="sp_name" class="form-control col-sm-9 mch4 sp_name" value="">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="wh_name" class="col-sm-3">창 고</label>
								<input type="text" id="wh_name" name="wh_name" class="form-control col-sm-9 mch4 wh_name" value="">
							</div>
<!-- 							<div class="form-group col-sm-12 row"> -->
<!-- 								<label for="c_name" class="col-sm-3">회 사</label> -->
<!-- 								<input type="text" id="c_name" name="c_name" class="form-control col-sm-9 mch4 c_name" value=""> -->
<!-- 							</div> -->
							<div class="form-group col-sm-12 row">
								<label for="files" class="col-sm-3">사진 첨부</label>
								<input type="file" id="files" name="files" class="form-control col-sm-9 mch4 files" value="" accept=".jpg, .jpeg, .png, .PPM, .PGM, .PBM, .PNM">
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
			
			for(let i = 0; i < $('input[type="text"]').get().length; i++){
				if($('input[type="text"]').eq(i).val() == "" || $('input[type="text"]').eq(i).val() == null) {
					alert("값을 입력해 주세요.");
					return;
				}
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


// 		$(document).on('click', '.c_name', function(){
			
// 			let openWin = OpenWindow("/erp4/findCompany.do", "회사 찾기", 800, 500);
			
// 		});
		
		$(document).on('click', '.wh_name', function(){
			
			let openWin = OpenWindow("/erp4/findWarehouseToitem.do", "회사 찾기", 800, 500);
			
		});
		
		$(document).on('click', '.sp_name', function(){
			
			let openWin = OpenWindow("/erp4/findSprice.do", "특별단가 찾기", 800, 500);
			
		});
		

	}
	
	
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>