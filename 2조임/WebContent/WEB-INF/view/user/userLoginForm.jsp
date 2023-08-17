<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>


<style>
        @font-face { font-family: 'font'; src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_nine_@1.1/BBTreeGB.woff') format('woff'); font-weight: normal; font-style: normal; }
        h1 {
            font-family: 'font', sans-serif;
            font-size: 25px;
        }
        html {
            text-align: center;
        }
        input {
            width: 25%;
            height: 50px;
            border: 2px solid black;
            padding-left: 10px;
        }
        #id_ {
            font-size: 20px;
        }
        #pass_ {
            font-size: 20px;
        }
        #submit, #login, #signin {
            width: 200px;
            height: 75px;
            background-color: #0d6efd;
            color: white;
            font-size: 30px;
            font-family: 'font', sans-serif;
            transition-duration: 0.5s;
            cursor: pointer;
        }
        #login, #signin {
        	display: inline-block;
        	width: 30%;
        }
        #submit:hover {
            background-color:lightgreen;
        }
        .a{
        	display: inline-block;
        	width: 40%;
        	align-items: center;
        	justify-content: center;
        }
    </style>
</head>
<body>
<br><br>
    <h1 style="font-size: 4em;">로그인</h1>
	<br><br><br>
    <h1>아이디</h1>
    <form form action="<%= request.getContextPath() %>/user/userLogin.do" method="post" style="display: inline;">
    <input type="text" name="id" required placeholder="아이디를 입력해주세요.">
    <br>
    <br>
    <h1>패스워드</h1>
    <input type="password" name="pwd" required placeholder="비밀번호를 입력해주세요.">
    <br>
    <br>
    <br><br>
    <div class="a">
	    <input type="submit" value="로그인" class="btn btn-primary" id="login"></a>
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</form>
	    <a href="<%= request.getContextPath() %>/user/joinForm.do" id="signin" button class="btn btn-primary">회원가입</button></a>
	</div>
	    
    <!--JAVASCRIPT START-->
    <script> //JS
       
   		$('.signup').on('click', function(){
   			location.href="<%= request.getContextPath() %>/user/userLogin.do";
   		})
    	
    </script>
</body>
</html>