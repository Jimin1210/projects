package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.WareHouseVO;

public interface ItemService {

	Map<String, Object> selectItemList(SearchCriteria cri, String c_no) throws SQLException;

	List<Map<String, Object>> getWarehouse(Map<String, String> dataMap) throws SQLException;

	List<Map<String, Object>> getWarehouseList() throws SQLException;

	List<Map<String, Object>> getSprice(Map<String, String> dataMap) throws SQLException;

	List<Map<String, Object>> getSpriceList() throws SQLException;

	void registItem(ProductVO product) throws SQLException;

	Map<String, Object> selectProductDetail(String pr_no)throws SQLException;

	void modifyItem(ProductVO product) throws SQLException;

	void deleteProduct(ProductVO product) throws SQLException;


}
