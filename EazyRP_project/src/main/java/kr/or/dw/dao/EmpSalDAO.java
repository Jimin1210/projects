package kr.or.dw.dao;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DeductionVO;
import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.ExtrapayVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.SalDetailVO;
import kr.or.dw.vo.SalVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;
import kr.or.dw.vo.WorkVO;

@Mapper
public interface EmpSalDAO {

	// EMP	
	
	List<Map<String, Object>> selectEmpList(@Param("cri") SearchCriteria cri, RowBounds rowBounds, @Param("c_no") String c_no) throws SQLException;

	int selectEmpListCount(@Param("cri") SearchCriteria cri, @Param("c_no") String c_no) throws SQLException;

	Map<String, Object> selectEmpDetail(int emp_no) throws SQLException;

	List<CompanyVO> getCompany(Map<String, String> dataMap) throws SQLException;

	List<CompanyVO> getCompanyList() throws SQLException;

	List<DeptVO> getDept(Map<String, String> dataMap) throws SQLException;

	List<DeptVO> getDeptList() throws SQLException;

	void insertEmp(EmpVO empVO) throws SQLException;

	List<EmpVO> getEmp(Map<String, String> dataMap) throws SQLException;

	List<EmpVO> getEmpList(String c_no) throws SQLException;

	void modifyEmp(EmpVO empVO) throws SQLException;

	void deleteEmp(EmpVO empVO) throws SQLException;
	
	// EXTRAPAY

	List<Map<String, Object>> selectExtrapayList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectExtrapayListCount(SearchCriteria cri) throws SQLException;

	void insertExtrapay(ExtrapayVO exVO) throws SQLException;

	Map<String, Object> selectExpayDetail(String ep_no) throws SQLException;

	void modifyExtrapay(ExtrapayVO exVO) throws SQLException;

	void deleteExtrapay(ExtrapayVO exVO) throws SQLException;
	
	// DEDUCTION

	List<Map<String, Object>> selectDeductionList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectDeductionListCount(SearchCriteria cri) throws SQLException;

	void insertDeduction(DeductionVO dedVO) throws SQLException;

	Map<String, Object> selectDeductionDetail(String ded_no) throws SQLException;

	void modifyDeduction(DeductionVO dedVO) throws SQLException;

	void deleteDeduction(String ded_no) throws SQLException;
	
	// DEPT

	List<Map<String, Object>> selectDeptList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectDeptListCount(SearchCriteria cri) throws SQLException;

	void insertDept(DeptVO deptVO) throws SQLException;

	Map<String, Object> selectDeptDetail(String dept_no) throws SQLException;

	void modifyDept(DeptVO deptVO) throws SQLException;

	void deleteDept(String dept_no) throws SQLException;
	
	// WORK

	List<Map<String, Object>> selectWorkList(@Param("cri") SearchCriteria cri, RowBounds rowBounds, @Param("c_no") String c_no) throws SQLException;

	int selectWorkListCount(@Param("cri") SearchCriteria cri,@Param("c_no") String c_no) throws SQLException;

	void insertWork(WorkVO workVO) throws SQLException;

	Map<String, Object> selectWorkDetail(int w_no) throws SQLException;

	void modifyWork(WorkVO workVO) throws SQLException;

	void deleteWork(int w_no) throws SQLException;

	List<ExtrapayVO> getExtrapay(Map<String, String> dataMap) throws SQLException;

	List<ExtrapayVO> getExtrapayList() throws SQLException;

	List<Map<String, Object>> selectExtraPay(Map<String, Object> map) throws SQLException;

	void insertSal(SalVO salVO) throws SQLException;

	void insertSalDetail(SalDetailVO saldetailVO) throws SQLException;

	List<Map<String, Object>> selectSalList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectSalListCount(SearchCriteria cri) throws SQLException;

	Map<String, Object> selectSalDetail(String sal_no) throws SQLException;

	List<Map<String, Object>> selectSalDetailDetail(String sal_no) throws SQLException;

	void deleteSal(String sal_no_a) throws SQLException;

	void updateStatus(Map<String, Object> map) throws SQLException, ParseException;

	List<Map<String, Object>> allEmpList(String c_no) throws SQLException;

	void tr(Map<String, Object> map) throws SQLException;

	String getSal_no() throws SQLException;

}
