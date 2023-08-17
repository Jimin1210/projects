<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="cri" value="${pageMaker.cri }"/>
<div style="height: 40px"></div>
<section class="content container-fluid">
	<div class="row justify-content-center">
		<div class="col-md-10" style="max-width: 1100px;">
			<div class="card card-outline card-info">
				<div class="card-header" style="border-bottom: none;">
					<h2 class="card-title p-1">문의사항</h2>
					<div class="input-group row" style="width: 90%; margin-left: 50%;">
						<form id="searchForm2" method="post"
							action="/member/qna.do?mcode=${mcode }"
							style="display: contents;"></form>
					</div>
				</div>

				<div class="card-body pad">
					<div>
						<table class="table accordion text-center">
							<thead>
								<tr>
									<th scope="col" width="300px" style="text-align: center;">내 용</th>
									<th scope="col" width="100px" style="text-align: center;">날 짜</th>
									<th scope="col" width="50px" style="text-align: center;">답변여부</th>
									<th scope="col" width="20px" style="text-align: center;"></th>
								</tr>
							</thead>						
							<c:forEach items="${qnaList}" var="qna">
								<tbody>
									<tr class="r2">
										<td style="text-align: center;">${qna.INQ_CON } </td>
										<td style="text-align: center;">${qna.REGDATE }</td>
										<td style="text-align: center;">${empty qna.ANS_CON ? 'N' : 'Y' }</td>
										<td id="${qna.INQ_NO }">
											<!-- 수정 -->
											<svg type="button"  id="modifyBtn" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
											  <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
											  <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
											</svg>
											<!-- 삭제 -->
											<svg type="button" id="removeBtn" xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-trash3" viewBox="0 0 16 16">
												<path d="M6.5 1h3a.5.5 0 0 1 .5.5v1H6v-1a.5.5 0 0 1 .5-.5ZM11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3A1.5 1.5 0 0 0 5 1.5v1H2.506a.58.58 0 0 0-.01 0H1.5a.5.5 0 0 0 0 1h.538l.853 10.66A2 2 0 0 0 4.885 16h6.23a2 2 0 0 0 1.994-1.84l.853-10.66h.538a.5.5 0 0 0 0-1h-.995a.59.59 0 0 0-.01 0H11Zm1.958 1-.846 10.58a1 1 0 0 1-.997.92h-6.23a1 1 0 0 1-.997-.92L3.042 3.5h9.916Zm-7.487 1a.5.5 0 0 1 .528.47l.5 8.5a.5.5 0 0 1-.998.06L5 5.03a.5.5 0 0 1 .47-.53Zm5.058 0a.5.5 0 0 1 .47.53l-.5 8.5a.5.5 0 1 1-.998-.06l.5-8.5a.5.5 0 0 1 .528-.47ZM8 4.5a.5.5 0 0 1 .5.5v8.5a.5.5 0 0 1-1 0V5a.5.5 0 0 1 .5-.5Z"/>
											</svg>
										</td>
									</tr>

									<c:if test="${not empty qna.ANS_CON }">
										<tr class="r1" style=" background-color: whitesmoke;">
											<td colspan="4">${qna.ANS_CON }</td>
										</tr>
									</c:if>
							</c:forEach>
							</tbody>
						</table>
					</div>
				</div> 
				<!-- 등록 -->
				 <div class="text">
                    <div class="container">
				<div class="re_form" style="display: none;">
                        <form method="post" name ="form" action="/member/qnaRegist">
	                        <input class="form-control" style="margin-bottom:10px;" name="inq_con" placeholder="내용입력">
	                        <input type="hidden" name="mcode" value="${mcode }">
	                        <input type="hidden" name="inq_no" value="">
                        </form>
                     <div style="float: right; margin-bottom:10px;">
	                    <button class="btn btn-primary" style="width: 60px;font-size: 0.8em; height: 30px;" id="submit">등록</button>
                        <button  class="btn btn-primary" style="width: 60px;font-size: 0.8em; height: 30px;" id="cancelBtn">취소</button>
                    </div>
                  </div>
                  </div>
                  </div>
                  
                  
				<div class="card-footer">
					<%@ include file="/WEB-INF/views/common/pagination.jsp"%>
				</div>
			</div>
			<div style="display: flex; align-items: end; justify-content: end;">
				<button type="button" class="btn btn-primary" id="registBtn" style="width: 100px; font-size: 0.8em; margin: 20px; align-self: center;">문의하기</button>
			</div>
		</div>
	</div>

</section>
	
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

<script>

$('.r1').hide();

	$('tr').on('click', function(){
		if($(this).attr('class') == 'r2'){
			$(this).next().stop().slideDown();		
			$(this).attr('class', 'r3');
		} else if($(this).attr('class') == 'r3'){
			$(this).next().stop().slideUp();		
			$(this).attr('class', 'r2');
		}
	})

	$('#registBtn').on('click',function(){
  		$('.re_form').toggle();
    	$('#registBtn').toggle();
    	$('form[name="form"]').attr('action', '/member/qnaRegist.do');
    })

	 $('#cancelBtn').on('click', function(){
    	$('.re_form').toggle();
        $('#registBtn').toggle();
    })

	$('#submit').on('click', function(){
    	$('form[name="form"]').submit();
    })
    
    

	$('svg#removeBtn').on('click', function(){
			if(confirm("정말 삭제하시겠습니까")){
				location.href="/member/remove.do?inq_no="+ $(this).parent('td').attr('id') + "&mcode=${mcode}";
			}
		});	 

	$('svg#modifyBtn').on('click', function(){
			$('.re_form').toggle();	
			$('#registBtn').toggle();
			let inq_no = $(this).parent().attr('id');
			$('input[name="inq_no"]').val(inq_no);
			$('form[name="form"]').attr('action', '/member/modify.do');	
	    });	

	
	

    
</script>
<%@ include file="../include/footer_js.jsp"%>
