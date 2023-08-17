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
import kr.or.dw.dao.DeptDAO;
import kr.or.dw.dao.ItemDAO;
import kr.or.dw.dao.WarehouseDAO;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.WareHouseVO;



@Service
public class DeptServiceImpl implements DeptService{
	
	@Autowired
	private DeptDAO deptDAO;

	@Override
	public Map<String, Object> selectDeptList(SearchCriteria cri) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<Map<String, Object>> deptList = deptDAO.selectDeptList(cri, rowBounds);
		int totalCount = deptDAO.selectDeptListCount(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("deptList", deptList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public void registDept(DeptVO dept) throws SQLException {
		deptDAO.insertDept(dept);
		
	}

	@Override
	public DeptVO selectDeptDetail(String dept_no) throws SQLException {
		DeptVO dept = deptDAO.selectDeptDetail(dept_no);
		return dept;
	}

	@Override
	public void modifyDept(DeptVO dept) throws SQLException {
		deptDAO.updateDept(dept);
		
	}

	@Override
	public void deleteDept(String dept_no) throws SQLException {
		deptDAO.deleteDept(dept_no);
		
	}

	
}
