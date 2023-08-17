<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cri" value="${pageMaker.cri }"/>
<div style="height: 40px"></div>
<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10" style="max-width: 1300px;">
				<div class="card card-outline card-info">
					<div class="card-header" style="border-bottom: none;">
						<h2 class="card-title p-1">품목관리</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/erp4/item.do?mcode=${mcode }&murl=${murl }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="p" ${cri.searchType eq 'p' ? 'selected' : '' }>제품명</option>
								<option value="g" ${cri.searchType eq 'g' ? 'selected' : '' }>그룹명</option>
								<option value="s" ${cri.searchType eq 's' ? 'selected' : '' }>규 격</option>
								<option value="c" ${cri.searchType eq 'c' ? 'selected' : '' }>품목구분</option>
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
									<th width="200px" style="text-align: center;">제품명</th>
									<th width="150px" style="text-align: center;">그룹명</th>
									<th width="150px" style="text-align: center;">규 격</th>
									<th width="150px" style="text-align: center;">입고단가</th>
									<th width="150px" style="text-align: center;">출고단가</th>
									<th width="100px" style="text-align: center;">수 량</th>
									<th width="200px" style="text-align: center;">유통기한</th>
									<th width="150px" style="text-align: center;">품목구분</th>
<!-- 									<th width="200px" style="text-align: center;">회 사</th> -->
									<th width="200px" style="text-align: center;">창 고</th>
								</tr>
									<c:forEach items="${itemList}" var="product">
									<c:set var="exdate"><fmt:formatDate value="${product.exdate }" pattern="yyyy-MM-dd"></fmt:formatDate></c:set>
									<c:if test="${product.exdate eq '' || product.exdate == null}">
										<c:set var="exdate">기한없음</c:set>
									</c:if>
									<tr>
										<td style="text-align: center;"><a id="aTag" href="javascript:OpenWindow('itemDetail.do?pr_no=${product.pr_no }','품목 수정/삭제', 800 , 600);">${product.pr_name }</a></td>
										<td style="text-align: center;">${product.pr_gr }</td>
										<td style="text-align: center;">${product.pr_st }</td>
										<td style="text-align: center;">${product.pr_inprice } 원</td>
										<td style="text-align: center;">${product.pr_exprice } 원</td>
										<td style="text-align: center;">${product.quantity }</td>
										<td style="text-align: center;">${exdate }</td>
										<td style="text-align: center;">${product.pr_class}</td>
<%-- 										<td style="text-align: center;">${product.c_no }</td> --%>
										<td style="text-align: center;">${product.wh_no }</td>
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
								<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow('itemRegistForm.do', '품목 추가', 800, 800)"
								style="width: 100px; font-size: 0.8em; margin: 20px; align-self: center;">품목 추가</button>
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
<%@ include file="/WEB-INF/views/include/footer_js.jsp" %>
