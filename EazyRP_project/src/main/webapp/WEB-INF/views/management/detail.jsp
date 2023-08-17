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
<div style="width: 90%; margin-top: 20px;">
<c:if test="${fail eq 'Y' }">
<table border="3px solid" style="display: inline-block;">
	<tr height="185px">
		<td width="250px" style="vertical-align : top;"><h5>반려 사유</h5><br>
		${draft.failComment }</td>
	</tr>
</table>
</c:if>
<table border="1px solid" style="float: right; margin-bottom: 10px;">
	<tr height="30px">
		<td width="300px" colspan="3" style="text-align: center;">결재 라인</td>
	</tr>
	<tr height="100px">
		<td width="100px">
		<c:if test="${draft.pl_progress eq '1' || draft.pl_progress eq '2' || draft.pl_progress eq '3' || draft.pl_progress eq '2fail' || draft.pl_progress eq '3fail'}">
		<img src="<%=request.getContextPath() %>/resources/stamp/no13.jpg" style="width: 100px; height:100px; border-radius: 30px;">
		</c:if>
		<c:if test="${draft.pl_progress eq '1fail'}">
		<img src="<%=request.getContextPath() %>/resources/stamp/fail.png" style="width: 100px; height:100px; border-radius: 30px;">
		</c:if>
		</td>
		<td width="100px">
		<c:if test="${draft.pl_progress eq '2' || draft.pl_progress eq '3' || draft.pl_progress eq '3fail'}">
		<img src="<%=request.getContextPath() %>/resources/stamp/no14.png" style="width: 100px; height:100px; border-radius: 30px;">
		</c:if>
		<c:if test="${draft.pl_progress eq '2fail'}">
		<img src="<%=request.getContextPath() %>/resources/stamp/fail.png" style="width: 100px; height:100px; border-radius: 30px;">
		</c:if>
		</td>
		<td width="100px">
		<c:if test="${draft.pl_progress eq '3'}">
		<img src="<%=request.getContextPath() %>/resources/stamp/no15.png" style="width: 100px; height:100px; border-radius: 30px;">
		</c:if>
		<c:if test="${draft.pl_progress eq '3fail'}">
		<img src="<%=request.getContextPath() %>/resources/stamp/fail.png" style="width: 100px; height:100px; border-radius: 30px;">
		</c:if>
		</td>
	</tr>
	<tr height="30px">
		<td width="100px" style="text-align: center;">${pl.e_name1 }</td>
		<td width="100px" style="text-align: center;">${pl.e_name2 }</td>
		<td width="100px" style="text-align: center;">${pl.e_name3 }</td>
	</tr>
	<tr height="30px">
		<td width="100px" style="text-align: center;">${rank.get(2) }</td>
		<td width="100px" style="text-align: center;">${rank.get(1) }</td>
		<td width="100px" style="text-align: center;">${rank.get(0) }</td>
	</tr>
</table>
<c:if test="${dg_no eq 'D001' }">
<%@ include file="../management/D001.jsp" %>
</c:if>
<c:if test="${dg_no eq 'D002' }">
<%@ include file="../management/D002.jsp" %>
</c:if>
<c:if test="${dg_no eq 'D003' }">
<%@ include file="../management/D003.jsp" %>
</c:if>
<c:if test="${dg_no eq 'D004' }">
<%@ include file="../management/D004.jsp" %>
</c:if>
<div style="width: 100%;">
	<section class="content container-fluid">
		<div class="row">	<!-- row Start -->
			<div class="col-md-12" style="display: flex; justify-content: center">
				<div class="card card-outline card-info" style="margin-top: 20px; width:95%;">
					<div class="card-body">	<!-- card body Start -->
						<div class="form-group col-sm-12">
							<label for="title">결재서류명</label>
							<input type="text" class="form-control" id="title" value="${draft.title }" readonly style="background-color: white;">
						</div>
						<div class="form-group col-sm-12">
							<label for="title">기안자</label>
							<input type="text" class="form-control" id="title" value="${draftEname }" readonly style="background-color: white;">
						</div>
						<div class="row" style="align-items: center; justify-content: space-evenly;">
						</div>
						<div class="form-group col-sm-12">
							<label for="content">내 용</label>
							<div style="background-color: white; border: 1px solid #afafaf; border-radius: 5px; min-height: 100px;">
								<div id="content">${draft.con }</div>
							</div>

						</div>
						<div class="form-group col-sm-12">
						</div>
					</div>	<!-- card body End -->
					<div class="card-footer">
						<button type="button" id="cancelBtn" class="btn btn-warning">닫기</button>
						<button type="button" id="payBtn" class="btn btn-primary" style="float: right; margin-left: 10px; ${avail eq 'N' || draft.pl_progress eq '3' ? 'background-color: gray; border: none;"disabled' : '"'}>결재</button>
						<c:if test="${fail eq 'N' }">
						<button type="button" id="failBtn" class="btn btn-danger" style="float: right;  margin-left: 10px; ${avail eq 'N' || draft.pl_progress eq '3' ? 'background-color: gray; border: none;"disabled' : '"'}>반려</button>
						</c:if>
						<c:if test="${modify eq 'Y' }">
							<button type="button" id="modifyBtn" class="btn btn-danger" style="float: right;  margin-left: 10px;  ${draft.pl_progress eq '0' || fail eq 'Y' ? '"' : 'background-color: gray; border: none;"disabled' }>수정</button>
							<button type="button" id="deleteBtn" class="btn btn-danger" style="float: right;  margin-left: 10px; ${draft.pl_progress eq '0' || fail eq 'Y' ? '"' : 'background-color: gray; border: none;"disabled' }>삭제</button>
						</c:if>
					</div>	<!-- card footer End -->
				</div>
			</div>
		</div>	<!-- row End -->
	</section>

</div>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script>
	$('#cancelBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	})
	$('#payBtn').on('click', function(){
		if(confirm("결재를 진행하시겠습니까?")){
			location.href="/management/payForm.do?dr_no=${draft.dr_no}&pl_progress=${draft.pl_progress}";
		}
	})
	$('#deleteBtn').on('click', function(){
		if(confirm("기안문을 삭제하시겠습니까?")){
			location.href="/management/delete.do?dr_no=${draft.dr_no}";
		}
	})
	$('#failBtn').on('click', function(){
		if(confirm("반려를 진행하시겠습니까?")){
			OpenWindow("/management/failComment.do?dr_no=${draft.dr_no}&pl_progress=${draft.pl_progress}",
					"반려사유", 500, 500);
		}
	})
	$('#modifyBtn').on('click', function(){
		location.href="/management/modify.do?dr_no=${draft.dr_no}"
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