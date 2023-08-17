<%@page import="kr.or.dw.util.BoardJoinUtil"%>
<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.dw.board.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../user/header.jsp" %>
<style>      .header .navbar-bg .nav .dropdown:hover ul {
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
.container{
    font-family: 'ONE-Mobile-POP';
}
</style>
    <div class="container">
        <div class="row">
        	<%
        	int notice = (int)request.getAttribute("notice");
        	if(notice < 4){ %>
            <ul class="nav nav-tabs">
                <li class="nav-item">
                  <a class="nav-link n1" aria-current="page" href="<%= request.getContextPath()%>/board/board1.do?notice=1&u_no=<%= u_no%>">건의함</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link active n2" href="<%= request.getContextPath()%>/board/board1.do?notice=2&u_no=<%= u_no%>">칭찬함</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link n3" href="<%= request.getContextPath()%>/board/board1.do?notice=3&u_no=<%= u_no%>">불편함</a>
                </li>
              </ul>
             <%} %>
            <div class="col-12 mb-3 mb-lg-5">
                <div class="overflow-hidden card table-nowrap table-card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                    </div>
                    <div class="table-responsive">
                        <table class="table mb-0">
                            <thead class="small text-uppercase bg-body text-muted">
                                <tr>
                                    <th width="60px">게시물 번호</th>
                                    <th>제목</th>
                                    <th width="120px">작성자</th>
                                    <th width="70px">날짜</th>
                                    <th width="60px">조회</th>
                                </tr>
                            </thead>
                            <tbody>
                          
		<%
		List<BoardVO> boardList = (List<BoardVO>)request.getAttribute("boardList");
		
		for(BoardVO board : boardList){
		%>
			<tr>
						<td><%=board.getRownum()%></td>
						<td>
							<a href="<%=request.getContextPath()%>/board/boardView.do?num=<%=board.getNum()%>&u_no=<%= vo.getU_no()%>&notice=<%= notice%>"><%=board.getTitle()%></a>
						</td>
						<td>
							<%=board.getNick()%>
						</td>
						<td><%=board.getCount()%></td>
						<td><%=board.getW_date()%></td>
					</tr>
				<%
					}
				%>
				</tbody>
			</table>
			
			<% if((notice == 4 && u_no == 0) || notice < 4) {%>
				<br>
				<div style="width: 25px; background-color: white; display: inline-block;"></div><a href="<%=request.getContextPath()%>/board/boardInsertForm.do?notice=<%=notice%>"><button>글 작성</button></a>
				<br><br>
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
	<% if(notice == 1){%>
        $('.n1').addClass("active");
        $('.n2').removeClass("active");
        $('.n3').removeClass("active");
	<%} else if(notice == 2){%>
		$('.n2').addClass("active");
	    $('.n1').removeClass("active");
	    $('.n3').removeClass("active");
	 <%} else if(notice == 3){%>
		 $('.n3').addClass("active");
	    $('.n1').removeClass("active");
	    $('.n2').removeClass("active");
    <%}%>
})

</script>
</body>