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
						<h2 class="card-title p-1">창고관리</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<input id="cnoChk" type="hidden" value="${c_no }">
						<form id="searchForm2" method="post" action="/erp4/warehouse.do?mcode=${mcode }&murl=${murl }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="w" ${cri.searchType eq 'w' ? 'selected' : '' }>창고명</option>
								<option value="a" ${cri.searchType eq 'a' ? 'selected' : '' }>주소</option>
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
									<th width="150px" style="text-align: center;">창고명</th>
									<th width="150px" style="text-align: center;">주소</th>
									<th width="150px" style="text-align: center;">가동여부</th>  
								</tr>
									<c:forEach items="${warehouseList}" var="warehouse">
									<tr>
										<td style="text-align: center;"><a id="aTag" href="javascript:OpenWindow('warehouseDetail.do?wh_no=${warehouse.wh_no }','창고 수정/삭제', 800 , 600);">${warehouse.wh_name }</a></td>
										<td style="text-align: center;">${warehouse.addr }</td>
										<td style="text-align: center;">${warehouse.wh_gb eq 'Y' ? '가동 중' : '사용중지' }</td>
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
								<button type="button" class="btn btn-primary" id="registBtn" style="width: 100px; font-size: 0.8em; margin: 20px; align-self: center;">창고 등록</button>
						</div>
			</div>
		</div>
	</section>

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	
<script>
		
	$('#searchBtn').on('click', function(){
		$('#searchForm2').submit();
	})
	
	$('#registBtn').on('click', function () {
		if($('#cnoChk').val() == null || $('#cnoChk').val() == ''){
			alert('페이지 상단의 업체와 직원을 선택해주세요.');
			return;
		}
		OpenWindow('warehouseRegistForm.do', '창고 등록', 700, 400);
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
