<%@page import="kr.or.dw.admin.vo.adminVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@ include file="header.jsp" %>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<!-- Font Awesome Icons -->
<style>
.box1{
color : rgb(146, 146, 146);

text-align: center;

width: 500px;

height: 300px;
margin: 0 auto;

border-radius: 8%
}

.box2{
margin: 0 auto;
    text-align: center;
    width: 500px;
}
</style>
<!-- Theme style -->
<div class="content-wrapper">
    <div class="container">
        <div class="row">
        <div class="col-lg-3"></div>
            <div class="col-lg-6">
                <ul id="slider" style="border-radius: 200px">
                    <li style="margin: 0px;">
                        <img src="/img/product/냄새버거.png" width="97%"  height="100%" style="margin: 0px; border-radius: 200px">
                    </li>
                    <li style="margin: 0px;">
                        <img src="/img/product/바닷가재버거.png" width="97%"  height="100%" style="margin: 0px; border-radius: 200px">
                    </li>
                    <li>
                        <img src="/img/product/게살와퍼.png" width="97%"  height="100%" style="margin: 0px; border-radius: 200px">
                    </li>
                    <li>
                        <img src="/img/product/해삼튀김.png" width="97%"  height="100%" style="margin: 0px; border-radius: 200px">
                    </li>
                    <li>
                        <img src="/img/product/이쁜이버거.png" width="97%"  height="100%" style="margin: 0px; border-radius: 200px">
                    </li>
                    
                </ul>
                <script>
                  // Slide every slideDelay seconds
                  const slideDelay = 3000;

                  const dynamicSlider = document.getElementById("slider");

                  var curSlide = 0;
                  window.setInterval(()=>{
                      curSlide++;
                      if (curSlide === dynamicSlider.childElementCount) {
                          curSlide = 0;
                      }

                    // Actual slide
                    dynamicSlider.firstElementChild.style.setProperty("margin-left", "-" + curSlide + "00%");
                  }, slideDelay);

                </script>
            </div>
            <div class="col-lg-3" style="align-items: center; justify-content: center; display: flex;">
            <div class="myStatus">
            	<% 
            		
            		if(vo == null){
            	%>
                <div class="side-img"><img src="/img/a1.png" width="50%"></div>
                <br>
                <a href="<%= request.getContextPath() %>/user/userLoginForm.do" button class="btn btn-primary">로그인</button></a>
                <br>
                <a href="<%= request.getContextPath() %>/user/joinForm.do" button class="btn btn-primary">회원가입</button></a>
				<%
            		} else if(vo.getU_no() > -1) {
				%>
				<br>
			    <div class="box2">
			        <div style="border-radius: 50%;  justify-content: center; align-items: center; display: flex">
						<img src="/img/profile/<%= vo.getPicture()%>.png" style="border: 3px; border-radius: 80%; width: 100px; height: 100px;">
					</div>
					<br>
				    <h4><%= vo.getNick()%>님, 안녕하세요.</h4>
				    <br>
				    <h5>포인트 : <%= vo.getPoint()%>P</h5>
				    <br><br>
				</div>
				<div class="box1">
					<a href="<%= request.getContextPath()%>/user/userStatus.do?u_no=<%=vo.getU_no()%>" style=""><button>정보수정</button></a>
					<a href="<%= request.getContextPath() %>/user/userLogOut.do"><button>로그아웃</button></a><br><br>
					<% 
					System.out.println(vo.getNick().equals("관리자"));
					if(vo.getU_no() == 0 || vo.getPos().equals("점장") || vo.getPos().equals("매니저") || vo.getPos().equals("알바")){
					%>
					<a href="<%= request.getContextPath()%>/admin/admin.do?pos=<%=vo.getPos()%>"><button>직원 페이지로 이동</button></a>
				<%}} %>
				</div>
				</div>
            </div>
        </div>
    </div>
</div>

<div class="footer">
<p style="font-size: 450%">오늘의 추천 메뉴!</p>
<br><br>
    <p>대전광역시 중구 중앙로 121번길 20 (선화동 41) 2층
    <br>tel 042-123-1234
    사업자 등록번호 123-12-12345  <br> (주)집게이리아 : 집게이사장
    Copyright 2019 ® Ltd All right Reserved</p>
</div>
</body>
</html>