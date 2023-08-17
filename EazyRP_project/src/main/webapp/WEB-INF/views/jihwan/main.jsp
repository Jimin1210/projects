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
					<h3 class="card-title p-1">견 적 서</h3>
<!-- 					<button type="button" class="btn btn-danger" id="" -->
<!-- 						onclick="javascript:OpenWindow('estimate_regist.do','견적서 등록', 600 ,800);">등록</button> -->
					<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post" action="/erp4/estimate.do?mcode=${mcode }&murl=${murl }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="all" ${cri.searchType eq 'all' ? 'selected' : '' }>전  체</option>
								<option value="d" ${cri.searchType eq 'd' ? 'selected' : '' }>거래처</option>
								<option value="t" ${cri.searchType eq 't' ? 'selected' : '' }>담당자</option>
								<option value="w" ${cri.searchType eq 'w' ? 'selected' : '' }>품목명</option>
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
				<div class="card-body pad" style="padding-top: 0px;">
					<div>
						<table style="font-size: 0.8em; " class="table table-borderd text-center">
							<tr>
								<th style="text-align: center;">견적서코드</th>
								<th style="text-align: center;">등록일자</th>
								<th style="text-align: center;">거래처명</th>
								<th style="text-align: center;">담당자</th>
								<th style="text-align: center;">품목명</th>
								<th style="text-align: center;">규격</th>
								<th style="text-align: center;">견적금액합계</th>
								<th style="text-align: center;">진행상태</th>
								<th style="text-align: center;">첨부파일여부</th>
							</tr>
							<c:forEach items="${estimList }" var="estimate">
								<%-- 						<c:set var="est_no">${estimate.EST_NO }</c:set> --%>
								<tr style="font-size: 1em; text-align : center;">
									<td><a
										href="javascript:OpenWindow('estimateDetail.do?est_no=${estimate.EST_NO }','견적서 조회', 700 ,700);">${estimate.EST_NO }</a></td>
									<td><fmt:formatDate value="${estimate.REGDATE }"
											pattern="yyyy-MM-dd"></fmt:formatDate></td>
									<td>${estimate.C_NAME }</td>
									<td>${estimate.E_NAME }</td>
									<td>${estimate.P_AMOUNT_NAME }</td>
									<td>${estimate.PR_ST }</td>
									<td>${estimate.AMOUNT }</td>
									<td style="color: ${estimate.PROGRESS eq '0' ? 'red' : estimate.PROGRESS eq '1' ? 'green' : estimate.PROGRESS eq '2' ? 'blue' : '' }">
									${estimate.PROGRESS == '0' ? '접수중' : (estimate.PROGRESS == '1' ? '처리중' : (estimate.PROGRESS == '2' ? '완료' : '' ))}
									</td>
									<td style="color:${estimate.FILES ne null ? 'blue' : 'red'}">${estimate.FILES != null ? "있음" : "없음"}</td>
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
				onclick="javascript:OpenWindow('estimate_regist.do','견적서 등록', 600 ,800);"
					style="width: 110px; heigth: 20px; margin: 10px; font-size: 0.8em; align-self: center;">견적서 등록</button>
			</div>
		</div>

	</div>
</section>


<script
	src="<%=request.getContextPath()%>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>


<%@ include file="../include/footer_js.jsp"%>

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
