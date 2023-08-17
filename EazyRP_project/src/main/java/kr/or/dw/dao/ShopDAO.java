package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;

@Mapper
public interface ShopDAO {

	List<ShopVO> getShop(Map<String, String> dataMap) throws SQLException;

	List<ShopVO> getShopList() throws SQLException;
	
	List<Map<String, Object>> selectShopList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectShopListCount(SearchCriteria cri) throws SQLException;

	void insertShop(ShopVO shopVO) throws SQLException;

	Map<String, Object> selectDetail(String s_no) throws SQLException;

	void deleteShop(ShopVO shopVO) throws SQLException;

	void modifyShop(ShopVO shopVO) throws SQLException;


	
}
