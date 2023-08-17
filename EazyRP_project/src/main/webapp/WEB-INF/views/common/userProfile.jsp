<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">

<head>
  <meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>

  <style>
    html, body{
      width: 100%;
      height: 100%;
    }
    .bd-placeholder-img {
      font-size: 1.125rem;
      text-anchor: middle;
      -webkit-user-select: none;
      -moz-user-select: none;
      user-select: none;
    }

    @media (min-width: 768px) {
      .bd-placeholder-img-lg {
        font-size: 3.5rem;
      }
    }

    .b-example-divider {
      height: 3rem;
      background-color: rgba(0, 0, 0, .1);
      border: solid rgba(0, 0, 0, .15);
      border-width: 1px 0;
      box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .05);
    }

    .b-example-vr {
      flex-shrink: 0;
      width: 1.5rem;
      height: 100vh;
    }

    .bi {
      vertical-align: -.125em;
      fill: currentColor;
    }

    .p-2 {
      color: whitesmoke;
    }

    .nav d-flex {
      justify-content: space-evenly;
    } */

    .container {
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>
</head>

  
  <!-- main -->
  <div class="main">

     <!-- 11111 -->
     <div class="h-60 col-lg-8 container text-center;" style="align-items: center; display: flex; justify-content: center;">

      <!-- .card -->
      <div class="card card-fluid" style="width: 80%;">
        <div class="card-body" style="text-align: center;">
          <!-- form -->
          <div class="d-flex align-items-center pb-3 mb-3 text-center link-dark text-decoration-none border-bottom">
            <span class="fs-5 fw-semibold "> 개인정보 조회 </span>
            <form id="searchForm2" method="post"
							action="/member/mypage.do?mcode=${mcode }"
							style="display: contents;"></form>
          </div>
          <!-- .form-group -->
          <form action="/member/userProfile.do" method="post" style="text-align: -webkit-center; width: 100%;align-items: center; display: inline-block;">
            <div class="mb-8 row"  style="align-items: center; justify-content: center;">
              <label for="staticid" class="col-sm-2 col-form-label">아이디</label>
              <div class="col-sm-8">
                <input type="id" readonly class="form-control-plaintext" id="staticid" name="id" value="${member.id }" readonly>
              </div>
            </div>

            <div class="mb-8 row" style="align-items: center; justify-content: center;" >
              <label for="staticname" class="col-sm-2 col-form-label">이 름</label>
              <div class="col-sm-8">
                <input type="name" readonly class="form-control-plaintext" id="staticname" name="name"value="${member.name }" readonly>
              </div>
            </div>

            <div class="mb-8 row" style="align-items: center; justify-content: center;" >
              <label for="staticphone" class="col-sm-2 col-form-label">연락처</label>
              <div class="col-sm-8">
                <input type="phone" readonly class="form-control-plaintext" id="staticphone" name="tel" value="${member.tel }" readonly>
              </div>
            </div>

            <div class="mb-8 row" style="align-items: center; justify-content: center;" > 
              <label for="staticadd" class="col-sm-2 col-form-label">집주소</label>
              <div class="col-sm-8">
                <input type="add" readonly class="form-control-plaintext" id="addr" name="addr"value="${member.addr }" readonly>
              </div>
            </div>
            <div class="mb-8 row" style="align-items: center; justify-content: center;">
              <label for="staticEmail" class="col-sm-2 col-form-label">이메일</label>
              <div class="col-sm-8">
                <input type="emailstaticadd" readonly class="form-control-plaintext" id="Email" name="email" value="${member.email }" readonly>
              </div>
            </div><!-- /.form-group -->
          </form><!-- /form -->
 
            <div class="btn" style="border:0">
              <button type="submit" id="repwdBtn" class="btn btn-primary " >비밀번호 변경</button>
              <button type="submit" id="modifyBtn" class="btn btn-primary" >정보변경</button>
              <button type="submit" id="deleteBtn" class="btn btn-primary" >회원탈퇴</button>
            </div>
        </div><!-- /.card-body -->
      </div><!-- /.card -->
    </div>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
  </html>
  
  <script>
$(function(){

	$('#repwdBtn').on('click', function(){
		location.href = "/member/repwdForm.do?mcode=${mcode }"; 
	});
	
	$('#modifyBtn').on('click', function(){
		location.href = "/member/modProfileForm.do?mcode=${mcode }"; 
	});
	
	$('#deleteBtn').on('click', function(){
		if(confirm("정말 탈퇴하시겠습니까")){
		location.href="/member/delete.do"	
		
		}
	});	
	
})
</script>
  
<%@ include file="../include/footer_js.jsp"%>