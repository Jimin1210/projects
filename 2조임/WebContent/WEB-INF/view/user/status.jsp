<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="header.jsp" %>
<style>
#content {
    position: relative;
    padding: 30px;
}
.c_header {
    padding-bottom: 43px;
}

.c_header+.private_set {
    margin-top: -21px
}

.c_header h2 {
    font-size: 20px;
    line-height: 22px;
    position: relative;
    color: #333
}

.c_header .contxt {
    line-height: 19px;
    padding-top: 10px;
    color: #666
}

.c_header .contxt strong {
    font-size: 14px;
    color: #08a600
}

.c_header .contxt a {
    text-decoration: underline;
    color: #336fc9
}
.tbl_model {
    position: relative;
    width: 100%;
    table-layout: fixed;
    border-spacing: 0;
    border-collapse: collapse;
    word-wrap: break-word;
    word-break: keep-all;
    border: 0;
    border-bottom: 1px solid #e5e5e5
}

.tbl_model td,.tbl_model th {
    line-height: 14px;
    text-align: left;
    vertical-align: top;
    letter-spacing: -1px;
    border: 0;
    border-top: 1px solid #e5e5e5
}

.tbl_model th {
    color: #333;
    border-right: 1px solid #e5e5e5;
    background: #f9f9f9
}

.tbl_model td {
    color: #565656
}

.tbl_model .thcell {
    padding: 32px 31px 32px
}

.tbl_model .tdcell {
    padding: 32px 0 32px 30px
}

.tbl_model select {
    font-size: 12px;
    float: left;
    height: 18px;
    margin-top: 5px;
    vertical-align: top;
    letter-spacing: 0;
    color: #333;
    border: 1px solid #ccc;
    background: #fff
}

:root .tbl_model select {
    line-height: 23px;
    height: 29px;
    margin-top: 0;
    padding: 5px
}

.tbl_model .contxt_tit {
    font-size: 14px;
    line-height: 16px;
    color: #333
}

.tbl_model .contxt_tit2,.tbl_model .contxt_tit3 {
    font-weight: 700;
    padding-top: 27px;
    color: #333
}

.tbl_model .contxt_tit3 {
    padding-top: 0
}

.tbl_model .tdcell>.contxt_tit2:first-child {
    padding-top: 0
}

.tbl_model .contxt_desc,.tbl_model .contxt_desc3 {
    line-height: 19px;
    padding-top: 10px;
    color: #8e8e8e
}

.tbl_model .contxt_desc em {
    color: #ff6020
}

.tbl_model .contxt_desc+.contxt_webctrl {
    padding: 11px 0 5px
}

.tbl_model .contxt_desc2 {
    padding-top: 29px;
    color: #666
}

.tbl_model .contxt_desc2 .link {
    text-decoration: underline;
    color: #336fc9
}

.tbl_model .contxt_desc3 {
    padding-top: 1px
}

.tbl_model .contxt_webctrl {
    font-size: 0;
    line-height: 0;
    position: relative;
    overflow: hidden;
    margin-left: -8px;
    padding: 13px 0 5px;
    color: #666
}

.tbl_model .contxt_webctrl.nickname {
    padding: 0
}

.tbl_model .contxt_webctrl .btn_model,.tbl_model .contxt_webctrl .country_drop,.tbl_model .contxt_webctrl input,.tbl_model .contxt_webctrl_box .btn_model {
    margin-left: 8px
}

:root .tbl_model .contxt_webctrl .country_drop {
    width: 110px
}

.tbl_model .contxt_webctrl .country_code_w {
    display: inline-block;
    overflow: hidden;
    min-width: 176px;
    margin-left: 8px;
    vertical-align: top;
    border: 1px solid #ccc
}

.tbl_model .contxt_webctrl .country_code_w input {
    float: left;
    width: 147px;
    margin-left: 4px;
    padding-left: 0;
    letter-spacing: 0;
    border: 0
}

.tbl_model .contxt_webctrl .country_code {
    font-size: 12px;
    line-height: 27px;
    display: inline-block;
    float: left;
    padding-left: 7px;
    letter-spacing: 0;
    color: #333
}

.tbl_model .contxt_webctrl2 {
    padding-top: 11px;
    color: #666
}

