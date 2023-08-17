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
						<h2 class="card-title p-1">작성 기안문</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/management/registPayment.do?mcode=${mcode }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="all" ${searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="d" ${searchType eq 'd' ? 'selected' : '' }>서류구분</option>
								<option value="t" ${searchType eq 't' ? 'selected' : '' }>결재서류명</option>
								<option value="w" ${searchType eq 'w' ? 'selected' : '' }>기안자</option>
								<option value="p" ${searchType eq 'p' ? 'selected' : '' }>진행상태</option>
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
									<th width="90px"></th>
									<th width="150px" style="text-align: center;">기안일자</th>
									<th width="350px" style="text-align: center;">결재서류명</th>
									<th width="200px" style="text-align: center;">구분</th>
									<th width="100px" style="text-align: center;">기안자</th>
									<th width="200px" style="text-align: center;">진행상태</th>
								</tr>
									<c:forEach items="${draft}" var="dr" varStatus="var">
									<tr>
										<td style="color: red; font-size: 0.6em; font-weight: bold;">
											<c:if test="${dr.pay_no eq emp_no}">
												결재필요!
											</c:if>
										</td>
										<td style="text-align: center;">${dr.sys_regdate }</td>
										<td style="text-align: center;"><a id="aTag" href="#" onclick="OpenWindow('/management/detail.do?dr_no=${dr.dr_no }&send=N', '기안문 조회', 700, 1000, '${loop.index}')">${dr.title }</a></td>
										<td style="text-align: center;">${dr.gb }</td>
										<td style="text-align: center;">${dr.e_name}</td>
										<td id="read_${loop.index}" style="text-align: center; height:80%; font-weight:bold; font-size: 0.6em; color: 
										<c:if test="${dr.pl_progress eq '0'}">
										black
										</c:if>
										<c:if test="${dr.pl_progress eq '1' || dr.pl_progress eq '2'}">
										#ae78ff
										</c:if>
										<c:if test="${dr.pl_progress eq '3'}">
										blue
										</c:if>
										<c:if test="${dr.pl_progress eq '1fail' || dr.pl_progress eq '2fail' || dr.pl_progress eq '3fail'}">
										red
										</c:if>
										;">
										<c:if test="${dr.pl_progress eq '0'}">
											결재 대기중
										</c:if>
										<c:if test="${dr.pl_progress eq '1' || dr.pl_progress eq '2'}">
											결재 진행중(${dr.pl_progress})
										</c:if>
										<c:if test="${dr.pl_progress eq '3'}">
											결재 완료
										</c:if>
										<c:if test="${dr.pl_progress eq '1fail' || dr.pl_progress eq '2fail' || dr.pl_progress eq '3fail'}">
											반려
										</c:if>
										</td>
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
					<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow2('/management/documentRegist.do', '기안문작성', 700, 1000)"
					style="width: 100px; font-size: 0.8em; margin: 20px; align-self: center;">기안문 작성</button>
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
