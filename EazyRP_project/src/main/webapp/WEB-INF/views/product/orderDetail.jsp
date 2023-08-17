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
    		text-align: center;
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
            font-size: 0.7em;
        }

        td {
            vertical-align: middle;
            font-size: 0.7em;
            text-align: center;
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
    <h2>발주 상세 내역</h2>
	
	<!-- card footer End -->
<form role="form" method="post" action="/product/orderCancel.do">
<input type="hidden" name="o_no" value="${order.o_no }">
	<table>
		<tr>
            <td align="center">작성자</td>
            <td><input type="text" style="" value="${order.sys_reg}" id="name" name="sys_reg" readonly></td>
        </tr>
        <tr>
            <td align="center">등록일자</td>
            <td><input type="text" name="sys_regdate" value="${order.sys_regdate }" readonly></td>
        </tr>
        <tr>
            <td align="center">진행 상태</td>
            <td>${order.progress }</td>
        </tr>
        <tr>
            <td align="center">발주 보고서</td>
            <td><a id="aTag" href="#" onclick="OpenWindow('/management/detail.do?dr_no=${order.dr_no}', '기안문', 700, 700)">${order.title }</a></td>
        	<input type="hidden" name="dr_no" value="${order.dr_no}">
        </tr>
    </table>
    <table style="margin: 0px;">
        <tr>
            <th align="center" style="width: 20%;">창고명</th>
            <th align="center" style="width: 20%;">업체명</th>
            <th align="center" style="width: 20%;">제품명</th>
            <th align="center" style="width: 20%;">수량</th>
            <th align="center" style="width: 20%;">가격</th>
        </tr>
    	<tbody id="prInput">
       <c:forEach items="${detail }" var="detail" varStatus="loop">
        <tr>    	
            <td><input type="text" id="wh_name" name="wh_name" style="width: 100%;" value="${detail.wh_name}" readonly></td>
            <td><input type="text" id="con_c_name" name="con_c_name" style="width: 100%;" value="${detail.c_name}" readonly></td>
            <td><input type="text" id="pr_name" name="pr_name" style="width: 100%;" value="${detail.pr_name}" readonly></td>
            <td><input type="text" id="amount" name="amount" style="width: 100%;" value="${detail.quantity}" ></td>
            <td><input type="text" id="amount" name="amount" style="width: 100%;" value="${detail.buy_price} 원" readonly ></td>
        </tr>
        </c:forEach>
        </tbody>
        <tr class="total">
            <td colspan="3" align="center">총계</td>
            <td colspan="2" align="center"><input type="text" id="totalAmount" style="width: 100%;" value="${order.buy_price } 원" readonly></td>
        </tr>
    </table>
    <div class="card-footer">
		<button type="button" id="listBtn" class="btn btn-primary">닫기</button>
		<c:if test="${order.progress eq '배송중'}">
	    	<button type="button" id="receiveBtn" class="btn btn-primary">입고 확인</button>
	    </c:if>
		<button type="button" id="cancelBtn" class="btn btn-danger" style="float: right;" ${order.progress ne '접수중' ? 'disabled' : '' }>요청 취소</button>
	</div>
</form>
</body>


	

<script>
window.onload = function(){
	
	let fc_no = "${est.FC_NO}";
	$('#fc-select').val(fc_no);
	$('select#fc-select').find('option[value="' + fc_no + '"]').attr('selected', 'selected');
	console.log(fc_no);
	
	let formObj = $('form[role="form"]');
	$('#cancelBtn').on('click', function(){
		if(confirm('정말로 취소하시겠습니까?')){
			$('form[role="form"]').submit();
		}
	})
	
	$('#receiveBtn').on('click', function(){
		if(confirm('입고 확정 처리하시겠습니까?')){
			alert("입고가 확정되었습니다.");
			location.href="/product/receive.do?o_no=${order.o_no }";
		}
	})
	
	$('button#listBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	});
}

</script>

<script>
let rownumList = $('.rownum');
let cnt = rownumList.length; 
console.log(cnt);
let dtail_no = $('#dtail_no').val();
// 제품 추가 버튼
$('#addPutBtn').on('click', function(){
	cnt++;
	$('#prInput').append('<tr><input type="hidden" class="rownum" value="'+ cnt + '">' +
	'<input type="hidden" name="estdetail_no" value="0">'+
    '<td><input type="text" id="'+ cnt +'" class="pr_names" name="pr_name" style="width: 100%;" value=""><input type="hidden" name="pr_no"></td>'+
    '<td><input type="text" id="wh_no' + cnt +'" class="wh_names" name="wh_name" style="width: 100%;" value=""><input type="hidden" name="wh_no"></td>'+
    '<td><input type="text" id="quantity'+cnt+'" class="quantity" name="quantity" style="width: 100%;" value=""><input type="hidden" id="cost"></td>'+
    '<td><input type="text" id="amount" name="amount" style="width: 100%;" value=""></td>'+
    '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-secondary">삭제</button></td>'+
'</tr>');
	
	
	
//		$('script').append(
//			'$("#quantity' + cnt + '").on("keyup", function(){'+
//				'alert($(this).val())'+
//				'$(this).parent().next().children().val($(this).val()*$(this).next().val())});'
//		)
});


function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
	winleft = (screen.width - WinWidth) / 2;
	wintop = (screen.height - WinHeight) / 2;
	var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
							+ "height=" + WinHeight + ",top="+ (wintop - 50) + ",left="
							+ (winleft + 50) + ",resizable=yes,status=yes");
	win.focus();
	return win;
};

$('tr').on('click', function(){
	$('#name', opener.document).val($(this).find('#c_name').text() + " / " + $(this).find('#name').text());
	$('#receiver', opener.document).val($(this).find("#emp_no").val());
	
})

	// 제품코드 td 클릭 이벤트
	$(document).on('click', '.pr_names', function(){
		let idVal = $(this).parents("tr").find(".rownum").val();
		console.log(idVal);
		$('#cnt').val(idVal);
		let openWin = OpenWindow("/erp4/findProduct.do", "제품 찾기", 500, 500);
		
	});
	
	//제품 삭제 버튼
	$('#prInput').on('click', '#cancelBtn', function(){
		$(this).parent('td').parent('tr').remove();
	});
	
	//창고코드 이벤트
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

	
	$(document).on('change, keyup', '#prInput', function(){
		let sum = Number(0);
		let inputAmount = $('input[name="amount"]').get();
		for(let i = 0; i < inputAmount.length; i++){
			sum += Number($('input[name="amount"]').eq(i).val());
		}
		
		$('#totalAmount').val(sum);
	})
	
</script>


</html>
