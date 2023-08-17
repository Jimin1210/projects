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
<title>생산입고 상세보기</title>
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
	

<body>
    <h2>생산입고 상세보기</h2>
	<div class="card-footer">
		<button type="submit" id="modifyBtn" class="btn btn-warning" ${wh.PROGRESS ne '0' ? 'disabled' : '' }>수정</button>
		<button type="button" id="removeBtn" class="btn btn-danger" ${wh.PROGRESS ne '0' ? 'disabled' : '' }>삭제</button>
		<button type="button" id="closeBtn" class="btn btn-primary">닫기</button>
		<c:if test="${wh.PROGRESS ne '2'}">
			<button type="button" id="progressBtn" class="btn btn-primary" ${wh.PROGRESS eq '2' ? 'disabled' : '' } style="float:right;">
				<c:if test="${wh.PROGRESS eq '0'}">진행</c:if>
				<c:if test="${wh.PROGRESS eq '1'}">완료</c:if>
			</button>
		</c:if>
	</div>
	<!-- card footer End -->
<form role="form" method="post" enctype="multipart/form-data">

		<input type="hidden" name="whNo" value="${wh.WH_NO }">
		<table>
	        <tr>
	            <td width="40%" align="center"><b>코드번호</b></td>
	            <td width="100%"><input type="text" style="width: 100%;" value="${wh.WH_NO }" readonly></td>
	        </tr>
	        <tr>
	            <td width="40%" align="center">
	            	<b>작업지시서</b>
	            </td>
	            <td width="100%">
					<input type="hidden" name="wo_no" id="wo_no" class="wo_no" value="${wh.WO_NO }">
	            	<div style="display: flex;">
	            		<c:if test="${wh.PROGRESS eq '0'}">
			            	<input type="text" style="width: 78%;" value="${wh.WO_NAME }" id="wo_name"
								readonly onclick="OpenWindow('/erp4/findWorkOrder.do', '작업지시서 찾기', 400, 600)">
	            		</c:if>
	            		<c:if test="${wh.PROGRESS ne '0'}">
			            	<input type="text" style="width: 78%;" value="${wh.WO_NAME }" id="wo_name"
								readonly>
	            		</c:if>
						<button style="float: right" type="button" id="woDetailOpenBtn" class="btn btn-success">상세보기</button>
					</div>
				</td>
	        </tr>
	        <tr>
	            <td width="40%" align="center"><b>담당자</b></td>
	            <td width="100%">
		        	<input type="hidden" id="receiver" name="emp_no" value="${wh.EMP_NO }">
		        	<c:if test="${wh.PROGRESS eq '0'}">
	            		<input type="text" style="width: 100%;" value="${wh.C_NAME } / ${wh.E_NAME }" id="name" name="name" readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 400, 600)">
	            	</c:if>
	            	<c:if test="${wh.PROGRESS ne '0'}">
	            		<input type="text" style="width: 100%;" value="${wh.C_NAME } / ${wh.E_NAME }" id="name" name="name" readonly>
	            	</c:if>
	            </td>
	        </tr>
	        <tr>
	        	<td width="40%" align="center"><b>등록일</b></td>
	        	<td width="40%" align="center">
					<input type="date" id="sys_regdate" name="sys_regdate" class="form-control mch7" value="${wh.SYS_REGDATE }" disabled>
	        	</td>
	        </tr>
	        <tr>
	            <td width="40%" align="center">
	            	<b>상태</b>
	            </td>
	            <td>
	            	<c:if test="${wh.PROGRESS eq '0'}">
		            	<input type="text" name="" value="대기중" readonly>
		            	<input type="hidden" name="progress" value="0" readonly>
	            	</c:if>
	            	<c:if test="${wh.PROGRESS eq '1'}">
		            	<input type="text" name="" value="진행중" readonly>
		            	<input type="hidden" name="progress" value="1" readonly>
	            	</c:if>
	            	<c:if test="${wh.PROGRESS eq '2'}">
		            	<input type="text" name="" value="완료" readonly>
		            	<input type="hidden" name="progress" value="2" readonly>
	            	</c:if>
				</td>
	        </tr>
	    </table>
	    <c:if test="${wh.PROGRESS eq '0'}">
    <button type="button" id="addPutBtn" style="margin-bottom: 10px;" class="btn btn-primary" >추가</button>
	    </c:if>
    <table>
    	<thead>
	        <tr>
	            <th align="center" style="width: 14%;">품목</th>
				<th align="center" style="width: 14%;">생산 공장</th>
				<th align="center" style="width: 14%;">입고 창고</th>
				<th align="center" style="width: 14%;">외주비 단가</th>
				<th align="center" style="width: 14%;">수량</th>
				<th align="center" style="width: 14%;">외주비 합계</th>
				<th align="center" style="width: 14%;">삭제</th>
	       	</tr>
       	</thead>
    	<tbody id="prInput">
	        <input type="hidden" value="" id="cnt">
	        <input type="hidden" value="A" id="A">
	        <input type="hidden" id="sort" value="detail">
	       	<c:forEach items="${whDetail }" var="whDetail" varStatus="loop">
		        <tr id="trChk">
					<input type="hidden" class="rownum" value="${whDetail.ROWNUM }">
					<input type="hidden" name="detail_no" id="dtail_no" value="${whDetail.DETAIL_NO }">
		<%-- 	       <input type="hidden" name="enabled" id="estenabled" value="${est.ENABLED }"> --%>
					<input type="hidden" name="pr_delete" value="o">
		        	<td>								
						<input type="text" ${wh.PROGRESS ne '0' ? 'readonly' : ''} id="${whDetail.ROWNUM }" class="pr_names" name="pr_name" style="width: 100%;" value="${whDetail.PR_NAME }">
						<input type="hidden" name="pr_no" value="${whDetail.PR_NO }">
					</td>
					<td>	
						<input type="text" id="fac_no${whDetail.ROWNUM }" readonly class="fac_names" name="fac_name" style="width: 100%;" value="${whDetail.FAC_NAME }">
						<input type="hidden" name="fac_no" id="fac_no${whDetail.ROWNUM }" value="${whDetail.FAC_NO }">
					</td>
					<td>		
						<input type="text" id="wh_no${whDetail.ROWNUM }" readonly class="wh_names" name="wh_name" style="width: 100%;" value="${whDetail.WH_NAME }">
						<input type="hidden" id="wh" name="wh_no" value="${whDetail.WH_NO2 }">
					</td>
					<td>
						<input type="text" id="outprice"  ${wh.PROGRESS ne '0' ? 'readonly' : ''} class="outprice" name="outprice" style="width: 100%;" value="${whDetail.OUTPRICE }">
					</td>
					<td>
						<input type="text" id="quantity"  ${wh.PROGRESS ne '0' ? 'readonly' : ''} class="quantity" name="quantity" style="width: 100%;" value="${whDetail.QUANTITY }">
					</td>
					<td>
						<input type="text" id="total_outprice" name="total_outprice" style="width: 100%;" value="${whDetail.TOTAL_OUTPRICE }" readonly>
					</td>
					<td style="text-align: center;">
						<button type="button" id="cancelBtn" class="btn btn-danger" ${wh.PROGRESS ne '0' || loop.index == 0 ? 'disabled' : ''} >삭제</button>
					</td>
		        </tr>
	        </c:forEach>
        </tbody>
     	<tr class="total">
            <td colspan="5" align="center">총액</td>
            <td colspan="2" align="center"><input type="text" id="wh_total" name="wh_total" style="width: 100%;" value="${wh.WH_TOTAL }" readonly></td>
        </tr>
    </table>
