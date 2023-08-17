<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
const checkInput = $('.mail-check-input');
	var emailChk = 0;
	$('#email').on('change', function(){
		emailChk = 0;
	})

	
	$('#emailauth').on('click', function(){
		let id = $('input[name="id"]').val();
		let email = $('#email').val();
	$.ajax({
		type : 'get',
		url :  '<%=request.getContextPath()%>/member/mailChecked2.do?id=' + id + '&email=' + email,
		success : function (data) {
			if(data == 1){
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
				} else{
					alert('ID나 이메일주소를 다시 확인해주세요.')
				}
		},
		error : function(err){
			alert(err.status)
		}
	}); // end send eamil
	})
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
		
		if($('input[name="id"]').val() == ""){
			alert("아이디는 필수 입니다.");
			return false;
		};

  		if(emailChk != 1){
			alert("이메일 인증이 필요합니다.");
			return false;
		};  
		
	$('#pwFindForm').submit();
	
	}; 
</script>