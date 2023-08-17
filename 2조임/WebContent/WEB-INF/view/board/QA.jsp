<%@page import="kr.or.dw.board.vo.QABoardVO"%>
<%@page import="kr.or.dw.reply.vo.ReplyVO"%>
<%@page import="kr.or.dw.board.vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<%@ include file="../user/header.jsp" %>
<style>
    @font-face {
    font-family: 'ONE-Mobile-POP';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2105_2@1.0/ONE-Mobile-POP.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
body {
  background: #eee;
}
ul, ol {
  margin: 0;
  padding: 0;
  list-style: none;
}
a {
  text-decoration: none;
}


.nav li {
    margin: 0 30px;
}

    body {
      background-color: #ffffff;
      margin: 0;
    }
    .content {
      width: 800px;
      min-height: 600px;
      margin: 0 auto;
      padding: 15px 0;
    }
    .column {
      flex: 1;
      padding: 5px;
      padding-right: 100%;
}
    
    .footer {
      background-color: #ffffff;
      color: #000000;
      text-align: center;
      bottom: 0;
      width: 815px;
      margin: 0 auto;
      font-size: 12px;
      font-family: 'ONE-Mobile-POP';
    }
    .btn {
      content: counter(name);
      background-color: #ffffff;
      border: none;
      color: rgb(0, 0, 0);
      padding: 20px 0px;
      text-align: center;
      text-decoration: none;
      display: block;
      font-size: 20px;
      cursor: pointer;
      width: 100%;
      font-family: 'ONE-Mobile-POP';
    }

    #slider {       
        width: 100%;
        height: 100%;
        margin: 0% auto;
        padding: 0%;
        overflow: hidden;
        white-space: nowrap;
        box-sizing: border-box;
    }
      #slider > li {
        width: 100%;
        height: 550px;

        position: relative;
        display: inline-block;
        overflow: hidden;
        font-size: initial;
        line-height: normal;
        transition: all 0.5s; 
        background-size: cover;
        box-sizing: border-box;
        white-space: normal;
      }
      
      .header .navbar-bg .nav .dropdown:hover ul {
  display: block;
}
.content-wrapper .side-img {
    text-align: center;
}
.card {
    box-shadow: 0 20px 27px 0 rgb(0 0 0 / 5%);
}
.avatar.sm {
    width: 2.25rem;
    height: 2.25rem;
    font-size: .818125rem;
}
.table-nowrap .table td, .table-nowrap .table th {
    white-space: nowrap;
}
.table>:not(caption)>*>* {
    padding: 0.75rem 1.25rem;
    border-bottom-width: 1px;
}
table th {
    font-weight: 600;
    background-color: #eeecfd !important;
}
.nav-link{
    font-family: 'ONE-Mobile-POP';
}
.container{
    font-family: 'ONE-Mobile-POP';
}
.reply {
    font-size: 14px;
}

</style>
<div class="container">
        <div class="row">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                  <a class="nav-link active" aria-current="page" href="#">Q&A</a>
                </li>
                
              </ul>
            <div class="col-12 mb-3 mb-lg-5">
                <div class="overflow-hidden card table-nowrap table-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5 class="mb-0">Q&A</h5>
                    </div>
                    <div>
                        <table class="table mb-0">
                            <thead class="small text-uppercase bg-body text-muted">
                                <tr>
                                    <th style="text-align: center;">내용</th>
                                    <th width="120px" style="text-align: center;">작성자</th>
                                    <th width="70px" style="text-align: center;">날짜</th>
                                </tr>
                            </thead>
                            <tbody>
                            <% 
                            	List<QABoardVO> bvo = null;
                            	int cnt = 0;
                            	int notice = (int)request.getAttribute("notice");
                            	if((List<QABoardVO>)request.getAttribute("QAboard") != null){
                            		bvo = (List<QABoardVO>)request.getAttribute("QAboard");
                            		for(QABoardVO board : bvo){
                            		cnt = cnt + 1;%>
                            		<tr>
                                    <td><%= board.getContent()%></td>
                                    <td><%= board.getNick()%></td>
                                    <td><%= board.getW_date()%></td>
                                	</tr>
                                	<tr style="background-color: #b1e0ff;">
                                	<% if(board.getContent2() != null){  %>
                                	<td style="padding-left: 35px;"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
                                        <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
                                    </svg><%= board.getContent2()%></td>
                                	<td>관리자</td>
                                	<td><%= board.getW_date2()%></td>
                                	<%} else{ 
                                	if(u_no == 0){%>
                                	<td>
                                	<button  class="repl<%=cnt%>">답글달기</button>
                                	<div class="re_form<%= cnt%>" style="display: none;">
			                        <form method="post" action="<%= request.getContextPath()%>/reply/reply.do?num=<%=board.getNum()%>&u_no=<%=vo.getU_no()%>&notice=<%=notice%>">
				                        <input class="form-control" name="content" placeholder="내용입력">
				                        <input type="submit" value="등록">
			                        </form>
			                        </td>
			                        <td></td>
			                        <td></td>
			                        <%}} %>
			                        
                                	</tr>
                                	<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
									<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
                                	<script>
                                		$(function(){
                                			$('.repl<%=cnt%>').on('click', function(){
                                				$('.re_form<%= cnt%>').toggle();
                                				$('.repl<%=cnt%>').toggle();
                                			});
                                		});
                                	</script>
                            		<% }}%>
                            		
                            </tbody>
                        </table>
                    </div>
                </div>
                <% if(u_no != 0){ %>
                <div class="text">
                    <div class="container">
                        <button id="toggleBtn">글작성</button>
                        <div class="re_form" style="display: none;">
                        <form method="post" action="<%= request.getContextPath()%>/board/boardInsert.do?u_no=<%=vo.getU_no()%>&notice=<%=notice%>">
	                        <input class="form-control" name="content" placeholder="내용입력">
	                        <input type="submit" value="등록">
                        </form>
                        <button id="cancel">취소</button>
                        <div>
                    </div>
                        </div>
                    </div>
                </span>
                </div>
                <%} %>
                </div>
            </div>
            </div>
        </div>
    </div>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script>
$(function(){
    $(".nav-tabs .nav-link").click(function(){
        $(".nav-tabs .nav-link").removeClass("active");
        $(this).addClass("active");
    });
    $('#toggleBtn').on('click',function(){
        $('.re_form').toggle();
        $('#toggleBtn').toggle();
    })
    $('#cancel').on('click', function(){
    	$('.re_form').toggle();
        $('#toggleBtn').toggle();
    })
    
})

</script>
</body>
</html>