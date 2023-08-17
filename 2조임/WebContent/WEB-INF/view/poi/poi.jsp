<%@page import="org.apache.poi.hssf.usermodel.HSSFCell"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFRow"%>
<%@page import="java.util.List"%>
<%@page import="kr.or.dw.sales.vo.SalesVO"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.poi.ss.usermodel.HorizontalAlignment"%>
<%@page import="org.apache.poi.ss.usermodel.BorderStyle"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFFont"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFFont"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFSheet"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page language="java" contentType="application/vnd-ms.excel"
    pageEncoding="UTF-8"%>
<html>
<head>

</head>

<%
	String start = (String)request.getAttribute("start");
	String end = (String)request.getAttribute("end");

 	HSSFWorkbook wb = null; // .xls 확장자 지원
 	HSSFSheet sheet = null; // .xls 확장자 지원
 	HSSFRow row = null; // .xls 확장자 지원
 	HSSFCell cell = null; // .xls 확장자 지원
	
 	try {
 	HSSFWorkbook xssfWb = new HSSFWorkbook();// 워크북 생성
 	HSSFSheet xssfSheet = xssfWb.createSheet("매출"); // 워크시트 이름
	
 	HSSFFont font1 = xssfWb.createFont(); // 글씨 스타일 객체 생성
 	font1.setFontName(HSSFFont.FONT_ARIAL); //글씨체
 	
	
 	xssfSheet.setColumnWidth(0, (xssfSheet.getColumnWidth(0))+(short)3096);
 	xssfSheet.setColumnWidth(1, (xssfSheet.getColumnWidth(0))+(short)1000);
 	xssfSheet.setColumnWidth(2, (xssfSheet.getColumnWidth(0))+(short)800);
 	
	
 	CellStyle style = xssfWb.createCellStyle(); // 보더 적용 할 셀 스타일 설정
 	style.setBorderTop(BorderStyle.THIN); //테두리 위쪽
 	style.setBorderBottom(BorderStyle.THIN); //테두리 아래쪽
 	style.setBorderLeft(BorderStyle.THIN); //테두리 왼쪽
 	style.setBorderRight(BorderStyle.THIN); //테두리 오른쪽
 	style.setAlignment(HorizontalAlignment.CENTER);
	
	
 	//셀 생성
 	row = xssfSheet.createRow(0); // 0행을 가르키는 객체
 	cell = row.createCell((short) 0); // 0행에 0열에 셀 객체 추가
 	cell.setCellStyle(style); // 셀에 스타일 지정
 	cell.setCellValue("매출 발생 일"); // 데이터 입력
 	
 	cell = row.createCell((short) 1); // 0행에 0열에 셀 객체 추가
 	cell.setCellStyle(style); // 셀에 스타일 지정
 	cell.setCellValue("발생 매출"); // 데이터 입력
 	
 	cell = row.createCell((short) 2); // 0행에 0열에 셀 객체 추가
 	cell.setCellStyle(style); // 셀에 스타일 지정
 	cell.setCellValue("방문 고객 수"); // 데이터 입력
 	
 	
	List<SalesVO> vo = (List<SalesVO>)request.getAttribute("vo");
 	int count = 1;
 	int totalSales = 0;
 	int totalCnt = 0;
 	for(SalesVO sv : vo){
 	 	row = xssfSheet.createRow(count);
 	 	cell = row.createCell((short) 0); // 0행에 0열에 셀 객체 추가
 	 	cell.setCellStyle(style); // 셀에 스타일 지정
 	 	cell.setCellValue(sv.getA_date()); // 데이터 입력
 	 	
 	 	cell = row.createCell((short) 1); // 0행에 0열에 셀 객체 추가
 	 	cell.setCellStyle(style); // 셀에 스타일 지정
 	 	cell.setCellValue(sv.getDailysales()+"원"); // 데이터 입력
 	 	
 	 	cell = row.createCell((short) 2); // 0행에 0열에 셀 객체 추가
 	 	cell.setCellStyle(style); // 셀에 스타일 지정
 	 	cell.setCellValue(sv.getCnt()+"명"); // 데이터 입력
 	 	
 	 	count = count + 1;
 	 	totalSales = totalSales + sv.getDailysales();
 	 	totalCnt = totalCnt + sv.getCnt();
 	}
	
 	row = xssfSheet.createRow(count);
 	cell = row.createCell((short) 0); // 0행에 0열에 셀 객체 추가
	cell.setCellStyle(style); // 셀에 스타일 지정
	cell.setCellValue("총합"); // 데이터 입력
	
	cell = row.createCell((short) 1); // 0행에 0열에 셀 객체 추가
	cell.setCellStyle(style); // 셀에 스타일 지정
	cell.setCellValue(totalSales + "원"); // 데이터 입력
	
	cell = row.createCell((short) 2); // 0행에 0열에 셀 객체 추가
	cell.setCellStyle(style); // 셀에 스타일 지정
	cell.setCellValue(totalCnt + "명"); // 데이터 입력
	
	
	

 	
 	
 	

	
 	String fileSave = "C:\\Users\\admin\\Desktop\\"; // 파일 저장 경로
 	String fileName = ""; // 파일 이름
 	if(start != end){
 		fileName = start + "_" + end;
 	} else {
 		fileName = start;
 	}
	
	
 	String localFile = fileSave + fileName + ".xls";
	
 	File file = new File(localFile);
 	FileOutputStream fos = null;
 	fos = new FileOutputStream(file);
 	xssfWb.write(fos);
//	fos.flush();
 	if (xssfWb != null)	xssfWb.close();
 	if (fos != null) fos.close();
	
 	}
 	catch(Exception e){
		
 	}finally{
 	%>
 	<script>
 	location.href="<%=request.getContextPath()%>/sales.jsp"
 	</script>
 	<%
 	}%>
	
</html>
