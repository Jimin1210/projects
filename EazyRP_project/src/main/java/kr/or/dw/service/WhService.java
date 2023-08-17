package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.WhVO;

public interface WhService {
	
	Map<String, Object> selectWhList(Map<String, Object> map) throws SQLException;

	void registWh(List<WhVO> whDetailVoList) throws SQLException;

	Map<String, Object> selectWh(String wh_no) throws SQLException;

	void modifyWh(List<WhVO> whList) throws SQLException;

	void whRemove(String whNo) throws SQLException;

}
