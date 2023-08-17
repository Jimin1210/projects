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
    <title>출하지시서 상세</title>
    
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
    <h2>DW 출하지시서 상세</h2>
	<div class="card-footer">
		<button type="button" id="modifyBtn" class="btn btn-warning">수정</button>
		<c:if test="${siList.get(0).PROGRESS eq 0 }">
		<button type="button" id="removeBtn" class="btn btn-danger">삭제</button>
		</c:if>
		<button type="button" id="listBtn" class="btn btn-primary">닫기</button>
	</div>
	<!-- card footer End -->
<form role="form" method="post" enctype="multipart/form-data">
<input type="hidden" name="si_no" value="${si.SI_NO }">
	<table>
        <tr>
            <td width="40%" align="center"><b>출하지시서 코드</b></td>
            <td width="100%"><input type="text" style="width: 100%;" value="${si.SI_NO }" readonly></td>
        </tr>
        <tr>
            <td align="center">등록 일자</td>
            <td><fmt:formatDate value="${si.SYS_REGDATE }" pattern="yyyy-MM-dd"></fmt:formatDate></td>
        </tr>
        <tr>
            <td align="center">담당자</td>
            <td><input type="hidden" name="emp_no" id="receiver" value="${siList.get(0).EMP_NO }" ${siList.get(0).PROGRESS ne '0' ? 'readonly' : '' }>
            <input type="text" style="width: 100%;" value="${siList.get(0).E_NAME }" id="name" name="name" readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 500, 500)"></td>
        </tr>
        <tr>
            <td align="center">진행상태</td>
            <td><select name="progress" id="progress">
            	<option value="0"${siList.get(0).PROGRESS eq "0" ? 'selected' : "" }>접수중</option>
			    <option value="1"${siList.get(0).PROGRESS eq "1" ? 'selected' : "" }>출하대기중</option>
			    <option value="2"${siList.get(0).PROGRESS eq "2" ? 'selected' : "" }>출하완료</option>
				</select>
			</td>
        </tr>
         <tr>
            <td align="center">출하 창고</td>
             <td><input type="text" id="si_whname" class="wh_names" name="wh_name" style="width: 100%;" value="${siList.get(0).WH_NAME }"><input type="hidden" name="wh_no" value="${siList.get(0).WH_NO }"></td>
        </tr>
        <tr>
            <td align="center">출하 일자</td>
            <td><input type="date" id="ship" name= "shipdate" value="<fmt:formatDate value="${siList.get(0).SHIPDATE }" pattern="yyyy-MM-dd"></fmt:formatDate>" ${siList.get(0).PROGRESS ne '0' ? 'disabled' : '' }></td>
        </tr>
       
    </table>
    <c:if test="${siList.get(0).PROGRESS eq 0 }">
    <button type="button" id="addPutBtn" style="margin-bottom: 10px;" class="btn btn-primary">버튼 추가</button>
    </c:if>
    <table>
        <tr>
            <th align="center" style="width: 20%;">제품코드</th>
            <th align="center" style="width: 20%;">제품 명</th>           
            <th align="center" style="width: 20%;">수량</th>
           	<th align="center" style="width: 20%;">내용</th>
           	<th align="center" style="width: 20%;">비고</th>
        </tr>
    	<tbody id="prInput">
    	<input type="hidden" value="" id="cnt">
    	<input type="hidden" value="B" id="A">
       <c:forEach items="${siList}" var="si">
        <tr id="trChk" >    	
	       <input type="hidden" class="rownum" value="${si.ROWNUM }">
	       <input type="hidden" name="sidetail_no" id="sidtail_no" value="${si.SIDETAIL_NO }">
	       <input type="hidden" name="enabled" id="sienabled" value="${si.ENABLED }">
	       <input type="hidden" name="pr_delete" value="o">
        	<td><input type="text" id="" class="pr_nos" name="pr_no" value="${si.PR_NO }"  style="width: 100%;" readonly></td>
        	<td><input type="text" id="${si.ROWNUM }" class="pr_names2" name="pr_name" style="width: 100%;" value="${si.PR_NAME }"  ${siList.get(0).PROGRESS ne '0' ? 'readonly' : '' }></td>
            <td><input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value="${si.QUANTITY }"  ${siList.get(0).PROGRESS ne '0' ? 'readonly' : '' }>
            <td><input type="text" id="contents" class="content" name="content" style="width: 100%;" value="${si.CONTENT }" ${siList.get(0).PROGRESS ne '0' ? 'readonly' : '' }></td>
            <td style="text-align : center;">
            <c:if test="${siList.get(0).PROGRESS eq 0 }">
            <button type="button" id="cancelBtn" class="btn btn-danger">삭제</button>
            </c:if></td>
        </tr>
        </c:forEach>
        </tbody>
        <tr class="total">
            <td colspan="2" align="center">총 수량</td>
            <td colspan="1" align="center"><input type="text" id="totalQuantity" style="width: 100%;" value="${si.QUANTITY }" readonly></td>
            <td colspan="2" align="center"></td>
        </tr>
    </table>
