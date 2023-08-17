<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- Font Awesome Icons -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">

<c:set var="cri" value="${pageMaker.cri }"/>
<div style="height: 40px"></div>
<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10" style="max-width: 1100px;">
				<div class="card card-outline card-info">
					<div class="card-header" style="border-bottom: none; padding-bottom: 0px;">
						<h2 class="card-title p-1">인사 발령</h2>
						<div class="input-group row">
						<form id="searchForm2" method="post" action="/pa/pa.do?mcode=${mcode }&murl=${murl }" style="font-size:0.9em; margin-left: 17%;">
							검색 구분 <select class="form-control col-md-2" name="searchType" id="searchType1" style="font-size: 0.8em; width: 10%; margin: 10px; display: inline;" >
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="n" ${cri.searchType eq 'n' ? 'selected' : '' }>이름</option>
								<option value="d" ${cri.searchType eq 'd' ? 'selected' : '' }>부서명</option>
							</select>
							<input class="form-control col-md-4" type="text" name="keyword" style="width: 15%; font-size: 0.8em; display: inline; margin-right: 10px;" placeholder="검색어를 입력하세요." value="${cri.keyword}">
							발령 날짜 <input type="date" value="${cri2.startDate }" id="startDate" name="startDate" style="margin: 10px; width:15%; display: inline; font-size: 0.9em;"class="form-control">
							 ~ <input type="date" value="${cri2.endDate }" id="endDate" name="endDate" style="margin: 10px; width:15%; display: inline; font-size: 0.9em;"class="form-control">
							<span class="input-group-append col-md-3" style=" padding: 0px; margin: 10px; display: inline;">
								<button class="btn btn-primary" type="button" id="searchBtn">
									<i class="fa fa-fw fa-search" style="font-size: 0.8em; padding: 0px;"></i>
								</button>
							</span>
						</form>
						</div>
					</div>
					<div class="card-body pad" style="padding-top: 0px;">
						<div>
							<table style="font-size: 0.5em;" class="table table-borderd text-center">
								<tr height="40px;">
									<th width="14%" style="text-align: center;">발령 날짜</th>
									<th width="14%" style="text-align: center;">인사 구분</th>
									<th width="14%" style="text-align: center;">부서</th>
									<th width="14%" style="text-align: center;">이름</th>
									<th width="14%" style="text-align: center;">직급</th>
									<th width="14%" style="text-align: center;">발령 부서</th>
									<th width="14%" style="text-align: center;">승진 직급</th>
								</tr>
								<c:forEach items="${list}" var="pa" varStatus="var">
									<tr height="40px;">
										<td style="text-align: center;">${pa.padate }</td>
										<td style="text-align: center;">${pa.pg_name }</td>
										<td style="text-align: center;">${pa.predept }</td>
										<td style="text-align: center;">${name.get(var.index) }</td>
										<td style="text-align: center;">${pa.prerank }</td>
										<td style="text-align: center;">
											<c:if test="${pa.pg_no eq 'pa_001'}">
												${pa.nextdept }
											</c:if>
										</td>
										<td style="text-align: center;">
											<c:if test="${pa.pg_no eq 'pa_002'}">
												${pa.nextrank }
											</c:if>
										</td>
									</tr>
								</c:forEach>
									
							</table>
							<div class="card-footer">
							</div>
						</div>
					</div>
					</div>
					<div style="display: flex; align-items: end; justify-content: end;">
				</div>
				<div style="display: flex; align-items: end; justify-content: end;">
					<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow2('/pa/paInsert.do', '인사발령 등록', 900, 600)"
					style="width: 120px; font-size: 0.8em; margin: 20px; align-self: center;">인사발령 등록</button>
				</div>
			</div>
			
		</div>
	</section>
	
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script>
		
	$('#searchBtn').on('click', function(){
		var startDateInput = $("#startDate").val();
	    var endDateInput = $("#endDate").val();

	    var startDate = new Date(startDateInput);
	    var endDate = new Date(endDateInput);

	    if (startDate > endDate) {
	    	alert('시작 날짜가 종료 날짜보다 이후입니다.');
	    	return;
	    }
		$('#searchForm2').submit();
	})
	
	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight, index){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
	};
	
	function OpenWindow2(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
	};
	
</script>
<%@ include file="../include/footer_js.jsp" %>
