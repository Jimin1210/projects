<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="height: 50px"></div>
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: 600px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">상품 등록</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="registBtn">등 록</button>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="insertMerchandise.do" name="registForm">
							<div class="form-group col-sm-12 row">
								<label for="s_name" class="col-sm-3">쇼핑몰 코드</label>
								<input type="text" id="shname" name="s_name" class="form-control col-sm-9 s_name mch1" value="" placeholder="쇼핑몰코드를 입력하세요." readonly style="background-color: white;">
								<input type="hidden" id="s_no_receiver" name="s_no" value="">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="pr_name" class="col-sm-3">제품 이름</label>
								<input type="text" id="name" name="pr_name" class="form-control col-sm-9 pr_no mch2" value="" placeholder="제품이름을 입력하세요." readonly style="background-color: white;">
								<input type="hidden" id="pr_no_receiver" name="pr_no" value="">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="sp_q" class="col-sm-3">수량</label>
								<input type="text" id="sp_q" name="sp_q" class="form-control col-sm-9 mch3" value="" placeholder="수량을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="price" class="col-sm-3">판매가격</label>
								<input type="text" id="price" name="price" class="form-control col-sm-9 mch4" value="" placeholder="판매가격을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="unitprice" class="col-sm-3">단가</label>
								<input type="text" id="unitprice" name="unitprice" class="form-control col-sm-9 pr_inprice_receiver" readonly value="" placeholder="단가를 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="status" class="col-sm-3">판매상태</label>
								<div class="col-sm" style="padding-left:0px; padding-right:0px;">
									<select name="status" class="form-select mch5">
										<option value="판매중">판매중</option>
										<option value="판매중지">판매중지</option>
									</select>
								</div>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="stperiod" class="col-sm-3">판매시작일</label>
								<input type="date" id="stperiod" name="startperiod" class="form-control col-sm-9 mch6" value="" placeholder="판매시작일을 입력하세요.">
							</div>
<!-- 							<div class="form-group col-sm-12 row"> -->
<!-- 								<label for="endperiod" class="col-sm-3">판매종료일</label> -->
<!-- 								<input type="date" id="endperiod" name="endperiod" class="form-control col-sm-9 " value="" placeholder="판매종료일을 입력하세요."> -->
<!-- 							</div> -->
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>

<script>
	window.onload = function(){
		/* SmartEditor_summernote($('#content')); */
		
		// 등록버튼 클릭
		$('#registBtn').on('click', function() {
			let form = $('form[role="form"]');
			
			if($('.mch1').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch2').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch3').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch4').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch6').val() == "") {
				alert("빈 항목이 있습니다.");
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


	$(document).on('click', '.pr_no', function(){
		
		let openWin = OpenWindow("/erp5/findProduct.do", "제품 찾기", 800, 600);
	});
	
	$(document).on('click', '.s_name', function(){
		
		let openWin = OpenWindow("/erp5/findShop.do", "쇼핑몰 찾기", 800, 600);
		
	});
}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>