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
<title>창고이동 등록</title>

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
	<h2>창고이동 등록</h2>
	<!-- card footer End -->
	<form role="form" method="post" action="/erp4/whtransfer/regist.do" enctype="multipart/form-data">
		<table>
			<tr>
				<td width="40%" align="center"><b>담당자</b></td>
				<td>
					<input type="hidden" name="emp_no" id="receiver" value="${empno }"> 
					<input type="text" style="width: 100%;" value="${c_name } / ${ename }" id="name" name="name" 
							readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 400, 600)">
				</td>
			</tr>
			<tr><input type="hidden" id="A" value="C">
            	<td align="center"><b>보내는 창고</b></td>
             	<td>
             		<input type="text" id="give_wh_name" class="wh_names" style="width: 100%;" value="">
             		<input type="hidden" name="wh_no" value="">
             	</td>
        	</tr>
	        <tr>
	            <td align="center"><b>받는 창고</b></td>
				<td>
					<input type="text" id="take_wh_name" class="wh_names2" style="width: 100%;" value="">
					<input type="hidden" name="wh_no2" value="">
				</td>
	        </tr>
			<!-- <tr>
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
			</tr> -->
		</table>
		<button type="button" id="addPutBtn" style="margin-bottom: 10px;" class="btn btn-primary">추가</button>
		<table>
			<thead>
				<tr>
					<th align="center" style="width: 20%;">품목코드</th>
					<th align="center" style="width: 20%;">품목명</th>
					<th align="center" style="width: 20%;">이동 가능 수량</th>
					<th align="center" style="width: 20%;">이동할 수량</th>
					<th align="center" style="width: 20%;">삭제</th>
				</tr>
			</thead>
			<tbody id="prInput">
				<input type="hidden" value="" id="cnt">
				<tr>
					<td>
						<input type="text" id="pr_no0" class="pr_names" name="pr_no" style="width: 100%;" value="" readonly>
					</td>
					<td>
						<input type="text" id="pr_name0" class="pr_names" name="pr_name" style="width: 100%;" value="" readonly>
					</td>
					<td>
						<input type="text" id="possible_quantity" class="pr_names" name="possible_quantity" style="width: 100%;" value="" readonly>
					</td>
					<td>
						<input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value="">
					</td>
					<td style="text-align: center;">
<!-- 						<button type="button" id="cancelBtn" class="btn btn-danger">삭제</button> -->
					</td>
				</tr>
			</tbody>
			<tr class="total">
				<td colspan="3" align="center">
					총량
				</td>
				<td colspan="2" align="center">
					<input type="text" style="width: 100%;" id="total_quantity" name="total_quantity" value="" readonly>
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
 				+ '<td><input type="text" id="pr_no' + cnt + '" class="pr_names" name="pr_no" style="width: 100%;" value=""></td>'
				+ '<td><input type="text" id="pr_name' + cnt + '" class="pr_names" name="pr_name" style="width: 100%;" value=""></td>'
				+ '<td><input type="text" id="possible_quantity' + cnt + '" class="pr_names" name="possible_quantity" style="width: 100%;" value=""></td>'
				+ '<td><input type="text" id="quantity' + cnt + '" class="quantity" name="quantity" style="width: 100%;" value=""></td>'
				+ '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'
			+ '</tr>'
		);
	
		calculateTotalQuantity();
		
	});
	
	// 제품코드 td 클릭 이벤트
	$(document).on('click', '.pr_names', function() {
		let idVal = $(this).attr('id');
		$('#cnt').val(idVal);
		
		let whNo = $('input[name="wh_no"]').val();
		let openWin = OpenWindow("/erp4/whtSelectWareHouse.do?wh_no=" + whNo, "창고 재고 조회", 600, 700);
	});

	// 제품 삭제 버튼
	$('#prInput').on('click', '#cancelBtn', function() {
		$(this).parent('td').parent('tr').remove();
		calculateTotalQuantity();
	});

	// 공장 클릭시 목록 열기 이벤트
	$(document).on('click', '.fac_names', function() {
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findFactory.do", "공장 찾기", 800, 600);
	})

	// 창고코드 이벤트
	$(document).on('click', '.wh_names, .wh_names2', function() {
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findWareHouse.do", "창고 찾기", 800, 600);
	})


// 	// 가격 * 수량 = 합계
// 	$(document).on('change keyup', '.quantity', function() {
// 		let unitPrice = $(this).parents("tr").find(".outprice").val()
// 		let quantity = $(this).val();

// 		let totalPrice = unitPrice * quantity;
		
// 		$(this).parent().next().children().val(totalPrice);
// 	})
	
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
	
	// 총량 계산
	function calculateTotalQuantity() {
	    let sum = 0;
	    $('#prInput tr').each(function(index, row) {
	        let quantity = $(row).find('input[name="quantity"]').val();
	        let possible_quantity = $(row).find('input[name="possible_quantity"]').val();

	        if (parseInt(quantity) <= parseInt(possible_quantity)) {
	        	$(row).find('input[name="quantity"]').css('color', '');
	        	sum += parseInt(quantity);
	        } else {
	        	$(row).find('input[name="quantity"]').css('color', 'red');
	        }
	    });

	    $('#total_quantity').val(sum);
	}
	
	// 수량 입력 시 총량 계산
	$(document).on('change keyup click', '.quantity, button#cancelBtn', function() {
	    calculateTotalQuantity();
	});
	
	// 등록 버튼 클릭 시
	$(document).on('click', '#submitBtn', function() {
	    let form = $('form[role="form"]');
	    let emp_no = $('input[name="emp_no"]').val();
	    let wh_no = $('input[name="wh_no"]').val();
	    let wh_no2 = $('input[name="wh_no2"]').val();
	    let valid = true;

	    if (emp_no == "") {
	        alert("담당자를 선택하세요.");
	        valid = false;
	    } else if (wh_no == "") {
	        alert("보내는 창고를 선택하세요.");
	        valid = false;
	    } else if (wh_no2 == "") {
	        alert("받는 창고를 선택하세요.");
	        valid = false;
	    } else {
	        $('#prInput tr').each(function(index, row) {
	            let pr_no = $(row).find('input[name="pr_no"]').val();
	            let quantity = $(row).find('input[name="quantity"]').val();
	            let possible_quantity = $(row).find('input[name="possible_quantity"]').val();
	    
	            if (pr_no == "" || quantity == "" || possible_quantity == "") { 
	                alert("빈칸을 모두 입력하세요.");
	                valid = false;
	                return false; // Loop 종료
	            } else if (parseInt(quantity) > parseInt(possible_quantity)) {
	                alert('수량이 부족합니다.');
	                valid = false;
	                return false; // Loop 종료
	            }
	        });
	    }

	    if (valid) {
	        alert('전송합니다.');
	        form.submit();
	    }
	});
	
</script>

<script src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

</html>
