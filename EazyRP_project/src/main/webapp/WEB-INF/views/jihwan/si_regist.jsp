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
    <title>출하지시서</title>
    
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
    <h2>DW 출하지시서 등록</h2>
	<!-- card footer End -->
<form role="form" method="post" action="/erp4/insertSi.do"enctype="multipart/form-data">
	<table>
        <tr>
            <td align="center">담당자</td>
            <td><input type="hidden" name="emp_no" id="receiver" value="${empno }">
            <input type="text" style="width: 100%;" value="${ename }" id="name" name="name" readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 500, 500)"></td>
        </tr>
<!--         <tr> -->
<!--          <td width="40%" align="center"><b>진행상태</b></td> -->
<!--          <td><select name="progress" id="progress"> -->
<!-- 				<option value="출하대기중">출하대기중</option> -->
<!-- 				<option value="출하완료">출하완료</option> -->
<!-- 			</select> -->
<!-- 		</td> -->
<!-- 		</tr> -->
         <tr>
            <td align="center">출하 창고</td>
             <td><input type="text" id="si_whname" class="wh_names" name="wh_name" style="width: 100%;" value=""><input type="hidden" name="wh_no" value=""></td>
        </tr>
        <tr>
            <td align="center">출하 일자</td>
            <td><input type="date" id="dateInput" name="shipdate" value=""></td>
        </tr>
       
    </table>
    <button type="button" id="addPutBtn" style="margin-bottom: 10px;" class="btn btn-primary">버튼 추가</button>
    <table>
          <tr>
        	 <th align="center" style="width: 20%;">제품코드</th> 
            <th align="center" style="width: 20%;">제품 명</th>           
            <th align="center" style="width: 20%;">수량</th>
           	<th align="center" style="width: 20%;">내용</th>
           	<th align="center" style="width: 20%;"></th>
        </tr>
    	<tbody id="prInput">
    	<input type="hidden" value="" id="cnt">
        <input type="hidden" value="B" id="A">
        <tr id="trChk" >    	
	       <input type="hidden" class="rownum" value="">
	       <input type="hidden" name="sidetail_no" id="sidtail_no" value="">
	       <input type="hidden" name="enabled" id="estenabled" value="">
	       <input type="hidden" name="pr_delete" value="n">
        	<td><input type="hidden" id="pr_no0" name="pr_no" value=""></td>
        	<td><input type="text" id="0" class="pr_names3" name="pr_name" style="width: 100%;" value=""></td>
            <td><input type="text" id="quantity0" class="quantity" name="quantity" style="width: 100%;" value="">
            <td><input type="text" id="contents0" class="content" name="content" style="width: 100%;" value=""  ></td>
            <td style="text-align : center;"></td>
        </tr>
        
        </tbody>
        <tr class="total">
            <td colspan="2" align="center">총 수량</td>
            <td colspan="1" align="center"><input type="text" id="totalQuantity" style="width: 100%;" value="" readonly></td>
            <td colspan="2" align="center"></td>
        </tr>
    </table>
    <input type="button" id="registBtn" class="btn btn-primary" style="text-align : center;" value="생성">
    <input type="button" id="closeBtn" class="btn btn-warning" style="text-align : center;" value="닫기">
</form>
</body>
<script>
	let cnt = 1;
	// 제품 추가 버튼
	$('#addPutBtn').on('click', function(){
		cnt++;
		$('#prInput').append('<tr id="trChk"><input type="hidden" class="rownum" value="'+ cnt + '">' +
		'<input type="hidden" name="sidetail_no" value="0">'+
		'<input type="hidden" name="pr_delete" value="n">'+
		'<td><input type="hidden" id="pr_no'+ cnt+ '" name="pr_no" value=""></td>' + 
		'<td><input type="text" id="' + cnt + '" class="pr_names3" name="pr_name" style="width: 100%;" value=""></td>' +
	    '<td><input type="text" id="quantity'+ cnt +'" class="quantity" name="quantity" style="width: 100%;" value=""><input type="hidden" id="cost"></td>'+
	    '<td><input type="text" id="contents' + cnt +'"class="content" name="content" style="width: 100%;" value="" ></td>' +
	    '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'+
	'</tr>');
	});
		

	
	// 제품코드 td 클릭 이벤트
	$(document).on('click', '.pr_names3', function(){
		let idVal = $(this).attr('id');
		$('#cnt').val(idVal);
		let openWin = OpenWindow("/erp4/findProduct.do", "제품 찾기", 500, 500);
		
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
	
// 	// 수량 이벤트
// 	$(document).on('keyup', '.quantity', function(){
// // 		let quantity = $(this).val();
// 		$(this).parent().next().children().val($(this).val()*$(this).next().val());
// 	})
	
	// 수량 체인지
	$(document).on('change keyup', '.quantity', function(){
    let totalQuantity = 0;
    $('.quantity').each(function(){
        totalQuantity += parseInt($(this).val()) || 0;
    });
    $('#totalQuantity').val(totalQuantity);
	});

	
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
			if($('input[type="text"]').eq(i).attr('name') == 'content') {
				continue;
			}
			if($('input[type="text"]').eq(i).val() == "" || $('input[type="text"]').eq(i).val() == null) {
				alert("값을 입력해 주세요.");
				return;
			}
		}
		
		if($('#dateInput').val() == '' ){
			alert('출하일자를 입력해주세요!');
			return;
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
