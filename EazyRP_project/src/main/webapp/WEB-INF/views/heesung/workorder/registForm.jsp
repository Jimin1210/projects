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
    <title>작업지시서 등록</title>
    
    <style>
    	input {
    		border: none;
    		text-size : 100%;
    		width: 100%;
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
    <h2>작업지시서 등록</h2>
	<!-- card footer End -->
<form role="form" method="post" action="/erp4/workorder/regist.do" enctype="multipart/form-data">
	<table>
        <tr>
        	<td width="40%" align="center"><b>제목</b></td>
            <td><input type="text" name="wo_name"></td>
        </tr>
        <tr>
            <td width="40%" align="center"><b>담당자</b></td>
            <td>
	            <input type="hidden" name="emp_no" id="receiver" value="${empno }">
	            <input type="text" style="width: 100%;" value="${c_name } / ${ename }" id="name" name="name" readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 400, 600)">
            </td>
        </tr>
        <tr>
        	<td width="40%" align="center"><b>마감일</b></td>
        	<td width="40%" align="center">
				<input type="date" id="endperiod" name="deliverydate" class="form-control mch7" value="" placeholder="납기일을 입력하세요.">
        	</td>
        </tr>
        <tr>
            <td width="40%" align="center">
            	<b>상태</b>
            </td>
            <td>
            	<select name="progress" id="fc-select">
				    <option value="0">대기중</option>
				    <option value="1">진행중</option>
				    <option value="2">완료</option>
				</select>
			</td>
        </tr>
<!--         <tr> -->
<!--             <td align="center"><b>첨부파일</b></td> -->
<!--             <td><input type="file" style="width: 100%;"  name ="files" value=""> -->
<!--             	<input type="hidden" id="fileName" name="fileName" value="">  -->
<!--             </td> -->
<!--         </tr> -->
    </table>
    <button type="button" id="addPutBtn" style="margin-bottom: 10px;" class="btn btn-primary">추가</button>
    <table>
    	<thead>
        <tr>
            <th align="center" style="width: 25%;">품목명</th>
            <th align="center" style="width: 25%;">생산 공장</th>
            <th align="center" style="width: 25%;">수량</th>
            <th align="center" style="width: 25%;">비고</th>
        </tr>
        </thead>
        <tbody id="prInput">
        <input type="hidden" value="" id="cnt">
        <input type="hidden" value="A" id="A">
        <input type="hidden" id="sort" value="registForm">
        <tr>
            <td>
            	<input type="text" id="0" class="pr_names" name="pr_name" style="width: 100%;" value="">
            	<input type="hidden" name="pr_no">
            </td>
            <td>
				<input type="text" id="fac_no0" class="fac_names" name="fac_name" style="width: 100%;" value="">
				<input type="hidden" name="fac_no" id="fac_no0">
			</td>
            <td>
            	<input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value="">
            	<input type="hidden" id="cost">
            </td>
            <td style="text-align : center;"></td>
        </tr>
        </tbody>
        <tr class="total">
            <td colspan="2" align="center">총량</td>
            <td colspan="2" align="center"><input type="text" id="woTotal" style="width: 100%;" value=""></td>
        </tr>
    </table>
            <input type="button" id="registBtn" class="btn btn-primary" style="text-align : center;" value="등록">
</form>
</body>

<script>
	let cnt = 1;
	// 파일 추가 버튼
	$('#addPutBtn').on('click', function(){
		cnt++;
		$('#prInput').append('<tr>'+
        '<td><input type="text" id="'+ cnt +'" class="pr_names" name="pr_name" style="width: 100%;" value=""><input type="hidden" name="pr_no"></td>'+
        '<td><input type="text" id="fac_no' + cnt + '" class="fac_names" name="fac_name" style="width: 100%;" value=""><input type="hidden" name="fac_no" id="fac_no' + cnt + '"></td>'+
        '<td><input type="text" id="quantity'+cnt+'" class="quantity" name="quantity" style="width: 100%;" value=""><input type="hidden" id="cost"></td>'+
        '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'+
    '</tr>');
		
// 		$('script').append(
// 			'$("#quantity' + cnt + '").on("keyup", function(){'+
// 				'alert($(this).val())'+
// 				'$(this).parent().next().children().val($(this).val()*$(this).next().val())});'
// 		)
	});
	
	// 제품코드 td 클릭 이벤트
	$(document).on('click', '.pr_names', function() {
		let idVal = $(this).attr('id');
		$('#cnt').val(idVal);
		let openWin = OpenWindow("/erp4/findMakeProduct.do", "제품 찾기", 800, 600);
	});
	
	// 제품 삭제 버튼
	$('#prInput').on('click', '#cancelBtn', function(){
		$(this).parent('td').parent('tr').remove();
	});
	
	// 공장 클릭시 목록 열기 이벤트
	$(document).on('click', '.fac_names', function() {
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findFactory.do", "공장 찾기", 800, 600);
	})
	
	// 창고코드 이벤트
	$(document).on('click', '.wh_names', function() {
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findWareHouse.do", "창고 찾기", 800, 600);
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
	
	$(document).on('change keyup click', '#prInput, button#cancelBtn', function(){
		let sum = Number(0);
		let inputAmount = $('input[name="quantity"]').get();
		
		for(let i = 0; i < inputAmount.length; i++){
			sum += Number($('input[name="quantity"]').eq(i).val());
		}
		
		$('#woTotal').val(sum);
	})
	
	$(document).on('click', '#registBtn', function() {
		
		let form = $('form[role="form"]');
		let wo_name = $('input[name="wo_name"]').val();
		let deliverydate = $('input[name="deliverydate"]').val();
		let valid = true;
		
		if (wo_name == "") {
			alert("제목을 입력하세요.");
			valid = false;
		} else if (deliverydate == "") {
			alert("마감일을 선택하세요.")
			valid = false;
		} else {
			$('#prInput tr').each(function(index, row){
				let pr_name = $(row).find('.pr_names').val();
				let fac_name = $(row).find('.fac_names').val();
				let quantity = $(row).find('.quantity').val();
				
				if (pr_name == "" || fac_name == "" || quantity == "") {
					alert("빈칸을 모두 입력하세요.");
					valid = false;
	                return false; // Loop 종료
				}
			});
		}
		
		if (valid) {
	        form.submit();
	    }
		
	})
	
</script>

	

<!-- <script> -->


<!-- </script> -->

<script	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
</html>
