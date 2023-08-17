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
						<h2 class="card-title p-1">손익 발생 내역 조회</h2>
						<div class="input-group row">
						<form id="searchForm2" method="post" action="/profitLoss/dayProfit.do?mcode=${mcode }&murl=${murl }" style="font-size:0.9em; margin-left: 15%;">
							손익 구분 <select class="form-control col-md-2" name="searchType1" id="searchType1" style="font-size: 0.8em; width: 10%; margin: 10px; display: inline;" >
								<option value="all" ${cri2.searchType1 eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="l" ${cri2.searchType1 eq 'l' ? 'selected' : '' }>손해 내역</option>
								<option value="p" ${cri2.searchType1 eq 'p' ? 'selected' : '' }>이익 내역</option>
							</select>
							발생 구분 <select class="form-control col-md-2" name="searchType2" id="searchType2" style="font-size: 0.8em; width: 10%; margin: 10px; display: inline;" >
								<option value="all" ${cri2.searchType2 eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="s" ${cri2.searchType2 eq 's' ? 'selected' : '' }>쇼핑몰 판매</option>
								<option value="w" ${cri2.searchType2 eq 'w' ? 'selected' : '' }>창고 이동</option>
								<option value="pb" ${cri2.searchType2 eq 'pb' ? 'selected' : '' }>제품 구매</option>
								<option value="b" ${cri2.searchType2 eq 'b' ? 'selected' : '' }>기타 구매</option>
								<option value="o" ${cri2.searchType2 eq 'o' ? 'selected' : '' }>발주 요청</option>
								<option value="e" ${cri2.searchType2 eq 'e' ? 'selected' : '' }>불량 처리</option>
								<option value="p" ${cri2.searchType2 eq 'p' ? 'selected' : '' }>급여 제공</option>
								<option value="a" ${cri2.searchType2 eq 'a' ? 'selected' : '' }>AS 비용</option>
							</select>
							발생 날짜 <input type="date" value="${cri2.startDate }" id="startDate" name="startDate" style="margin: 10px; width:15%; display: inline; font-size: 0.9em;"class="form-control">
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
						<table style="font-size: 0.5em; margin-bottom: 0px;" class="table table-borderd text-center">
							<tr height="40px;" style="font-size: 11px; background-color: #dddddd; font-weight: bold;">
										<td style="color: ${prevAmount > 0 ? 'blue' : 'red' };"></td>
										<td colspan="2" style="">선택한 날짜 범위 : ${cri2.startDate } ~ ${cri2.endDate }</td>
										<td style="color: ${total > 0 ? 'blue' : 'red' };">총 손익 금액 : ${total }원</td>
										<td style="color: ${prevAmount > 0 ? 'blue' : 'red' };">전월 대비 : ${prevAmount }원</td>
										<td style="color: ${total > 0 ? 'blue' : 'red' };"></td>
								</tr>
								<tr height="40px;">
									<th width="16%" style="text-align: center;">발생 일자</th>
									<th width="16%" style="text-align: center;">발생 구분</th>
									<th width="16%" style="text-align: center;">단가</th>
									<th width="16%" style="text-align: center;">판매(구입)가</th>
									<th width="16%" style="text-align: center;">손익</th>
									<th width="16%" style="text-align: center;">상세정보</th>
								</tr>
						</table>
							<div style="height: 400px; overflow: auto;">
							<table style="font-size: 0.5em;" class="table table-borderd text-center">
									<c:forEach items="${list}" var="list" varStatus="var">
										<tr height="40px;">
											<td width="16%" style="text-align: center;">${list.sys_regdate }</td>
											<td width="16%" style="text-align: center;">${gb.get(var.index) }</td>
											<td width="16%" style="text-align: center;">${list.unitprice }원</td>
											<td width="16%" style="text-align: center;">${list.saleprice }원</td>
											<td width="16%" style="text-align: center; color: ${list.amount > 0 ? 'blue' : 'red'}">${list.amount}원</td>
											<td width="16%" style="text-align: center;"><a id="aTag" href="#" onclick="OpenWindow('${list.pr_url }', '상세 조회', ${gb.get(var.index) eq '급여 제공' ? '1200' : '700' }, 1000)">${list.th_no}</a></td>
										</tr>
									</c:forEach>
							</table>
							<div class="card-footer">
							</div>
							</div>
						</div>
					</div>
					</div>
					<div style="display: flex; align-items: end; justify-content: end;">
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
