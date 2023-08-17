<%@page import="kr.or.dw.admin.vo.ScheduleVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../admin/header.jsp"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<%
    List<ScheduleVO> scheduleList = (List<ScheduleVO>) request.getAttribute("scheduleList");
    request.getAttribute("title");
    
    List<ScheduleVO> rangeList = (List<ScheduleVO>)request.getAttribute("scheduleList");
    request.getAttribute("title");
%>
<script>
	$(function(){
		
	})

</script>

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

</style>

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
.pagination {
    margin-top: 20px;
}
</style>
<div class="nav-bar">
</div>
<div class="main_content">
    <div class="container-fluid">
        <div class="row">
        <div class="col-lg-1"></div>
            <div class="col-lg-10">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title text-center" style="float: none">스케줄</div>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-striped projects">
                            <thead>
                                <tr>
                                   <th style="width: 65px">이름</th>
                                   <th style="width: 65px">직급</th>
                                    <th style="width: 65px">일자</th>
                                    <th style="width: 65px">출근 시간</th>
                                    <th style="width: 65px">퇴근 시간</th>
                                    <th style="width: 65px">총 근무 시간</th>						
                                </tr>
                            </thead>
                            <form action="<%=request.getContextPath() %>/admin/ScheduleSelect.do"  method="POST">
 								 <label for="start_date">시작 날짜:</label>
  									<input type="date" id="start_date" name="start_date">
									  <label for="end_date">종료 날짜:</label>
									  <input type="date" id="end_date" name="end_date">
									  <input type="submit" value="조회">
                            <tbody>
                                <%  
                                    for (ScheduleVO sche : scheduleList) {
                                        
                                %>
                                <tr>
                                    <td><%=sche.getName()%></td>
                                    <td><%=sche.getPos()%></td>
                                    <td><%=sche.getW_date() %></td>
                                    <td><%=sche.getIntime() %></td>
                                    <td><%=sche.getOuttime() %></td>
                                    <td><%=sche.getTotal() %></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                            
                        </table>
                    </div>
                </div>
		</form>
               
            </div>
        </div>
    </div>
</div>
