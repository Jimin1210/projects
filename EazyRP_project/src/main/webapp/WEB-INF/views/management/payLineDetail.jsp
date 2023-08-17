<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<style>
	tr{
		font-size: 0.7em;
	}
	
</style>
<div class="data-wrapper" style="justify-content: center; display: flex;">
<div style="width: 100%;">
	<section class="content container-fluid">
		<div class="row">	<!-- row Start -->
			<div class="col-md-12" style="display: flex; justify-content: center">
				<div class="card card-outline card-info" style="margin-top: 20px; width:95%;">
					<div class="card-body">	<!-- card body Start -->
						<div class="form-group col-sm-12">
							<label for="title">결재라인명</label>
							<input type="text" class="form-control" id="title" value="${pl.pl_name }" readonly style="background-color: white;">
						</div>
						<table style="width:100%;">
							<tr>
								<td style="text-align: center;"><label for="title" style="font-size: 1.2em; text-align: center;">결재자 1</label></td>
								<td style="text-align: center;"><label for="title" style="font-size: 1.2em; text-align: center;">결재자 2</label></td>
								<td style="text-align: center;"><label for="title" style="font-size: 1.2em; text-align: center;">결재자 3</label></td>
							</tr>
							<tr>
								<td style="text-align: center;"><input type="text" class="form-control" id="title" value="${pl.e_name1 }" readonly style="background-color: white; width:130px; text-align:center; display: inline;"></td>
								<td style="text-align: center;"><input type="text" class="form-control" id="title" value="${pl.e_name2 }" readonly style="background-color: white; width:130px; text-align:center; display: inline;"></td>
								<td style="text-align: center;"><input type="text" class="form-control" id="title" value="${pl.e_name3 }" readonly style="background-color: white; width:130px; text-align:center; display: inline;"></td>
							</tr>
						</table>
						<div class="form-group col-sm-12" style="margin-top: 20px;">
							<label for="content">비 고</label>
							<input type="text" class="form-control" id="title" value="${pl.comments }" readonly style="background-color: white;">
						</div>
					</div>
					<div class="card-footer">
						<button type="button" id="cancelBtn" class="btn btn-warning">닫기</button>
						<button type="button" id="modifyBtn" class="btn btn-primary" style="float: right;  margin-left: 10px;">수정</button>
						<button type="button" id="deleteBtn" class="btn btn-danger" style="float: right;  margin-left: 10px;">삭제</button>
					</div>	<!-- card footer End -->
					</div>	<!-- card body End -->
					
					</div>
		</div>	<!-- row End -->
	</section>
</div>
</div>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script>
	$('#cancelBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	})
	$('#deleteBtn').on('click', function(){
		if(confirm("결재라인을 삭제하시겠습니까?")){
			location.href="/management/deletePayLine.do?pl_no=${pl.pl_no}";
		}
	})
	$('#modifyBtn').on('click', function(){
		location.href="/management/modifyPayLine.do?pl_no=${pl.pl_no}"
	})
	
	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
	};
</script>