</form>
</body>

<script>
window.onload = function(){
	
	let formObj = $('form[role="form"]');

	$('button#modifyBtn').on('click', function(){
		formObj.attr({
			'action' : 'modify.do',
			'method' : 'post'
		});
		
		//
		let form = $('form[role="form"]');
	    let emp_no = $('input[name="emp_no"]').val();
	    let wo_no = $('input[name="wo_no"]').val();
	    let valid = true;
		
	    if (emp_no == "") {
	        alert("담당자를 선택하세요.");
	        valid = false;
	    } else if (wo_no == "") {
	        alert("작업지시서를 선택하세요.");
	        valid = false;
	    } else {
	        $('#prInput tr').each(function(index, row) {
	            let pr_name = $(row).find('.pr_names').val();
	            let fac_name = $(row).find('.fac_names').val();
	            let wh_name = $(row).find('.wh_names').val();
	            let outprice = $(row).find('.outprice').val();
	            let quantity = $(row).find('.quantity').val();
	            let total_outprice = $(row).find('input[name="total_outprice"]').val();
	
	            if (pr_name == "" || fac_name == "" || wh_name == "" ||
	                outprice == "" || quantity == "" || total_outprice == "") {
	                alert("빈칸을 모두 입력하세요.");
	                valid = false;
	                return false; // Loop 종료
	            }
	        });
	    }
	
	    if (valid) {
	        form.submit();
	    }
	    //
	    
	});
	
	$('#progressBtn').on('click', function(){
		if($('input[name="progress"]').val() == '1') {
			if(confirm('불량 등록을 하시겠습니까?')) {
				formObj.attr('action', '/erp4/insertError.do');
				formObj.submit();
			} else{
				formObj.attr('action', '/erp4/updateBtn.do');
				formObj.submit();
			}
		} else{
			formObj.attr('action', '/erp4/updateBtn.do');
			formObj.submit();
		}
	})
	
	
	$('button#removeBtn').on('click', function(){
		if(confirm("정말 삭제하시겠습니까?")){
			formObj.attr({
				'action' : 'remove',
				'method' : 'post' 
			});
			formObj.submit();
		};
	});
	
	$('button#closeBtn').on('click', function(){
		window.close();
	});
	
	// 작업지시서 상세보기 버튼 클릭 이벤트
	$(document).on('click', '#woDetailOpenBtn', function() {
		let wo_number = $('input[type="hidden"]#wo_no').val();
		let openWin = OpenWindow("/erp4/selectWorkOrderDetail.do?wo_no=" + wo_number, "작업지시서 상세보기", 600, 800);
	})
	
}

