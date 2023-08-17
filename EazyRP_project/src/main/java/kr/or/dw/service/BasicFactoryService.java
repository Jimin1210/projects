package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.FactoryVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.WareHouseVO;

public interface BasicFactoryService {

	Map<String, Object> selectFactoryList(SearchCriteria cri, String c_no) throws SQLException;

	List<ProcessVO> getProcess(Map<String, String> dataMap) throws SQLException;

	List<ProcessVO> getProcessList() throws SQLException;

	void registFactory(FactoryVO factory) throws SQLException;

	Map<String, Object> selectFactoryDetail(String fac_no) throws SQLException;

	void modifyFactory(FactoryVO factory) throws SQLException;

	void deleteFactory(String fac_no) throws SQLException;



}
