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
						<h2 class="card-title p-1">창고이동 내역</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/erp4/whtransfer.do?mcode=${mcode }&murl=${murl }" style="display: contents;">
							<select class="form-control col-md-2 custom-select" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="scn" ${cri.searchType eq 'scn' ? 'selected' : '' }>등록일+번호+창고명</option>
								<option value="s" ${cri.searchType eq 's' ? 'selected' : '' }>등록일</option>
								<option value="c" ${cri.searchType eq 'c' ? 'selected' : '' }>이동번호</option>
								<option value="n" ${cri.searchType eq 'n' ? 'selected' : '' }>창고명</option>
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
									<th style="text-align: center;">등록일</th>
									<th style="text-align: center;">이동번호</th>
									<th style="text-align: center;">보내는 창고</th>
									<th style="text-align: center;">받는 창고</th>
									<th style="text-align: center;">품목</th>
									<th style="text-align: center;">총량</th>
<!-- 									<th style="text-align: center;">상태</th> -->
								</tr>
								<c:if test="${empty whtList }">
									<tr>
										<td colspan="7">
											<strong>해당 게시글이 없습니다.</strong>
										</td>
									</tr>
								</c:if>
								<c:forEach items="${whtList}" var="wht" varStatus="loop">
								<tr>
									<td style="text-align: center;">${wht.SYS_REGDATE }</td>
									<td style="text-align: center;">
										<a id="aTag" href="#" onclick="OpenWindow('/erp4/whtransfer/detail.do?wt_no=${wht.WT_NO }', '창고이동 보기', 700, 1000)">
											${wht.WT_NO }
										</a>
									</td>
									<td style="text-align: center;">${wht.WH_NAME }</td>
									<td style="text-align: center;">${wht.WH_NAME2}</td>
									<td style="text-align: center;">${wht.PR_NAMES}</td>
									<td style="text-align: center;">${wht.TOTAL_QUANTITY }</td>
<%-- 									<td style="text-align: center;">${wht.PROGRESS == '0' ? '대기중' : (wht.PROGRESS == '1' ? '진행중' : '완료')}</td> --%>
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
					<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow2('/erp4/whtransfer/registForm.do', '창고이동 등록', 700, 1000)"
					style="width: 100px; margin: 20px; align-self: center;">등록</button>
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
		var selectedElement = document.getElementById("read_"+index);
		  if (selectedElement) {
		    selectedElement.style.color = "blue";
		    selectedElement.innerHTML = "읽음";
		  }
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
<%@ include file="../../include/footer_js.jsp" %>
