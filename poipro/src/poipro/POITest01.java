package poipro;

import java.io.File;
import java.io.FileOutputStream;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class POITest01 {

	public static void main(String[] args) {
//		HSSFWorkbook wb = null; // .xls 확장자 지원
//		HSSFSheet sheet = null; // .xls 확장자 지원
//		Row row = null; // .xls 확장자 지원
//		Cell cell = null; // .xls 확장자 지원
		
		XSSFRow xssfRow = null; // .xlsx 확장자 지원
		XSSFCell xssfCell = null;// .xlsx 확장자 지원
			
			try {
			XSSFWorkbook workbook = new XSSFWorkbook();// 워크북 생성
			XSSFSheet sheet = workbook.createSheet("바보"); // 워크시트 이름
			
			XSSFFont font1 = workbook.createFont();
			font1.setColor(IndexedColors.RED.getIndex());
			font1.setFontName(HSSFFont.FONT_ARIAL);
			font1.setFontHeightInPoints((short)40);
			font1.setBold(true);
			
			sheet.addMergedRegion(new CellRangeAddress(0, 3, 0, 8));
			
			CellStyle ex = workbook.createCellStyle();
			ex.setAlignment(HorizontalAlignment.CENTER);
			ex.setFont(font1);
			
			xssfRow = sheet.createRow(0); // 0행을 가르키는 객체
			xssfCell = xssfRow.createCell((short) 0); // 0행에 0열에 셀 객체 추가
			xssfCell.setCellStyle(ex); // 셀에 스타일 지정
			xssfCell.setCellValue("타이틀 입니다."); // 데이터 입력
			
//			XSSFFont font1 = xssfWb.createFont(); // 글씨 스타일 객체 생성
//			font1.setColor(IndexedColors.GREEN.getIndex());	//초록 글씨
//			font1.setFontName(HSSFFont.FONT_ARIAL); //글씨체
//			font1.setFontHeightInPoints((short)20); //폰트크기
//			font1.setBold(true); //Bold 유무
//
//			xssfSheet.setColumnWidth(0, (xssfSheet.getColumnWidth(0))+(short)4096); // 8번째 컬럼 넓이 조절
//			
//			CellStyle ex1 = xssfWb.createCellStyle(); // 보더 적용 할 셀 스타일 설정
//			ex1.setBorderTop(BorderStyle.THIN); //테두리 위쪽
//			ex1.setBorderBottom(BorderStyle.THIN); //테두리 아래쪽
//			ex1.setBorderLeft(BorderStyle.THIN); //테두리 왼쪽
//			ex1.setBorderRight(BorderStyle.THIN); //테두리 오른쪽
//			ex1.setFillForegroundColor(IndexedColors.AQUA.getIndex());  //배경색 설정
//			ex1.setFillPattern(FillPatternType.SOLID_FOREGROUND);
//			ex1.setAlignment(HorizontalAlignment.CENTER);
//			
//			CellStyle ex2 = xssfWb.createCellStyle(); // 셀 스타일 객체 생성
//			
//			ex2.setFillForegroundColor(IndexedColors.VIOLET.getIndex());  //배경색 설정
//			ex2.setFillPattern(FillPatternType.SOLID_FOREGROUND);  // 채우기
//			ex2.setFont(font1); // cellStle에 font를 적용
//			ex2.setAlignment(HorizontalAlignment.CENTER); // 정렬
//			
//			//셀 병합
//			xssfSheet.addMergedRegion(new CellRangeAddress(0, 3, 0, 8)); //첫행, 마지막행, 첫열, 마지막열
//			
//			//셀 생성
//			xssfRow = xssfSheet.createRow(0); // 0행을 가르키는 객체
//			xssfCell = xssfRow.createCell((short) 0); // 0행에 0열에 셀 객체 추가
//			xssfCell.setCellStyle(ex1); // 셀에 스타일 지정
//			xssfCell.setCellValue("타이틀 입니다."); // 데이터 입력
//			
//			
//			
//			CellStyle cellStyle_Body = xssfWb.createCellStyle(); 
//			cellStyle_Body.setAlignment(HorizontalAlignment.LEFT); 
			
			
			
			String fileSave = "C:\\Users\\PC8\\Desktop\\"; // 파일 저장 경로
			String fileName = "test2"; // 파일 이름
			
			
			String localFile = fileSave + fileName + ".xlsx";
			
			File file = new File(localFile);
			FileOutputStream fos = null;
			fos = new FileOutputStream(file);
			workbook.write(fos);

			if (workbook != null)workbook.close();
			if (fos != null) fos.close();
			
			}
			catch(Exception e){
	        	
			}finally{
				
			}

	}

}
