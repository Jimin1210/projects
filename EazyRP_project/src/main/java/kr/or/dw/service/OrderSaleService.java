package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.SaleDetailVO;
import kr.or.dw.vo.SsheetVO;

public interface OrderSaleService {


	Map<String, Object> selectSaleList(Map<String, Object> dataMap) throws SQLException;

	List<SaleDetailVO> getSaleDetail(String sheet_no) throws SQLException;

	SsheetVO getSheet(String sheet_no) throws SQLException;
	
	int insertProductSale(SsheetVO sheet) throws SQLException;

	void insertProductDetail(List<SaleDetailVO> detail) throws SQLException;

	void saleRemove(String sheet_no) throws SQLException;


	
	
	
	
	

}
