<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<div style="min-height: 800px;">
	<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10" style="max-width: 950px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">직원 등록</h3>
					</div>
					<div class="card-body pad">
						<form role="form" method="post" action="/management/insertEmp.do" name="registForm" enctype="multipart/form-data">
							<div class="form-group col-sm-12 row">
								<label for="emp_no" class="col-sm-2">사원번호</label>
								<input type="text" class="form-control col-sm-3" value="" placeholder="사원번호" readonly>
								<div class="col-sm-1"></div>
								<label for="e_name" class="col-sm-2">사원명</label>
								<input type="text" id="e_name" name="e_name" class="form-control col-sm-4 emp1" value="" placeholder="사원명을 입력하세요">
							</div>
							<div class="form-group col-sm-12 row " >
								<label for="c_name" class="col-sm-2">업체명</label>
								<input type="text" id="c_name" name="c_name" class="form-control col-sm-3 c_name emp2" value="${c_name }" placeholder="업체명을 입력하세요 " readonly>
								<input type="hidden" id="c_no" name="c_no" value="">								
								<div class="col-sm-1"></div>
								<label for="e_rank" class="col-sm-2">직급</label>
								<select name="e_rank" id="e_rank" class="form-select col-sm-4 ">
									<option value="대표이사">대표이사</option>
									<option value="이사">이사</option>
									<option value="전무">전무</option>
									<option value="상무">상무</option>
									<option value="부장">부장</option>
									<option value="차장">차장</option>
									<option value="과장">과장</option>
									<option value="대리">대리</option>
									<option value="주임">주임</option>
									<option value="사원">사원</option>
									<option value="인턴">인턴</option>
								</select>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="dname" class="col-sm-2">부서명</label>
								<input type="text" id="dname" name="dname" class="form-control col-sm-3 dname emp3" value="" placeholder="부서명을 입력하세요">
								<input type="hidden" id="dept_no" name="dept_no" value="">
								<div class="col-sm-1"></div>
								<label for="emp_no2" class="col-sm-2">대무자</label>
								<input type="text" id="e_name2" name="e_name2" class="form-control col-sm-4 e_name2 emp4" value="" placeholder="대무자를 입력하세요">
								<input type="hidden" id="emp_no2" name="emp_no2" value="">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="e_email" class="col-sm-2">이메일</label>
								<input type="text" id="e_email" name="e_email" class="form-control col-sm-3" value="" placeholder="이메일을 입력하세요">
								<div class="col-sm-1"></div>
								<label for="e_sal" class="col-sm-2">봉급</label>
								<input type="text" id="e_sal" name="e_sal" class="form-control col-sm-4 emp6" value="" placeholder="봉급을 입력하세요">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="e_bank" class="col-sm-2">은행</label>
								<input type="text" id="e_bank" name="e_bank" class="form-control col-sm-3 emp7" value="" placeholder="은행을 입력하세요">
								<div class="col-sm-1"></div>
								<label for="e_account" class="col-sm-2">계좌번호</label>
								<input type="text" id="e_account" name="e_account" class="form-control col-sm-4 emp8" value="" placeholder="계좌번호를 입력하세요">
							</div>
							<div class="form-group col-sm-12 row">
								<label for="e_hd" class="col-sm-2">입사일</label>
								<input type="date" id="e_hd" name="e_hd" class="form-control col-sm-3 emp9" value="" placeholder="입사일">
								<div class="col-sm-1"></div>
								<label for="e_dd" class="col-sm-2">퇴사일</label>
								<input type="date" id="e_dd" name="e_dd" class="form-control col-sm-4" value="" placeholder="퇴사일" disabled>
							</div>
							<div class="form-group col-sm-12 row">
								<label for="e_tenure" class="col-sm-2">재직구분</label>
								<select name="e_tenure" class="form-select col-sm-3">
									<option value="YES">YES</option>
									<option value="NO">NO</option>
								</select>
								<div class="col-sm-1"></div>
								<label for="e_tel" class="col-sm-2">전화번호</label>
								<input type="text" id="e_tel" name="e_tel" class="form-control col-sm-4 emp10" value="" placeholder="전화번호를 입력하세요">
							</div>
 							<div class="form-group col-sm-12 row">
								<label for="files" class="col-sm-3">도장 첨부</label>
								<input type="file" id="files" name="files" class="form-control col-sm-9 files" value="" accept=".jpg, .jpeg, .png, .PPM, .PGM, .PBM, .PNM">
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
			
			if($('.emp1').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.emp2').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.emp3').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.emp4').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.emp6').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.emp7').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.emp8').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.emp9').val() == ""){
				alert("빈 항목이 있습니다.");
				return;
			}
			if($('.emp10').val() == ""){
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

// 		$(document).on('click', '.c_name', function(){
			
// 			let openWin = OpenWindow("/management/findCompany.do", "업체명 찾기", 500, 500);
			
// 		});
		
		$(document).on('click', '.dname', function(){
			
			let openWin = OpenWindow("/management/findDept.do", "부서명 찾기", 500, 500);
			
		});
		
		$(document).on('click', '.e_name2', function(){
			let c_no = $('#c_no').val();
			let openWin = OpenWindow("/management/findEmp.do?c_no=" + c_no, "사원 찾기", 500, 500);
			
		});
	}
</script>

<script src="<%= request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>