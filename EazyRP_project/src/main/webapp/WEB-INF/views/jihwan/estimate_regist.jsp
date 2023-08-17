<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>견적서</title>
    
    <style>
    	input {
    		border: none;
    		text-size : 100%;
    	}
    	html {
    		display: flex;
    		align-items: center;
    		justify-content: center;
    		font-size: 0.7em;
    	}
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            align-items: center;
    		justify-content: center;
            width: 70%;
            height: 70%;
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

        th,
        td {
            padding: 10px;
            border: 1px solid #ccc;
        }

        th {
            background-color: #f2f2f2;
            text-align: center;
        }

        td {
            vertical-align: middle;
        }

        .total,
        .files {
            font-weight: bold;
        }

        .note {
            font-style: italic;
        }
    </style>
</head>
	

<body>
    <h2>DW 견적서 등록</h2>
	<!-- card footer End -->
<form role="form" method="post" action="/erp4/insertEstimate.do" enctype="multipart/form-data">
	<table>
        <tr>
            <td width="40%" align="center"><b>담당자</b></td>
            
            <td><input type="hidden" name="emp_no" id="receiver" value="${empno }">
            <input type="text" style="width: 100%;" value="${ename }" id="name" name="name" readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 400, 600)"></td>
        </tr>
        <tr>
            <td width="40%" align="center"><b>외화 명</b></td>
            <td><select name="fc_no" id="fc-select">
			    <option value="FC_001">달러</option>
			    <option value="FC_002">한화</option>
			    <option value="FC_003">위안화</option>
			    <option value="FC_004">엔화</option>
			    <option value="FC_005">페소</option>
			    <option value="FC_006">동</option>
				</select></td>
        </tr>
<!--         <tr> -->
<!--          <td width="40%" align="center"><b>진행상태</b></td> -->
<!--          <td><select name="progress" id="progress"> -->
<!-- 				<option value="처리중">처리중</option> -->
<!-- 				<option value="완료">완료</option> -->
<!-- 		</select></td> -->
<!-- 		</tr> -->
        <tr>
            <td align="center"><b>첨부파일</b></td>
            <td><input type="file" style="width: 100%;" id="file" name ="files" value="">
            	<input type="hidden" id="fileName" name="fileName" value=""> 
            	<input type="hidden" id="realfilename" name="realfilename" value="">
            </td>
        </tr>
    </table>
    <button type="button" id="addPutBtn" style="margin-bottom: 10px;" class="btn btn-primary">제품추가</button>
    <table>
    	<thead>
        <tr>
            <th align="center" style="width: 20%;">제품명</th>
            <th align="center" style="width: 20%;">창고명</th>           
            <th align="center" style="width: 20%;">수량</th>
            <th align="center" style="width: 20%;">가격</th>
            <th align="center" style="width: 15%;">비고</th>
            
        </tr>
        </thead>
        <tbody id="prInput">
        <input type="hidden" value="" id="cnt">
         <input type="hidden" value="A" id="A">
        <tr>
            <td><input type="text" id="0" class="pr_names" name="pr_name" style="width: 100%;" value=""><input type="hidden" name="pr_no"></td>
            <td><input type="text" id="wh_no0" class="wh_names" name="wh_name" style="width: 100%;" value=""><input type="hidden" id="wh_0" name="wh_no"></td>
            <td><input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value=""><input type="hidden" id="cost"></td>
            <td><input type="text" id="amount" name="amount" style="width: 100%;" value=""></td>
            <td style="text-align : center;"></td>
        </tr>
        </tbody>
        <tr class="total">
            <td colspan="3" align="center">총계</td>
            <td colspan="2" align="center"><input type="text" id="totalAmount" style="width: 100%;" value=""></td>
        </tr>
    </table>
            <input type="button" id="registBtn" class="btn btn-primary" style="text-align : center;" value="생성">
            <input type="button" id="closeBtn" class="btn btn-warning" style="text-align : center;" value="닫기">
</form>
</body>

<script>

	$('#file').on('change', function(){
		$('#fileName').val($('#file').val());
	})
	
	let cnt = 1;
	
	// 파일 추가 버튼
	$('#addPutBtn').on('click', function(){
		cnt++;
		$('#prInput').append('<tr>'+
        '<td><input type="text" id="'+ cnt +'" class="pr_names" name="pr_name" style="width: 100%;" value=""><input type="hidden" name="pr_no"></td>'+
        '<td><input type="text" id="wh_no' + cnt +'" class="wh_names" name="wh_name" style="width: 100%;" value=""><input type="hidden" id="wh_'+ cnt+ '" name="wh_no"></td>'+
        '<td><input type="text" id="quantity'+cnt+'" class="quantity" name="quantity" style="width: 100%;" value=""><input type="hidden" id="cost"></td>'+
        '<td><input type="text" id="amount" name="amount" style="width: 100%;" value=""></td>'+
        '<td style="text-align : center;"><button type="button" id="cancelBtn">삭제</button></td>'+
    '</tr>');
		
// 		$('script').append(
// 			'$("#quantity' + cnt + '").on("keyup", function(){'+
// 				'alert($(this).val())'+
// 				'$(this).parent().next().children().val($(this).val()*$(this).next().val())});'
// 		)
	});
	
	// 제품코드 td 클릭 이벤트
	$(document).on('click', '.pr_names', function(){
		let idVal = $(this).attr('id');
		$('#cnt').val(idVal);
		let openWin = OpenWindow("/erp4/findProduct.do", "제품 찾기", 500, 500);
		
// 		openWin.document.getElementById('cnt').value = cnt;
	});
	
	// 제품 삭제 버튼
	$('#prInput').on('click', '#cancelBtn', function(){
		$(this).parent('td').parent('tr').remove();
	});
	
	// 창고코드 이벤트
	$(document).on('click', '.wh_names', function(){
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findWareHouse.do","창고 찾기", 500,500);
	})
	
	// 수량 이벤트
	$(document).on('keyup', '.quantity', function(){
// 		let quantity = $(this).val();
		$(this).parent().next().children().val($(this).val()*$(this).next().val());
	})
	
	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
		return win;
	};
	
	$(document).on('change, keyup', '#prInput', function(){
		let sum = Number(0);
		let inputAmount = $('input[name="amount"]').get();
		for(let i = 0; i < inputAmount.length; i++){
			sum += Number($('input[name="amount"]').eq(i).val());
		}
		
		$('#totalAmount').val(sum);
	})
	
	$('#registBtn').on('click', function () {
		
		for(let i = 0; i < $('input[type="text"]').get().length; i++){
			if($('input[type="text"]').eq(i).val() == "" || $('input[type="text"]').eq(i).val() == null) {
				alert("값을 입력해 주세요.");
				return;
			}
		}
				
		$('form[role="form"]').submit();
		
	})
	
	
	$('#closeBtn').on('click', function(){
		window.close();
	})
	
	
</script>

	

<!-- <script> -->


<!-- </script> -->

<script	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
</html>
