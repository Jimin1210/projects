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
						<h2 class="card-title p-1">A/S 관리</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/asmanage/as.do?mcode=${mcode }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="p" ${cri.searchType eq 'p' ? 'selected' : '' }>진행상황</option>
								<option value="c" ${cri.searchType eq 'c' ? 'selected' : '' }>내  용</option>
								<option value="n" ${cri.searchType eq 'n' ? 'selected' : '' }>담당기사</option>
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
									<th style="text-align: center;">A/S 코드</th>
									<th style="text-align: center;">담당 기사</th>
									<th style="text-align: center;">요청 날짜</th>
									<th style="text-align: center;">완료 날짜</th>
									<th style="text-align: center;">진행 상황</th>
								</tr>
								
								<c:forEach items="${asList}" var="as" >								
									<tr>
										<td style="text-align: center;">
											<a id="asDetailBtn" href="#" onclick="detailOpenWindow('/asmanage/detail.do?as_no=${as.AS_NO }', 'A/S 상세정보', 500, 600)">
												${as.AS_NO }
											</a>
										</td>
										<td style="text-align: center;">${as.E_NAME }</td>
										<td style="text-align: center;"><fmt:formatDate value="${as.SYS_REGDATE }" pattern="yyyy-MM-dd"></fmt:formatDate></td>
										<td style="text-align: center;"><fmt:formatDate value="${as.COMPLDATE }" pattern="yyyy-MM-dd"></fmt:formatDate></td>
										<td style="color: ${as.PROGRESS eq '0' ? 'red' : as.PROGRESS eq '1' ? 'green' : as.PROGRESS eq '2' ? 'blue' : '' }"; "text-align: center;" > ${as.PROGRESS == '0' ? '대기중' : (as.PROGRESS == '1' ? '진행중' : '완료')}</td>
										<input type="hidden" name="emp_no "value="${as.EMP_NO }">
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
					<button type="button" class="btn btn-primary" id="registBtn" onclick="registOpenWindow('/asmanage/registForm.do', 'A/S 접수',  500, 600)"
					style="width: 100px; margin: 20px; align-self: center;">A/S 접수</button>

				</div>
			</div>
		</div>
	</section>
	
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	
<script>
		
	$('#searchBtn').on('click', function(){
		$('#searchForm2').submit();
	})
	
	function detailOpenWindow(UrlStr, WinTitle, WinWidth, WinHeight, index){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
	};
	
	function registOpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
	};

	
</script>
<%@ include file="../include/footer_js.jsp" %>
