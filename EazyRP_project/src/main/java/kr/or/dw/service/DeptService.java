package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.tomcat.jdbc.pool.interceptor.SlowQueryReport;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.WareHouseVO;

public interface DeptService {

	Map<String, Object> selectDeptList(SearchCriteria cri) throws SQLException;

	void registDept(DeptVO dept) throws SQLException;

	DeptVO selectDeptDetail(String dept_no) throws SQLException;

	void modifyDept(DeptVO dept) throws SQLException;

	void deleteDept(String dept_no) throws SQLException;


}
