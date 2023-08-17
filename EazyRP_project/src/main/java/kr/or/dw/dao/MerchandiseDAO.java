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
public interface MerchandiseDAO {

	List<Map<String, Object>> selectMerchandiseList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectMerchandiseListCount(SearchCriteria cri) throws SQLException;

	void insertMerchandise(MerchandiseVO mchVO) throws SQLException;

	Map<String, Object> selectDetail(String sp_no) throws SQLException;

	void modifyMerchandise(MerchandiseVO mchVO) throws SQLException;

	void deleteMerchandise(MerchandiseVO mchVO) throws SQLException;

	void deleteShopMerchandise(ShopVO shopVO) throws SQLException;

	List<Map<String, Object>> getMerchandise(Map<String, String> dataMap) throws SQLException;

	List<Map<String, Object>> getMerchandiseList() throws SQLException;

	
}
