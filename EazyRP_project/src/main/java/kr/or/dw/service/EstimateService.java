package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.EstimateVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.WareHouseVO;

public interface EstimateService {
	
	// 견적서 메인 리스트
	Map<String, Object> selectEstimList(SearchCriteria cri) throws SQLException;
	
	// 견적서 디테일
	Map<String, Object> selectDetail(String est_no) throws SQLException;
	
	// 견적서 등록
	void estimateInsert(EstimateVO vo) throws SQLException;

	// 제품 찾기
	List<ProductVO> getProduct(Map<String, String> map) throws SQLException;
	
	// 제품찾기 리스트
	List<ProductVO> getProductList() throws SQLException;
	
	// 창고 찾기 
	List<WareHouseVO> getWareHouse(Map<String, String> dataMap) throws SQLException;
	
	// 창고 리스트
	List<WareHouseVO> getWareHouseList() throws SQLException;
	
	// 세션 empno 
	String ename(int empno) throws SQLException;
	
	// 견적서 등록
	void insertEstimate(List<EstimateVO> vo) throws SQLException;
	
	// 파일
	String selectFile(String files) throws SQLException;
	
	// 견적서 수정
	void modifyEstimate(List<EstimateVO> modify ,String empno) throws SQLException;
	
	// 견적서 삭제
	void deleteEstimate(String est_no) throws SQLException;
	
	// 이름으로 파일 다운
	EstimateVO selectEst(String est_no) throws SQLException;

	
	
	

}
