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
					<div class="card-header">
						<h3 class="card-title p-1">받은 쪽지함</h3>
						<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm" method="post" action="/mymenu/search.do?mcode=${mcode }" style="display: contents;">
							<select class="form-control col-md-2" name="searchType" id="searchType" style="font-size: 0.8em;">
								<option value="tcw" ${searchType eq 'tcw' ? 'selected' : '' }>전  체</option>
								<option value="t" ${searchType eq 't' ? 'selected' : '' }>제  목</option>
								<option value="w" ${searchType eq 'w' ? 'selected' : '' }>보낸사람</option>
								<option value="c" ${searchType eq 'c' ? 'selected' : '' }>업  체</option>
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
							<table style="font-size: 0.8em;">
								<tr>
									<th width="50px" style="text-align: center;"></th>
									<th width="350px" style="text-align: center;">제목</th>
									<th width="150px" style="text-align: center;">보낸 사람</th>
									<th width="220px" style="text-align: center;">업체명</th>
									<th width="120px" style="text-align: center;">첨부파일 여부</th>
									<th width="300px" style="text-align: center;">보낸 시간</th>
								</tr>
									<tr style="height: 20px;"></tr>
									<tr>
										<td id="read_${loop.index}" style="text-align: center; height:80%; font-weight:bold; font-size: 0.7em; color: ${note.readable == 'N' ? 'red' : 'blue' };">
										1
										</td>
										<td style="text-align: center;"><a id="aTag" href="#" onclick="OpenWindow('/mymenu/detail.do?n_no=${note.n_no }&send=N', '쪽지보기', 700, 1000, '${loop.index}')">2</a></td>
										<td style="text-align: center;">3</td>
										<td style="text-align: center;">4</td>
										<td style="text-align: center;">5</td>
										<td style="text-align: center;">6</td>
									</tr>
							</table>
							<div class="card-footer">
								<%@ include file="/WEB-INF/views/common/pagination2.jsp" %>
							</div>
						</div>
					</div>
					</div>
					<div style="display: flex; align-items: end; justify-content: end;">
					<button type="button" class="btn btn-primary" id="registBtn" onclick="OpenWindow2('/mymenu/communication.do', '쪽지쓰기', 700, 1000)"
					style="width: 100px; margin: 20px; align-self: center;">쪽지 쓰기</button>
				</div>
			</div>
			
		</div>
	</section>
	
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
	

<%@ include file="../include/footer_js.jsp" %>