.tbl_model .contxt_webctrl2 .link_more {
    display: inline-block
}
.image modal-body{
    display: flex;
    flex-direction: row;
    
}
.image {
    margin-bottom: 40px;
    display: flex;
}
.pic {
	position: absolute;
	z-index: -2;
	align-self: center;
	justify-self: center;
	text-align: center; 
	background-color: #b9ddff;
	opacity: 0;
}
.picture:hover{
	opacity: 0.3;
}
    </style>
<body style="display: grid;">
<div class="pic" style="padding: 20px; border: solid 3px blue; border-radius: 20px;">
	<h1>변경 할 프로필 사진을 선택해주세요.</h1>
	<hr>
	<img src="/img/profile/1.png" class="picture" name="1" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/2.png" class="picture" name="2" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/3.png" class="picture" name="3" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/4.png" class="picture" name="4" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;"><br>
	<img src="/img/profile/5.png" class="picture" name="5" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/6.png" class="picture" name="6" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/7.png" class="picture" name="7" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/8.png" class="picture" name="8" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;"><br>
	<img src="/img/profile/9.png" class="picture" name="9" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/10.png" class="picture" name="10" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/11.png" class="picture" name="11" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/12.png" class="picture" name="12" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;"><br>
	<img src="/img/profile/13.png" class="picture" name="13" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/14.png" class="picture" name="14" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/15.png" class="picture" name="15" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
	<img src="/img/profile/16.png" class="picture" name="16" style="border: 3px solid; border-radius: 80%; width: 100px; height: 100px; margin: 5px;">
</div>
<div id="opacity">
<div class="content-wrapper">
    <div class="container" style="display: flex; align-items: center; justify-content: center;">
