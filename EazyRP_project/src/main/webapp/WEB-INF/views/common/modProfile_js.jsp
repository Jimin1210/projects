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
		}); // end ajax
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
	
	$('#cancelBtn').on('click', function(){
		history.go(-1);
	});
	
	function submit_go(){
		if($('input[name="tel"]').val() == ""){
			alert("전화번호는 필수입니다.");
			return false;
		};
		
		if($('input[name="addr"]').val() == ""){
			alert("주소는 필수입니다.");
			return false;
		};
		
  		if(emailChk != 1){
			alert("이메일 인증이 필요합니다.");
			return false;
		};  
		
	
	$('#modProfileForm').submit();
	
	}; 
</script>
<%@ include file="../include/footer_js.jsp"%>