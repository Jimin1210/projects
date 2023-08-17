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
		<button type="submit" id="modifyBtn" class="btn btn-warning" ${wo.PROGRESS ne '0' ? 'disabled' : '' }>수정</button>
		<button type="button" id="removeBtn" class="btn btn-danger" ${wo.PROGRESS ne '0' ? 'disabled' : '' }>삭제</button>
		<button type="button" id="listBtn" class="btn btn-primary">닫기</button>
		<c:if test="${wo.PROGRESS ne '2'}">
			<button type="button" id="progressBtn" class="btn btn-primary" ${wo.PROGRESS eq '2' ? 'disabled' : '' } style="float:right;">
				<c:if test="${wo.PROGRESS eq '0'}">진행</c:if>
				<c:if test="${wo.PROGRESS eq '1'}">완료</c:if>
			</button>
		</c:if>
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
	            <td width="100%"><input type="text" style="width: 100%;" name="wo_name" value="${wo.WO_NAME }"></td>
	        </tr>
	        <tr>
	            <td width="40%" align="center"><b>담당자</b></td>
	            <td width="100%">
	            	<input type="hidden" id="receiver" name="emp_no" value="${wo.EMP_NO }">
	            	<input type="text" style="width: 100%;" value="${wo.C_NAME } / ${wo.E_NAME }" id="name" name="name" readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 400, 600)">
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
					<input type="date" id="endperiod" name="deliverydate" class="form-control mch7" value="${wo.DELIVERYDATE }" placeholder="납기일을 입력하세요.">
	        	</td>
	        </tr>
	        <tr>
	            <td width="40%" align="center">
	            	<b>상태</b>
	            </td>
	            <td>
	            	<c:if test="${wo.PROGRESS eq '0'}">
		            	<input type="text" name="" value="대기중" readonly>
		            	<input type="hidden" name="progress" value="0" readonly>
	            	</c:if>
	            	<c:if test="${wo.PROGRESS eq '1'}">
		            	<input type="text" name="" value="진행중" readonly>
		            	<input type="hidden" name="progress" value="1" readonly>
	            	</c:if>
	            	<c:if test="${wo.PROGRESS eq '2'}">
		            	<input type="text" name="" value="완료" readonly>
		            	<input type="hidden" name="progress" value="2" readonly>
	            	</c:if>
				</td>
	        </tr>
	    </table>
	<c:if test="${wo.PROGRESS eq '0'}">
    	<button type="button" id="addPutBtn" style="margin-bottom: 10px;" class="btn btn-primary">추가</button>
    </c:if>
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
        <input type="hidden" id="sort" value="detail">
       	<c:forEach items="${woDetail }" var="woDetail" varStatus="loop">
	        <tr id="trChk" >    	
				<input type="hidden" class="rownum" value="${woDetail.ROWNUM }">
				<input type="hidden" name="detail_no" id="dtail_no" value="${woDetail.DETAIL_NO }">
	<%-- 	       <input type="hidden" name="enabled" id="estenabled" value="${est.ENABLED }"> --%>
				<input type="hidden" name="pr_delete" value="o">
	        	<td>
	        		<input type="text" id="${woDetail.ROWNUM }" class="pr_names" name="pr_name" style="width: 100%;" value="${woDetail.PR_NAME }">
	        		<input type="hidden" name="pr_no" value="${woDetail.PR_NO }">
	        	</td>
	        	<td>	
					<input type="text" id="fac_no${woDetail.ROWNUM }" class="fac_names" name="fac_name" style="width: 100%;" value="${woDetail.FAC_NAME }">
					<input type="hidden" name="fac_no" id="fac_no${woDetail.ROWNUM }" value="${woDetail.FAC_NO }">
				</td>
	            <td><input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value="${woDetail.QUANTITY }"><input type="hidden" id="cost" value="${est.PR_EXPRICE }"></td>
	            <td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger" ${wo.PROGRESS ne '0' || loop.index == 0 ? 'disabled' : ''} >삭제</button></td>
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
	
	// detail.jsp 처음 열었을때 수량 합계 표시
	let selectSum = Number(0);
	let selectInputquantity = $('input[name="quantity"]').get();
	
	for(let i = 0; i < selectInputquantity.length; i++){
		selectSum += Number($('input[name="quantity"]').eq(i).val());
	}
	
	$('#woTotal').val(selectSum);
	
	let formObj = $('form[role="form"]');

	$('button#modifyBtn').on('click', function(){
			
		formObj.attr({
			'action' : 'modify.do',
			'method' : 'post'
		});
		
		//
// 		let form = $('form[role="form"]');
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
	        formObj.submit();
	    }
		
	});
	
	$('#progressBtn').on('click', function(){
		if(confirm('상태를 변경 하시겠습니까?')) {
			formObj.attr('action', '/erp4/updateWorkOrderProgress.do');
			formObj.submit();
		}
	})
	
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
<c:if test="${wo.PROGRESS eq '0'}">
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
		$(this).parents('tr').find("input[name='pr_delete']").val("d");
		$(this).parents('tr').find('input#quantity').val(0);
	    }
	   });
	
	// 공장 클릭시 목록 열기 이벤트
	$(document).on('click', '.fac_names', function() {
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findFactory.do", "공장 찾기", 800, 600);
	})
	
	//창고코드 이벤트
	$(document).on('click', '.wh_names', function(){
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findWareHouse.do","창고 찾기", 500,500);
	})
	
	// 수량 이벤트
	$(document).on('keyup change click', '.quantity, button#cancelBtn', function(){
	
		let sum = Number(0);
		let inputquantity = $('input[name="quantity"]').get();
		
		for(let i = 0; i < inputquantity.length; i++){
			sum += Number($('input[name="quantity"]').eq(i).val());
		}
		
		$('#woTotal').val(sum);

	})
	
</script>
</c:if>
</html>
