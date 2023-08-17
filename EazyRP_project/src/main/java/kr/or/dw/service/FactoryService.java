package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.FactoryVO;

public interface FactoryService {

	Map<String, Object> selectFactoryList(SearchCriteria cri) throws SQLException;

}
