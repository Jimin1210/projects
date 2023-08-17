<%@page import="kr.or.dw.product.vo.ProductVO"%>
<%@page import="java.util.List"%>
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
<% List<ProductVO> pvo = (List<ProductVO>)request.getAttribute("vo");
	int cla = (int)request.getAttribute("cla");%>
<script>
$(function(){
	<%if(cla == 0){ %>
		$('.n0').addClass('active');
		$('.n1').removeClass('active');
		$('.n2').removeClass('active');
		$('.n3').removeClass('active');
	<%} else if(cla == 1) { %>
		$('.n0').removeClass('active');
		$('.n1').addClass('active');
		$('.n2').removeClass('active');
		$('.n3').removeClass('active');
	<%} else if(cla == 2) { %>
		$('.n0').removeClass('active');
		$('.n1').removeClass('active');
		$('.n2').addClass('active');
		$('.n3').removeClass('active');
	<%}else if(cla == 3) {%>
		$('.n0').removeClass('active');
		$('.n1').removeClass('active');
		$('.n2').removeClass('active');
		$('.n3').addClass('active');
	<%}%>
});
</script>
<div class="container">
        <div class="row">
   			<ul class="nav nav-tabs">
                <li class="nav-item">
                  <a class="nav-link n0" aria-current="page" href="<%=request.getContextPath()%>/product/productView.do?cla=0">전체보기</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link n1" href="<%=request.getContextPath()%>/product/productView.do?cla=1">비프패티버거</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link n2" href="<%=request.getContextPath()%>/product/productView.do?cla=2">튀김패티버거</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link n3" href="<%=request.getContextPath()%>/product/productView.do?cla=3">사이드&음료</a>
                </li>
              </ul>
<div class="content-wrapper">
    <div class="container">
<div id="content" >
  
    <form id="profileForm" method="post" enctype="multipart/form-data">
        <fieldset>
            <div class="tab-pane fade show active" id="nav-fruitsandveg" role="tabpanel" aria-labelledby="nav-fruitsandveg-tab" tabindex="0">
             
              <div class="row g-4 row-cols-xl-4 row-cols-lg-3 row-cols-2 row-cols-md-2 mt-2">
              <% for(ProductVO pro : pvo){%>
                <div class="col">
                  <!-- card -->
                  <div class="card card-product">
                    <div class="card-body">
                      <div class="text-center position-relative">
                        <!-- badge -->
                        <div class="position-absolute top-0 start-0">
                        </div>
                        <a href="#!">
                          <!-- img --><img src="/img/product/<%= pro.getImg()%>.png" class="mb-3 img-fluid"></a>
                        <!-- btn action -->
                        <div class="card-product-action">
                          <a href="#!" class="btn-action" data-bs-toggle="modal" data-bs-target="#quickViewModal"><i class="bi bi-eye" data-bs-toggle="tooltip" data-bs-html="true" aria-label="Quick View" data-bs-original-title="Quick View"></i></a>
                          <a href="#!" class="btn-action" data-bs-toggle="tooltip" data-bs-html="true" aria-label="Wishlist" data-bs-original-title="Wishlist"><i class="bi bi-heart"></i></a>
                          <a href="#!" class="btn-action" data-bs-toggle="tooltip" data-bs-html="true" aria-label="Compare" data-bs-original-title="Compare"><i class="bi bi-arrow-left-right"></i></a>
                        </div>
                      </div>
                      <div class="text-small mb-1">
                        
                      </div>
                      <h2 class="fs-6">
                      <p>제품명 : <%= pro.getName()%></p>
                        <p class="text-decoration-none text-muted"><small>금액 : <%= pro.getCost()%>원</small></p>
                      </h2>
                     
                      <!-- price -->
                      <div class="d-flex justify-content-between align-items-center mt-3">
                        <div>
                         <div><span class="text-dark"></span>제품설명 : <%= pro.getP_description()%> </div>
                        </div>
                        <div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <%} %>
                </div>
                </div>
              </div>
