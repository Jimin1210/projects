<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>A/S 등록</title>

<style>
	input {
		border: none;
		text-size: 100%;
	}
	
	html {
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 0.7em;
	}
	
	body {
		font-family: Arial, sans-serif;
		margin: 5em;
		align-items: center;
		justify-content: center;
	}
	
	h2 {
		color: #333;
		text-align: center;
		margin-bottom: 30px;
	}
	
	table {
		width: 100%;
		border-collapse: collapse;
		margin-bottom: 20px;
	}
	
	th, td {
		padding: 1em;
		border: 1px solid #ccc;
	}
	
	th {
		background-color: #f2f2f2;
		text-align: center;
	}
	
	td {
		vertical-align: middle;
	}
	
	.total, .files {
		font-weight: bold;
	}
	
	.note {
		font-style: italic;
	}
	
</style>
</head>


<body style="width: 400px;">
	<h2>A/S 등록</h2>
	<!-- card footer End -->
	<form role="form" method="post" action="/asmanage/regist.do" enctype="multipart/form-data">
		<table>
			<tr>
				<td width="40%" align="center"><b>담당자</b></td>
				<td>
					<input type="hidden" name="emp_no" id="receiver" value="${empno }"> 
					<input type="text" style="width: 100%;" value="${c_name }  ${ename }" id="name" name="name" 
							readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 400, 600)">
				</td>
			</tr>
			
			<tr>
				<td width="40%" align="center"><b>A/S 비용</b></td>
				<td>
					<div style="display: flex;">
						<input type="text" style="width: 78%;" value="" id="asprice" name="asprice">
					</div>
				</td>
			</tr>
			<tr>
				<td width="40%" align="center"><b>수리예정일</b></td>
				<td width="100%">
					<input type="date" id="sys_regdate" name="sys_regdate" class="form-control col-sm-9 mch6" value="" placeholder="요청날짜를 입력하세요.">
				</td>
			</tr>
		</table>
		<table>
 		<tr>
	        	<td width="40%" align="center"><b>A/S 내용</b></td>
	        	<td width="100%">
					<textarea row="5" cols="50" name="content"></textarea>
	        	</td>
	        </tr>
 	</table>
		<button type="button" id="submitBtn" class="btn btn-primary" style="text-align: center;" value="">등록</button>
		<input type="button" class="btn btn-warning" id="closeBtn" value="취 소">
	</form>
</body>

<script>

	let cnt = 1;
	
	// 제품코드 td 클릭 이벤트
	$(document).on('click', '.pr_names', function() {
		let idVal = $(this).attr('id');
		$('#cnt').val(idVal);
		let openWin = OpenWindow("/erp4/findProduct.do", "제품 찾기", 800, 600);
	});



	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight) {
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width="
				+ WinWidth + ", " + "height=" + WinHeight + ",top=" + wintop
				+ ",left=" + winleft + ",resizable=yes,status=yes");
		win.focus();
		return win;
	};
	
	// 취소버튼 클릭
	$('input#closeBtn').on('click', function() {
		window.close();							// 윈도우 창을 닫는다.
	});
	
	let submitBtn = $('input[type=submit]#submitBtn');
	let form = $('form[role="form"]');

	$(document).on('click', '#submitBtn', function() {
		
		if ($('input[name=emp_no]').val() == "") {
			
			alert("담당자를 선택하세요.");
			
		} else if ($('input[name="asprice"]').val() == "") {
			
			alert("A/S 비용을 입력하세요.");
	
		} else if ($('input[name="sys_regdate"]').val() == "") {
			
			alert("수리 예정일을 선택하세요.");
	
		}  
		else if ($('input[name="content"]').val() == "") {
			
			alert("A/S 내용을 입력하세요.");
		} else {
				
			form.submit();
				
		};

	})
	
</script>

<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

</html>
