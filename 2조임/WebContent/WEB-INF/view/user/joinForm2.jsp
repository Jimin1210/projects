<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<style>
      #wrap{
            width:530px;
            margin-left:auto; 
            margin-right:auto;
            text-align:center;
        }
        
     
      .header .navbar-bg .nav .dropdown:hover ul {
  display: block;
}
.content-wrapper .side-img {
    text-align: center;
}
select,
input[type="text"],
input[type="password"] {
    border: 2px solid #000;
    padding: 5px;
}
.btn-primary {
    background-color: #0d6efd;
    padding: 3px 0;
    color: #fff;
}
.btn-ok {
    float: left;
    width: 48%!important;
    margin: 10px 1%;
}
input[type="submit"],
input[type="button"] {
    background-color: #0d6efd;
    border-color: #0d6efd;
    color: #fff;
    border-radius: 5px;
    width: auto;
    padding:10px 30px 6px;
}


</style>
<script>
$(function(){
	
	n_check = false;
	
	$('#joinForm').on('submit', function(e){
		if($('#joinForm').find('.is-invalid').length > 0){
			alert("형식에 맞게 입력해주세요.");
			$('#joinForm').find('.is-invalid').focus();
			e.preventDefault();
			return;
		};
		
		if(n_check == false){
			alert("닉네임 중복확인 체크를 해주세요.");
			$('input[name=nick]').focus();
			e.preventDefault();
			return;
		};
	});
	
	// email 정규식 체크
	let email = $('input[name=email]');
	email.on('keyup', function(){
		let emailVal = email.val().trim();
		
		regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
		if( !(regEmail.test(emailVal)) ){
			email.attr('class', 'form-control is-invalid');	
		}else{
			email.attr('class', 'form-control is-valid');
		};
	});
	
	// password 정규식 체크 - 영문 소문자, 대문자, 특수문자, 숫자가 반드시 하나 이상씩 입력
	let pass = $('input[name=pass]');
	pass.on('keyup', function(){
		passVal = pass.val().trim();
		
		regPass = /^(?=.*[a-z])(?=.*[A-Z])(?=.*[`~!@$%&?*])[A-Za-z\d`~!@$%&?*]{8,15}/;
		
		if( !(regPass.test(passVal)) ){
			pass.attr('class', 'form-control is-invalid');
		}else{
			pass.attr('class', 'form-control is-valid');
		};
	});
	
	// pass2 pass일치 비교
	let passCheck = $('input[name=passCheck]');
	passCheck.on('keyup', function(){
		let passCheckVal = passCheck.val().trim();
		
		if(passVal == passCheckVal){
			passCheck.attr('class', 'form-control is-valid');
		}else{
			passCheck.attr('class', 'form-control is-invalid');
		}
	});
	
	let nickCheck = false;
	
	// 닉네임 정규식 체크
	let nick = $('input[name=nick]');
	nick.on('keyup', function(){
		nickVal = nick.val().trim();
		
		regNick = /^[가-힣a-zA-Z0-9]{3,13}$/;
		if( !(regNick.test(nickVal)) ){
			nick.attr('class', 'form-control is-invalid');
			nickCheck = false;
		}else{
			nick.attr('class', 'form-control is-valid');
			nickCheck = true;
		};
	});
	
	// 아이디 정규식 체크
	let nick = $('input[name=id]');
	id.on('keyup', function(){
		idVal = id.val().trim();
		
		regId = /^[a-zA-Z0-9]{6,16}$/;
		if( !(regId.test(idVal)) ){
			id.attr('class', 'form-control is-invalid');
			idCheck = false;
		}else{
			id.attr('class', 'form-control is-valid');
			idCheck = true;
		};
	});
	
	// 닉네임 중복체크
	$('#nickCheckBtn').on('click', function(){
		if(nickCheck){
			$.ajax({
				url : '<%= request.getContextPath() %>/user/nickCheck.do',
				method : 'post',
				data : {'nick' : nickVal},
				dataType : 'json',
				success : function(res){
					if(res == '사용가능한 닉네임입니다.'){
						alert(res);
						n_check = true;
					}else{
						alert(res);		
						n_check = false;
					}
				},
				error : function(req){
					alert('상태 : ' + req.status);
				}
			});
		}else{
			alert('닉네임을 확인해주세요.');
		};
	});
	
	//아이디 중복체크
	$('#idCheckBtn').on('click', function(){
		if(nickCheck){
			$.ajax({
				url : '<%= request.getContextPath() %>/user/idCheck.do',
				method : 'post',
				data : {'id' : idVal},
				dataType : 'json',
				success : function(res){
					if(res == '사용가능한 아이디입니다.'){
						alert(res);
						n_check = true;
					}else{
						alert(res);		
						n_check = false;
					}
				},
				error : function(req){
					alert('상태 : ' + req.status);
				}
			});
		}else{
			alert('아이디를 확인해주세요.');
		};
	});
	
	// 생년월일 체크 - 14살 이상
	let bir = $('input[name=bir]');
	bir.on('change', function(){
		let birVal = bir.val().trim();
		
		regBir = new Date(birVal);
		now = new Date();
		
		if((now - regBir) < 0){
			alert("올바른 형식이 아닙니다!");
			bir.attr('class', 'form-control is-invalid');
			bir.focus();
		}else if(14 > (now.getFullYear() - regBir.getFullYear()) ){
			alert("14세 이상만 가입 가능합니다!");
			bir.attr('class', 'form-control is-invalid');
			bir.focus();
		}else{
			bir.attr('class', 'form-control is-valid');
		}
	});
	
	//if ($("input[name='id']".val() == '')) {
	//	alert("아디를 입력하세요.");
	//	return;
	//}	
})

</script>

<!-- Main content -->

<form method="post" action="<%=request.getContextPath()%>/user/insertUser.do" id="joinForm">
	아이디 : <input type="text" name="id" ><input type="button" id="idCheckBtn" value="중복확인"><br>
	비밀번호 : <input type="password" name="pwd" ><br>
	비밀번호 확인 : <input type="password" name="pwdChk" ><br>
	이메일 : <input type="email" name="email" ><br>
	이름 : <input type="text" name="name" ><br>
	생년월일 : <input type="date" name="birth" ><br>
	전화번호 : <input type="text" name="tel" ><br>
	집주소 : <input type="text" name="addr" ><br>
	성별 : <input type="text" name="gender" ><br>
	닉네임 : <input type="text" name="nick" ><button id="nickCheckBtn">중복확인</button><br>
	<input type="submit" value="회원가입">
</form>

</body>
</html>