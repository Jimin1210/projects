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
        }
    </style>
</head>
	

<body>
    <h2>인사 발령 등록</h2>
	<!-- card footer End -->
<form role="form" method="post" action="/pa/paRegist.do" enctype="multipart/form-data">
	<table>
        <tr>
            <td width="40%" align="center"><b>발령일</b></td>
            <td><input type="date" name="padate" id="padate" value="" required></td>
        </tr>
    </table>
    <button type="button" class="btn btn-primary" id="addPutBtn" style="margin-bottom: 5px;">추가</button>
    <table>
    	<thead>
        <tr>
            <th align="center" style="width: 15%;">직원명</th>
            <th align="center" style="width: 15%;">직책</th>
            <th align="center" style="width: 15%;">부서</th>
            <th align="center" style="width: 15%;">발령구분</th>
            <th align="center" style="width: 15%;">변경직책</th>
            <th align="center" style="width: 15%;">변경부서</th>
            <th align="center" style="width: 10%;"></th>
            
        </tr>
        </thead>
        <tbody id="prInput">
        <input type="hidden" value="" id="cnt">
        <tr>
            <td><input type="text" id="0" class="e_name" name="e_name" style="width: 100%;" value="" readonly><input type="hidden" class="emp_no" name="emp_no" value=""></td>
            <td><input type="text" id="prerank" class="prerank" name="prerank" style="width: 100%; background-color: #e1e1e1;" value="" readonly><input type="hidden" name="c_no" value="${c_no }"></td>
            <td><input type="text" class="predept" name="predept" id="predept" style="width: 100%; background-color: #e1e1e1;" readonly><input type="hidden" class="predept_no" name="predept_no" value=""></td>
            <td>
	            <select class="form-control" name="pg_no" id="pg_no" style="font-size: 0.8em; width: 100%;" >
					<option value="pa_001">인사이동</option>
					<option value="pa_002">승 진</option>
				</select>
			</td>
            <td style="text-align : center;">
            	<select class="form-control" name="nextrank" id="nextrank" style="font-size: 0.8em; width: 100%;" >
					<option value="사원">사원</option>
					<option value="대리">대리</option>
					<option value="과장">과장</option>
					<option value="차장">차장</option>
					<option value="부장">부장</option>
					<option value="이사">이사</option>
					<option value="상무">상무</option>
					<option value="전무">전무</option>
					<option value="부사장">부사장</option>
				</select>
            </td>
            <td style="text-align : center;">
            	<select class="form-control" name="nextdept" id="nextdept" style="font-size: 0.8em; width: 100%;" >
					<c:forEach items="${dept }" var="dept" varStatus="loop">
						<option value="${dept.dept_no}">${dept.dname}</option>
					</c:forEach>
				</select>
            </td>
            <td style="text-align : center;">
        </tr>
        </tbody>
    </table>
            <button type="button" id="submitBtn" class="btn btn-primary" style="text-align : center;">등록</button>
            <input type="button" id="calcelBtn" class="btn btn-warning" style="text-align : center;" value="닫기">
</form>
</body>

<script>
	let cnt = 0;
	// 파일 추가 버튼
	$('#addPutBtn').on('click', function(){
		cnt++;
		$('#prInput').append('<tr>'+
        '<td><input type="text" id="' + cnt + '" class="e_name" name="e_name" style="width: 100%; " value="" readonly><input type="hidden" class="emp_no" name="emp_no" value=""></td>'+
        '<td><input type="text" id="prerank" class="prerank" name="prerank" style="width: 100%; background-color: #e1e1e1;" value="" readonly><input type="hidden" name="c_no" value="${c_no }"></td>'+
        '<td><input type="text" class="predept" name="predept" id="predept" style="width: 100%; background-color: #e1e1e1;" readonly><input type="hidden" class="predept_no" name="predept_no" value=""></td>'+
        '<td>'+
            '<select class="form-control" name="pg_no" id="pg_no" style="font-size: 0.8em; width: 100%;" >'+
				'<option value="pa_001">인사이동</option>'+
				'<option value="pa_002">승 진</option>'+
			'</select>'+
		'</td>'+
        '<td style="text-align : center;">'+
        	'<select class="form-control" name="nextrank" id="nextrank" style="font-size: 0.8em; width: 100%;" >'+
				'<option value="사원">사원</option>'+
				'<option value="대리">대리</option>'+
				'<option value="과장">과장</option>'+
				'<option value="차장">차장</option>'+
				'<option value="부장">부장</option>'+
				'<option value="이사">이사</option>'+
				'<option value="상무">상무</option>'+
				'<option value="전무">전무</option>'+
				'<option value="부사장">부사장</option>'+
			'</select>'+
       '</td>'+
        '<td style="text-align : center;">'+
        	'<select class="form-control" name="nextdept" id="nextdept" style="font-size: 0.8em; width: 100%;" >'+
				'<c:forEach items="${dept }" var="dept" varStatus="loop">'+
					'<option value="${dept}">${dept}</option>'+
				'</c:forEach>'+
			'</select>'+
        '</td>'+
        '<td><button type="button" id="cancelBtn" class="btn btn-danger">삭제</button></td>'+
    '</tr>');
	});
	$('#submitBtn').on('click', function(){
		var selectedDate = new Date($('#padate').val());
	    var today = new Date();
		if(today > selectedDate){
			alert('오늘날짜 이후의 날짜를 선택해주세요.');
		} else{
			$('form[role="form"]').submit();
		}
		
	})
	
	$('#calcelBtn').on('click', function(){
		window.close();
	})
	
	// 제품 삭제 버튼
	$('#prInput').on('click', '#cancelBtn', function(){
		$(this).parent('td').parent('tr').remove();
	});
	
	// 창고코드 이벤트
	$(document).on('click', 'input[name="e_name"]', function(){
		let whVal = $(this).attr('id');
		$('#cnt').val(whVal);
		let openWin = OpenWindow("/pa/findPeople.do","사람 찾기", 500,500);
	})
	
	
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

	

<!-- <script> -->


<!-- </script> -->

<script	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
</html>
