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
    <title>작업지시서 상세페이지</title>
    
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
    <h2>작업지시서 상세보기</h2>
	<div class="card-footer">
		<button type="button" id="listBtn" class="btn btn-primary">닫기</button>
	</div>
	<!-- card footer End -->
<form role="form" method="post" enctype="multipart/form-data">

		<input type="hidden" name="wo_no" value="${wo.WO_NO}">
		<table>
	        <tr>
	            <td width="40%" align="center"><b>코드번호</b></td>
	            <td width="100%"><input type="text" style="width: 100%;" value="${wo.WO_NO }" readonly></td>
	        </tr>
	        <tr>
	            <td width="40%" align="center"><b>제목</b></td>
	            <td width="100%"><input type="text" style="width: 100%;" value="${wo.WO_NAME }" readonly></td>
	        </tr>
	        <tr>
	            <td width="40%" align="center"><b>담당자</b></td>
	            <td width="100%">
	            	<input type="hidden" id="receiver" name="emp_no" value="${wo.EMP_NO }">
	            	<input type="text" style="width: 100%;" value="${wo.C_NAME } / ${wo.E_NAME }" id="name" name="name" readonly>
	            </td>
	        </tr>
	        <tr>
	        	<td width="40%" align="center"><b>등록일</b></td>
	        	<td width="40%" align="center">
					<input type="date" id="sys_regdate" class="form-control mch7" value="${wo.SYS_REGDATE }" placeholder="등록일" disabled>
	        	</td>
	        </tr>
	        <tr>
	        	<td width="40%" align="center"><b>마감일</b></td>
	        	<td width="40%" align="center">
					<input type="date" id="endperiod" name="deliverydate" class="form-control mch7" value="${wo.DELIVERYDATE }" placeholder="납기일을 입력하세요." disabled>
	        	</td>
	        </tr>
	        <tr>
	            <td width="40%" align="center">
	            	<b>상태</b>
	            </td>
	            <td>
	            	<select name="progress" id="progress_select" disabled>
					    <option>선택</option>
					    <option value="" ${wo.PROGRESS eq '' ? 'selected' : '' }>선택</option>
					    <option value="0" ${wo.PROGRESS eq '0' ? 'selected' : '' }>대기중</option>
					    <option value="1" ${wo.PROGRESS eq '1' ? 'selected' : '' }>진행중</option>
					    <option value="2" ${wo.PROGRESS eq '2' ? 'selected' : '' }>완료</option>
					</select>
				</td>
	        </tr>
	    </table>
    <table>
    	
        <tr>
            <th align="center" style="width: 25%;">품목명</th>
            <th align="center" style="width: 25%;">생산 공장</th>
            <th align="center" style="width: 25%;">수량</th>
            <th align="center" style="width: 25%;">비고</th>
        </tr>
    	<tbody id="prInput">
        <input type="hidden" value="" id="cnt">
        <input type="hidden" value="A" id="A">
       	<c:forEach items="${woDetail }" var="woDetail" varStatus="loop">
	        <tr id="trChk" >    	
				<input type="hidden" class="rownum" value="${woDetail.ROWNUM }">
				<input type="hidden" name="detail_no" id="dtail_no" value="${woDetail.DETAIL_NO }">
	<%-- 	       <input type="hidden" name="enabled" id="estenabled" value="${est.ENABLED }"> --%>
				<input type="hidden" name="pr_delete" value="o">
	        	<td>
	        		<input type="text" id="${woDetail.ROWNUM }" class="pr_names" name="pr_name" style="width: 100%;" value="${woDetail.PR_NAME }" readonly>
	        		<input type="hidden" name="pr_no" value="${woDetail.PR_NO }">
	        	</td>
	        	<td>	
					<input type="text" id="fac_no${woDetail.ROWNUM }" class="fac_names" name="fac_name" style="width: 100%;" value="${woDetail.FAC_NAME }" readonly>
					<input type="hidden" name="fac_no" value="${woDetail.FAC_NO }">
				</td>
	            <td><input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value="${woDetail.QUANTITY }" readonly><input type="hidden" id="cost" value="${est.PR_EXPRICE }"></td>
	            <td style="text-align : center;"><button type="button" class="btn"></button></td>
	        </tr>
        </c:forEach>
        </tbody>
        <tr class="total">
            <td colspan="2" align="center">총량</td>
            <td colspan="2" align="center"><input type="text" id="woTotal" style="width: 100%;" value="${est.AMOUNT }" readonly></td>
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
			'action' : 'modify.do',
			'method' : 'post'
		});
		
		let trCnt = 0;
		
		for(let i = 0; i < $('tr[id="trChk"]').get().length; i++){
			if($('tr[id="trChk"]').eq(i).css("display") != "none") {
				for(let j = 0; j < $('tr[id="trChk"]').eq(i).find('input[type="text"]').get().length; j++) {
					if($('tr[id="trChk"]').eq(i).find('input[type="text"]').eq(j).val() == "" || $('tr[id="trChk"]').eq(i).find('input[type="text"]').eq(j).val() == null) {
						alert("값을 입력해 주세요.");
						return;
					}
				}				
			} else {
				trCnt += 1;
			}
		}
		
		if($('tr[id="trChk"]').get().length == trCnt) {
			alert("제품을 추가하세요.");
			return;
		}
		
		formObj.submit();
	});
	
	
	$('button#removeBtn').on('click', function(){
		if(confirm("정말 삭제하시겠습니까?")){
			formObj.attr({
				'action' : 'remove.do',
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
	$('#prInput').append(
		'<tr id="trChk"><input type="hidden" class="rownum" value="'+ cnt + '">'+
			'<input type="hidden" name="detail_no" id="" value="0">'+
			'<input type="hidden" name="pr_delete" value="n">'+
	        '<td><input type="text" id="'+ cnt +'" class="pr_names" name="pr_name" style="width: 100%;" value=""><input type="hidden" name="pr_no"></td>'+
	        '<td><input type="text" id="fac_no' + cnt + '" class="fac_names" name="fac_name" style="width: 100%;" value=""><input type="hidden" name="fac_no"id="fac_no' + cnt + '"></td>'+
	        '<td><input type="text" id="quantity'+cnt+'" class="quantity" name="quantity" style="width: 100%;" value=""><input type="hidden" id="cost"></td>'+
	        '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'+
    	'</tr>'
    );
	
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
// 	$(document).on('click', '.pr_names', function(){
// 		let idVal = $(this).parents("tr").find(".rownum").val();
// 		console.log(idVal);
// 		$('#cnt').val(idVal);
// 		let openWin = OpenWindow("/erp4/findProduct.do", "제품 찾기", 500, 500);
		
// 	});
	
	//제품 삭제 버튼
	$('#prInput').on('click', '#cancelBtn', function(){
		if($(this).parent('td').parent('tr').find("input[name='pr_delete']").val() == "n") {
	        $(this).parent('td').parent('tr').remove();
	    }else{
		$(this).parents('tr').css('display', 'none');
		$(this).parents('tr').find("input[name='pr_delete']").val("d")
	    }
	   });
	
	// 공장 클릭시 목록 열기 이벤트
// 	$(document).on('click', '.fac_names', function() {
// 		let whVal = $(this).attr('id');
// 		$('#cnt').val(whVal);
// 		let openWin = OpenWindow("/erp4/findFactory.do", "공장 찾기", 800, 600);
// 	})
	
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

	let sum = Number(0);
	let inputquantity = $('input[name="quantity"]').get();
	
	for(let i = 0; i < inputquantity.length; i++){
		sum += Number($('input[name="quantity"]').eq(i).val());
	}
	
	$('#woTotal').val(sum);
	
</script>


</html>
