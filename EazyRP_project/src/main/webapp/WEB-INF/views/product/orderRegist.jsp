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
    		width: 80%;
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
        	width: 80%;
        }
    </style>
</head>
	

<body>
    <h2>발주 요청 추가</h2>
	<!-- card footer End -->
<form id="submitForm" method="post" action="/product/orderRegistForm.do">
	<table>
        <tr>
            <td width="40%" align="center"><b>작성자</b></td>
            <td><input type="text" value="${e_name }" id="name" name="sys_reg" readonly class="readonly"></td>
        </tr>
        <tr>
            <td width="40%" align="center"><b>발주 보고서 첨부</b></td>
            <td>
            	<input type="hidden" name="dr_no" id="dr_no">
            	<select name="dr_no2" id="documentSel" style="width: 50%; height: 20px;" ${not empty name ? 'disabled' : ''}>
            			<option value="">보고서 선택</option>
            		<c:forEach items="${draft}" var="draft">
            			<option value="${draft.dr_no }" ${dr_no eq draft.dr_no ? 'selected' : '' }>${draft.title }</option>
            		</c:forEach>
				</select>
				<button type="button" id="documentInsertBtn" class="btn btn-primary" style="margin-left: 5px;">첨부</button>
			</td>
        </tr>
        <tr>
            <td align="center"><b>발주 요청 업체</b></td>
            <td><input type="text" value="${data.get(9) }" readonly class="readonly"><input type="hidden" name="con_c_no" value="${c_no }"></td>
        </tr>
    </table>
    <table>
    	<thead>
        <tr>
            <th align="center" style="width: 25%;">제품명</th>
            <th align="center" style="width: 25%;">창고명</th>
            <th align="center" style="width: 25%;">수량</th>
            <th align="center" style="width: 25%;">발생 금액</th>
        </tr>
        </thead>
        <tbody id="prInput">
        <input type="hidden" id="cnt" value="">
        <c:if test="${not empty name}">
         	<c:forEach var="nameItem" items="${name}" varStatus="loop">
                <tr>
                    <td><input class="readonly" name="pr_name" type="text" value="${name.get(loop.index) }" readonly><input type="hidden" name="pr_no" value="${product.get(loop.index).pr_no }"></td>
                    <td><input type="text" name="wh_name" id="${loop.index }" placeholder="창고 선택" onclick="OpenWindow('/product/findWareHouse.do?pr_name=${product.get(loop.index).pr_name }&quantity=${quantity.get(loop.index) }','창고 찾기', 500,500);" readonly><input type="hidden" name="wh_no" id="no${loop.index }"><input type="hidden" name="lack" id="lack${loop.index }"></td>
                    <td><input class="readonly" type="text" name="quantity" value=${quantity.get(loop.index) } readonly></td>
                    <td><input class="readonly" type="text" name="buy_price2" value="${product.get(loop.index).pr_exprice }" readonly><input type="hidden" name="unit_price2" value="${product.get(loop.index).pr_inprice }"></td>
                </tr>
            </c:forEach>
		</c:if>
        </tbody>
        <tr class="total">
            <td colspan="2" align="center">총계</td>
            <td colspan="2" align="center" id="total"><input class="readonly" type="text" id="buy_price" name="buy_price" value="${totalBuy }" readonly><input type="hidden" id="unit_price" value="${totalUnit }" name="unit_price"></td>
        </tr>
    </table>
    <button class="btn btn-primary" id="submitBtn" style="text-align : center;" value="">요청</button>
    <button id="calcelBtn" class="btn btn-warning" style="text-align : center;" value="">닫기</button>
</form>
</body>

<form id="documentForm" action="/product/document.do" method="post">
	<input type="hidden" id="documentName" name="dr_no" value="">
</form>

<script>
	$('#dr_no').val($('#documentSel').val());
	
	$('select[name="dr_no2"]').on('change', function(){
		$('#documentName').val($('#documentSel').val());
	})

	$('#documentInsertBtn').on('click', function(){
		$('#documentForm').submit();
	})
	
	$('#submitBtn').on('click', function(){
		$('#submitForm').submit();
	})
	
	$('input[name="wh_name"]').on('click', function(){
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
	})
	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
		return win;}
</script>

<script	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
</html>
