<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="cri" value="${pageMaker.cri }" />
<div style="height: 40px"></div>
<section class="content container-fluid">
	<div class="row justify-content-center">
		<div class="col-md-10" style="max-width: 1100px;">
			<div class="card card-outline card-info">
				<div class="card-header">
					<h3 class="card-title p-1">출 하 지 시 서</h3>
					<!-- 					<button type="button" class="btn btn-danger" id="" -->
					<!-- 						onclick="javascript:OpenWindow('estimate_regist.do','견적서 등록', 600 ,800);">등록</button> -->
					<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post"
							action="/erp4/siSelect.do?mcode=${mcode }&murl=${murl }"
							style="display: contents;">
							<select class="form-control col-md-2" name="searchType"
								id="searchType" style="font-size: 0.8em;">
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전
									체</option>
								<option value="d" ${cri.searchType eq 'd' ? 'selected' : '' }>사원명</option>
								<option value="t" ${cri.searchType eq 't' ? 'selected' : '' }>창고명</option>
								<option value="w" ${cri.searchType eq 'w' ? 'selected' : '' }>제품명</option>
							</select> <input class="form-control col-md-4" type="text" name="keyword"
								style="width: 60%; font-size: 0.8em" placeholder="검색어를 입력하세요."
								value="${cri.keyword}"> <span
								class="input-group-append col-md-3" style="padding: 0px;">
								<button class="btn btn-primary" type="button" id="searchBtn">
									<i class="fa fa-fw fa-search"
										style="font-size: 0.8em; padding: 0px;"></i>
								</button>
							</span>
						</form>
					</div>
				</div>
				<div class="card-body pad" style="padding-top: 0px;">
					<div>
						<table style="font-size: 0.8em;"
							class="table table-borderd text-center">
							<tr>
								<th style="text-align: center;">지시서 코드</th>
								<th style="text-align: center;">창고명</th>
								<th style="text-align: center;">등록일자</th>
								<th style="text-align: center;">사원이름</th>
								<th style="text-align: center;">품목명</th>
								<th style="text-align: center;">규격</th>
								<th style="text-align: center;">총 수량</th>
								<th style="text-align: center;">진행 상태</th>
							</tr>
							<c:forEach items="${siList }" var="si">
								<tr style="font-size: 1em; text-align: center;">
									<td><a
										href="javascript:OpenWindow('siDetail.do?si_no=${si.SI_NO }','출하지시서 조회', 600 ,700);">${si.SI_NO }</a></td>
									<td>${si.WH_NAME }</td>
									<td><fmt:formatDate value="${si.SYS_REGDATE }"
											pattern="yyyy-MM-dd"></fmt:formatDate></td>
									<td>${si.E_NAME}</td>
									<td>${si.PR_NAME }</td>
									<td>${si.PR_ST }</td>
									<td>${si.QUANTITY }</td>
									<td style="color: ${si.PROGRESS eq 0 ? 'red' : si.PROGRESS eq 1 ? 'green' : si.PROGRESS eq 2 ? 'blue' : '' }">
										${si.PROGRESS == '0' ? '접수중' : (si.PROGRESS == '1' ? '출하대기중' : (si.PROGRESS == '2' ? '출하완료' : '' ))}
									</td>
								</tr>
							</c:forEach>
						</table>
						<div class="card-footer">
							<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
						</div>
					</div>
				</div>
			</div>
			<div style="display: flex; align-items: end; justify-content: end;">
				<button type="button" class="btn btn-primary" id=""
				onclick="javascript:OpenWindow('si_regist.do','출하지시서 등록', 600 ,800);"
					style="width: 110px; heigth: 20px; margin: 10px; font-size: 0.8em; align-self: center;">출하 등록</button>
			</div>
		</div>
	</div>
</section>


<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>



<script>
	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
	}
</script>


<!-- jQuery -->
<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<%@ include file="../include/footer_js.jsp"%>

