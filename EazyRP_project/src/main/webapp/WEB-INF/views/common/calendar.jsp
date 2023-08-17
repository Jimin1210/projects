<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@	page import="java.util.List"%>
<%@	page import="kr.or.dw.vo.CalendarVO"%>

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">

<!DOCTYPE html>
<html>
<head>
<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

<!-- jquery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- moment CDN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<!-- fullcalendar CDN -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<!-- fullcalendar 언어 CDN -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
		  
<style>
	/* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
	.fc-header-toolbar {
/* 		padding: 0em; */
	}
	
	/* body 스타일 */
	.fc .fc-scrollgrid-liquid {
	  overflow: hidden;
	  font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	}
	
	/* modal 스타일 */
	.modal {
		text-align: left;
	}
</style>

</head>

<body style="padding:30px;">

	<!-- calendar 태그 -->
	<div class="calendarBox" id='calendar-container'>
		<div id='calendar'></div>
	</div>
	
	<!-- 비어 있는 modal 추가 -->
    <div class="modal fade" id="calendarModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="taskId" class="col-form-label" id="">일정 내용</label>
                        <input type="text" class="form-control" id="title" value="" name="calendar_title">
                        
                        <label for="taskId" class="col-form-label" id="">시작일</label>
                        <input type="date" class="form-control" id="StartDate" value="" name="calendar_start">
                        
                        <label for="taskId" class="col-form-label" id="">종료일</label>
                        <input type="date" class="form-control" id="EndDate" value="" name="calendar_end">
                        
                        <label for="taskId" class="col-form-label" id="">시작 시간</label>
                        <input type="time" class="form-control" id="startTime" value="" name="calendar_start">
                        
                        <label for="taskId" class="col-form-label" id="">종료 시간</label>
                        <input type="time" class="form-control" id="endTime" value="" name="calendar_end">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-warning" id="registCalendar">등록</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="closeCalendar">닫기</button>
                </div>
    
            </div>
        </div>
    </div>
    
	<!-- modal 디테일 및 수정, 삭제 -->
    <div class="modal fade" id="calendarDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
                </div>
                <div class="modal-body">
	                    <div class="form-group">
	                        <label for="taskId" class="col-form-label" id="">일정 내용</label>
	                        <input type="text" class="form-control" id="modifyTitle" value="" name="calendar_title">
	                        
	                        <label for="taskId" class="col-form-label" id="">시작일</label>
	                        <input type="date" class="form-control" id="modifyStartDate" value="" name="calendar_start">
	                        
	                        <label for="taskId" class="col-form-label" id="">종료일</label>
	                        <input type="date" class="form-control" id="modifyEndDate" value="" name="calendar_end">
	                        
	                        <label for="taskId" class="col-form-label" id="">시작 시간</label>
	                        <input type="time" class="form-control" id="modifyStartTime" value="" name="calendar_start">
	                        
	                        <label for="taskId" class="col-form-label" id="">종료 시간</label>
	                        <input type="time" class="form-control" id="modifyEndTime" value="" name="calendar_end">
	                        
	                        <input type="hidden" name="calendar_no" id="calendar_no">
	                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" id="modifyCalendarBtn">수정</button>
                    <button type="button" class="btn btn-danger" id="removeCalendarBtn">삭제</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="closeModifyCalendar">닫기</button>
                </div>
            </div>
        </div>
    </div>
    
<!-- Calendar <script></script> (박희성) -->
<%@ include file="calendar_js.jsp" %>


<!-- 풀캘린더  -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<!-- jQuery -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
