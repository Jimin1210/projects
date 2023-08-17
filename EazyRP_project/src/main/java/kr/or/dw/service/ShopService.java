package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;

public interface ShopService {

	List<ShopVO> getShop(Map<String, String> dataMap) throws SQLException;

	List<ShopVO> getShopList() throws SQLException;

	Map<String, Object> selectShopList(SearchCriteria cri) throws SQLException;

	void insertShop(ShopVO shopVO) throws SQLException;

	Map<String, Object> selectShop(String s_no) throws SQLException;

	void deleteShop(ShopVO shopVO) throws SQLException;

	void modifyShop(ShopVO shopVO) throws SQLException;
}
