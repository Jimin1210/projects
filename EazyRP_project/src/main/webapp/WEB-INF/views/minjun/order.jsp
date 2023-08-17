<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cri" value="${pageMaker.cri }"/>
<div style="height: 40px"></div>
<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10" style="max-width: 1400px;">
				<div class="card card-outline card-info">
					<div class="card-header" style="border-bottom: none;">
						<h2 class="card-title p-1">주문관리</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/erp5/order.do?mcode=${mcode }&murl=${murl }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="d" ${cri.searchType eq 'd' ? 'selected' : '' }>상품코드</option>
								<option value="t" ${cri.searchType eq 't' ? 'selected' : '' }>쇼핑몰 이름</option>
								<option value="w" ${cri.searchType eq 'w' ? 'selected' : '' }>제품 이름</option>
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
									<th width="150px" style="text-align: center;">주문 번호</th>
									<th width="150px" style="text-align: center;">상품 코드</th>
									<th width="150px" style="text-align: center;">상품 이름</th>
									<th width="150px" style="text-align: center;">주문 수량</th>
									<th width="200px" style="text-align: center;">주문일</th>
									<th width="150px" style="text-align: center;">배송방법</th>
									<th width="150px" style="text-align: center;">송장번호</th>
									<th width="200px" style="text-align: center;">배송시작일</th>
									<th width="200px" style="text-align: center;">배송완료일</th>
									<th width="200px" style="text-align: center;">진행상태</th>
								</tr>
									<c:forEach items="${orderList}" var="order" varStatus="loop">
									<tr>
										<td style="text-align: center;"><a id="aTag" href="javascript:OpenWindow('orderDetail.do?so_no=${order.SO_NO}','상품 상세보기', 1000 , 800);">${order.SO_NO }</a></td>
										<td style="text-align: center;" id="sp_no"><a id="aTag" href="javascript:OpenWindow('merchandiseDetail.do?sp_no=${order.SP_NO}','상품 상세보기', 800 , 600);">${order.SP_NO }</a></td>
										<td style="text-align: center;">${order.PR_NAME }</td>
										<td style="text-align: center;">${order.QUANTITY}</td>
										<td style="text-align: center;">
											<fmt:formatDate value="${order.ORDERDATE }"
												pattern="yyyy-MM-dd"></fmt:formatDate>
										</td>
										<td style="text-align: center;">${order.METHOD }</td>
										<td style="text-align: center;">${order.INVOICE }</td>
										<td style="text-align: center;">
											<fmt:formatDate value="${order.DELSTARTDATE }"
												pattern="yyyy-MM-dd"></fmt:formatDate>
										</td>
										<td style="text-align: center;">
											<fmt:formatDate value="${order.DELENDDATE }"
												pattern="yyyy-MM-dd"></fmt:formatDate>
										</td>
										<td style="text-align: center;" class="test">${order.PROGRESS }</td>
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
								<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow('orderRegistForm.do', '상품등록', 1000, 800)"
								style="width: 100px; font-size: 0.8em; margin: 20px; align-self: center;">주문 등록</button>
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
