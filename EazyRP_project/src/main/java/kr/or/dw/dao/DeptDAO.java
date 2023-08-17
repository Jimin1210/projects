package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;
import kr.or.dw.vo.WareHouseVO;

@Mapper
public interface DeptDAO {

	List<Map<String, Object>> selectDeptList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectDeptListCount(SearchCriteria cri) throws SQLException;

	void insertDept(DeptVO dept) throws SQLException;

	DeptVO selectDeptDetail(String dept_no) throws SQLException;

	void updateDept(DeptVO dept) throws SQLException;

	void deleteDept(String dept_no) throws SQLException;

	
}
