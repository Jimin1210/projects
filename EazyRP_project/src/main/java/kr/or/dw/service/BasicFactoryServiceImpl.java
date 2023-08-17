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
import kr.or.dw.dao.BasicFactoryDAO;
import kr.or.dw.dao.ContactDAO;
import kr.or.dw.dao.WarehouseDAO;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.FactoryVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.WareHouseVO;



@Service
public class BasicFactoryServiceImpl implements BasicFactoryService {
	
	@Autowired
	private BasicFactoryDAO basicFactoryDAO;

	@Override
	public Map<String, Object> selectFactoryList(SearchCriteria cri, String c_no) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cri", cri);
		map.put("c_no", c_no);		
		List<Map<String, Object>> factoryList = basicFactoryDAO.selectFactoryList(map, rowBounds);
		int totalCount = basicFactoryDAO.selectFactoryListCount(map);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("factoryList", factoryList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
		
	}

	@Override
	public List<ProcessVO> getProcess(Map<String, String> dataMap) throws SQLException {
		List<ProcessVO> processList = basicFactoryDAO.selectFindSearchProcess(dataMap);
		return processList;
	}

	@Override
	public List<ProcessVO> getProcessList() throws SQLException {
		List<ProcessVO> processList = basicFactoryDAO.selectFindProcessList();
		return processList;
	}

	@Override
	public void registFactory(FactoryVO factory) throws SQLException {
		basicFactoryDAO.insertFactory(factory);
		
	}

	@Override
	public Map<String, Object> selectFactoryDetail(String fac_no) throws SQLException {
		Map<String, Object> factory = basicFactoryDAO.selectFactoryDetail(fac_no);
		return factory;
	}

	@Override
	public void modifyFactory(FactoryVO factory) throws SQLException {
		basicFactoryDAO.updateFactory(factory);
		
	}

	@Override
	public void deleteFactory(String fac_no) throws SQLException {
		basicFactoryDAO.deleteFactory(fac_no);
		
	}

	
}
