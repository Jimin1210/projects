<%@page import="kr.or.dw.admin.vo.CommVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../admin/header.jsp"%>

<%
	List<CommVO> everyCommList = (List<CommVO>) request.getAttribute("everyCommList");
	request.getAttribute("title");
%>
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

<div class="nav-bar"></div>

<div class="main_content">
    <div class="container-fluid">
        <div class="row">
        <div class="col-lg-1"></div>
            <div class="col-lg-10">
                <div class="card">
                    <div class="card-header">
                        <div class="card-title text-center" style="float: none">급여 조회</div>
                    </div>
                    <div class="card-body p-0">
                        <div class="form-group" style="margin-top: 10px; margin-right: 10px; float: right;">
                            <label for="month">조회 할 월 선택</label>
                            <select class="form-control" id="month">                      					
                                <option value="">전체</option>
                                <option value="01">1월</option>
                                <option value="02">2월</option>
                                <option value="03">3월</option>
                                <option value="04">4월</option>
                                <option value="05">5월</option>
                                <option value="06">6월</option>
                                <option value="07">7월</option>
                                <option value="08">8월</option>
                                <option value="09">9월</option>
                                <option value="10">10월</option>
                                <option value="11">11월</option>
                                <option value="12">12월</option>
                            </select>
                        </div>
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
                                    for (CommVO comm : everyCommList) {
                                %>
                                <tr>
                                    <td><%= comm.getC_no() %></td>
                                    <td><%= comm.getU_no() %></td>
                                    <td><%= comm.getName() %></td>
                                    <td><%= comm.getC_date() %></td>
                                    <td><%= comm.getW_incen() %> 원</td>
                                    <td><%= comm.getN_incen() %> 원</td>
                                    <td><%= comm.getIncen() %> 원</td>
                                    <td><%= comm.getTotal() %> 원</td>
                                    <td><%= comm.getDeduction() %> 원</td>
                                    <td><%= comm.getActual() %> 원</td>
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
	// Function to filter the table based on the selected month
	


function filterTable() {
		
		var month = document.getElementById("month").value;
		var rows = document.getElementsByTagName("tbody")[0]
				.getElementsByTagName("tr");
		
		
		for (var i = 0; i < rows.length; i++) {
			var row = rows[i];
			var cell = row.getElementsByTagName("td")[3]; // Assuming the third column contains the month

			if (month == "" || cell.textContent.startsWith(month)) {
				row.style.display = "";
			} else if (month == "05" && cell.textContent.startsWith(month, 5)) {
				row.style.display = "";
			} else if (month == "06" && cell.textContent.startsWith(month, 5)) {
				row.style.display = "";
			} else if (month == "07" && cell.textContent.startsWith(month, 5)) {
				row.style.display = "";
			} else {
				row.style.display = "none";
			}

		}
	}
	// Event listener for the month select dropdown
	document.getElementById("month").addEventListener("change", filterTable);
	
	
</script>

