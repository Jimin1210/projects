package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.SiVO;


//출하 지시서
public interface SiService {
	
	// 출하지시서 리스트 조회
	Map<String, Object> selectSiList(SearchCriteria cri) throws SQLException;
	
	// 디테일 조회
	Map<String, Object> selectSiDetail(String si_no) throws SQLException;
	
	// 세션에 등록된 사원이름
	String ename(int empno) throws SQLException;
	
	// 출하지시서 등록
	void insertSi(List<SiVO> siVO) throws SQLException;
	
	// 출하지시서 수정
	void modifySi(List<SiVO> modify, String empno) throws SQLException;
	
	// 삭제
	void siRemove(String si_no) throws SQLException;
	
	
}
