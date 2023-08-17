<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	var emailChk = 0;
	$('#email').on('change', function(){
		emailChk = 0;
	})
		
	$('#emailauth').on('click', function () {
		const email = $('#email').val(); // 이메일 주소값 얻어오기!
		console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
		const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
		if($('#email').val() == $('#email2').val()){
		alert('인증번호가 전송되었습니다.')
		$.ajax({
			type : 'get',
			url :  '<%=request.getContextPath()%>/member/mailCheck.do?email=' + email,
			success : function (data) {
				console.log("data : " +  data);
				checkInput.attr('disabled',false);
				code = data;
			},
			error : function(err){
				alert(err.status)
			}
		});
		} else{
			alert('이메일을 확인해주세요.')
		}// end ajax
	}); // end send eamil
	
	// 인증번호 비교 
	// blur -> focus가 벗어나는 경우 발생
	$('#emailchk').click(function () {
		const inputCode = $('.mail-check-input').val();

		if(inputCode === code){
			emailChk = 1;
			alert('인증번호가 일치합니다.');
			$('#mail-Check-Btn').attr('disabled',true);
			$('#email').attr('readonly',true);
		}else{
			alert('인증번호가 불일치 합니다. 다시 확인해주세요!.');
			emailChk = 0;
		}
	});	
	
	var passChk = 0;
	$('#pwd').on('change', function(){
		passChk = 0;
	})
	// password 정규식 체크 - 영문 소문자, 대문자, 특수문자, 숫자가 반드시 하나 이상씩 입력
	let pass = $("input[name=pwd]");
	pass.on("keyup",  function () {
		passVal = pass.val().trim();
		
		regPass =  /^(?=.*[a-z])(?=.*[A-Z])(?=.*[`~!@$%&?*])[A-Za-z\d`~!@$%&?*]{8,15}/;
		
		if ( !(regPass.test(passVal)) ) {
			pass.attr("class", "form-control is-invalid");
		} else {
			pass.attr("class", "form-control is-valid");
		}
	});
	
	// pass2 pass일치 비교
	let passCheck = $("input[name=pwchk]");
	passCheck.on("keyup", function () {
		let passCheckVal = passCheck.val().trim();
		
		if (passVal != passCheckVal) {
			passCheck.attr("class", "form-control is-invalid");
		} else {
			passChk = 1;
			passCheck.attr("class", "form-control is-valid");
		}
	});	

	$('#cancelBtn').on('click', function(){
		history.go(-1);
	});
	
	function submit_go(){
		
  		if(emailChk != 1){
			alert("이메일 인증이 필요합니다.");
			return false;
		};  
		
		alert("비밀번호 변경이 완료 되었습니다.");
	$('#repwdForm').submit();
	
	}; 
</script>
<%@ include file="../include/footer_js.jsp"%>