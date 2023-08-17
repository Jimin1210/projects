<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

.container-fluid {
    padding-top: 20px;
}

.card {
    border: none;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.card-header {
    background-color: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
    padding: 10px 20px;
    position: relative;
}

.card-title {
    font-family: 'SUITE-Regular';
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 0;
    text-align: center;
}

.card-tools {
    position: absolute;
    top: 50%;
    right: 20px;
    transform: translateY(-50%);
}

.card-tools button {
    background-color: transparent;
    border: none;
    padding: 0;
}

.card-tools button:focus {
    outline: none;
}

.form-group label {
    font-family: 'SUITE-Regular';
    font-weight: bold;
}

.form-control {
    border-radius: 0;
    border: 1px solid #ced4da;
}

.form-group input[type="text"] {
    height: 40px;
}

.form-group input[type="submit"] {
    width: 100%;
}

@media (min-width: 576px) {
    .col-md-2 {
        flex: 0 0 16.66667%;
        max-width: 16.66667%;
    }
    .col-md-8 {
        flex: 0 0 66.66667%;
        max-width: 66.66667%;
    }
}

@media (min-width: 992px) {
    .col-md-2 {
        flex: 0 0 16.66667%;
        max-width: 16.66667%;
    }
    .col-md-8 {
        flex: 0 0 66.66667%;
        max-width: 66.66667%;
    }
}
</style>

<div class="content">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">메뉴 추가</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <form method="post" action="<%=request.getContextPath()%>/admin/InsertMenu.do">
                        <fieldset>
                            <legend style="text-align: center"></legend>
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="num">제품 번호</label>
                                    <input type="text" class="form-control" name="num" >
                                </div>
                                <div class="form-group">
                                    <label for="name">제품 이름</label>
                                    <input type="text" class="form-control" name="name">
                                </div>
                                <div class="form-group">                                
                                	<label for="cla">제품 구분</label><br>
                                <select name="cla"><br><br>                               	
                                	<option selected value= "1" name="cla">비프패티버거</option>
                                	<option selected value="2" name="cla">튀김패티버거</option>
                                	<option selected value="3" name="cla">사이드메뉴</option> 
                                </select>
                                </div>
                                                   
                                <div class="form-group">
                                    <label for="cost">금액</label>
                                    <input type="text" class="form-control" name="cost">
                                </div>
                                <div class="form-group">
                                    <label for="img">이미지 파일명</label>
                                    <input type="text" class="form-control" name="img" >
                                </div>
                                
                                <div class="form-group">
                                    <label for="p_description">제품 설명</label>
                                    <input type="text" class="form-control" name="p_description" id="addr">
                                </div>
                                
                                <div class="form-group">
                                    <input type="submit" class="btn btn-danger" value="계정추가">
                                </div>
                            </div>
                        </fieldset>
                    </form>
                </div>
            </div>
            <div class="col-md-2"></div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
