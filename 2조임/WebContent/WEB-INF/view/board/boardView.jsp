<%@page import="kr.or.dw.reply.vo.ReplyVO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="kr.or.dw.board.vo.BoardVO"%>
<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../user/header.jsp" %>
    <style>
  @import url(//fonts.googleapis.com/earlyaccess/nanumgothic.css);

  .post-content {
 font-family: 'Nanum Gothic', sans-serif;
    margin: 15px 0;
  }
  .post-content h3 {
    color: #333;
    font-size: 1.85rem;
  }
  .post-content .qs_info_wrap {
    float: left;
    width: 100%;
    height: 55px;
    line-height: 55px;
    border-top: 1px solid #e3e3e3;
    border-bottom: 1px solid #e3e3e3;
}
  .post-content .bi {
    color: #ddd;
}
.post-content .list-inline-item span {
  color: #444;
}
.post-content .contont-wrapper {
  margin: 25px 0;
  color: #000;
  font-size: 1.05rem;
  font-weight: normal;
  min-height: 200px;
}
.post-content  .qs_title {
    float: left;
    width: 100%;
    line-height: 1.3;
    min-height: 36px;
    border-top: 1px solid #7e7e7e;
    color: #333;
    font-size: 24px;
    background-color: #f9f9f9;
    word-break: break-all;
    font-weight: bold;
    padding: 37px 27px 30px;
    margin-top: 0 !important;
    margin: 0;
}
.post-content  .qs_info p {
    float: left;
    font-size: 12px;
    color: #aaa;
    margin-right: 25px;
    line-height: 1;
    margin-top: 21px;
    font-family: "Tahoma";
}
.post-content  .contont-wrapper {
    float: left;
    width: 876px;
    margin-top: 40px;
    margin-left: 27px;
    font-size: 16px;
    color: #333;
    line-height: 26px;
    margin-bottom: 40px;
    word-break: break-all;
    display: block;
}.reply_title {
    float: left;
    width: 100%;
    height: 44px;
    line-height: 45px;
    border-top: 1px solid #e3e3e3;
    background-color: #f9f9f9;
}.reply_title h2 {
  margin:0;
  padding: 12px 0;
    float: left;
    margin-left: 27px;
    font-size: 16px;
    color: #333333;
}.reply_title h2 span {
    font-size: 16px;
    color: #f68400;
    margin-left: 5px;
}
.comment-write {
    float: left;
    margin-top: 40px;
    width: 100%;
    background-color: #e8eaee;
    border: 1px solid #dcdde1;
    margin-bottom:20px;
}
.comment-write .form-textarea {
    float: left;
    padding: 20px;
    width: calc(100% - 20px);
    height: 90px;
    margin-top: 10px;
    margin-left: 10px;
    background-color: #fff;
    resize: none;
    overflow: hidden;
    overflow-y: auto;
}.bottom_txar_btn {
    position: relative;
    float: left;
    margin-top: 11px;
    width: 100%;
    height: 42px;
    line-height: 42px;
}
.txar_right_btn {
    float: right;
    margin-right: 9px;
}
.txar_right_btn span {
    float: left;
    margin-right: 10px;
    font-size: 12px;
    color: #666666;
}
.txar_right_btn span em {
    font-style: normal;
}
.btn01_g {
    min-width: 53px;
    font-size: 16px;
    color: #fff !important;
    text-align: center;
    background-color: #747a86;
    border-radius: 2px;
    padding: 9px 14px 9px 14px;
    border: 1px solid #747a86;
    display: inline-block;
    line-height: 1;
    float: left;
}
</style>
   <script
	src="<%=request.getContextPath()%>/assets/plugins/jquery/jquery.js"></script>

<%
	BoardVO boardVo = (BoardVO)request.getAttribute("boardVo");
	int notice = (int)request.getAttribute("notice");
 	int no = (int)request.getAttribute("u_no");
%>

<script>
$(document).ready(function() {
    $('.form-textarea').on('keyup', function() {
        $('.glist_number em').html($(this).val().length);
 
        if($(this).val().length > 200) {
            $(this).val($(this).val().substring(0, 200));
            $('.glist_number em').html(200);
        }
    });
});
		
		
</script>

    <div class="container" style="padding: 0;">
        <div class="row">
        <div class="col-md-2">
        </div>
          <div class="col-md-8">
            <article>
                <div class="post-content">
                        <p class="qs_title" style="margin-top:30px"><span><%= boardVo.getTitle() %></span></p>
                        <div class="qs_info_wrap">
                          <div class="qs_info">
                              <p><i class="bi bi-person-circle"></i> <span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;작성자 : <%= boardVo.getNick()%></span></p>
                              <p><i class="bi bi-calendar"></i> <span>작성일 : <%= boardVo.getW_date() %></span></p>
                              <p><i class="bi bi-chat-square"></i> <span>조회수 : <%= boardVo.getCount() %></span></p>
                          </div>
                      </div>
                        <div class="contont-wrapper">
                        <p><%= boardVo.getContent() %></p>
                        </div>
                    <div class="comment">
                      <div>
                      <div>
						<% if ( vo != null && boardVo.getU_no() == no || no == 0) { %>
							<button id="delete" style="border-radius: 10px; width: 80px; height: 40px;">
								글삭제
							</button>
							<a href="<%= request.getContextPath()%>/board/boardModifyForm.do?num=<%=boardVo.getNum()%>&notice=<%=notice%>"><button  style="border-radius: 10px; width: 80px; height: 40px;">
								수정
							</button></a>
						<% } %>
							<a href="<%= request.getContextPath()%>/board/board1.do?notice=<%=notice%>&u_no=<%=no%>"><button style="border-radius: 10px; width: 80px; height: 40px;">
								목록
							</button></a>
						</div>
                      </div>
                      <br>
                     <%
                      	List<ReplyVO> rvo = null;
                     	if((List<ReplyVO>)request.getAttribute("replyList") != null){
                    		rvo = (List<ReplyVO>)request.getAttribute("replyList");
  	                      	for(ReplyVO reply : rvo){
// 							ReplyVO reply = null;
//   	                      	for(int i = 0; i < rvo.size(); i++){
// 							rvo.get(i);         	
                      %>
                      <div style="background-color: white;"> 
                      <hr style="margin: 0px">
                      <p style="font-size: 70%; color: gray; padding-left: 20px; margin: 5px 0px 5px 0px;">작성자 : <%= reply.getNick()%></p><p style="font-size: 70%; color: gray; padding-left: 20px">작성일 : <%= reply.getW_date()%></p> 
                      <p style=" padding-left: 20px"><%= reply.getContent()%></p> 
                      <hr style="margin: 0px">
                       </div> 
                     <%}}%> 
                      <div class="comment-write" style="margin-top: 10px;">
                  <form method="post" action="<%= request.getContextPath()%>/reply/reply.do?num=<%=boardVo.getNum()%>&u_no=<%=no%>&notice=<%=notice%>">                        
                    <textarea class="form-textarea" rows="5" placeholder="내용" name="content"></textarea>
                    <div class="bottom_txar_btn">
                      <div class="txar_right_btn">
                              <span class="glist_number">(<em>0</em>/200)</span>
                              <input type="submit" class="btn01_g" value="댓글등록">
                           </div>
                   </div>
                  </form>
                  </div>
                      </div>
                </div>
            </article>
        </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>