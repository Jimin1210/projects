<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cri" value="${pageMaker.cri }"/>
<div style="height: 40px"></div>
<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-10" style="max-width: 1200px;">
				<div class="card card-outline card-info">
					<div class="card-header" style="border-bottom: none;">
						<h2 class="card-title p-1">거래처관리</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/erp4/contact.do?mcode=${mcode }&murl=${murl }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="d" ${cri.searchType eq 'c' ? 'selected' : '' }>업체명</option>
								<option value="t" ${cri.searchType eq 'r' ? 'selected' : '' }>대표자명</option>
								<option value="w" ${cri.searchType eq 'p' ? 'selected' : '' }>취급품목</option>
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
									<th width="150px" style="text-align: center;">거래처 코드</th>
									<th width="200px" style="text-align: center;">거래처 명</th>
									<th width="150px" style="text-align: center;">대표자 명</th>
									<th width="200px" style="text-align: center;">전화번호</th>
									<th width="200px" style="text-align: center;">핸드폰 번호</th>
									<th width="150px" style="text-align: center;">취급품목</th>
									<th width="300px" style="text-align: center;">계좌</th>
									<th width="300px" style="text-align: center;">주소</th>
								</tr>
									<c:forEach items="${contactList}" var="contact">
									<tr>
										<td style="text-align: center;"><a id="aTag" href="javascript:OpenWindow('contactDetail.do?c_no=${contact.c_no }','거래처 조회', 800 , 600);">${contact.c_no }</a></td>
										<td style="text-align: center;">${contact.c_name }</td>
										<td style="text-align: center;">${contact.c_rname }</td>
										<td style="text-align: center;">${contact.c_tel }</td>
										<td style="text-align: center;">${contact.c_phone }</td>
										<td style="text-align: center;">${contact.keyword }</td>
										<td style="text-align: center;">${contact.account }</td>
										<td style="text-align: center;">${contact.addr }</td>
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
								<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow('contactRegistForm.do', '거래처 등록', 700, 700)"
								style="width: 100px; font-size: 0.8em; margin: 20px; align-self: center;">거래처 등록</button>
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
