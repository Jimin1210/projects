<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../user/header.jsp" %>
<% 
		int notice = (int)request.getAttribute("notice");
	System.out.println(notice);
	%>
        <style>
            .table {padding: 15px;}
            .btn-write {padding: 10px 15px!important;border: 1px solid #333!important;}
            .ck-editor__editable { height: 400px; }
        </style>

        <form action="<%= request.getContextPath()%>/board/boardInsert.do?u_no=<%=vo.getU_no()%>&notice=<%=notice%>" method="post" style="display: flex; align-items: center">
	        <div style="width: 25%"></div>
		        <div style="width: 50%">
			        <div class="mb-3">
			            <input type="text" name="title" class="form-control" id="subject" required placeholder="제목을 입력해주세요.">
			        </div>
			        <div class="mb-3">
			           <textarea rows="10" style="width: 100%; resize: none;" name="content" placeholder="작성할 내용을 입력해주세요." id="name"></textarea>
			        </div>
	        <input type="submit" class="btn btn-write col-sm-5" style="width:49%; display: inline;" value="글작성">
	            
	     <a href="<%= request.getContextPath()%>/board/board1.do?notice=<%=notice%>&u_no=<%=vo.getU_no()%>">
	     	<input type="button" class="btn btn-write col-sm-5" style="width:49%; display: inline;" value="뒤로가기">
	     </a>
        </div>
	   </form>
        </div>
        <div style="width: 25%"></div>

        <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
        <script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
        <script>
	        ClassicEditor.create( document.querySelector( '#content' ), {
	            removePlugins: [ 'Heading', 'MediaEmbed' ],
	            language: "ko"
	        });
	        
	        
        </script>
    </div>
</div>