<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../user/header.jsp" %>
<% 
		int num = (int)request.getAttribute("num");
		int notice = (int)request.getAttribute("notice");
	%>
        <style>
            .table {padding: 15px;}
            .btn-write {padding: 10px 15px!important;border: 1px solid #333!important;}
            .ck-editor__editable { height: 400px; }
        </style>

        <form id="submitForm" action="<%= request.getContextPath()%>/board/boardModify.do?num=<%=num%>&notice=<%= notice%>&u_no=<%= vo.getU_no()%>" method="post" style="display: flex; align-items: center">
	        <div style="width: 25%"></div>
		        <div style="width: 50%">
			        <div class="mb-3">
			            <input type="text" name="title" class="form-control" id="subject" required placeholder="수정할 제목을 입력해주세요.">
			            <br>
<!-- 			            <input class="content" type="text" name="content" style="width: 100%;" hidden> -->
			            <textarea rows="10" style="width: 100%; resize: none;" name="content" placeholder="수정할 내용을 입력해주세요." id="name"></textarea>
			        </div>
	        <input type="submit" class="btn btn-write col-sm-5" style="width:49%; display: inline;" value="글수정">
	   </form>
	            
	     <a href="<%= request.getContextPath()%>/board/board1.do?notice=<%=notice%>&u_no=<%=vo.getU_no()%>">
	     	<input type="button" class="btn btn-write col-sm-5" style="width:49%; display: inline;" value="뒤로가기">
	     </a>
        </div>
        </div>
        <div style="width: 25%"></div>

        <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
        <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
        <script>
	        ClassicEditor.create( document.querySelector( '#content' ), {
	            removePlugins: [ 'Heading', 'MediaEmbed' ],
	            language: "ko"
	        });
	        $(function(){
// 	        	$('#name').on('keyup', function(){
// 	        		$('.content').html($('#name').val());
// 	        	})
	        })
	      
        </script>
    </div>
</div>