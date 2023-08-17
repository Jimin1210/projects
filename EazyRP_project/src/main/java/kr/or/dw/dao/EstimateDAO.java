package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.EstimateVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.WareHouseVO;

@Mapper
public interface EstimateDAO {

	List<Map<String, Object>> selectEstimList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	Map<String, Object> selectDetail(String est_no) throws SQLException;

	void estimateInsert(EstimateVO vo) throws SQLException;

	List<Map<String, Object>> forEstimList(String est_no) throws SQLException;
	
	List<ProductVO> getProduct(Map<String, String> map) throws SQLException;

	List<ProductVO> getProductList() throws SQLException;

	List<WareHouseVO> getWareHouse(Map<String, String> dataMap) throws SQLException;

	List<WareHouseVO> getWareHouseList() throws SQLException;

	String ename(int empno) throws SQLException;

	void insertEstimateDetail(EstimateVO est) throws SQLException;

	void insertEstimate(EstimateVO estimateVO) throws SQLException;

	int selectSearchEstimateListCount(SearchCriteria cri) throws SQLException;

	String selectFile(String files) throws SQLException;

	void modifyEstimateDetail(EstimateVO est) throws SQLException;

	void modifyEstimate(Map<String, String> modifyMap) throws SQLException;

	void deleteEstimate(String est_no) throws SQLException;
	
	// 견적서 디테일 삭제
	void deleteEstimateDetail(EstimateVO est) throws SQLException;
	
	// 견적서에있는 enabled를  N으로 바꿔놈
	void deletUpdateEstimate(String est_no) throws SQLException;

	EstimateVO selectEst(String est_no) throws SQLException;

	String deleteFile(String est_no) throws SQLException;
	
}
