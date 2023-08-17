<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>
<div style="height: 50px"></div>
<section class="content container-fluid">
		<div class="row justify-content-center">
			<div class="col-md-9" style="max-width: 600px;">
				<div class="card card-outline card-info">
					<div class="card-header">
						<h3 class="card-title p-1">결재 라인 추가</h3>
						<div class="card-tools">
							<button type="button" class="btn btn-primary" id="registBtn">추 가</button>
							&nbsp;&nbsp;&nbsp;
							<button type="button" class="btn btn-warning" id="cancelBtn">취 소</button>
						</div>
					</div>
					<div class="card-body pad">
						
							<div class="form-group">
								<label for="title">결재라인명</label>
								<input type="text" id="pl_name1" name="pl_name" class="form-control" placeholder="결재라인명을 입력하세요.">
							</div>
							<table style="width:100%;">
								<tr>
									<td style="text-align: center;"><label for="title" style="font-size: 1.0em; text-align: center;">결재자 1</label></td>
									<td style="text-align: center;"><label for="title" style="font-size: 1.0em; text-align: center;">결재자 2</label></td>
									<td style="text-align: center;"><label for="title" style="font-size: 1.0em; text-align: center;">결재자 3</label></td>
								</tr>
								<tr>
									<td style="text-align: center;">
									<input type="text" class="form-control" id="e_name11" readonly style="background-color: white; width:130px; text-align:center; display: inline;" onclick="OpenWindow('/management/findPeople.do?no=1', '사람찾기', 400, 600)">
									<input type="hidden" class="form-control" id="emp_no11" readonly style="background-color: white; width:130px; text-align:center; display: inline;">
									</td>
									<td style="text-align: center;">
									<input type="text" class="form-control" id="e_name22" readonly style="background-color: white; width:130px; text-align:center; display: inline;" onclick="OpenWindow('/management/findPeople.do?no=2', '사람찾기', 400, 600)">
									<input type="hidden" class="form-control" id="emp_no22" readonly style="background-color: white; width:130px; text-align:center; display: inline;">
									</td>
									<td style="text-align: center;">
									<input type="text" class="form-control" id="e_name33" readonly style="background-color: white; width:130px; text-align:center; display: inline;" onclick="OpenWindow('/management/findPeople.do?no=3', '사람찾기', 400, 600)">
									<input type="hidden" class="form-control" id="emp_no33" readonly style="background-color: white; width:130px; text-align:center; display: inline;">
									</td>
								</tr>
							</table>
							<div class="form-group col-sm-12" style="margin-top: 20px;">
								<label for="content">비 고</label>
								<input type="text" class="form-control" id="comment1" name="comment1" style="background-color: white;">
							</div>
						
					</div>
				</div>
			</div>
		</div>
	</section>
<form id="submitForm2" method="post" action="/management/registPayLineForm.do">
	<input type="hidden" class="form-control" name="e_name1" id="e_name1" readonly style="background-color: white; width:130px; hidden-align:center; display: inline;" onclick="OpenWindow('/management/findPeople.do?no=1', '사람찾기', 400, 600)">
	<input type="hidden" class="form-control" name="emp_no1" id="emp_no1" readonly style="background-color: white; width:130px; hidden-align:center; display: inline;">
	<input type="hidden" class="form-control" name="e_name2" id="e_name2" readonly style="background-color: white; width:130px; hidden-align:center; display: inline;" onclick="OpenWindow('/management/findPeople.do?no=2', '사람찾기', 400, 600)">
	<input type="hidden" class="form-control" name="emp_no2" id="emp_no2" readonly style="background-color: white; width:130px; hidden-align:center; display: inline;">
	<input type="hidden" class="form-control" name="e_name3" id="e_name3" readonly style="background-color: white; width:130px; hidden-align:center; display: inline;" onclick="OpenWindow('/management/findPeople.do?no=3', '사람찾기', 400, 600)">
	<input type="hidden" class="form-control" name="emp_no3" id="emp_no3" readonly style="background-color: white; width:130px; hidden-align:center; display: inline;">
	<input type="hidden" id="pl_name" name="pl_name" class="form-control" placeholder="결재라인명을 입력하세요.">
	<input type="hidden" class="form-control" id="comments" name="comments" style="background-color: white;">
</form>
<script>
	function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight){
		winleft = (screen.width - WinWidth) / 2;
		wintop = (screen.height - WinHeight) / 2;
		var win = window.open(UrlStr, WinTitle, "scrollbars=yes,width=" + WinWidth+", "
								+ "height=" + WinHeight + ",top="+ wintop + ",left="
								+ winleft + ",resizable=yes,status=yes");
		win.focus();
	};
	$('#registBtn').on('click', function(){
		$('#pl_name').val($('#pl_name1').val());
		$('#comments').val($('#comment1').val());
		$('#submitForm2').submit();
	})
	$('#cancelBtn').on('click', function(){
		window.opener.location.reload(true);
		window.close();
	})
</script>