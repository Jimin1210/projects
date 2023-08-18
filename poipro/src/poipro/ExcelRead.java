package poipro;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Iterator;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelRead {

	
	 public static String filePath = "C:\\Users\\PC8\\Desktop\\";
	  public static String fileNm = "test.xlsx";
	   
	public static void main(String[] args) {
		
		 try (FileInputStream file = new FileInputStream(new File(filePath, fileNm))){

	            // 엑셀 파일로 Workbook instance를 생성한다.
	            XSSFWorkbook workbook = new XSSFWorkbook(file);

	            // workbook의 첫번째 sheet를 가저온다.
	            XSSFSheet sheet = workbook.getSheetAt(0);

	            // 만약 특정 이름의 시트를 찾는다면 workbook.getSheet("찾는 시트의 이름");
	            // 만약 모든 시트를 순회하고 싶으면
	            // for(Integer sheetNum : workbook.getNumberOfSheets()) {
	            //      XSSFSheet sheet = workbook.getSheetAt(i);
	            // }
	            // 아니면 Iterator<Sheet> s = workbook.iterator() 를 사용해서 조회해도 좋다.

	            // 모든 행(row)들을 조회한다.
	            for (Row row : sheet) {
	                // 각각의 행에 존재하는 모든 열(cell)을 순회한다.
	                Iterator<Cell> cellIterator = row.cellIterator();

	                while (cellIterator.hasNext()) {
	                    Cell cell = cellIterator.next();

	                    // cell의 타입을 하고, 값을 가져온다.
	                    switch (cell.getCellType()) {

	                        case NUMERIC:
	                            //getNumericCellValue 메서드는 기본으로 double형 반환
	                            System.out.print((int) cell.getNumericCellValue() + "\t");
	                            break;

	                        case STRING:
	                            System.out.print(cell.getStringCellValue() + "\t");
	                            break;
	                    }
	                }
	                System.out.println();
	            }
	            
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
		
	}

}
