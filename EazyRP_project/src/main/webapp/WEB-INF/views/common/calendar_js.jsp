<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 풀캘린더  -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<!-- jQuery -->
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
	function convertYMD(date){
		console.log("날짜다3  " + date);
		let year = date.getFullYear();
		let month = ('0' + (date.getMonth() + 1)).slice(-2);
		let day = ('0' + date.getDate()).slice(-2);
		let dateStr = year + '-' + month  + '-' + day;
		return dateStr;
	}
	
	// 시간 포맷 변환 함수
	function formatTime(time) {
		// var date = new Date(time);
		var hours = time.getHours().toString().padStart(2, '0');
		var minutes = time.getMinutes().toString().padStart(2, '0');
		var formattedTime = hours + ':' + minutes;
		return formattedTime;
	}

	// 한국 표준시간으로 변환하는 함수
	function convertKST(date){
		// 1. 현재 시간(Locale)
		const curr = new Date();
		console.log("현재시간(Locale) : " + curr + '<br>');

		// 2. UTC 시간 계산
			// const utc = curr.getTime() + (curr.getTimezoneOffset() * 60 * 1000);
		const utc = date.getTime();

		// 3. UTC to KST (UTC + 9시간)
		const KR_TIME_DIFF = 9 * 60 * 60 * 1000;
		const kr_curr = new Date(utc - (KR_TIME_DIFF));

		console.log("한국시간 : " + kr_curr);
		return kr_curr;
	}
	
	$(function(){
// 	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView : 'dayGridMonth',
			locale : 'ko', // 한국어 설정
// 			height: '700px', // calendar 높이 설정
	        expandRows: true, // 화면에 맞게 높이 재설정
	        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
	        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
	        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
			
			// 헤더
			headerToolbar : {
				  left: 'prev,next today',
			      center: 'title',
			      right: 'dayGridMonth,timeGridWeek,timeGridDay'
			},
			         
			// 일정 표시
			events: [
				<c:forEach var="vo" items="${calendarList}">
					{
					  title: '${vo.getCalendar_title()}',
					  start: '${vo.getCalendar_start()}',
					  end: '${vo.getCalendar_end()}',
					  cal_no: '${vo.getCalendar_no()}',
					  color: '#7bc4b2' // '#' + Math.round(Math.random() * 0xffffff).toString(16)
					},
				</c:forEach>
			],
			
			// 일정 드롭다운 이벤트 start
			eventDrop: function (info) {
					
				console.log("eventDrop 실행");
				
				// 시작 시간 변환
				var startTimeInput = document.getElementById('modifyStartTime');
				var startTimeValue = info.event.start;
				var startTimeFormatted = formatTime(startTimeValue);
				startTimeInput.value = startTimeFormatted;

				// 종료 시간 변환
				var endTimeInput = document.getElementById('modifyEndTime');
				var endTimeValue = info.event.end;
				var endTimeFormatted = formatTime(endTimeValue);
				endTimeInput.value = endTimeFormatted;

	            // 이전에 등록한 일정의 정보를 이벤트를 클릭했을때 나타나는 해당 모달로 불러온다
				$('#modifyTitle').attr('value', info.event.title);
				$('#modifyStartDate').attr('value', info.event.start);
				$('#modifyEndDate').attr('value', info.event.end);
				$('#modifyStartTime').attr('value', info.event.start);
				$('#modifyEndTime').attr('value', info.event.end);
		            
				console.log("ㅡ 변경 전 정보 ㅡ");
				console.log("내용 : " + info.event.title);
	            console.log("시작 시간 : " + info.event.start);
	            console.log("종료 시간 : " + info.event.end);
					
				var title = $('#modifyTitle').val();
				var startTime = $('#modifyStartTime').val();
				var endTime = $('#modifyEndTime').val();

				var endDate = new Date(info.endStr);
				var startDate = new Date(info.startStr);
		        endDate.setDate(endDate.getDate() - 1); // 일자를 1일 뒤로 당김
		        
        		let stdFormat = info.event._instance.range.start.toISOString().slice(0, 10) + " " + startTime;
                let endFormat = info.event._instance.range.end.toISOString().slice(0, 10) + " " + endTime;

                console.log("ㅡ 변경 후 정보 ㅡ");
                console.log("내용 : " + title);
                console.log("시작 시간 : " + stdFormat);
				console.log("종료 시간 : " + endFormat);
	
                   	$.ajax({
						  url: "/calendar/modify",
						  type: "POST",
						  data : { 
							 	calendar_title: title,	// 키값 : 벨류값
							  	calendar_start: stdFormat,	// 키값 : 벨류값
							  	calendar_end: endFormat,	// 키값 : 벨류값
							  	calendar_no: info.event._def.extendedProps.cal_no
						  },
						  success : function(data){
							  alert("일정이 수정 되었습니다.");
							  $("#calendarModal").modal("hide");
							  location.reload();
						  },
						  error : function(request,status,error){
							alert("error(ajax)"); // 실패 시 처리
						  }
					});
			// 일정 드롭다운 이벤트 end
			}, 
			
			// 이벤트 클릭 start
			eventClick:function(info) {
				$('#calendar_no').val(info.event._def.extendedProps.cal_no);
				console.log("eventClick 실행");
				
				// 시작일 변환
				var startDateInput = document.getElementById('modifyStartDate');
				var startDateValue = info.event.start;
				var startDateFormatted = convertYMD(startDateValue);
				startDateInput.value = startDateFormatted;
				
				console.log("시작일 " + startDateFormatted);
				
				// 종료일 변환
				var endDateInput = document.getElementById('modifyEndDate');
				var endDateValue = info.event.end;
				if(endDateValue == null){
					endDateValue = startDateValue;
				}
				var endDateFormatted = convertYMD(endDateValue);
				endDateInput.value = endDateFormatted;
				
				console.log("종료일 " + endDateFormatted);

				// 시작 시간 변환
				var startTimeInput = document.getElementById('modifyStartTime');
				var startTimeFormatted = formatTime(startDateValue);
				startTimeInput.value = startTimeFormatted;
				
				console.log("시작 시간 " + startTimeFormatted);
	
				// 종료 시간 변환
				var endTimeInput = document.getElementById('modifyEndTime');
				var endTimeFormatted = formatTime(endDateValue);
				endTimeInput.value = endTimeFormatted;
				
				console.log("종료 시간 " + endTimeFormatted);

	            // 이전에 등록한 일정의 정보를 이벤트를 클릭했을때 나타나는 해당 모달로 불러온다
				$('#modifyTitle').attr('value', '');
				$('#modifyTitle').attr('value', info.event.title);
				$('#modifyStartDate').attr('value', '');
				$('#modifyStartDate').attr('value', startDateFormatted);
				console.log("test " + startDateFormatted);
				$('#modifyEndDate').attr('value', info.event.end);
				$('#modifyStartTime').attr('value', info.event.start);
				$('#modifyEndTime').attr('value', info.event.end);
				
				console.log("ㅡ 변경 전 정보 ㅡ");
				console.log("내용 : " + info.event.title);
	            console.log("시작 시간 : " + info.event.start);
	            console.log("종료 시간 : " + info.event.end);

	            $("#calendarDetailModal").modal("show");
		            
	            // 캘린더 삭제 버튼
	        	$("#removeCalendarBtn").on("click", function() {
	        		
	        		console.log("removeCalendarBtn 실행");
	        		
	        		$.ajax({
						  url: "/calendar/remove",
						  type: "POST",
						  data : { 
							  	calendar_no: info.event._def.extendedProps.cal_no
						  },
						  success : function(res){
							  alert("일정이 삭제 되었습니다.");
							  $("#calendarDetailModal").modal("hide");
							  location.reload();
						  },
						  error : function(request,status,error){
							  alert("error(ajax)"); // 실패 시 처리
						  } 
					});
				});
		        	
	        	let cnt = 0;
            },
			selectable : true,
			droppable : true,
			editable : true,
			
			// 이벤트명 : function(){} : 각 날짜에 대한 이벤트를 통해 처리할 내용
			// 클릭 & 드래그로 일정 추가
			select: function(arg) { 
				
				console.log("select 클릭&드래그 실행");

                $("#calendarModal").modal("show");
                
				console.log("arg.startStr : " + arg.startStr);
				console.log("arg.endStr : " + arg.endStr);
				
				var startDate = new Date(arg.startStr);
				var endDate = new Date(arg.endStr);
		        endDate.setDate(endDate.getDate() - 1); // 일자를 1일 뒤로 당김
		        
		        console.log("startDate : " + startDate);
				console.log("endDate : " + endDate);
				
				var endDateFormatted = convertYMD(endDate);
				endDate.value = endDateFormatted;
				
				console.log("종료일 " + endDateFormatted);
				
				// 이전에 등록한 일정의 정보를 이벤트를 클릭했을때 나타나는 해당 모달로 불러온다
				$('#StartDate').attr('value', arg.startStr);
				$('#EndDate').attr('value', endDate.value);
                
//                 $("#registCalendar").on("click", function () {
                	
// 					var title = $('#title').val();
// 					var startTime = $('#startTime').val();
// 					var endTime = $('#endTime').val();
// 					var calendar_no = $('#calendar_no').val();
// 					var ed = $('#EndDate').val();
// 					var sd = $('#StartDate').val();
					
// 					//내용 입력 여부 확인
// 					if(title == null || title == ""){
// 					    alert("내용을 입력하세요.");
// 					}else if(startTime == "" || endTime ==""){
// 					    alert("시간을 입력하세요.");
// 					}else if(ed == sd && endTime < startTime){ // date 타입으로 변경 후 확인
// 						alert("종료 시간이 시작 시간보다 빠릅니다.\n시간을 올바르게 설정해주세요.");
// 						return false;
// 					}else{ // 정상적인 입력 시
				
// 	                 	$.ajax({
// 							 url: "/calendar/regist",
// 							 type: "POST",
// 							 data : { 
// 							 	calendar_title: title,	// 키값 : 벨류값
// 							  	calendar_start: arg.startStr + ' ' + startTime ,	// 키값 : 벨류값
// 							  	calendar_end: endDateFormatted + " " + endTime,	// 키값 : 벨류값
// 							 },
// 							 success : function(data){
// 							  alert("일정이 등록되었습니다.");
// 							  $("#calendarModal").modal("hide");
// 							  location.reload();
// 							 },
// 							 error : function(request,status,error){
// 								alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
// 								console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
// 							 }
// 						});
// 					};
// 				});
				
			}
			
		});
		
		$("#registCalendar").on("click", function(arg) {
        	
			var title = $('#title').val();
			var startTime = $('#startTime').val();
			var endTime = $('#endTime').val();
			var calendar_no = $('#calendar_no').val();
			var ed = $('#EndDate').val();
			var sd = $('#StartDate').val();
			
			var StartDate = $('#StartDate').val();
			var EndDate = $('#EndDate').val();
			
			//내용 입력 여부 확인
			if(title == null || title == ""){
			    alert("내용을 입력하세요.");
			}else if(startTime == "" || endTime ==""){
			    alert("시간을 입력하세요.");
			}else if(ed == sd && endTime < startTime){ // date 타입으로 변경 후 확인
				alert("종료 시간이 시작 시간보다 빠릅니다.\n시간을 올바르게 설정해주세요.");
				return false;
			}else{ // 정상적인 입력 시
		
             	$.ajax({
					 url: "/calendar/regist",
					 type: "POST",
					 data : { 
					 	calendar_title: title,	// 키값 : 벨류값
					  	calendar_start: StartDate + ' ' + startTime ,	// 키값 : 벨류값
					  	calendar_end: EndDate + " " + endTime,	// 키값 : 벨류값
					 },
					 success : function(data){
					  alert("일정이 등록되었습니다.");
					  $("#calendarModal").modal("hide");
					  location.reload();
					 },
					 error : function(request,status,error){
						alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
						console.log("code = "+ request.status + " message = " + request.responseText + " error = " + error);
					 }
				});
			};
		});
		
		calendar.render();
		
		$("#closeCalendar").on("click", function(arg) {
			
			console.log("closeCalendar 실행");
			
			 $("#endTime").val('');
			 $("#startTime").val('');
			 $("#title").val('');
// 			 $("#StartDate").val('');
// 			 $("#EndDate").val('');

			$('#StartDate').attr('value', arg.startStr);
			$('#EndDate').attr('value', arg.endStr);
			 
			 $("#calendarModal").modal("hide");
		});
		
		// 디테일 캘린더 닫기 버튼
    	$("#closeModifyCalendar").on("click", function() {
    		console.log("closeModifyCalendar 실행");
				 console.log("모달 입력값 초기화");
				 
			$("#calendarDetailModal").modal("hide");
		});
		
    	// 캘린더 수정 완료 버튼
    	$("#modifyCalendarBtn").on("click", function() {
    		
    		console.log("modifyCalendarBtn 실행");
    		var title = $('#modifyTitle').val();
			var startDate = $('#modifyStartDate').val();
			var sd = $('#modifyStartDate').val();
			console.log(startDate);
			var endDate = $('#modifyEndDate').val();
			var ed = $('#modifyEndDate').val();
			var startTime = $('#modifyStartTime').val();
			console.log(startTime);
			var endTime = $('#modifyEndTime').val();

			console.log("sd : " + sd);
			console.log("ed : " + ed);
			console.log(startTime);
	        
    		let stdFormat = sd + " " + startTime;
            let endFormat = ed + " " + endTime;
            console.log("ㅡ 변경 후 정보 ㅡ");
            console.log("내용 : " + title);
            console.log("시작 시간 : " + stdFormat);
			console.log("종료 시간 : " + endFormat);
			console.log(endTime);
			console.log(startTime);
			
			//내용 입력 여부 확인
			if(title == null || title == ""){
			    alert("내용을 입력하세요.");
			}else if(startTime == "" || endTime ==""){
			    alert("시간을 입력하세요.");
			}else if(ed == sd && endTime < startTime){ // date 타입으로 변경 후 확인
				alert("종료 시간이 시작 시간보다 빠릅니다.\n시간을 올바르게 설정해주세요.");
				return;
			}else{ // 정상적인 입력 시
               	$.ajax({
					url: "/calendar/modify",
					type: "POST",
					data : { 
						calendar_title: title,	// 키값 : 벨류값
					  	calendar_start: stdFormat,	// 키값 : 벨류값
					  	calendar_end: endFormat,	// 키값 : 벨류값
					  	calendar_no: $('#calendar_no').val()
					},
					success : function(data) {
						console.log(data);
						alert("일정이 수정 되었습니다.");
						$("#calendarModal").modal("hide");
						location.reload();
					},
					error : function(request,status,error) {
						alert("error(ajax)"); // 실패 시 처리
					}
				});
			};
			return;
		});
		
	});
</script>
