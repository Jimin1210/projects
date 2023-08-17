<%@page import="kr.or.dw.user.vo.UserVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.dw.board.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="table table-striped projects">
		<thead>
			<tr>
				<th style="width: 10%">글번호</th>
				<th style="">제목</th>
				<th style="width: 20%">작성자</th>
				<th style="width: 7%">조회수</th>
				<th style="width: 16%">작성일</th>
			</tr>
		</thead>
		<tbody>
		
		<%
		List<BoardVO> boardList = (List<BoardVO>)request.getAttribute("boardList");
		int notice = (int)request.getAttribute("notice");
		UserVO vo = (UserVO)session.getAttribute("userVO");
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
	<% if(vo != null) {%>
		<a href="<%=request.getContextPath()%>/board/boardInsertForm.do?notice=<%=notice%>"><button>글 작성</button></a>
	<%} %>
</body>
</html>