<div id="content" style="background-color: #fff; width : 60%" >
    <div class="c_header">
    <button id="delete">회원탈퇴</button>
    </div>
    <form id="profileForm" method="post" action="<%=request.getContextPath()%>/user/profileUpdate.do?u_no=<%=u_no%>">
        <fieldset>
            <legend style="text-align: center">프로필 수정하기</legend>
            <table border="0" class="tbl_model">
                <caption></caption>
                <colgroup>
                    <col style="width:25%"><col>
                </colgroup>
                <tbody>
                <tr>
                    <th scope="row">
                        <div class="thcell">프로필 사진</div>
                    </th>
                    <td style="display: flex; align-items: center; justify-content: center;  padding-top: 15px;">
                            <div class="profile_photo" style="display: flex; align-items: center; justify-content: center;">
                            	<input type="text" name="picture" hidden value="<%= vo.getPicture()%>">
                                <img id="profile" src="/img/profile/<%= vo.getPicture()%>.png" style="border: 3px; border-radius: 80%; width: 100px; height: 100px;">
                                <span class="mask"></span>
                            </div>
                    </td>
                    <td style="width: 30%;">
                     <div class="btn_area_btm">
                     <div class="tdcell">
                         <button type="button" class="btn btn-info col-sm-3"  data-bs-toggle="modal" data-bs-target="#imageModal" style="width: 80%" id="pict">사진 선택</button>
                      </div>
                      </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row">
                        <div class="thcell" id="userId" name="id" class="col-sm-3 col-form-label">닉네임</div>
                        <div class="col-sm-6">
                        </div>
                    </th>
                    <td>
                    	<div class="tdcell">
                            <p class="contxt_webctrl nickname">
                                <input type="text" name="nick" class="form-control" style="width:254px" value="<%=vo.getNick()%>">
                            </p>
                           </div>
                    </td>
                    
                    <td>
	                    <div class="tdcell">
	                    	<button type="button" class="btn btn-info col-sm-3"  id="nickCheckBtn" style="width: 80%">중복확인</button>
	                    </div>
                    </td>
                    
                </tr>
                
                </tbody>
            </table>
            
            <div class="btn_wrap">
                <button type="submit" class="btn btn-dark" input type="submit" class="btn btn-ok" id="go" value="가입">정보수정</button>
                <a href="/main.do" class="btn btn-light" input type="button" class="btn btn-ok" value="취소">뒤로가기</a>
            </div>
        </fieldset>
    </form>
    </div>
    </body>
        <script>
        $(function(){
        	$('#pict').on('click',function(){
        		$('.pic').css('z-index', 1);
        		$('.pic').css('opacity', 1);
        		$('#opacity').css('opacity', 0.5);
        	})
        	$('.picture').on('click', function(){
        		$('.pic').css('z-index', -1);
        		$('.pic').css('opacity', 0);
        		$('#opacity').css('opacity', 1);
        		$('#profile').replaceWith('<img id="profile" src="/img/profile/'+$(this).attr("name")+'.png" style="border: 3px; border-radius: 80%; width: 100px; height: 100px;">');
        		$('input[name=picture]').replaceWith('<input type="text" name="picture" hidden value='+$(this).attr("name")+'>')
        	})
        	
        	$('#go').on('click', function(){
        		alert("정보 수정이 완료되었습니다!");
        	})
        	
        	$('#delete').on('click', function(){
        		if(confirm("정말로 계정을 삭제하시겠습니까?")){
        			location.href="<%=request.getContextPath()%>/user/userDelete.do?u_no=<%= vo.getU_no()%>"
        		}
        	})
        	
        	let nickCheck = true;
    		
    		// 닉네임 정규식 체크
    		let nick = $('input[name=nick]');
    		nick.on('keyup', function(){
    			nickVal = nick.val().trim();
    			
    			regNick = /^[가-힣a-zA-Z0-9]{3,13}$/;
    			if( !(regNick.test(nickVal)) ){
    				nick.attr('class', 'form-control is-invalid');
    				nickCheck = false;
    			}else{
    				nick.attr('class', 'form-control is-valid');
    				nickCheck = true;
    			};
    		});
    		
    		// 닉네임 중복체크
    		$('#nickCheckBtn').on('click', function(){
    			if(nickCheck){
    				$.ajax({
    					url : '<%= request.getContextPath()%>/user/nickCheck.do',
    					method : 'post',
    					data : {'nick' : nickVal},
    					dataType : 'json',
    					success : function(res){
    						if(res == '사용가능한 닉네임입니다.'){
    							n_check = true;
    						}else{
    							n_check = false;
    						}
    						alert(res)
    					},
    					error : function(req){
    						alert('상태 : ' + req.status);
    					}
    				});
    			}else{
    				alert('닉네임을 확인해주세요.');
    			};
    		});
        	
        	
        	
        });
        function idCheck(){

var id = document.getElementById("userId").value;

if (!id) {
    alert("닉네임를 입력하지 않았습니다.");
    return false;
} 
else if((id < "0" || id > "9") && (id < "A" || id > "Z") && (id < "a" || id > "z")){ 
    alert("한글 및 특수문자는 아이디로 사용하실 수 없습니다.");
    return false;
}
else
{
    var param="id="+id
    httpRequest = getXMLHttpRequest();
    httpRequest.onreadystatechange = callback;
    httpRequest.open("POST", "MemberIdCheckAction.do", true);   
    httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 
    httpRequest.send(param);
}
}

function callback(){
if(httpRequest.readyState == 4){
    // 결과값을 가져온다.
    var resultText = httpRequest.responseText;
    if(resultText == 0){
        alert("사용할수없는 아이디입니다.");
        document.getElementById("cancelBtn").style.visibility='visible';
        document.getElementById("useBtn").style.visibility='hidden';
        document.getElementById("msg").innerHTML ="";
    } 
    else if(resultText == 1){ 
        document.getElementById("cancelBtn").style.visibility='hidden';
        document.getElementById("useBtn").style.visibility='visible';
        document.getElementById("msg").innerHTML = "사용 가능한 아이디입니다.";
    }
}
}

       function sendCheckValue(){
         // 중복체크 결과인 idCheck 값을 전달한다.
         opener.document.userInfo.idDuplication.value ="idCheck";
         // 회원가입 화면의 ID입력란에 값을 전달
         opener.document.userInfo.id.value = document.getElementById("userId").value;
         
         if (opener != null) {
               opener.chkForm = null;
               self.close();
         }   
      }   
        function joinbtn(){
            
           var f = document.forms[0];

           var password = f.password.value;
           var password_re = f.password_re.value;

            if (password == '') {
                event.preventDefault();
                alert('비밀번호를 입력하세요.');
                return;
            }
            if (password_re == '') {
                event.preventDefault();
                alert('비밀번호 확인를 입력하세요.');
                return;
            }
            if (password != password_re) {
                event.preventDefault();
                alert('비밀번호가 일치 하지 않습니다.');
                return;
            }
        }
    </script>