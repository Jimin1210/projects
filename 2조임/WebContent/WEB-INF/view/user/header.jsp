<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kr.or.dw.user.vo.UserVO"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<script
	src="<%=request.getContextPath()%>/assets/plugins/jquery/jquery.js"></script>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>집게리아</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet"><link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
  <style> @font-face {
    font-family: 'ONE-Mobile-POP';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/ONE-Mobile-POP.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
body::after {
  width: 100%;
  height: 100%;
  content: "";
  background-image: url(/img/bg1.jpg);
	background-size: 70%;
	position: fixed;
  bottom: 0px;
   top: 0px;
   right: 0px;
  z-index: -1;
  opacity: 0.3;
}
navb::after {
	content: "";
	opacity: 0.5;
}
html{
	
}
ul, ol {
  margin: 0;
  padding: 0;
  list-style: none;
}
a {
  text-decoration: none;
}

.header {
      position: relative;
      width: auto;
      padding: 20px 0;
      text-align: center;
      font-size: 25px;
      font-family: 'ONE-Mobile-POP';
    }
    
    .header .logo {
  width: 350px;
  margin: 0px auto 25px;
  color: #000;
}
.header .logo img {
  width: 100%;  
}
.header .navbar-bg {
  width: 100%;
  background: #fff;
}
.nav li {
    margin: 0 30px;
}
	.myStatus{
		height: 80%;
		background-color: 
	}
    body {
      background-color: #ffffff;
      margin: 0;
    }
    .content {
      width: 800px;
      min-height: 600px;
      margin: 0 auto;
      padding: 15px 0;
    }
    .column {
      flex: 1;
      padding: 5px;
      padding-right: 100%;
}
    
    .footer {
      color: #000000;
      text-align: center;
      bottom: 0;
      width: 815px;
      margin: 0 auto;
      font-size: 12px;
      font-family: 'ONE-Mobile-POP';
    }
    .btn {
      content: counter(name);
      background-color: #ffffff;
      border: none;
      color: rgb(0, 0, 0);
      padding: 20px 0px;
      text-align: center;
      text-decoration: none;
      display: block;
      font-size: 20px;
      cursor: pointer;
      width: 100%;
      font-family: 'ONE-Mobile-POP';
    }

    #slider {       
        width: 100%;
        height: 100%;
        margin: 0% auto;
        padding: 0%;
        overflow: hidden;
        white-space: nowrap;
        box-sizing: border-box;
    }
      #slider > li {
        width: 100%;
        height: 550px;

        position: relative;
        display: inline-block;
        overflow: hidden;
        font-size: initial;
        line-height: normal;
        transition: all 0.5s; 
        background-size: cover;
        box-sizing: border-box;
        white-space: normal;
      }
      
  
      
      .header .navbar-bg .nav .dropdown:hover ul {
  display: block;
}
.content-wrapper .side-img {
    text-align: center;
}

</style>
<%
	UserVO vo = (UserVO)session.getAttribute("userVO");
	
	int u_no = -1;
	if(vo != null){
		u_no = vo.getU_no();
	}

%>
<header class="header">
    <div class="container">
        <div class="row">      
            <a href="/main.do" class="logo"><img src="/img/a2.png"></a>
            <div>
            	<div class="navbar-bg navb" style="border-radius: 30px;">
                <nav class="d-flex justify-content-center py-3">
                    <ul class="nav nav-pills">
                        <li class="dropdown">
                            <a href="#" class="nav-link dropdown-toggle">메뉴</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="<%=request.getContextPath()%>/product/productView.do?cla=0">전체보기</a></li>
                                <li><a class="dropdown-item" href="<%=request.getContextPath()%>/product/productView.do?cla=1">비프패티버거</a></li>
                                <li><a class="dropdown-item" href="<%=request.getContextPath()%>/product/productView.do?cla=2">튀김패티버거</a></li>
                                <li><a class="dropdown-item" href="<%=request.getContextPath()%>/product/productView.do?cla=3">사이드&음료</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#" class="nav-link dropdown-toggle">고객지원</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="<%= request.getContextPath()%>/board/board1.do?notice=1&u_no=<%= u_no%>">건의함</a></li>
                                <li><a class="dropdown-item" href="<%= request.getContextPath()%>/board/board1.do?notice=2&u_no=<%= u_no%>">칭찬함</a></li>
                                <li><a class="dropdown-item" href="<%= request.getContextPath()%>/board/board1.do?notice=3&u_no=<%= u_no%>">불편함</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="<%= request.getContextPath()%>/board/board1.do?notice=4&u_no=<%= u_no%>" class="nav-link">공지사항</a>
                            
                        </li>
                        <li class="dropdown">
                            <a href="<%= request.getContextPath()%>/board/board1.do?notice=5&u_no=<%= u_no%>" class="nav-link">Q&A</a>
                          
                        </li>
                    </ul>
                </nav>
            </div>
            </div>
        </a>
    </div>
    </div>
    
</header>