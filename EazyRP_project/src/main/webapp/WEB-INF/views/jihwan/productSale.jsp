<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cri" value="${pageMaker.cri }"/>
<div style="height: 40px"></div>
<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10" style="max-width: 1100px;">
				<div class="card card-outline card-info">
					<div class="card-header" style="border-bottom: none;">
						<h2 class="card-title p-1">제품 판매 내역</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/erp4/sale.do?mcode=${mcode }&murl=${murl }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="a" ${cri.searchType eq 'a' ? 'selected' : '' }>작성자</option>
								<option value="c" ${cri.searchType eq 'c' ? 'selected' : '' }>제목</option>
							</select>
							<input class="form-control col-md-4" type="text" name="keyword" style="width: 60%; font-size: 0.8em" placeholder="검색어를 입력하세요." value="${cri.keyword}">
							<span class="input-group-append col-md-3" style=" padding: 0px;">
								<button class="btn btn-primary" type="button" id="searchBtn">
									<i class="fa fa-fw fa-search" style="font-size: 0.8em; padding: 0px;"></i>
								</button>
							</span>
						</form>
						</div>
					</div>
					<div class="card-body pad">
						<div>
							<table style="font-size: 0.8em;" class="table table-borderd text-center">
								<tr>
									<th width="25%" style="text-align: center;">비고</th>
									<th width="25%" style="text-align: center;">요청날짜</th>
									<th width="25%" style="text-align: center;">작성자</th>
									<th width="25%" style="text-align: center;">발생금액</th>
								</tr>
									<input type="hidden" value="" name="sheet_no">
									<c:forEach items="${sale}" var="sale">
									<tr>
										<td style="text-align: center;"><a id="aTag" href="#" onclick="OpenWindow('/erp4/saleDetail.do?sheet_no=${sale.SHEET_NO}', '판매내역 상세조회', 600, 600)">${sale.PR_NAME }</a></td>
										<td style="text-align: center;">${sale.SYS_REGDATE}</td>
										<td style="text-align: center;">${sale.E_NAME }</td>
										<td style="text-align: center;">${sale.PRICE }원</td>
									</tr>
									</c:forEach>
							</table>
							<div class="card-footer">
								<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
							</div>
						</div>
					</div>
					</div>
					<div style="display: flex; align-items: end; justify-content: end;">
					<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow2('/erp4/productSaleRegist.do', '구매 내역 추가', 600, 700)"
					style="width: 100px; margin: 20px; align-self: center; font-size: 0.7em;">판매 내역 추가</button>
				</div>
			</div>
			
		</div>
	</section>
	
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	
<script>
		
	$('#searchBtn').on('click', function(){
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
