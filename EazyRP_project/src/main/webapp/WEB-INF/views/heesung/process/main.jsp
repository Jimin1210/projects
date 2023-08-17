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
						<h2 class="card-title p-1">공정 목록</h2>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/erp4/process.do?mcode=${mcode }&murl=${murl }" style="display: contents;">
							<select class="form-control col-md-2 custom-select" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="cto" ${cri.searchType eq 'cto' ? 'selected' : '' }>코드 + 공정명 + 순번</option>
								<option value="c" ${cri.searchType eq 'c' ? 'selected' : '' }>공정코드</option>
								<option value="t" ${cri.searchType eq 't' ? 'selected' : '' }>공정명</option>
								<option value="o" ${cri.searchType eq 'o' ? 'selected' : '' }>순번</option>
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
					<table style="font-size: 0.8em;" class="table table-borderd text-center">
						<tr>
							<th>공정코드</th>
							<th>공정명</th>
							<th>내용</th>
							<th>순번</th>
						</tr>
						<c:if test="${empty processList }">
							<tr>
								<td colspan="5">
									<strong>해당 게시글이 없습니다.</strong>
								</td>
							</tr>
						</c:if>
						<c:forEach items="${processList }" var="process">		
							<tr>
								<td>${process.pc_code}</td>								
								<td>
									<a href="javascript:OpenWindow('/erp4/process/detail.do?pc_code=${process.pc_code}', '공정상세보기', 500, 540);">
										${process.pc_name}
									</a>
								</td>
								<td>${process.pc_content}
								<td>${process.pc_order}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<div class="card-footer">
					<%@ include file="/WEB-INF/views/common/pagination.jsp" %>
				</div>
				<div style="display: flex; align-items: end; justify-content: end;">
					<button type="button" class="btn btn-primary" id="registBtn" 
							onclick="OpenWindow('/erp4/process/registForm.do', 
									'공정 등록', 500, 540)"
							style="width: 100px; margin: 20px; align-self: center;">
						등록
					</button>
				</div>
			</div>
		</div>
	</div>
</section>
	
	
</body>
</html>

<script>

	$('#searchBtn').on('click', function(){
		$('#searchForm2').submit();
	})
	
	// 팝업창 띄우기
	// 새로운 Window 창을 Open 할 경우 사용되는 함수 (arg : 주소, 창 타이틀, 넓이, 길이)
	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
	}
	
	// 팝업창 닫기
	function CloseWindow(){
		self.opener = self;
    // 	if (window.opener) window.opener.location.reload(true);
		window.close();
	}
	
	
	
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<!-- jQuery -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<%@ include file="../../include/footer_js.jsp" %>
