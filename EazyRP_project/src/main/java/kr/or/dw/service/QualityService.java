package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.QualityVO;

public interface QualityService {
	
	// 품질관리 리스트를 불러옴 검색기능
	Map<String, Object> selectQualityList(SearchCriteria cri, String c_no) throws SQLException;
	
	// 품질 디테일
	Map<String, Object> selectQcDetail(int qc_no) throws SQLException;
	
	// 세션에저장된 empno
	String ename(int empno) throws SQLException;
	
	// 품질 등록
	void insertQc(List<QualityVO> qualityVO) throws SQLException;
	// 품질 수정
	void modifyQc(List<QualityVO> modify, String empno) throws SQLException;
	
	// 파일다운
	QualityVO qcFileDown(int qc_no) throws SQLException;
	
	// 품질 삭제
	void qcRemove(int qc_no) throws SQLException;
	
}
