package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.SaleDetailVO;
import kr.or.dw.vo.SsheetVO;

@Mapper
public interface OrderSaleDAO {

	List<Map<String, Object>> selectSaleList(Map<String, Object> dataMap2, RowBounds rowBounds) throws SQLException;

	int selectSearchSaleListCount(Map<String, Object> dataMap2) throws SQLException;

	List<SaleDetailVO> getSaleDetail(String sheet_no) throws SQLException;

	SsheetVO getSheet(String sheet_no) throws SQLException;

	void insertProductSale(SsheetVO sheet) throws SQLException;

	int insertSheetNo() throws SQLException;
	
	void insertProudctDetail(SaleDetailVO vo) throws SQLException;

	void detailRemove(String sheet_no)throws SQLException;
	
	void saleRemove(String sheet_no) throws SQLException;



	
	
}	
