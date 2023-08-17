package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.SiVO;


public interface MerchandiseService {

	Map<String, Object> selectMerchandiseList(SearchCriteria cri) throws SQLException;

	List<ProductVO> getProduct(Map<String, String> dataMap) throws SQLException;

	List<ProductVO> getProductList() throws SQLException;

	void insertMerchandise(MerchandiseVO mchVO) throws SQLException;

	Map<String, Object> selectDetail(String sp_no) throws SQLException;

	void modifyMerchandise(MerchandiseVO mchVO) throws SQLException;

	void deleteMerchandise(MerchandiseVO mchVO) throws SQLException;

	List<Map<String, Object>> getMerchandise(Map<String, String> dataMap) throws SQLException;

	List<Map<String, Object>> getMerchandiseList() throws SQLException;

	
	
}
