<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="selectedEmpNo" value="${sessionScope.emp_no}" />
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
  <meta name="generator" content="Hugo 0.104.2">
  <title>EazyRP</title>

  <!-- CSS only -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

  <meta name="theme-color" content="#712cf9">
</head>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<style>
html {
    height: 100%;
  }

  body {
    overflow-x: hidden;
    height: 100%;
  }

  .a:hover {
    background-color: darkslategray;
    transition-duration: 0.35s;
  }

  .nav--link.show {
    color: #fff !important;
  }

  .dropdown-menu {
    border: 1px solid #eee;
    border-radius: 0;
  }

  .card {
    border: solid 6px #f8f9fa;
    border-radius: 10px;
  }

  /* Custom styles */
  .navbar {
    background-color: #7bc4b2;
  }

  .navbar-brand {
    color: #fff;
    font-weight: bold;
  }

  .nav-link {
    color: #fff;
    text-decoration: none;
  }

  .nav-link:hover {
    color: #fff;
    background-color: #6ea89d;
    transition-duration: 0.35s;
  }

  .dropdown-menu {
    background-color: #7bc4b2;
  }

  .dropdown-item {
    color: #fff;
  }

  .dropdown-item:hover {
    background-color: #6ea89d;
    transition-duration: 0.35s;
  }

  .card-header {
    background-color: #f8f9fa;
    color: #000;
    font-weight: bold;
  }

  .table {
    color: #000;
  }
   #selectOp{
      font-size: 0.8em;
      border: 2px red solid;
      text-align: center;
      width: 100px;
      ${c_no ne "" && emp_no eq 0 ? "animation: ct2 0.7s infinite;" : ""}
      
   }
   #selectOp2{
      font-size: 0.8em;
      border: 2px red solid;
      text-align: center;
      width: 100px;
      ${c_no eq "" ? "animation: ct2 0.7s infinite;" : ""}
      
   }
   @keyframes ct2 {
        50% {border: 2px yellow solid;}
   }
   
   #animation {
     color: red;
     ${c_no eq "" || emp_no eq 0 ? "animation: ct 0.7s infinite;" : ""}
   }
   
   @keyframes ct {
        50% {color: yellow;}
   }
	#header{
		box-shadow: 0px 5px 10px gray;
	}
</style>

<body class="bg-light" style="padding: 0px;">
	<div id="cover" style="width: 100%; height: 93%; background-color: gray; opacity: 0.7; position: absolute; z-index: 2; top: 7%;"></div>
    <nav class="navbar navbar-expand-lg bg-light">
    	<c:if test="${empty c_no || emp_no eq 0}">
		    <div style="position: absolute; z-index: 3; right: 40px; top: 55px; font-weight: bold;" id="animation">
		        체험하실 업체와 직원을 먼저 선택해주세요.
		    </div>
		</c:if>
      <div class="container-fluid" style="position: relative;">
        <a class="navbar-brand" href="/common/main.do"><img src="<%=request.getContextPath() %>/resources/img/EazyRP2.png" style="width: 100px;"></a>
            <div style="display: flex;">
            	<form>
	             <select id="selectOp2" class="form-control" name="selectedC_no" style="margin-right: 20px;">
					<option value="X" style=" text-align: center;">업체 선택</option>
					<option style=" text-align: center;" value="C000001" ${c_no eq 'C000001' ? 'selected' : '' }>(주)지민식품</option>
					<option style=" text-align: center;" value="C000002" ${c_no eq 'C000002' ? 'selected' : '' }>희성전자</option>
					<option style=" text-align: center;" value="C000003" ${c_no eq 'C000003' ? 'selected' : '' }>석준물산</option>
					<option style=" text-align: center;" value="C000004" ${c_no eq 'C000004' ? 'selected' : '' }>(주)소라전자</option>
					<option style=" text-align: center;" value="C000005" ${c_no eq 'C000005' ? 'selected' : '' }>민준식품</option>
					<option style=" text-align: center;" value="C000006" ${c_no eq 'C000006' ? 'selected' : '' }>지환물산</option>
				</select>
				</form>
				<form>
	             <select id="selectOp" class="form-control" name="selectedEmp" style="${c_no eq '' ? 'background-color: gray;' : ''}" ${c_no eq '' ? 'disabled' : ''} >
					<option value="X" style=" text-align: center;" >직원 선택</option>
						<c:forEach items="${empMap['e_nameList']}" var="eName" varStatus="loop">
						    <c:set var="empNo" value="${empMap['emp_noList'][loop.index]}" />
						    <option style="text-align: center;" value="${empNo}" ${empNo eq selectedEmpNo ? 'selected' : ''}>${eName}</option>
						</c:forEach>
				</select>
				</form>
           </div>
         </div>
    </nav>

    <nav class="nav d-flex" id="header" style="padding: 0 16.66666667%; padding-top: 6px; background-color: #7bc4b2; justify-content:space-evenly;">
      <c:forEach items="${menuList}" var="menu">
         <li class="nav-scroller py-1 mb-2 dropdown">
          <a class="p-2 a nav-link  bold fw-bold" href="javascript:goPage('${menu.murl}', '${menu.mcode}', '${menu.micon }');" data-url="${menu.mcode }" aria-expanded="true" style="color: white; text-decoration-line: none;">${menu.mname }</a>
                   
         </li>
         </c:forEach>
         <div class="btn btn-link" id="logout" style="font-size: 12px; color: white; right: 10px;top: 72px;position: absolute;" >
			<svg style="margin-left: 10px; display: flex;align-items: center;" xmlns="http://www.w3.org/2000/svg" width="25" height="25"
				fill="currentColor" class="bi bi-box-arrow-right"
				viewBox="0 0 16 16">
			  <path fill-rule="evenodd"
								d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z" />
			  <path fill-rule="evenodd"
								d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z" />				
			</svg>
			<p >로그아웃</p>
			
         </div>
			
  </nav>
  <script>
		if($('#selectOp').val() != 'X'){
			$('#cover').css('display', 'none');
		}
	console.log('${c_no}')
  	$('#selectOp2').on('change', function(){
  		if($(this).val() != 'X'){
	  		location.href="/common/change.do?mcode=${mcode }&selectedC_no=" + $(this).val()
  		}
  	})
  	$('#selectOp').on('change', function(){
  		if($(this).val() != 'X'){
	  		location.href="/common/empChange.do?mcode=${mcode }&selectedEmp=" + $(this).val()
	  		alert('설정이 모두 완료되었습니다.');
  		}
  	})
  	
 	
  	
  	$('#logout').on('click', function(){
  		if(confirm("정말 로그아웃하시겠습니까")){
  		location.href="/common/logout.do";
  		}
  	})
  	
</script>
<!--   <nav class="flex-column p-3 sideMenuList" style=" float:left ; width: 15%; height: 100%; display: none; background-color: #7bc4b2;"> -->

<!--   </nav> -->