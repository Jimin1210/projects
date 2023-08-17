package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;
import kr.or.dw.vo.WareHouseVO;

@Mapper
public interface ItemDAO {

	List<Map<String, Object>> selectItemList(Map<String, Object> map, RowBounds rowBounds) throws SQLException;

	int selectItemListCount(Map<String, Object> map) throws SQLException;

	List<Map<String, Object>> selectFindSearchWarehouseList(Map<String, String> dataMap) throws SQLException;

	List<Map<String, Object>> selectFindWarehouseList() throws SQLException;

	List<Map<String, Object>> selectFindSearchSpriceList(Map<String, String> dataMap) throws SQLException;

	List<Map<String, Object>> selectFindSpriceList() throws SQLException;

	void insertItem(ProductVO product) throws SQLException;

	Map<String, Object> selectProductDetail(String pr_no) throws SQLException;

	void updateProduct(ProductVO product) throws SQLException;

	void deleteProduct(ProductVO product) throws SQLException;

	
	
	
}
