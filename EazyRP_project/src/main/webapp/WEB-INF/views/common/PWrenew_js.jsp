<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<script>

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
	

	
 function submit_go(){

		if($('input[name="pwd"]').val() == ""){
 			alert("패스워드는 필수입니다.");
 			return false;
 		};
 		alert("비밀변호 변경이 되었습니다.");
 	$('#PWrenewForm').submit();
	
 	};  
</script>