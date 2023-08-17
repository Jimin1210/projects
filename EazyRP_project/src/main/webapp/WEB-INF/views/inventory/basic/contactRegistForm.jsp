<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래처 등록</title>
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
		<form method="post" id="searchForm" action="/erp4/contactRegistForm.do" style="display: contents;">
			<select class="form-control" name="searchType" id="searchType" style="font-size: 0.8em; width: 30%;">
				<option value="cwap" ${searchType eq 'cwap' ? 'selected' : '' }>전  체</option>
				<option value="w" ${searchType eq 'w' ? 'selected' : '' }>대표명</option>
				<option value="c" ${searchType eq 'c' ? 'selected' : '' }>업체명</option>
				<option value="a" ${searchType eq 'a' ? 'selected' : '' }>주 소</option>
				<option value="p" ${searchType eq 'p' ? 'selected' : '' }>취급품목</option>
			</select>
			<input class="form-control" type="text" name="keyword" style="width: 50%; font-size: 0.8em" placeholder="검색어를 입력하세요." value="${keyword}">
				<button class="btn btn-primary" type="button" id="searchBtn">
					<i class="fa fa-fw fa-search" style="font-size: 0.8em; padding: 0px;"></i>
				</button>
		</form>
		</div>
	<div>	
		<table style="font-size: 0.8em;" class="table table-borderd text-center">
			<tr>
				<th width="100px" style="text-align: center;">대표명</th>
				<th width="100px" style="text-align: center;">업체명</th>
				<th width="100px" style="text-align: center;">취급품목</th>
				<th width="100px" style="text-align: center;">주 소</th>
			</tr>
				<c:if test="${empty contactList}">
					<tr><td style="text-align: center;" colspan="4">거래처로 등록할 회사가 없습니다.</td></tr>
				</c:if>
				<tbody id="tbody">
				<c:forEach items="${contactList }" var="contact">
				<tr class="trHover">
					<td style="text-align: center;" id="name">${contact.c_rname }</td>
					<td style="text-align: center;" id="c_name">${contact.c_name }<input type="hidden" id="c_no" value="${contact.c_no }"></td>
					<td style="text-align: center;" id="addr">${contact.keyword }</td>
					<td style="text-align: center;" id="addr">${contact.addr }</td>
				</tr>
				</c:forEach>
				</tbody>
		</table>
	</div>
</div>
</div>
<form method="post" id="cnoForm" action="/erp4/contactRegist.do" style="display: none;">
	<input type="hidden" name="c_no" value="">
</form>
</body>
</html>
 <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script>

	$('#tbody').on('click', 'tr', function(){
		let c_no = $(this).find("#c_no").val();
		$('input[name="c_no"]').val(c_no);
		
		$('#cnoForm').submit();
		
	});

	$('#searchBtn').on('click', function(){
		$('#searchForm').submit();
	});
</script>