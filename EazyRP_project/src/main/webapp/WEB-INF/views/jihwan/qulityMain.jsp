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
						<h2 class="card-title p-1">품질관리</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/erp5/quality.do?mcode=${mcode }&murl=${murl }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="a" ${cri.searchType eq 'a' ? 'selected' : '' }>담당자</option>
								<option value="b" ${cri.searchType eq 'b' ? 'selected' : '' }>제품</option>
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
									<th width="200px" style="text-align: center;">품질번호</th>
									<th width="200px" style="text-align: center;">담당자</th>
									<th width="150px" style="text-align: center;">품목</th>
									<th width="150px" style="text-align: center;">규격</th>
									<th width="150px" style="text-align: center;">총 수량</th>
									<th width="150px" style="text-align: center;">종결 여부</th>
									<th width="150px" style="text-align: center;">파일 여부</th>
								</tr>
									<c:forEach items="${qualityList }" var="quality" varStatus="loop">
									<tr>
										<td style="text-align: center;"><a id="aTag" href="javascript:OpenWindow('qualityDetail.do?qc_no=${quality.QC_NO}','품질 상세보기', 600, 600);">${quality.QC_NO }</a></td>
										<td style="text-align: center;">${quality.E_NAME }</td>
										<td style="text-align: center;"><a id="aTag" href=""></a>${quality.PR_NAMES }</td>
										<td style="text-align: center;">${quality.PR_ST }</td>
										<td style="text-align: center;">${quality.QUANTITY }개</td>
										<td style="color:${quality.PROGRESS ne '0' ? 'blue' : 'red'}">${quality.PROGRESS == '0' ? '전수중' : '완료'}</td>
										<td style="color:${quality.FILES ne null ? 'blue' : 'red'}">${quality.FILES != null ? "있음" : "없음"}</td>
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
								<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow('qc_regist.do', '품질', 600, 600)"
								style="width: 100px; font-size: 0.8em; margin: 20px; align-self: center;">품질 등록</button>
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
	
	

	
</script>
<%@ include file="../include/footer_js.jsp" %>
