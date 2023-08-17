package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.FactoryVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;
import kr.or.dw.vo.WareHouseVO;

@Mapper
public interface BasicFactoryDAO {

	List<Map<String, Object>> selectFactoryList(Map<String, Object> map, RowBounds rowBounds) throws SQLException;

	int selectFactoryListCount(Map<String, Object> map) throws SQLException;

	List<ProcessVO> selectFindSearchProcess(Map<String, String> dataMap) throws SQLException;

	List<ProcessVO> selectFindProcessList() throws SQLException;

	void insertFactory(FactoryVO factory) throws SQLException;

	Map<String, Object> selectFactoryDetail(String fac_no) throws SQLException;

	void updateFactory(FactoryVO factory) throws SQLException;

	void deleteFactory(String fac_no) throws SQLException;

	
	
}
