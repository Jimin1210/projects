<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                        <h3 class="card-title">입사 정보</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <form method="post" action="<%=request.getContextPath()%>/admin/contentInsert.do">
                        <fieldset>
                            <legend style="text-align: center"></legend>
                            <div class="card-body">
<!--                                 <div class="form-group"> -->
<!--                                     <label for="u_no">회원 번호</label> -->
<!--                                     <input type="text" class="form-control" name="u_no" id="u_no" placeholder="회원 번호"> -->
<!--                                 </div> -->
                                <div class="form-group">
                                    <label for="id">직원 아이디</label>
                                    <input type="text" class="form-control" name="id" id="id">
                                </div>
                                
                                <div class="form-group">
                                    <label for="pwd">비밀번호</label>
                                    <input type="password" class="form-control" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요" >
                                </div>
                                
                                <div class="form-group">
                                    <label for="birth">생년 월 일</label>
                                    <input type="date" class="form-control" name="birth" id="birth">
                                </div>
                                <div class="form-group">
                                    <label for="name">직원 이름</label>
                                    <input type="text" class="form-control" name="name" id="name">
                                </div>
                                
                                <div class="form-group">
                                    <label for="addr">주소</label>
                                    <input type="text" class="form-control" name="addr" id="addr">
                                </div>
                                
                                <div class="form-group">                                
                                	<label for="pos">직급</label><br>
                                <select name="pos"><br><br>            
                                <%UserVO uvo = (UserVO)session.getAttribute("userVO");
                                			if(uvo.getU_no() == 0){%>  	
                                	<option selected value= "점장" name="점장">점장</option>
                                	<option selected value="매니저" name="매니저">매니저</option>
                                	<%} %>
                                	<option selected value="알바" name="알바">알바</option> 
                                </select>
                                </div>
<!--                                     <label for="pos">직급</label> -->
<!--                                     <input type="text" class="form-control" name="pos" id="pos"> -->
                                <div class="form-group"><br>
                                    <label for="loc">매장 정보</label>
                                    <input type="text" class="form-control" name="loc" id="loc">
                                </div>
                                
                                <div class="form-group">
                                    <label for="hiredate">입사 날짜</label>
                                    <input type="date" class="form-control" name="hiredate" id="hiredate">
                                </div>
                                <div class="form-group">
                                    <label for="sal">연봉 또는 시급</label>
                                    <input type="text" class="form-control" name="sal" id="sal">
                                </div>
                                <div class="form-group">
                                    <label for="tel">전화번호</label>
                                    <input type="text" class="form-control" name="tel" id="tel" placeholder="XXX-XXXX-XXXX">
                                </div>
                                <div class="form-group">
                                    <label for="email">이메일</label>
                                    <input type="email" class="form-control" name="email" id="email">
                                </div>
                                <div class="form-group">
                                    <label for="gender">성별</label><br>
                                    <input type="radio"  name="gender" id="gender" value="1"> 남자
                                    <input type="radio"  name="gender" id="gender" value="2"> 여자
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
