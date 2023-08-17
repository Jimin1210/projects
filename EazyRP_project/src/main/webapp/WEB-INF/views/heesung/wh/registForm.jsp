<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">
<head>
<meta charset="UTF-8">
<title>생산입고</title>

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
	<h2>생산입고 등록</h2>
	<!-- card footer End -->
	<form role="form" method="post" action="/erp4/wh/regist.do" enctype="multipart/form-data">
		<table>
			<tr>
				<td width="40%" align="center"><b>담당자</b></td>
				<td>
					<input type="hidden" name="emp_no" id="receiver" value="${empno }"> 
					<input type="text" style="width: 100%;" value="${c_name } / ${ename }" id="name" name="name" 
							readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 400, 600)">
				</td>
			</tr>
			<tr>
				<td width="40%" align="center"><b>작업지시서</b></td>
				<td>
					<input type="hidden" name="wo_no" id="wo_no" class="wo_no" value=""> 
					<div style="display: flex;">
						<input type="text" style="width: 78%;" value="" id="wo_name" name="wo_name"
								readonly onclick="OpenWindow('/erp4/findWorkOrder.do', '작업지시서 찾기', 400, 600)">
						<button style="float: right" type="button" id="woDetailOpenBtn" class="btn btn-success">상세보기</button>
					</div>
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
		</table>
		<button type="button" id="addPutBtn" style="margin-bottom: 10px;" class="btn btn-primary">추가</button>
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
				<input type="hidden" id="sort" value="registForm">
				<tr>
					<td>
						<input type="text" id="0" class="pr_names" name="pr_name" style="width: 100%;" value="" readonly>
						<input type="hidden" name="pr_no">
					</td>
					<td>
						<input type="text" id="fac_no0" class="fac_names" name="fac_name" style="width: 100%;" value="" readonly>
						<input type="hidden" name="fac_no" id="fac_no0">
					</td>
					<td>
						<input type="text" id="wh_no0" class="wh_names" name="wh_name" style="width: 100%;" value="" readonly>
						<input type="hidden" name="wh_no">
					</td>
					<td>
						<input type="text" id="outprice" class="outprice" name="outprice" style="width: 100%;" value="">
					</td>
					<td>
						<input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value="">
					</td>
					<td>
						<input type="text" id="total_outprice" name="total_outprice" style="width: 100%;" value="" readonly>
					</td>
					<td style="text-align: center;">
					</td>
				</tr>
			</tbody>
			<tr class="total">
				<td colspan="5" align="center">
					총계
				</td>
				<td colspan="2" align="center">
					<input type="text" style="width: 100%;" id="wh_total" name="wh_total" value="" readonly>
				</td>
			</tr>
		</table>
		<input type="button" id="submitBtn" class="btn btn-primary" style="text-align: center;" value="등록">
		<input type="button" class="btn btn-warning" id="closeBtn" value="취 소">
	</form>
</body>

<script>

	let cnt = 1;

	// 파일 추가 버튼
	$('#addPutBtn').on('click', function() {
		
		cnt++;

		$('#prInput').append(
			'<tr>'
 				+ '<td><input type="text" id="' + cnt + '" class="pr_names" name="pr_name" style="width: 100%;" value="" readonly><input type="hidden" name="pr_no"></td>'
				+ '<td><input type="text" id="fac_no' + cnt + '" class="fac_names" name="fac_name" style="width: 100%;" value="" readonly><input type="hidden" name="fac_no" id="fac_no' + cnt + '"></td>'
				+ '<td><input type="text" id="wh_no' + cnt + '" class="wh_names" name="wh_name" style="width: 100%;" value="" readonly><input type="hidden" name="wh_no"></td>'
				+ '<td><input type="text" id="outprice' + cnt + '" class="outprice" name="outprice" style="width: 100%;" value=""></td>'
				+ '<td><input type="text" id="quantity' + cnt + '" class="quantity" name="quantity" style="width: 100%;" value=""></td>'
				+ '<td><input type="text" id="amount" name="total_outprice" style="width: 100%;" value="" readonly></td>'
				+ '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'
			+ '</tr>'
		);
	
	});
	
	// 제품코드 td 클릭 이벤트
	$(document).on('click', '.pr_names', function() {
		let idVal = $(this).attr('id');
		$('#cnt').val(idVal);
		let openWin = OpenWindow("/erp4/findMakeProduct.do", "제품 찾기", 800, 600);
	});

	// 제품 삭제 버튼
	$('#prInput').on('click', '#cancelBtn', function() {
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


	// 가격 * 수량 = 합계
	$(document).on('change keyup', '.quantity', function() {
		let unitPrice = $(this).parents("tr").find(".outprice").val()
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

	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight) {
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width="
				+ WinWidth + ", " + "height=" + WinHeight + ",top=" + wintop
				+ ",left=" + winleft + ",resizable=yes,status=yes");
		win.focus();
		return win;
	};
	
	// 취소버튼 클릭
	$('input#closeBtn').on('click', function() {
		window.close();							// 윈도우 창을 닫는다.
	});
	
	// 작업지시서 상세보기 버튼 클릭 이벤트
	$(document).on('click', '#woDetailOpenBtn', function() {
		let wo_number = $('input[type="hidden"]#wo_no').val();
		if (wo_number == "") {
			alert('작업지시서를 선택해주세요.');
		} else {
			let openWin = OpenWindow("/erp4/selectWorkOrderDetail.do?wo_no=" + wo_number, "작업지시서 상세보기", 600, 800);
		}
	})
	
// 	등록 버튼을 클릭할때 submit 하기전에 값이 들어가지 않은 태그는 없는지 확인하고 없을때 비로소 submit을 한다.
	
// 	let submitBtn = $('input[type=submit]#submitBtn');
// 	let form = $('form[role="form"]');

// 	$(document).on('click', '#submitBtn', function() {
		
// 		if ($('input[name=emp_no]').val() == "") {
			
// 			alert("담당자를 선택하세요.");
// 			return;
			
// 		} else if ($('input[name=wo_no]').val() == "") {
			
// 			alert("작업지시서를 선택하세요.");
// 			return;
			
// 		} else if ($('input[name="pr_no"]').val() == "") {
				
// 			alert("품목을 선택하세요.");
// 			return;
			
// 		} else if ($('input[name="fac_no"]').val() == "") {
			
// 			alert("생산 공장을 선택하세요.");
// 			return;
			
// 		} else if ($('input[name="wh_no"]').val() == "") {
			
// 			alert("입고 창고를 선택하세요.");
// 			return;
			
// 		} else if ($('input[name="outprice"]').val() == "") {
			
// 			alert("외주비 단가를 선택하세요.");
// 			return;
			
// 		} else if ($('input[name="quantity"]').val() == "") {
			
// 			alert("수량을 선택하세요.");
// 			return;
			
// 		} else if ($('input[name="total_outprice"]').val() == "") {
			
// 			alert("외주비 합계 선택하세요.");
// 			return;
			
// 		} else if ($('input[name="wh_total"]').val() == "") {
			
// 			alert("품목을 선택하세요.");
// 			return;
		
// 		} else {
				
// 			form.submit();
				
// 		};

// 	})

	$(document).on('click', '#submitBtn', function() {
		
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
	});
	
</script>

<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

</html>
