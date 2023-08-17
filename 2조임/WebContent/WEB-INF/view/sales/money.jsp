<%@page import="kr.or.dw.sales.vo.SalesVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../admin/header.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<style>
@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
}
* {
	font: 1rem 'SUITE-Regular';
}
.main_content {
    padding-left: 270px;
    width: 100%;
    padding-top: 0!important;
    transition: .5s;
    position: relative;
    min-height: 100vh;
    padding-bottom: 90px;
    overflow: hidden;
}
.nav-bar {
    height: 100vh;
    left: 0;
    top: 0;
    z-index: 99;
    padding-bottom: 50px;
    position: fixed;
    width: 250px;
    z-index: 999;
    overflow: hidden;
    overflow-y: auto;
    transition: .5s;
    background: #fff;
    box-shadow: 0 0 40px #eff1f7;
    border-right: 1px solid #eee;
}
.card {border: 1px solid #eee;}
</style>
<div class="nav-bar">
</div>
<div class="main_content">
<div class="container-fluid">
	<div class="row">
	<div class="col-lg-2"></div>
		<div class="col-lg-8">
	<div class="card">
		<div class="card-header">
			<div class="card-title text-center" style="float: none">매출</div>
			조회날짜 : 
			<form method="post" action="<%= request.getContextPath()%>/sales/salesJoin.do">
				<input type="date" name="start">    ~    
				<input type="date" name="end">
				<input type="submit" value="조회하기">
			</form>
			<form style="text-align: center;" method="post" action="<%= request.getContextPath()%>/poi/poi.do">
				<input type="text" value="<%= request.getAttribute("start")%>" name="start" hidden>
				<input type="text" value="<%= request.getAttribute("end")%>" name="end" hidden>
				<%if(request.getAttribute("start") != null){ %>
				<input type="submit" value="엑셀 변환" class="btn btn-primary btn-sm modify-btn">
				<%} %>
			</form>
		</div>
		<div class="card-body p-0">
			<table class="table table-striped projects">
				<thead>
					<tr>
						<th style="width: 80px">매출 일자</th>
						<th style="width: 65px">일 매출</th>
						<th style="width: 65px">방문 인원</th>						
					</tr>
				</thead>
				<tbody>
		<% 
			List<SalesVO> salesVo = (List<SalesVO>)request.getAttribute("vo");
			if(salesVo != null){
				for(SalesVO svo : salesVo){
		%>
							
					<tr class="tr-check">
						<td><%= svo.getA_date()%></td>
						<%@ page import="java.text.*" %>
			<%
			DecimalFormat df = new DecimalFormat("###,###");
			%>
				<td><%= df.format(svo.getDailysales())%></td>
				<td><%= svo.getCnt()%></td>
				</tr>	
					
				
		<%}}%>
		</tbody>
			</table>
		</div>

	</div>

	</div>

</div>
</div>
