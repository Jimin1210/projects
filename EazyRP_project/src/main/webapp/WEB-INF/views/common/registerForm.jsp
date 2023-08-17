<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.2.3/js/bootstrap.min.js"></script>
</head>


<style>
html {
    height: 100%;
    width: 100%;
}
body {
	font-family: 'Varela Round', sans-serif;
   display: flex;
   justify-content: center;
   align-items: center;
   height: 100%;
}
.modal-login {
	width: 500px;
   
}
.modal-login .modal-content {
	padding: 20px;
	border-radius: 5px;
	border: none;
}
.modal-login .modal-header {
	border-bottom: none;
	position: relative;
	justify-content: center;
}
.modal-login .close {
	position: absolute;
	top: -10px;
	right: -10px;
}
.modal-login h4 {
	color: #636363;
	text-align: center;
	font-size: 26px;
	margin-top: 0;
}
.modal-login .modal-content {
	color: #999;
	border-radius: 1px;
	margin-bottom: 15px;
	background: #fff;
	border: 1px solid #f3f3f3;
	box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
	padding: 25px;
}
.modal-login .form-group {
	margin-bottom: 20px;
}
.modal-login label {
	font-weight: normal;
	font-size: 13px;
}
.modal-login .form-control {
	min-height: 44px;
	padding-left: 5px;
	box-shadow: none !important;
	border-width: 0 0 1px 0;
	border-radius: 0;
}
.modal-login .form-control:focus {
	border-color: #ccc;
}
.modal-login .input-group-addon {
	max-width: 42px;
	text-align: center;
	background: none;
	border-bottom: 1px solid #ced4da;
	padding-right: 5px;
	border-radius: 0;
}
.modal-login .btn, .modal-login .btn:active {        
	font-size: 16px;
	font-weight: bold;
	background: #4685e4 !important;
	border-radius: 3px;
	border: none;
	min-width: 140px;
}
.modal-login .btn:hover, .modal-login .btn:focus {
	background: #4685e4 !important;
}
.modal-login .hint-text {
	text-align: center;
	padding-top: 5px;
	font-size: 13px;
}
.modal-login .modal-footer {
	color: #999;
	border-color: #dee4e7;
	text-align: center;
	margin: 0 -25px -25px;
	font-size: 13px;
	justify-content: center;
}
.modal-login a {
	color: #fff;
	text-decoration: underline;
}
.modal-login a:hover {
	text-decoration: none;
}
.modal-login a {
	color: #636363;
	text-decoration: none;
}	
.modal-login a:hover {
	text-decoration: underline;
}
.modal-login .fa {
	font-size: 21px;
	position: relative;
	top: 6px;
}
.trigger-btn {
	display: inline-block;
	margin: 100px auto;
}
.findbtn{
	display: flex;
	justify-content: center;
	align-items: center;
	
}
.inputText{
	width: 70%;
	display: inline-flex;
}
.chkbtn{
	color: #fff;
	background: #4685e4 !important;
	border: none;
    font-size: 0.85rem;
    padding: 12px 7px;
	border-radius: 7px;
}
</style>


