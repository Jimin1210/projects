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
    <h2>구매 상세 내역</h2>
	<div class="card-footer">
		<button type="button" id="removeBtn" class="btn btn-danger">삭제</button>
		<button type="button" id="listBtn" class="btn btn-primary">닫기</button>
	</div>
	<!-- card footer End -->
<form role="form" method="post" enctype="multipart/form-data">
<input type="hidden" name="sheet_no" value="${sheet.sheet_no }">
	<table>
		<tr>
            <td align="center">작성자</td>
            <td><input type="hidden" name="emp_no" id="receiver" value="${sheet.e_name }">
            <input type="text" style="" value="${sheet.e_name}" id="name" name="name" readonly></td>
        </tr>
        <tr>
            <td align="center">등록일자</td>
            <td><input type="text" name="sys_regdate" value="${sheet.sys_regdate }" readonly></td>
        </tr>
        <tr>
            <td align="center">비고</td>
            <td>${sheet.pr_name }</td>
        </tr>
    </table>
    <table>
        <tr>
            <th align="center" style="width: 33%;">제품명</th>
            <th align="center" style="width: 33%;">수량</th>
            <th align="center" style="width: 33%;">가격</th>
        </tr>
    	<tbody id="prInput">
       <c:forEach items="${detail }" var="detail" varStatus="loop">
        <tr>    	
            <td><input type="text" id="amount" name="amount" style="width: 100%;" value="${detail.pr_no}" readonly ></td>
            <td><input type="text" id="amount" name="amount" style="width: 100%;" value="${detail.quantity}" readonly ></td>
            <td><input type="text" id="amount" name="amount" style="width: 100%;" value="${detail.amount} 원" readonly ></td>
        </tr>
        </c:forEach>
        </tbody>
        <tr class="total">
            <td colspan="1" align="center">총계</td>
            <td colspan="2" align="center"><input type="text" id="totalAmount" style="width: 100%;" value="${sheet.price } 원" readonly></td>
        </tr>
    </table>
</form>
</body>


	

<script>
window.onload = function(){
	
	let fc_no = "${est.FC_NO}";
	$('#fc-select').val(fc_no);
	$('select#fc-select').find('option[value="' + fc_no + '"]').attr('selected', 'selected');
	console.log(fc_no);
	
	let formObj = $('form[role="form"]');

	$('button#modifyBtn').on('click', function(){
		formObj.attr({
			'action' : 'modifyForm.do',
			'method' : 'post'
// 			'enctype' : 'multipart/form-data'
		});
		console.log($('form[role="form"]').serializeArray());
		formObj.submit();
	});
	
	$('button#removeBtn').on('click', function(){
		if(confirm("정말 삭제하시겠습니까?")){
			formObj.attr({
				'action' : 'remove',
				'method' : 'post' 
			});
			formObj.submit();
		};
	});
	
	$('button#listBtn').on('click', function(){
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
							+ "height=" + WinHeight + ",top="+ wintop + ",left="
							+ winleft + ",resizable=yes,status=yes");
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
