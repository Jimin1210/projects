<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	.sideMenuList{
		box-shadow: 0px 15px 10px gray;
	}
</style>

<nav id="navSideBar"class="d-flex flex-column p-3 sideMenuList" style=" float:left ; width: 15%; height: 100%; display: inline; background: linear-gradient(to bottom, #7bc4b2, #00ff72);">
		<div class="mousePoint">
		<a class="p-2 a nav-link bold fw-bold " href="javascript:goPage('/mymenu/noteList2.do?mymenu=1', 'M040100', '커뮤니케이션');" data-url="M040100" aria-expanded="true" style="color: white; text-decoration-line: none;">커뮤니케이션</a>
			<ul style="list-style-type: none;">
				<li>	
					<a class="p-2 a nav-link " href="javascript:goPage('/mymenu/noteList2.do?mymenu=1', 'M040101', '쪽지함');" data-url="M040101" aria-expanded="true" style="color: white; text-decoration-line: none;">&nbsp;&nbsp;&nbsp;&nbsp;쪽지함</a>
				</li>
				<li>	
					<a class="p-2 a nav-link " href="javascript:goPage('/mymenu/sendNoteList2.do?mymenu=1', 'M040102', '보낸쪽지');" data-url="M040102" aria-expanded="true" style="color: white; text-decoration-line: none;">&nbsp;&nbsp;&nbsp;&nbsp;보낸쪽지</a>
				</li>
			</ul>
			
		</div>
		<c:forEach var="myMenu" items="${myMenuList}">
		<div class="mousePoint">
			<a class="p-2 a nav-link bold fw-bold " href="javascript:goPage('${myMenu.MURL }?mymenu=1', '${myMenu.MCODE }', '${myMenu.MNAME }');" data-url="M040100" aria-expanded="true" style="color: white; text-decoration-line: none;">${myMenu.MNAME }</a>
		</div>
		</c:forEach>
</nav>



<script>
	$(function () {
		let micon = sessionStorage.getItem("micon");
		$('#menutitle').html("&nbsp;&nbsp;&nbsp;&nbsp;" + micon);
		
	})
	
	
	$('.mousePoint ul').hide();

	$('.mousePoint').on('mouseenter', function() {
		  $(this).find('ul').stop().slideDown(); // 아래로 내려오는 애니메이션 적용
		});

		$('.mousePoint').on('mouseleave', function() {
		  $(this).find('ul').stop().slideUp(); // 위로 올라가는 애니메이션 적용
		});

		$('.mousePoint ul').on('mouseenter', function() {
		  $(this).stop().slideDown(); // 아래로 내려오는 애니메이션 적용
		});

		$('.mousePoint ul').on('mouseleave', function() {
		  $(this).stop().slideUp(); // 위로 올라가는 애니메이션 적용
		});


</script>

