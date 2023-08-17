<%@page import="kr.or.dw.product.vo.ProductVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%

	List<ProductVO> bugerList = (List<ProductVO>) request.getAttribute("bugerList");
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
                        <div class="card-title text-center" style="float: none">버거 메뉴</div>
                        <div style="text-align: right;"><a href ="<%=request.getContextPath()%>/admin/InsertFormMenu.do"><button class="btn btn-primary btn-sm modify-btn" >메뉴 추가</button></a></div>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-striped projects">
                            <thead>
                                <tr>
                                    <th style="text-align: center;width: 65px">제품 번호</th>
                                    <th style="text-align: center;width: 65px">제품 이름</th>
                                    <th style="text-align: center;width: 80px">제품 종류</th>
                                    <th style="text-align: center;width: 10%">제품 가격</th>
                                    <th style="text-align: center;width: 75px">제품 이미지 파일명</th>
                                    <th style="text-align: center;width: 65px">제품 설명</th>
                                    <th style="text-align: center;width: 65px"></th>
                                    <th style="text-align: center;width: 65px"></th>
                                    <th style="text-align: center;width: 85px">판매여부</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                for (ProductVO buger : bugerList) {                                        
                                %>
                                <form action="<%=request.getContextPath()%>/admin/UpdateMenu.do" method = "POST">
                                <tr>
                                    <td style="text-align: center;"><%=buger.getNum()%></td>
                                    <input type ="hidden" value= "<%=buger.getNum()%>" name ="num">
                                    <td style="text-align: center;"><%=buger.getName() %></td>
                                    <td style="text-align: center;">
                                    	<%if(buger.getCla() == 1){ %>
                                    		비프패티버거
                                    	<%} else if(buger.getCla() == 2){%>
                                    		튀김패티버거
                                    	<%} else if(buger.getCla() == 3){%>
                                    		사이드 및 음료
                                    	<%} %>
                                    </td>
                                    <td style="text-align: center; width: 100px;"><input style="width: 100px;" type="text" value="<%=buger.getCost()%>" name="cost"></td>
                                    <td style="text-align: center; width: 100px;"><input style="width: 100px;" type="text" value="<%=buger.getImg() %>" name="img"></td>
                                    <td style="text-align: center;"><input type="text" value="<%=buger.getP_description() %>" name="p_description"></td>
                                    <td style="text-align: center;">
                                        <input type="submit" class="btn btn-primary btn-sm modify-btn" data-id="<%=buger.getNum()%>" value="수정">
                                    </td>
                                    <td style="text-align: center;">
                                        <button type="button" onclick="javascript:testtt('<%=buger.getNum() %>')" class="action btn btn-primary btn-sm modify-btn">메뉴 삭제</button>
                                    </td>
                                    <td style="text-align: center;"><input type="checkbox" name="gb_view" value="Y" <%if(buger.getGb_view().equals("Y")){ %> checked <%} %>></td>
                                </form>
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
    // Add an event listener for the modify button
    const modifyButtons = document.querySelectorAll('.modify-btn');
    modifyButtons.forEach(button => {
        button.addEventListener('click', (event) => {
            const productId = event.target.dataset.id;
            // Perform the necessary action for modifying the product with the given ID
            // You can redirect the user to another page or trigger a modal, etc.
            console.log(`Modify button clicked for product ID: ${productId}`);
        });
    });
    $(function(){
//     	$('.action').on('click',function(){
<%--     		location.href="<%=request.getContextPath()%>"; --%>
//     	});
    });
    
    function testtt(arg){
    	location.href="<%=request.getContextPath()%>/admin/menuDelete.do?num=" + arg;
    }
</script>

