<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="min-height: 800px;">
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10" style="max-width: 950px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">주문 등록</h3>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="insertOrder.do" name="registForm">
							<div class="form-group col-sm-12 row">
								<label for="sp_no" class="col-sm-2">상품 이름</label>
								<input type="text" id="name" name="sp_name" class="form-control col-sm-3 pr_name mch1" value="" placeholder="상품이름을 입력하세요." readonly style="background-color: white;">
								<input type="hidden" id="sp_no_receiver" name="sp_no" value="">
								<div class="col-sm-1"></div>
								<label for="so_no" class="col-sm-2">주문 번호</label>
								<input type="text" id="so_no" name="so_no" class="form-control col-sm-4" value="" placeholder="주문번호는 자동으로 입력됩니다." readonly >
								<input type="hidden" id="" name="" value="">
							</div>
							<div class="form-group col-sm-12 row " >
								<label for="reciever" class="col-sm-2">수취인 이름</label>
								<input type="text" id="reciever" name="reciever" class="form-control col-sm-3 mch2" value="" placeholder="수취인이름을 입력하세요.">
								<div class="col-sm-1"></div>
								<label for="tel" class="col-sm-2">수취인 연락처</label>
								<input type="text" id="tel" name="tel" class="form-control col-sm-4 mch3" value="" placeholder="수취인연락처를 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="addr" class="col-sm-2">주소</label>
								<input type="text" id="addr" name="addr" class="form-control col-sm-10 mch4" value="" placeholder="주소를 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="quantity" class="col-sm-2">주문수량</label>
								<input type="text" id="quantity" name="quantity" class="form-control col-sm-3 mch5" value="" placeholder="주문수량을 입력하세요.">
								<input type="hidden" id="hiddenquantity" name="hiddenquantity" value="">
								<div class="col-sm-1"></div>
								<label for="orderdate" class="col-sm-2">주문일</label>
								<input type="date" id="orderdate" name="orderdate" class="form-control col-sm-4 mch6" value="" placeholder="주문일을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="method" class="col-sm-2">배송방법</label>
								<input type="text" id="method" name="method" class="form-control col-sm-3 mch7" value="" placeholder="배송방법을 입력하세요.">
								<div class="col-sm-1"></div>
								<label for="invoice" class="col-sm-2">송장번호</label>
								<input type="text" id="invoice" name="invoice" class="form-control col-sm-4 mch8" value="" placeholder="송장번호를 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="request" class="col-sm-2">배송요청사항</label>
								<textarea rows="2" id="request" name="request" class="form-control col-sm-10" placeholder="배송요청사항을 입력하세요.">배송요청사항</textarea>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="delfee" class="col-sm-2">배송비</label>
								<input type="text" id="delfee" name="delfee" class="form-control col-sm-3" value="" placeholder="배송비를 입력하세요.">
								<div class="col-sm-1"></div>
								<label for="progress" class="col-sm-2">진행상태</label>
								<select name="progress" class="form-select col-sm-4">
									<option value="주문접수중">주문접수중</option>
<!-- 									<option value="주문취소">주문취소</option> -->
<!-- 									<option value="배송중">배송중</option> -->
<!-- 									<option value="배송완료">배송완료</option> -->
<!-- 									<option value="반품">반품</option> -->
								</select>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="delstartdate" class="col-sm-2">배송시작일</label>
								<input type="date" id="delstartdate" name="delstartdate" class="form-control col-sm-3 mch9" value="" placeholder="배송시작일을 입력하세요.">
								<div class="col-sm-1"></div>
								<label for="delenddate" class="col-sm-2">배송종료일</label>
								<input type="date" id="delenddate" name="delenddate" class="form-control col-sm-4 " value="" placeholder="배송종료일을 입력하세요.">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="failure" class="col-sm-2">실패사유</label>
								<textarea rows="2" id="failure" name="failure" class="form-control col-sm-6" placeholder="실패사유를 입력하세요.">실패사유</textarea>
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
		/* SmartEditor_summernote($('#content')); */
		// 등록버튼 클릭
		
		$('#registBtn').on('click', function() {
			let form = $('form[role="form"]');
			console.log('quantity value : ' + $('#quantity').val());
			console.log('hiddenquantity value : ' + $('#hiddenquantity').val());
			console.log(parseInt($('#hiddenquantity').val()) < parseInt($('#quantity').val()))
			
			if(parseInt($('#hiddenquantity').val()) < parseInt($('#quantity').val())){
				alert("주문수량이 남은 수량보다 많습니다.");
				return;
			}
			
			
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
			if($('.mch5').val() == "" || $('.mch5').val() == 0) {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch6').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch7').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch8').val() == "") {
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.mch9').val() == "") {
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


		$(document).on('click', '.pr_name', function(){
			let openWin = OpenWindow("/erp5/findMerchandise.do", "제품 찾기", 800, 600);
			console.log("sp_no 밸류 " + $('#sp_no_receiver').val());
			
		});
		
		$(document).on('click', '.s_name', function(){
			
			let openWin = OpenWindow("/erp5/findShop.do", "쇼핑몰 찾기", 800, 600);
			
		});
	}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>