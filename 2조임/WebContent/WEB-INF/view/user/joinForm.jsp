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

<body>
    <div id="wrap">
       <h3 class="mb-3"><strong>회원가입</strong></h3>
        
       <form method="post" action="<%=request.getContextPath()%>/user/insertUser.do" id="joinForm">
        <div class="mb-3 row">
            <label for="userId" class="col-sm-3 col-form-label">아이디</label>
            <div class="col-sm-6">
              <input type="text" style="background-color: white" class="form-control-plaintext" id="userId" name="id" maxlength="14">
            </div>
            <div class="col-sm-3">
              <button type="button" class="btn btn-primary" id="idCheck">중복확인</button>
            </div>
          </div>
          <div class="mb-3 row">
            <label for="password" class="col-sm-3 col-form-label">비밀번호</label>
            <div class="col-sm-6">
              <input type="password" style="background-color: white" class="form-control-plaintext" id="password" name="pwd" maxlength="20">
            </div>
          </div>
          <div class="mb-3 row">
            <label for="password_re" class="col-sm-3 col-form-label">비밀번호 확인</label>
            <div class="col-sm-6">
              <input type="password" style="background-color: white" class="form-control-plaintext" id="password_re" name="password_re" maxlength="20">
            </div>
            <div class="col-sm-3 pwdChk" style="font-size: 60%; color: red;">
              
            </div>
          </div>
          <div class="mb-3 row">
            <label for="name" class="col-sm-3 col-form-label">닉네임</label>
            <div class="col-sm-6">
              <input type="text" style="background-color: white" class="form-control-plaintext" id="name"  name="nick" maxlength="10">
            </div>
            <div class="col-sm-3">
              <button type="button" class="btn btn-primary" id="nickCheckBtn">중복확인</button>
            </div>
          </div>
          <div class="mb-3 row">
            <label for="name" class="col-sm-3 col-form-label">이름</label>
            <div class="col-sm-6">
              <input type="text" style="background-color: white" class="form-control-plaintext" id="name"  name="name" maxlength="10">
            </div>
          </div>
          <div class="mb-3 row">
            <label for="name" class="col-sm-3 col-form-label">전화번호</label>
            <div class="col-sm-6">
              <input type="text" style="background-color: white" class="form-control-plaintext" id="name"  name="tel" maxlength="13">
            </div>
          </div>
          <div class="mb-3 row">
            <label class="col-sm-3 col-form-label">성별</label>
            <div class="col-sm-6">
                <label><input type="radio" name="gender" value="1" checked>남</label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <label><input type="radio" name="gender" value="2" checked>여</label>
            </div>
          </div>
          <div class="mb-3 row">
            <label class="col-sm-3 col-form-label">생년월일</label>
            <div class="col-sm-6">
                <input type="date" name="birth">
            </div>
          </div>
          <div class="mb-3 row">
            <label for="name" class="col-sm-3 col-form-label">이메일</label>
            <div class="col-sm-6">
                <input type="email" name="email">
            </div>
          </div>
          <div class="row">
            <div class="col-md-8 offset-md-2">
           <input type="submit" class="btn btn-ok" value="회원가입하기"></form>  <input type="button" class="btn btn-ok" value="취소">
    </div>
    </div>
</div>
   

    <script type="text/javascript">
$(function(){
		
		let n_check = false;
		let id_check = false;
		
		$('#joinForm').on('submit', function(e){
			if($('#joinForm').find('.is-invalid').length > 0){
				alert("형식에 맞게 입력해주세요.");
				$('#joinForm').find('.is-invalid').focus();
				e.preventDefault();
				return;
			};
			
			if(n_check == false || id_check == false){
				alert("닉네임 및 아이디 중복확인 체크를 해주세요.");
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
		let pass = $('input[name=pwd]');
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
		let passCheck = $('input[name=password_re]');
		passCheck.on('keyup', function(){
			let passCheckVal = passCheck.val().trim();
			
			if(passVal == passCheckVal){
				passCheck.attr('class', 'form-control is-valid');
				$('.pwdChk').text('');
			}else{
				passCheck.attr('class', 'form-control is-invalid');
				$('.pwdChk').text('비밀번호가 일치하지 않습니다.');
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
		
		// 닉네임 중복체크
		$('#nickCheckBtn').on('click', function(){
			if(nickCheck){
				$.ajax({
					url : '<%= request.getContextPath()%>/user/nickCheck.do',
					method : 'post',
					data : {'nick' : nickVal},
					dataType : 'json',
					success : function(res){
						if(res == '사용가능한 닉네임입니다.'){
							n_check = true;
						}else{
							n_check = false;
						}
						alert(res)
					},
					error : function(req){
						alert('상태 : ' + req.status);
					}
				});
			}else{
				alert('닉네임을 확인해주세요.');
			};
		});
		
		
		// 아이디 정규식 체크
		let id = $('input[name=id]');
		id.on('keyup', function(){
			idVal = id.val().trim();
			
			regId = /^[a-zA-Z0-9]{6,13}$/;
			if( !(regId.test(idVal)) ){
				id.attr('class', 'form-control is-invalid');
				idCheck = false;
			}else{
				id.attr('class', 'form-control is-valid');
				idCheck = true;
			};
		});
		
		// 아이디 중복체크
		$('#idCheck').on('click', function(){
			if(idCheck){
				$.ajax({
					url : '<%= request.getContextPath()%>/user/idCheck.do',
					method : 'post',
					data : {'id' : idVal},
					dataType : 'json',
					success : function(res){
						alert(res);
						if(res == '사용가능한 아이디입니다.'){
							id_check = true;
						}else{
							id_check = false;
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
		let birth = $('input[name=birth]');
		birth.on('change', function(){
			let birthVal = birth.val().trim();
			
			regBirth = new Date(birthVal);
			now = new Date();
			
			if((now - regBirth) < 0){
				alert("올바른 형식이 아닙니다!");
				birth.attr('class', 'form-control is-invalid');
				birth.focus();
			}else if(14 > (now.getFullYear() - regBirth.getFullYear()) ){
				alert("14세 이상만 가입 가능합니다!");
				birth.attr('class', 'form-control is-invalid');
				birth.focus();
			}else{
				birth.attr('class', 'form-control is-valid');
			}
		});
		
	})
   </script>
</body>
</html>