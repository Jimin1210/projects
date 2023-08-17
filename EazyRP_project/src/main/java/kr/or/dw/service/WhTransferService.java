package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.WhTransferVO;

public interface WhTransferService {

	Map<String, Object> selectWhTransferList(Map<String, Object> map) throws SQLException;

	// 보내는 창고의 재고를 조회한다.
	Map<String, Object> whtSelectWareHouse(Map<String, Object> map) throws SQLException;

	void registWhTransfer(List<WhTransferVO> whtList) throws SQLException;

	Map<String, Object> selectWhTransfer(String wt_no) throws SQLException;
	
}