function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
	winleft = (screen.width - WinWidth) / 2;
	wintop = (screen.height - WinHeight) / 2;
	var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
							+ "height=" + WinHeight + ",top="+ wintop + ",left="
							+ winleft + ",resizable=yes,status=yes");
	
	win.focus();
	return win;
};

</script>
<c:if test="${wh.PROGRESS eq '0'}">

<script>
let rownumList = $('.rownum');
let cnt = rownumList.length; 
console.log(cnt);
let dtail_no = $('#dtail_no').val();

// 제품 추가 버튼
$('#addPutBtn').on('click', function(){
	cnt++;
	$('#prInput').append(
			'<tr id="trChk"><input type="hidden" class="rownum" value="'+ cnt + '">'
				+ '<input type="hidden" name="detail_no" id="" value="0">'
				+ '<input type="hidden" name="pr_delete" value="n">'
 				+ '<td><input type="text" id="' + cnt + '" class="pr_names" name="pr_name" style="width: 100%;" value=""><input type="hidden" name="pr_no"></td>'
				+ '<td><input type="text" id="fac_no' + cnt + '" class="fac_names" name="fac_name" style="width: 100%;" value=""><input type="hidden" name="fac_no"id="fac_no' + cnt + '"></td>'
				+ '<td><input type="text" id="wh_no' + cnt +'" class="wh_names" name="wh_name" style="width: 100%;" value=""><input type="hidden" id="wh" name="wh_no"></td>'
				+ '<td><input type="text" id="outprice' + cnt + '" class="outprice" name="outprice" style="width: 100%;" value=""></td>'
				+ '<td><input type="text" id="quantity' + cnt + '" class="quantity" name="quantity" style="width: 100%;" value=""></td>'
				+ '<td><input type="text" id="amount" name="total_outprice" style="width: 100%;" value="" readonly></td>'
				+ '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'
			+ '</tr>'
		);
});


	// 제품코드 td 클릭 이벤트
	$(document).on('click', '.pr_names', function(){
		let idVal = $(this).parents("tr").find(".rownum").val();
		console.log(idVal);
		$('#cnt').val(idVal);
		let openWin = OpenWindow("/erp4/findMakeProduct.do", "제품 찾기", 500, 500);
		
	});
	
	//제품 삭제 버튼
	$('#prInput').on('click', '#cancelBtn', function(){
		if($(this).parent('td').parent('tr').find("input[name='pr_delete']").val() == "n") {
	        $(this).parent('td').parent('tr').remove();
	    }else{
			$(this).parents('tr').css('display', 'none');
			$(this).parents('tr').find("input[name='pr_delete']").val("d")
	    }
	   });
	
	
	//창고코드 이벤트
	$(document).on('click', '.wh_names', function(){
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findWareHouse.do","창고 찾기", 500,500);
	})
	
	// 가격 * 수량 = 합계
	$(document).on('change keyup', '.quantity', function() {
		let unitPrice = $(this).parents("tr").find(".outprice").val();
		let quantity = $(this).val();

		let totalPrice = unitPrice * quantity;
		
		$(this).parent().next().children().val(totalPrice);

	})
	
	// 총합계
	$(document).on('change keyup click', '.quantity, button#cancelBtn', function(){
		
		let sum = Number(0);
		let inputAmount = $('input[name="total_outprice"]').get();
		
		for(let i = 0; i < inputAmount.length; i++){
			sum += Number($('input[name="total_outprice"]').eq(i).val());
		}
		
		$('#wh_total').val(sum);
		
	})
	
	// 공장 클릭시 목록 열기 이벤트
	$(document).on('click', '.fac_names', function() {
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findFactory.do", "공장 찾기", 800, 600);
	})
	

	
</script>
</c:if>
</html>
