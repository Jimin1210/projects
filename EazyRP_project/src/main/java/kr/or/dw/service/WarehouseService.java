package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.WareHouseVO;

public interface WarehouseService {

	Map<String, Object> selectWarehouseList(SearchCriteria cri, String c_no) throws SQLException;

	Map<String, Object> selectWarehouseDetail(String wh_no) throws SQLException;

	List<CompanyVO> getCompany(Map<String, String> dataMap) throws SQLException;

	List<CompanyVO> getCompanyList() throws SQLException;

	void modifyWarehouse(WareHouseVO warehouse) throws SQLException;

	void registWarehouse(WareHouseVO warehouse) throws SQLException;

	void deleteWarehouse(WareHouseVO warehouse) throws SQLException;



}
