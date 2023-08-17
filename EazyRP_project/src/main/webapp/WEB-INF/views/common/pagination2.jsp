<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="<%= request.getContextPath()%>/resources/bootstrap/dist/css/adminlte.min.css">

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<nav aria-label="member list Nabigation">
	<ul class="pagination justify-content-center m-0">
		<li class="page-item">
			<a class="page-link" href="javascript:searchList_go(1);">
				<i class="fas fa-angle-double-left"></i>
			</a>
		</li>
		<li class="page-item">
			<a class="page-link" href="javascript:searchList_go(${pageMaker.prev ? pageMaker.cri.page-1 : -1 })">
				<i class="fas fa-angle-left"></i>
			</a>
		</li>
		<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="pageNum">
			<li class="page-item ${pageMaker.cri.page == pageNum ? 'active' : '' }">
				<a class="page-link" href="javascript:searchList_go(${pageNum })">${pageNum }</a>
			</li>
		</c:forEach>
		<li class="page-item">
			<a class="page-link" href="javascript:searchList_go(${pageMaker.next ? pageMaker.cri.page+1 : -1 })">
				<i class="fas fa-angle-right"></i>
			</a>
		</li>
		<li class="page-item">
			<a class="page-link" href="javascript:searchList_go(${pageMaker.realEndPage });">
				<i class="fas fa-angle-double-right"></i>
			</a>
		</li>
	</ul>
</nav>

<form id="searchForm2">
	<input type="hidden" name="page">
	<input type="hidden" name="perPageNum">
	<input type="hidden" name="searchType">
	<input type="hidden" name="keyword">
</form>
<script>
	function searchList_go(page, url){
		
		let mcode = sessionStorage.getItem("mcode");
		
		let modMcode = mcode.substring(0,3) + "0000";
		
		if(page < 1){
			return;
		}
		
		let perPageNum = 10;
		if($('select[name="perPageNum"]').val()){
			perPageNum = $('select[name="perPageNum"]').val();
		}
		let searchForm = $('#searchForm2');
		searchForm.find('input[name="page"]').val(page);
		console.log(searchForm.find('input[name="page"]'))
		searchForm.find('[name="perPageNum"]').val(perPageNum);
		searchForm.find('[name="searchType"]').val($('select[name="searchType"]').val());
		searchForm.find('[name="keyword"]').val($('div.input-group > input[name="keyword"]').val());
		searchForm.attr("method", "post");
		
		if(url){
			searchForm.attr("action", url);
		}else{
			searchForm.attr("action", "noteList.do?mcode=" + modMcode);
		}
		console.log(searchForm)
		searchForm.submit();
	}
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>