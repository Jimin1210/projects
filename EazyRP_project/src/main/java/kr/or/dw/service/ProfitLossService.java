package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.command.SearchCriteria2;
import kr.or.dw.vo.ProfitLossVO;
import kr.or.dw.vo.Tr_historyVO;



public interface ProfitLossService {

	Map<String, Object> getHistorys(String c_no, SearchCriteria cri, SearchCriteria2 cri2) throws SQLException;

	void insertProfitLoss(List<Map<String, Object>> list) throws SQLException;

	Map<String, Object> getDayHistorys(String c_no, SearchCriteria cri, SearchCriteria2 cri2) throws SQLException;

	Map<String, Object> getMonthHistorys(String c_no, SearchCriteria cri, SearchCriteria2 cri2) throws SQLException;

	List<Tr_historyVO> getDetail(String month) throws SQLException;

	
}
