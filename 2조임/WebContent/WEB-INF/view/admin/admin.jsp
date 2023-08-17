<%@page import="java.util.List"%>
<%@page import="kr.or.dw.admin.vo.adminVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>

<%
	List<adminVO> adminList = (List<adminVO>) request.getAttribute("adminList");
%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<style>
@font-face {
	font-family: 'SUITE-Regular';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2')
		format('woff2');
	font-weight: 500;
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
		<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<div class="card">
					<div class="card-header" style="">
<!-- 						<div class="card-title text-center" style="float: none">직원</div> -->
						<td>
						<a
							href="<%=request.getContextPath()%>/admin/InsertAction.do"><button
									class="btn btn-primary">&nbsp직원 추가 버튼 <i class="bi bi-hand-index"></i></button></a>
						</td>
						<%--  				<td><a href = "<%=request.getContextPath()%>/admin/DeleteAction.do"><button class="btn btn-danger">직원 삭제 버튼</button></a></td> --%>
					</div>
					<div style="height: 50px; padding: 15px;">
						<input type="checkbox" id='test1' name="test" value="점장" checked> 점장 <input
							type="checkbox" id='test2' name="test" value="매니저" checked style="margin-left: 10px;"> 매니저 <input
							type="checkbox" id='test3' name="test" value="알바" checked style="margin-left: 10px;"> 알바
					</div>
					<div class="card-body p-0">
						<table class="table table-striped projects">
							<thead>
								<tr>
									<th style="width: 65px">번호</th>
									<th>아이디</th>
									<th>이름</th>
									<th>연봉 또는 시급</th>
									<th style="width: 90px">직급</th>
									<th style="width: 170px">관리</th>
								</tr>
							</thead>
							<tbody>

								<%
									for (adminVO admin : adminList) {
								%>
								<tr class="tr-check" id="<%=admin.getPos()%>">
									<td><%=admin.getU_no()%></td>
									<td><%=admin.getId()%></td>
									<td><%=admin.getName()%></td>
									<td><%=admin.getSal()%></td>
									<td><%=admin.getPos()%></td>
									<td>
									<%if(vo.getU_no() == 0){ %>
									<a class="btn btn-admin"
										href="<%=request.getContextPath()%>/admin/selectAdmin.do?u_no=<%=admin.getU_no()%>">
											<i class="bi bi-gear"></i></a>
									<%} else if (vo.getPos().equals("점장") || vo.getPos().equals("매니저")){
										if(admin.getPos().equals("알바")){%>
										<a class="btn btn-admin"
										href="<%=request.getContextPath()%>/admin/selectAdmin.do?u_no=<%=admin.getU_no()%>">
											<i class="bi bi-gear"></i></a>
										
									<%}} %>
									</td>
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

<script>
	$(function() {

		/* $('input[name="test"]').on('change', function() {
			var check = $(this).val();
			if ($('#점장').is(':checked')) {
				$(".tr-check").css("display", "none");
				$("#점장").css("display", "table-row");
			} else if ($('#매니저').is(':checked')) {
				$(".tr-check").css("display", "none");
				$("#매니저").css("display", "table-row");
			} else if ($('#알바').is(':checked')) {
				$(".tr-check").css("display", "none");
				$("#알바").css("display", "table-row");
			}
		}); */

		$('#test1').on('click', function(){
			$("#점장").toggle();
		})
		$('#test2').on('click', function(){
			$("#매니저").toggle();
		})
		$('#test3').on('click', function(){
			$("#알바").toggle();
		})
	});
</script>






