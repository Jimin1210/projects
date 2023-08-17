package kr.or.dw.service;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.ContactDAO;
import kr.or.dw.dao.WarehouseDAO;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.WareHouseVO;



@Service
public class WarehouseServiceImpl implements WarehouseService {
	
	@Autowired
	private WarehouseDAO warehouseDAO;

	@Override
	public Map<String, Object> selectWarehouseList(SearchCriteria cri, String c_no) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<Map<String, Object>> warehouseList = warehouseDAO.selectWarehouseList(cri, rowBounds, c_no);
		int totalCount = warehouseDAO.selectWarehouseListCount(cri, c_no);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("warehouseList", warehouseList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
		
	}

	@Override
	public Map<String, Object> selectWarehouseDetail(String wh_no) throws SQLException {
		
		Map<String, Object> warehouse = warehouseDAO.selectWarehouseDetail(wh_no);
		
		return warehouse;
	}

	@Override
	public List<CompanyVO> getCompany(Map<String, String> dataMap) throws SQLException {
		List<CompanyVO> company = warehouseDAO.selectFindSearchCompany(dataMap);
		return company;
	}

	@Override
	public List<CompanyVO> getCompanyList() throws SQLException {
		List<CompanyVO> company = warehouseDAO.selectFindCompanyList();
		return company;
	}

	@Override
	public void modifyWarehouse(WareHouseVO warehouse) throws SQLException {
		warehouseDAO.updateWarehouse(warehouse);
		
	}

	@Override
	public void registWarehouse(WareHouseVO warehouse) throws SQLException {
		warehouseDAO.insertWarehouse(warehouse);
		
	}

	@Override
	public void deleteWarehouse(WareHouseVO warehouse) throws SQLException {
		warehouseDAO.deleteWarehouse(warehouse);
		
	}


	

	
	
}
