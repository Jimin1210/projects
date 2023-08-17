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
            font-size: 0.7em;
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
        .readonly{
        	border: none;
        }
    </style>
</head>
	

<body>
    <h2>구매 내역 추가</h2>
	<!-- card footer End -->
<form role="form" method="post" action="/product/productBuyRegistFrom.do" enctype="multipart/form-data">
	<table>
        <tr>
            <td width="40%" align="center"><b>작성자</b></td>
            <td><input type="hidden" name="emp_no" id="receiver" value="${empno }">
            <input type="text" value="${ename }" id="name" name="name" readonly class="readonly"></td>
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
        <tr>
            <td align="center"><b>비고</b></td>
            <td><input type="text" name="pr_name" id="pr_name" style="width: 100%;"></td>
        </tr>
    </table>
    <button type="button" class="btn btn-primary" id="addPutBtn" style="margin-bottom: 5px;">제품추가</button>
    <table>
    	<thead>
        <tr>
            <th align="center" style="width: 22%;">제품명</th>
            <th align="center" style="width: 17%;">수량</th>
            <th align="center" style="width: 22%;">가격</th>
            <th align="center" style="width: 22%;">합계</th>
            <th align="center" style="width: 15%;"></th>
            
        </tr>
        </thead>
        <tbody id="prInput">
        <input type="hidden" value="" id="cnt">
        <tr>
            <td><input type="text" class="pr_no" name="pr_no" style="width: 100%;" value=""></td>
            <td><input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value=""></td>
            <td><input type="text" class="cost" id="cost" style="width: 100%;"></td>
            <td><input type="text" id="amount" name="amount" style="width: 100%;" value="" class="readonly" readonly></td>
            <td style="text-align : center;"></td>
        </tr>
        </tbody>
        <tr class="total">
            <td colspan="3" align="center">총계</td>
            <td colspan="2" align="center"><input type="text" id="price" name="price" class="readonly" style="width: 100%;" value="" readonly></td>
        </tr>
    </table>
            <input type="submit" class="btn btn-primary" style="text-align : center;" value="등록">
            <input type="button" id="calcelBtn" class="btn btn-warning" style="text-align : center;" value="닫기">
</form>
</body>

<script>
	let cnt = 1;
	// 파일 추가 버튼
	$('#addPutBtn').on('click', function(){
		cnt++;
		$('#prInput').append('<tr>'+
			'<td><input type="text" class="pr_no" name="pr_no" style="width: 100%;" value=""></td>'+
           '<td><input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value=""></td>'+
           '<td><input type="text" class="cost" id="cost" style="width: 100%;"></td>'+
           '<td><input type="text" id="amount" name="amount" style="width: 100%;" value="" class="readonly" readonly></td>'+
           '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'+
    '</tr>');
	});
	
	$('#calcelBtn').on('click', function(){
		window.close();
	})
	
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
		var cost = $(this).parent('td').next().find('#cost').val();
		console.log(cost)
		var amount = $(this).parent('td').next().next().find('#amount').val();
		console.log(amount)
		console.log($(this).val());
		$(this).parent('td').next().next().find('#amount').val(cost * $(this).val());
	})
	
	$(document).on('keyup', '.cost', function(){
		var quantity = $(this).parent('td').prev().find('#quantity').val();
		console.log(quantity)
		var amount = $(this).parent('td').next().find('#amount').val();
		console.log(amount)
		$(this).parent('td').next().find('#amount').val(quantity * $(this).val());
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
		
		$('#price').val(sum);
	})
	
</script>

	

<!-- <script> -->


<!-- </script> -->

<script	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
</html>
