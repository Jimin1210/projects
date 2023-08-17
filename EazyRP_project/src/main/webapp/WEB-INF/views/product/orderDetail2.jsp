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
            <td align="center">요청 업체</td>
            <td><input type="text" style="" value="${c_name}" id="name" name="sys_reg" readonly></td>
        </tr>
        <tr>
            <td align="center">등록 일자</td>
            <td><input type="text" name="sys_regdate" value="${order.sys_regdate }" readonly></td>
        </tr>
        <tr>
            <td align="center">진행 상태</td>
            <td>${order.progress }</td>
        </tr>
    </table>
    <table style="margin: 0px;">
        <tr>
            <th align="center" style="width: 25%;">창고명</th>
            <th align="center" style="width: 20%;">업체명</th>
            <th align="center" style="width: 20%;">제품명</th>
            <th align="center" style="width: 15%;">수량</th>
            <th align="center" style="width: 20%;">가격</th>
        </tr>
    	<tbody id="prInput">
       <c:forEach items="${detail }" var="detail" varStatus="loop">
        <tr>    	
            <td><input type="text" id="wh_name" name="wh_name" style="width: 100%;" value="${detail.wh_name}" readonly></td>
            <td><input type="text" id="con_c_name" name="con_c_name" style="width: 100%;" value="${detail.c_name}" readonly></td>
            <td><input type="text" id="pr_name" name="pr_name" style="width: 100%;" value="${detail.pr_name}" readonly></td>
            <td><input type="text" id="amount" name="amount" style="width: 100%;${detail.lack eq 'Y' ? 'color: red;' : '' }"  value="${detail.quantity}" >
            <c:if test="${detail.lack eq 'Y'}"><p style="position: absolute; z-index: 2; font-size: 0.5em; color: red; right: 25%;">해당 창고에 재고가 부족합니다.</p>
            </c:if>
            </td>
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
        <button type="button" id="registBtn" class="btn btn-warning" style="float: right;" onclick="OpenWindow('/erp4/workorder/registForm.do', '작업지시서 작성', 700, 700)">작업지시서 작성</button>
        <c:if test="${order.progress eq '접수중'}">
	    	<button type="button" id="receiptBtn" class="btn btn-primary">접수</button>
	    </c:if>
	    <c:if test="${order.progress eq '접수완료'}">
	    	<button type="button" id="deliveryBtn" class="btn btn-primary" ${del eq 'N' ? 'disabled' : ''}>배송 처리</button>
	    	<c:if test="${del eq 'N'}"><p style="position: absolute; z-index: 2; font-size: 0.5em; color: red; left: 25%;">재고 부족으로 배송이 불가능합니다.</p></c:if>
	    </c:if>
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
	
	
	$('button#listBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	});
	
	$('#deliveryBtn').on('click', function(){
		if(confirm('배송 처리를 하시겠습니까?')){
			alert('배송 처리가 완료되었습니다.');
			location.href='/product/delivery.do?o_no=${order.o_no }';
		}
	})
	
	$('#receiptBtn').on('click', function(){
		alert('해당 발주 요청건이 접수되었습니다.');
		location.href='/product/receipt.do?o_no=${order.o_no }';
	})
}	
	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2 + 50;
		wintop = (screen.height - WinHeight) / 2 + 50;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
	};



	
</script>


</html>