<body>
<!-- Modal HTML -->
	<div class="modal-dialog modal-login ">
		<div class="modal-content ">
			<div class="modal-header">				
				<h4 class="modal-title">회원가입</h4>
			</div>
			<div class="modal-body">
				
				<form id="registForm" action="/member/register.do" style="margin-left: 20px;" method="post">
					<div class="form-group d-flex">
						<div class="input-group inputText">
							<span class="fa"><i class="fa fa-user"></i></span><span style="width: 15px;"></span>
							<input type="text" class="form-control" id="id" name="id" placeholder="ID"  required="required">
						</div>
						<div>
							<input type="button" class="chkbtn" name="idchk" style="margin-left: 30px;" required="required" onclick="idCheck_go();" value="중복확인">							
						</div>
					</div>
					<div class="form-group">
						<div class="input-group inputText">
							<span class="fa"><i class="fa fa-lock"></i></span><span style="width: 15px;"></span>
							<input type="password" class="form-control" id="pwd" name="pwd" style="font-size: 0.7em;" placeholder="영어 대소문자, 특수문자, 숫자 포함 9자~16자" required="required">
						</div>
					</div>
					<div class="form-group">
						<div class="input-group inputText">
							<span class="fa"><i class="fa fa-lock"></i></span><span style="width: 15px;"></span>
							<input type="password" style="font-size: 0.7em;" class="form-control" id="pwdchk" name="pwchk" placeholder="PW check" required="required">
						</div>
					</div>
					<div class="form-group">
						<div class="input-group inputText">
							<span class="fa"><i class="fa fa-user"></i></span><span style="width: 15px;"></span>
							<input type="text" class="form-control" id="name" name="name" placeholder="이름" required="required">
						</div>
					</div>
					<div class="form-group d-flex">
						<div class="input-group">
							<span class="fa"><i class="fa fa-calendar"></i></span><span style="width: 15px;"></span>
							<input class="form-control" id="birth" name="birth" type="text" style="width: 242px;" placeholder="생년월일" name="birthday">
							<select class="form-select form-select-sm" aria-label="Default select example" id="gen" name="gen" style="border-radius: 7px; margin-left: 50px;">
								<option disabled="disabled" selected="selected">성별</option>
								<option value="남성">남성</option>
								<option value="여성">여성</option>
								<option value="기타">기타</option>
							</select>
						</div>
					</div>
					<!-- 이메일 -->
					<div class="form-group d-flex">
							<div class="input-group inputText">
									<span class="fa"><i class="fa fa-envelope"></i></span><span style="width: 15px;"></span>
									<input type="text" class="form-control" value="" placeholder="이메일" name="email" id="email" required="required"/> 
								</div>
									<div class="input-group" style="width: 50%;align-items: center;margin-right: 20px; margin-left: 10px;" >
										@
										<select name="domainselect" id="domainselect" class="form-select form-select-sm" style="align-items: baseline;margin-left: 10px;border-radius: 3px;">
											<option disabled="disabled" selected="selected">선택</option>
											<option value="@naver.com">naver.com</option>
											<option value="@gmail.com">gmail.com</option>
											<option value="@hanmail.net">hanmail.net</option>
											<option value="@daum.net">daum.net</option>
											<option value="">직접입력</option>
										</select>
										<div class="select-dropdown"></div>
									</div>
						<div>
							<input type="button" class="chkbtn" name="emailauth" id="emailauth" required="required"  value="인증번호 전송">							
						</div>
					</div>
					<div class="form-group d-flex">
						<div class="input-group">
							<span class="fa"><i class="fa fa-envelope"></i></span><span style="width: 15px;"></span>
							<input type="text" class="form-control mail-check-input" name="password" style="margin-right: 30px;" placeholder="인증번호" required="required">
						</div>
						<div>
							<input type="button" class="chkbtn" id="emailauthchk" name="emailauthchk" value="인증번호 확인">			
						</div>
					</div>
					<!-- 이메일 끝 -->
					<div class="form-group">
						<div class="input-group inputText">
							<span class="fa"><i class="fa fa-phone"></i></span><span style="width: 15px;"></span>
							<input type="text" class="form-control" name="tel" placeholder="전화번호" required="required">
						</div>
					</div>
					<div class="form-group">
						<div class="input-group inputText">
							<span class="fa"><i class="fa fa-home"></i></span><span style="width: 15px;"></span>
							<input type="text" class="form-control" name="addr" placeholder="주소" required="required">
						</div>
					</div>
				</form>
					<div class="form-group findbtn">
						<button class="btn btn-info btn-block btn-sm" style="width: 60%; margin-top: 30px; color:#fff;" id="registBtn" onclick="submit_go();">회원가입</button>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-info btn-block btn-sm" style="width: 60%; margin-top: 30px; color:#fff;" id="cancelBtn">취 소</button>
					</div>

			</div>
			
		</div>
	</div>    
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
<script>	




$(function(){
	$('#birth').datepicker({
		dateFormat: "yy-mm-dd",	//데이터 포맷 형식(yyyy : 년 mm : 월 dd : 일 )
 		startDate: '',	//달력에서 선택 할 수 있는 가장 빠른 날짜. 이전으로는 선택 불가능 ( d : 일 m : 달 y : 년 w : 주)
 		language : "ko"	//달력의 언어 선택, 그에 맞는 js로 교체해줘야한다.
 		});	
	
/* 	$('#registBtn').on('click', function(){
		$('#registForm').submit();
	}); */
	let gen = $('#gen').val();
	
	$('#cancelBtn').on('click', function(){
		location.href = "/common/loginForm"; 
	});
})

</script> 	 

<%@ include file="register_js.jsp" %> 