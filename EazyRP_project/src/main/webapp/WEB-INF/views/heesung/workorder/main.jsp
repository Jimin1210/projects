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
						<h2 class="card-title p-1">작업지시서 목록</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/erp4/workorder.do?mcode=${mcode }" style="display: contents;">
							<select class="form-control col-md-2 custom-select" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="tw" ${searchType eq 'tw' ? 'selected' : '' }>제목 + 담당자</option>
								<option value="t" ${searchType eq 't' ? 'selected' : '' }>제목</option>
								<option value="w" ${searchType eq 'w' ? 'selected' : '' }>담당자</option>
							</select>
							<input class="form-control col-md-4" type="text" name="keyword" style="width: 60%; font-size: 0.8em" placeholder="검색어를 입력하세요." value="${keyword}">
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
									<th width="15%" style="text-align: center;">등록일</th>
									<th width="30%" style="text-align: center;">제목</th>
									<th width="10%" style="text-align: center;">담당자</th>
									<th width="15%" style="text-align: center;">납기일</th>
									<th width="15%" style="text-align: center;">상태</th>
								</tr>
								<c:if test="${empty woList }">
									<tr>
										<td colspan="5">
											<strong>해당 게시글이 없습니다.</strong>
										</td>
									</tr>
								</c:if>
								<c:forEach items="${woList}" var="wo" varStatus="">
									<tr>
										<input type="hidden" name="${wo.wo_no }">
										<td width="15%" style="text-align: center;">
											<fmt:formatDate value="${wo.sys_regdate}" pattern="yyyy-MM-dd"></fmt:formatDate>
										</td>
										<td width="30%" style="text-align: center;">
											<a id="aTag" href="#" onclick="OpenWindow('/erp4/workorder/detail.do?wo_no=${wo.wo_no }&send=N', '작업지시서 보기', 700, 1000)">
												${wo.wo_name }
											</a>
										</td>
										<td width="10%" style="text-align: center;">${wo.e_name }</td>
										<td width="15%" style="text-align: center;">
											<fmt:formatDate value="${wo.deliverydate }" pattern="yyyy-MM-dd"></fmt:formatDate>
										</td>
										<td width="15%" style="text-align: center; color: ${wo.progress == '0' ? 'red' : wo.progress == '1' ? 'green' : 'blue'}">${wo.progress == '0' ? '대기중' : (wo.progress == '1' ? '진행중' : '완료')}</td>
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
					<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow2('/erp4/workorder/registForm.do', '작업지시서 등록', 700, 1000)"
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
