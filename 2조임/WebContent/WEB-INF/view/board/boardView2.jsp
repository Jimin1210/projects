<%@page import="kr.or.dw.reply.vo.ReplyVO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="kr.or.dw.board.vo.BoardVO"%>
<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <script
	src="<%=request.getContextPath()%>/assets/plugins/jquery/jquery.js"></script>

<%
	BoardVO boardVo = (BoardVO)request.getAttribute("boardVo");
	UserVO vo = (UserVO)session.getAttribute("userVO");
	int u_no = (int)request.getAttribute("u_no");
	int notice = (int)request.getAttribute("notice");
%>

<script>
	$(function(){
		
		$('#delete').on('click', function(){
			if(confirm("정말로 삭제하시겠습니까?")){
				location.href="<%= request.getContextPath()%>/board/deleteContent.do?num=<%=boardVo.getNum()%>&notice=<%=notice%>&u_no=<%=vo.getU_no()%>";
			}
		});
		
		function replyTemplate(reply){
			
			
			if("<%=vo.getNick()%>" != reply.nick){
			
				$('#re_container').prepend(
					'<div class="row">'
				   +'	<div class="col-md-4">'
				   +'		<div class="user-block">'
				   +'				<span class="username">' 
				   +'				<a href="#">' + reply.nick + '</a>'
				   +'					<a href="#" class="float-right btn-tool">'
				   +'						<i class="fas fa-times"></i>'
				   +'					</a>'
				   +'				</span>'
				   +'			<span class="description">' + reply.w_date + '</span>'
				   +'		</div>'
				   +'	</div>'
				   +'	<div class="col-md-8">' + reply.content + '</div>'
				   +'</div><hr style="margin: 0">'
				);
				
			};
		};
		
		function replyUpdateTemplate(target, update_re_no, update_re_content){
			
			$(target).after(
				 '<form id="re_update_form">'
				+	'<div class="form-group d-flex">'
				+		'<input type="hidden" name="update_re_no" value="' + update_re_no + '">'
				+		'<input type="text" name="update_re_content" value="' + update_re_content + '">'
				+		'<a class="btn btn-default btn-sm" href="#">취소</a>'
				+		'<input type="submit" hidden>'
				+	'</div>'
				+'</form>'
			)
		}
		
		// 댓글 등록
		$('#re_form').on('submit', function(e){
			

			e.preventDefault();
			console.log("1");
			let content = $('#re_form').find('input').val();
			let num = "<%=boardVo.getNum()%>";
			let u_no = "<%=vo.getU_no()%>"
			
			$.ajax({
				url : "<%=request.getContextPath()%>/reply/reply.do",
				dataType : "json",
				method : "post",
				data : {
					cmd : "insert",
					num : num,
					u_no : u_no,
					content : content
				},
				success : function(res){
					 replyTemplate(res.reply); 
				},
				error : function(){
					
				}
			});
		});
	});	
		
		
</script>

<div class="content">
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="card card-primary card-outline">
					<div class="card-header">
						<h3><%= boardVo.getTitle() %></h3>
					</div>

					<div class="card-body p-0">
						<div class="mailbox-read-info">
							<div class="image">
								<%= boardVo.getNick() %>
							</div>
							<h6>
								<span class="mailbox-read-time float-right"><%= boardVo.getW_date() %></span>
							</h6>
						</div>

						<div class="mailbox-read-message">
							<p><%= boardVo.getContent() %></p>
						</div>
							
					</div>

					<div class="card-footer">
						<div class="float-right">
						<% if ( vo != null && boardVo.getU_no() == u_no || u_no == 0) { %>
							<button id="delete" class="btn btn-default btn-sm">
								<i class="far fa-trash-alt"></i> 삭제
							</button>
							<button href="<%= request.getContextPath()%>/board/boardModifyForm.do?num=<%=boardVo.getNum()%>&notice=<%=notice%>">
								<i class="fas fa-pen"></i> 수정
							</button>
						<% } %>
							<button href="<%= request.getContextPath()%>/board/board1.do?notice=<%=notice%>">
								<i class="fas fa-reply"></i> 목록
							</button>
						</div>
						<hr>
						<p>
							</span>
						</p>
						<form id="re_form">
							<input class="form-control form-control-sm" type="text" name="content" placeholder="댓글남기기">
							<button type="submit">댓글작성</button>
						</form>
					</div>
				</div>
				<div>
				<% 	
				List<ReplyVO> replyList = (List<ReplyVO>)request.getAttribute("replyList");
				if(replyList != null){
				for(ReplyVO rvo : replyList) {
					String hidden = "hidden";
						if(vo != null && vo.getNick().equals(rvo.getNick())) {
							hidden = "";
						};
				%>
					<p><%= rvo.getCom_num()%></p>
					<p><%= rvo.getContent()%></p>
					<p><%= rvo.getGb_del()%></p>
					<p><%= rvo.getNick()%></p>
					<p><%= rvo.getNum()%></p>
					<p><%= rvo.getU_no()%></p>
					<p><%= rvo.getW_date()%></p>
				<% }} %>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
</div>

