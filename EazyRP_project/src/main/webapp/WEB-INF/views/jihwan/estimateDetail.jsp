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
    <h2>DW 견적서 상세</h2>
    <input type="hidden" id="gb" value="${est.PROGRESS}">
	<div class="card-footer">
		<button type="button" id="modifyBtn" class="btn btn-warning">수정</button>
		<c:if test="${est.PROGRESS eq '0'}">
		<button type="button" id="removeBtn" class="btn btn-danger">삭제</button>
		</c:if>
		<button type="button" id="listBtn" class="btn btn-primary">닫기</button>
	</div>
	<!-- card footer End -->
<form role="form" method="post" enctype="multipart/form-data">
<input type="hidden" name="est_no" value="${est.EST_NO }">
	<table>
        <tr>
            <td width="40%" align="center"><b>견적서 코드</b></td>
            <td width="100%"><input type="text" style="width: 100%;" value="${est.EST_NO }" readonly></td>
        </tr>
        <tr>
            <td align="center">등록일자</td>
            <td><fmt:formatDate value="${est.REGDATE }" pattern="yyyy-MM-dd"></fmt:formatDate></td>
        </tr>
        <tr>
            <td align="center">외화 명</td>
            <td><select name="fc_no" id="fc-select" ${est.PROGRESS ne 0 ? 'disabled' : '' }>
			    <option value="FC_001">달러</option>
			    <option value="FC_002">한화</option>
			    <option value="FC_003">위안화</option>
			    <option value="FC_004">엔화</option>
			    <option value="FC_005">페소</option>
			    <option value="FC_006">동</option>
				</select></td>
        </tr>
         <tr>
            <td align="center">진행상태</td>
            <td><select name="progress" id="progress">
            	<option value="0"${est.PROGRESS eq "0" ? 'selected' : "" }>접수중</option>
			    <option value="1"${est.PROGRESS eq "1" ? 'selected' : "" }>처리중</option>
			    <option value="2" ${est.PROGRESS eq "2" ? 'selected' : "" }>완료</option>
				</select>
			</td>
        </tr>
        <tr>
            <td align="center">담당자</td>
            <td><input type="hidden" name="emp_no" id="receiver" value="${est.EMP_NO }" ${est.PROGRESS ne '0' ? 'readonly' : '' }>
            <input type="text" style="width: 100%;" value="${est.E_NAME }" id="name" name="name" readonly onclick="OpenWindow('/mymenu/findPeople.do', '사람찾기', 500, 500)"></td>
        </tr>
        <tr>
            <td align="center">첨부파일</td>
            <td>
            
            <input type="file" id="file2" name="files" style="width: 100%;" value="${est.FILES }" ${est.PROGRESS ne 0 ? 'disabled' : '' }>
            <input type="hidden" name="realFileName" value="${est.REALFILENAME }">
            <input type="hidden" id="fileName" name="fileName" value="${est.FILENAME }">  
            
            <c:if test="${!empty est.FILES }">
			<div id="divRemove"><button type="button" onclick="location.href='<%=request.getContextPath()%>/erp4/getFile.do?est_no=${est.EST_NO }';">파일 다운</button>&nbsp;&nbsp;${est.REALFILENAME }</div>
			</c:if>
