<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사람찾기</title>
<style>
	.trHover:hover{
		background-color: #dfdfdf;
		transition-propety: background-color;
		transition-duration: 1s;
	}
</style>
</head>
<body>
<div class="card-body pad">
	<div>
	<div class="input-group row" style="width: 100%; margin: 0px 0px 20px 0px; justify-content: center;">
		</div>
	<div>	
		<table style="font-size: 0.8em;" class="table table-borderd text-center">
			<tr>
				<th width="100px" style="text-align: center;">이름</th>
				<th width="100px" style="text-align: center;">직책</th>
				<th width="100px" style="text-align: center;">부서</th>
			</tr>
				<c:forEach items="${emp }" var="emp" varStatus="loop">
				<tr class="trHover">
					<td style="text-align: center;" id="e_name">${emp.e_name }</td>
					<td style="text-align: center;" id="e_rank">${emp.e_rank }</td>
					<td style="text-align: center;" id="dept">${dept.get(loop.index) }<input type="hidden" id="dept_no" value="${emp.dept_no }"><input type="hidden" id="emp_no" value="${emp.emp_no }"></td>
				</tr>
				</c:forEach>
		</table>
	</div>
</div>
</div>
</body>
</html>
 <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script>

	const cnt = $('#cnt', opener.document).val();
	$('tr').on('click', function(){
		$('#'+cnt, opener.document).val($(this).find('#e_name').text());
		$('#'+cnt, opener.document).next().val($(this).find('#emp_no').val());
		$('#'+cnt, opener.document).parent('td').next().find('#prerank').val($(this).find('#e_rank').text());
		$('#'+cnt, opener.document).parent('td').next().next().next().next().find('#nextrank').val($(this).find('#e_rank').text());
		$('#'+cnt, opener.document).parent('td').next().next().find('#predept').val($(this).find('#dept').text());
		$('#'+cnt, opener.document).parent('td').next().next().next().next().next().find('#nextdept').val($(this).find('#dept_no').val());
		$('#'+cnt, opener.document).parent('td').next().next().find('.predept_no').val($(this).find('#dept_no').val());
		window.close();
	})
</script>
