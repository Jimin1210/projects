<%@page import="kr.or.dw.admin.vo.adminVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../admin/header.jsp"%>

<%
adminVO adminVo = (adminVO) request.getAttribute("adminVo");
String pos ="";
%>
<script>
  

</script>


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
      <div class="col-lg-10">
   <div class="card">
      <div class="card-header">
         <div class="card-title text-center" style="float: none">직원 정보</div>
      </div>
      <div class="card-body p-0">
         <form action="<%= request.getContextPath()%>/admin/updateStatus.do" method="post">
         <input type="text" value="<%=adminVo.getU_no()%>" name="u_no" style="display: none;">
         <table class="table table-striped projects">
            <thead>
               <tr>
                  <td>직원 번호</td>
                  <td><%=adminVo.getU_no()%></td>
                  <td>시급 또는 연봉</td>
                  <td><input type="text" value="<%=adminVo.getSal()%>" name="sal"></td>                     
               </tr>
               <tr>
                  <td>직원 아아디</td>
                  <td><%=adminVo.getId()%></td>
               </tr>
               <tr>
                  <td>생년 월 일</td>
                  <td><%=adminVo.getBirth()%></td>
               </tr>
               <tr>
                  <td>직원 이름</td>
                  <td><%=adminVo.getName()%></td>
                  <td>전화번호</td>
                  <td><%=adminVo.getTel()%></td>
               </tr>
               <tr>
                  <td>주소</td>
                  <td><%=adminVo.getAddr()%></td>
               </tr>
               <tr>
                  <td>직급</td>
                  <td>                     
                     <select name="pos">
                     	<% if(adminVo.getU_no() == 0){ %>
                        <option <%
                           if(adminVo.getPos().equals("점장")) {
                        %>
                           selected
                        <%      
                           } 
                        %>
                        >점장</option>
                        <option <%
                           if(adminVo.getPos().equals("매니저")) {
                        %>
                           selected
                        <%      
                           } 
                        %>>매니저</option>
                        <%} %>
                        <option <%
                           if(adminVo.getPos().equals("알바")) {
                        %>
                           selected
                        <%      
                           } 
                        %>>알바</option>
                     </select>      
                        
                  </td>   
                     
                  <td>이메일</td>
                  <td><%=adminVo.getEmail()%></td>   
               </tr>
               <tr>
                  <td>매장 정보</td>
                  <td><%=adminVo.getLoc()%></td>
                  <td>성별</td>
                  <td><%if(adminVo.getGender()== 1){%> 
                        남자<%} else {%> 
                  여자 <% } %></td> 
               </tr>
               <tr>
                  <td>입사 날짜</td>
                  <td><%=adminVo.getHiredate()%></td>            
               </tr>
            </thead>
         </table>      
      </div>
      </div>
      <input type="submit" value="수정하기">
      </form>
      <a href="<%=request.getContextPath()%>/admin/admin.do"><input type="button" value="뒤로가기"></a>
      
	  <a href="<%=request.getContextPath()%>/admin/deleteAdmin.do?u_no=<%=adminVo.getU_no()%>"><input type="button" id="delete" value="삭제하기"></a>
       
       <a href="<%=request.getContextPath()%>/admin/commselect.do?u_no=<%=adminVo.getU_no()%>"><input type="button" id="commselect" value="급여 확인"></a>
      

            
   </div>

   </div>
   
</div>

</div>


   

