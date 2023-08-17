<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@page import="kr.or.dw.admin.vo.adminVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>집게리아 직원페이지</title>

<!-- Google Font: Source Sans Pro -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/assets/dist/css/adminlte.min.css">
<script
	src="<%=request.getContextPath()%>/assets/plugins/jquery/jquery.js"></script>

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

.card {
    border: 1px solid #eee;
}

.card-header {
    background-color: #f8f9fa;
    border-bottom: none;
}

.card-title {
    font-size: 20px;
    font-weight: bold;
    color: #333;
    padding: 10px 0;
}

.card-body {
    padding: 20px;
}

.form-group {
    margin-bottom: 0;
}

.table {
    font-size: 14px;
}

.table thead th {
    background-color: #f8f9fa;
    border: none;
    font-weight: bold;
}

.table-striped tbody tr:nth-of-type(odd) {
    background-color: #f8f9fa;
}

.table-striped tbody tr:nth-of-type(even) {
    background-color: #fff;
}

.btn-primary {
    background-color: #007bff;
    border-color: #007bff;
}

.btn-primary:hover {
    background-color: #0069d9;
    border-color: #0062cc;
}

.btn-primary:focus,
.btn-primary.focus {
    box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.5);
}


.user-panel img {
	height: 5rem;
	width: 5rem;
}
</style>
<body class="">
	<nav class="main-header navbar navbar-expand navbar-white navbar-light">






	</nav>

	<aside class="main-sidebar sidebar-dark-primary elevation-4 "
		style="overflow: hidden;">



		<div
			class="sidebar os-host os-theme-light os-host-overflow os-host-resize-disabled os-host-scrollbar-horizontal-hidden os-host-transition">
			<div class="os-resize-observer-host observed">
				<div class="os-resize-observer" style="left: 0px; right: auto;"></div>
			</div>
			<div class="os-size-auto-observer observed"
				style="height: calc(100% + 1px); float: left;">
				<div class="os-resize-observer"></div>
			</div>
			<div class="os-padding">
				<div class="os-viewport os-viewport-native-scrollbars-invisible">
					<div class="os-content"
						style="padding: 0px 8px; height: 100%; width: 100%;">
						<%
						UserVO vo = (UserVO)session.getAttribute("userVO");
						System.out.println(vo.getPicture());
						%>
						<br>
						<div style="text-align: center;">
						<img src="/img/profile/<%= vo.getPicture()%>.png"
							class="img-circle elevation-2" alt="User Image" width="100px" height="100px">
							</div>
							<br>
							<hr>
 							<h5 style="color: white; text-align: center;"><%= vo.getNick()%> 님 안녕하세요.</h5>
						<br>
						<nav class="mt-2">
							<ul class="nav nav-pills nav-sidebar flex-column"
								data-widget="treeview" role="menu" data-accordion="false">
								<%if (vo.getPos().equals("점장") || vo.getPos().equals("매니저") || vo.getU_no() == 0){%>
								<li class="nav-item menu-is-opening menu-open"><a
									href="<%=request.getContextPath()%>/admin/admin.do"
									class="nav-link active"> <i class="fas fa-solid fa-user"></i>
										<p>직원</p>
								</a>
									<ul class="nav nav-treeview" style="display: block;">
										<li class="nav-item"><a
											href="<%=request.getContextPath()%>/admin/MoneyAction.do"
											class="nav-link active"> <i class="fas fa-solid fa-coins"></i>
												<p>매출 조회</p>
										</a></li>
									<%} %>
										<ul class="nav nav-treeview" style="display: block;">
											<li class="nav-item"><a
												href="<%=request.getContextPath()%>/admin/EveryComm.do"
												class="nav-link active"> <i
													class="fas fa-solid fa-won-sign"></i>
													<p>급여 조회</p>
											</a></li>
											<ul class="nav nav-treeview" style="display: block;">
												<li class="nav-item"><a
													href="<%=request.getContextPath()%>/admin/ScheduleMain.do"
													class="nav-link active"> <i
														class="fas fa-solid fa-calendar-week"></i>
														<p>스케줄 조회</p>
												</a></li>
												<%if(vo.getU_no() == 0){ %>
												<ul class="nav nav-treeview" style="display: block;">
													<li class="nav-item"><a href="<%=request.getContextPath()%>/admin/BugerMenu.do"
														class="nav-link active"> 
														<i class="fas fa-hamburger"></i>
															<p>메뉴 관리</p>
													</a></li>
													<%} %>
												<ul class="nav nav-treeview" style="display: block;">
													<li class="nav-item"><a href="<%=request.getContextPath()%>/main.do"
														class="nav-link active"> <i
															class="fas fa-solid fa-dungeon"></i>
															<p>홈으로</p>
													</a></li>
						</nav>

					</div>
				</div>
			</div>
			<div
				class="os-scrollbar os-scrollbar-horizontal os-scrollbar-unusable os-scrollbar-auto-hidden">
				<div class="os-scrollbar-track">
					<div class="os-scrollbar-handle"
						style="width: 100%; transform: translate(0px, 0px);"></div>
				</div>
			</div>
			<div
				class="os-scrollbar os-scrollbar-vertical os-scrollbar-auto-hidden">
				<div class="os-scrollbar-track">
					<div class="os-scrollbar-handle"
						style="height: 51.2877%; transform: translate(0px, 0px);"></div>
				</div>
			</div>
			<div class="os-scrollbar-corner"></div>
		</div>

	</aside>
	<div class="row">
	<div class="col-lg-2"></div>
	<div class="content-header col-lg-10">
		<h1 class="text-center" style="text-align: center;"><%=request.getAttribute("title")%></h1>
		<div class="container-fluid">
			<div class="row mb-2">
				<div class="col-12"></div>
				<div class="col-12">
					<ol class="breadcrumb float-sm-right">

						<!-- 						<li class="breadcrumb-item"><a href="http://localhost/admin.do">Back</a></li> -->
					</ol>
				</div>
			</div>
		</div>
	</div>
	</div>