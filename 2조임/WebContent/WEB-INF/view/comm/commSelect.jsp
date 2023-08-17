<%@page import="java.util.List"%>
<%@page import="kr.or.dw.admin.vo.CommVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>

<%@ include file="../admin/header.jsp"%>

<%
	List<CommVO> commList = (List<CommVO>) request.getAttribute("commList");

request.getAttribute("title");
%>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<style>
@font-face {
	font-family: 'SUITE-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2')
		format('woff2');
	font-weight: 400;
	font-style: normal;
}

* {
	font: 1rem 'SUITE-Regular';
}

.main_content {
	padding-left: 270px;
	width: 100%;
	padding-top: 0 !important;
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

.btn-primary:hover, .btn-danger:hover, .btn-primary {
	background-color: blue;
	border-color: blue;
}

.card {
	border: 1px solid #eee;
}
</style>
<div class="nav-bar"></div>
<div class="main_content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-header">
						<div class="card-title text-center" style="float: none">급여 내역
							</div>
					</div>
					
					<div class="card-body p-0">
						<table class="table table-striped projects">
							<thead>
								<tr>
									<th style="width: 65px">급여 번호</th>
									<th style="width: 65px">회원 번호</th>
									<th style="width: 65px">이름</th>
									<th style="width: 65px">급여일</th>
									<th style="width: 65px">주휴수당</th>
									<th style="width: 65px">야간근무수당</th>
									<th style="width: 65px">인센티브</th>
									<th style="width: 65px">총급여</th>
									<th style="width: 65px">공제금액</th>
									<th style="width: 65px">실지급액</th>
								</tr>
							</thead>
							<tbody>

								<%
									for (CommVO comm : commList) {
								%>
								<tr>
									<td><%=comm.getC_no()%></td>
									<td><%=comm.getU_no()%></td>
									<td><%=comm.getName() %></td>
									<td><%=comm.getC_date()%></td>
									<td><%=comm.getW_incen()%></td>
									<td><%=comm.getN_incen()%></td>
									<td><%=comm.getIncen()%></td>
									<td><%=comm.getTotal()%></td>
									<td><%=comm.getDeduction()%></td>
									<td><%=comm.getActual()%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>