</form>
</body>

<script>


window.onload = function(){
	
	let formObj = $('form[role="form"]');

	$('button#modifyBtn').on('click', function(){
		formObj.attr({
			'action' : 'simodifyForm.do',
			'method' : 'post'
		});
		
		let trCnt = 0;
		
		for(let i = 0; i < $('tr[id="trChk"]').get().length; i++){
			if($('tr[id="trChk"]').eq(i).css("display") != "none") {
				for(let j = 0; j < $('tr[id="trChk"]').eq(i).find('input[type="text"]').get().length; j++) {
					if($('input[type="text"]').eq(i).attr('name') == 'content') {
						continue;
					}
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
			alert("제품을 추가해주세요");
			return;
		}
		
		if($('input[name="shipdate"]').val() != '0'){
			$('#ship').removeAttr('disabled');
		}
		
		
		
		formObj.submit();	
		
	})
	
	
	

	$('button#removeBtn').on('click', function(){
		if(confirm("정말 삭제하시겠습니까?")){
			formObj.attr({
				'action' : 'siremove',
				'method' : 'post' 
			});
			formObj.submit();
		};
	});
	
	$('button#listBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	});
	
	
	let totalQuantity = 0;
	 
	$('.quantity').each(function(){
		totalQuantity += parseInt($(this).val());
	});
	$('#totalQuantity').val(totalQuantity);

	
	
}

</script>

<c:if test="${siList.get(0).PROGRESS eq 0 }">

<script>
let rownumList = $('.rownum');
let cnt = rownumList.length; 
console.log(cnt);
let dtail_no = $('#sidtail_no').val();




// 제품 추가 버튼
$('#addPutBtn').on('click', function(){
	cnt++;
	$('#prInput').append('<tr id="trChk"><input type="hidden" class="rownum" value="'+ cnt + '">' +
	'<input type="hidden" name="sidetail_no" id="sidtail_no" value="0">'+
	'<input type="hidden" name="pr_delete" id="sienabled" value="n">'+
	'<td><input type="text" id="" class="pr_nos" name="pr_no" value="" style="width: 100%;" readonly></td>' + 
	'<td><input type="text" id="' + cnt + '" class="pr_names2" name="pr_name" style="width: 100%;" value=""></td>' +
    '<td><input type="text" id="quantity'+ cnt +'" class="quantity" name="quantity" style="width: 100%;" value=""><input type="hidden" id="cost"></td>'+
    '<td><input type="text" id="contents' + cnt +'"class="content" name="content" style="width: 100%;" value="" ></td>' +
    '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'+
'</tr>');
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

	
	//제품 삭제 버튼
	$('#prInput').on('click', '#cancelBtn', function(){
		if($(this).parent('td').parent('tr').find("input[name='pr_delete']").val() == "n") {
	        $(this).parent('td').parent('tr').remove();
	    }else{
		      $(this).parents('tr').css('display', 'none');
		      $(this).parents('tr').find("input[name='pr_delete']").val("y");
	    }
		
	});
	
	//창고코드 이벤트
	$(document).on('click', '.wh_names', function(){
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/erp4/findWareHouse.do","창고 찾기", 500,500);
	})
	
	// 수량 체인지
	$(document).on('change keyup load', '.quantity', function(){
    let totalQuantity = 0;
    $('.quantity').each(function(){
        totalQuantity += parseInt($(this).val()) || 0;
    });
    $('#totalQuantity').val(totalQuantity);
	});

	
	$(document).on('change', '.pr_names', function(){   
			let selectedValue = $(this).val();
		    $(this).siblings('.pr_nos').val(selectedValue);
		});
	


	// 제품 코드 클릭 이벤트
	$(document).on('click', '.pr_names2', function() {
	    let idVal = $(this).parents("tr").find(".rownum").val();
	    $('#cnt').val(idVal);
	    console.log($('#cnt').val())
	    let openWin = OpenWindow("/erp4/findProduct.do", "제품 찾기", 500, 500);
	});


	
	$(document).on('change, keyup', '#prInput', function(){
		let sum = Number(0);
		let inputAmount = $('input[name="amount"]').get();
		for(let i = 0; i < inputAmount.length; i++){
			sum += Number($('input[name="amount"]').eq(i).val());
		}
		
		$('#totalAmount').val(sum);
	})
	
 

</script>
</c:if>


</html>
    