<!-- 			<button type="button" id="removeFileBtn" class="btn btn-danger">삭제</button> -->
			</td> 
        </tr>
    </table>
    <c:if test="${est.PROGRESS eq 0 }">
    <button type="button" id="addPutBtn" style="margin-bottom: 10px;" class="btn btn-primary">제품추가</button>
    </c:if>
    <table>
        <tr>
            <th align="center" style="width: 20%;">제품명</th>
            <th align="center" style="width: 20%;">창고</th>           
            <th align="center" style="width: 20%;">수량</th>
            <th align="center" style="width: 20%;">가격</th>
            <th align="center" style="width: 20%;">비고</th>
        </tr>
    	<tbody id="prInput">
        <input type="hidden" value="" id="cnt">
        <input type="hidden" value="A" id="A">
        
       <c:forEach items="${estPr }" var="est" varStatus="loop">
        <tr id="trChk" >    	
	       <input type="hidden" class="rownum" value="${est.ROWNUM }">
	       <input type="hidden" name="estdetail_no" id="dtail_no" value="${est.ESTDETAIL_NO }">
	       <input type="hidden" name="enabled" id="estenabled" value="${est.ENABLED }">
	       <input type="hidden" name="pr_delete" value="o">
        	<td>
        		<input type="text" id="${est.ROWNUM }" class="pr_names" name="pr_name" style="width: 100%;" value="${est.P_NAME }" ${est.PROGRESS ne '0' ? 'readonly' : '' }><input type="hidden" name="pr_no" value="${est.PR_NO }">
        	</td>
            <td><input type="text" id="wh_no${est.ROWNUM }" class="wh_names" name="wh_name" style="width: 100%;" value="${est.WH_NAME }" ${est.PROGRESS ne '0' ? 'readonly' : '' }><input type="hidden" id="wh" name="wh_no" value="${est.WH_NO }"></td>
            <td><input type="text" id="quantity" class="quantity" name="quantity" style="width: 100%;" value="${est.QUANTITY }" ${est.PROGRESS ne '0' ? 'readonly' : '' }><input type="hidden" id="cost" value="${est.PR_EXPRICE }"></td>
            <td><input type="text" id="amount" name="amount" style="width: 100%;" value="${est.AMOUNT }" readonly ></td>
            <td style="text-align : center;"><c:if test="${est.PROGRESS eq '0' }">
            <button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></c:if>
            </td>
        </tr>
        </c:forEach>
        </tbody>
        <tr class="total">
            <td colspan="3" align="center">총계</td>
            <td colspan="2" align="center"><input type="text" id="totalAmount" style="width: 100%;" value="${est.AMOUNT }" readonly></td>
        </tr>
    </table>
</form>
</body>


<script>
window.onload = function(){
	
	
	
	
	
	let fc_no = "${est.FC_NO}";
	$('#fc-select').val(fc_no);
	$('select#fc-select').find('option[value="' + fc_no + '"]').attr('selected', 'selected');
	
	
	let formObj = $('form[role="form"]');

	$('button#modifyBtn').on('click', function(){
		alert($('#fc-select').val())
		formObj.attr({
			'action' : 'modifyForm.do',
			'method' : 'post'
// 			'enctype' : 'multipart/form-data'
		});
		
		alert($('tr[id="trChk"]').get().length);
		
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
			alert("제품을 추가해주세요");
			return;
		}
		
		if($('#gb').val() != '0'){
			$('#fc-select').removeAttr('disabled');
			$('#file2').removeAttr('disabled');
		}
		
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
		window.opener.location.reload(true);
		window.close();
	});
	
	
	
}

</script>

<c:if test="${est.PROGRESS eq '0'}">

<script>
let rownumList = $('.rownum');
let cnt = rownumList.length; 
let dtail_no = $('#dtail_no').val();

$('#file2').on('change', function(){
	$('#fileName').val($('#file').val());
})

// 제품 추가 버튼
$('#addPutBtn').on('click', function(){
	cnt++;
	$('#prInput').append('<tr id="trChk"><input type="hidden" class="rownum" value="'+ cnt + '">' +
	'<input type="hidden" name="estdetail_no" value="0">'+
	'<input type="hidden" name="pr_delete" value="n">'+
    '<td><input type="text" id="'+ cnt +'" class="pr_names" name="pr_name" style="width: 100%;" value=""><input type="hidden" name="pr_no"></td>'+
    '<td><input type="text" id="wh_no' + cnt +'" class="wh_names" name="wh_name" style="width: 100%;" value=""><input type="hidden" id="wh" name="wh_no"></td>'+
    '<td><input type="text" id="quantity'+cnt+'" class="quantity" name="quantity" style="width: 100%;" value=""><input type="hidden" id="cost"></td>'+
    '<td><input type="text" id="amount" name="amount" style="width: 100%;" value=""></td>'+
    '<td style="text-align : center;"><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'+
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
	
	// 수량 이벤트
	$(document).on('keyup', '.quantity', function(){
// 		let quantity = $(this).val();
		$(this).parent().next().children().val($(this).val()*$(this).next().val().split(' 원')[0]);
	})
	
	
	 $( document ).ready( function() {
        $('#removeFileBtn').on('click', function() {  
        	$('#divRemove').remove();
        } );
      } );
	
	
	$('#file2').on('click', function(){
		$('#divRemove').hide();
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

</c:if>


</html>
