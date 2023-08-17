package kr.or.dw.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DeductionVO;
import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.ExtrapayVO;
import kr.or.dw.vo.SalDetailVO;
import kr.or.dw.vo.SalVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;
import kr.or.dw.vo.WorkVO;

public interface EmpSalService {
	
	// 사원
	
	Map<String, Object> selectEmpList(SearchCriteria cri, String c_no) throws SQLException;

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
	
	// 수당

	Map<String, Object> selectExtrapayList(SearchCriteria cri) throws SQLException;

	void insertExtrapay(ExtrapayVO exVO) throws SQLException;

	Map<String, Object> selectExpayDetail(String ep_no) throws SQLException;

	void modifyExtrapay(ExtrapayVO exVO) throws SQLException;

	void deleteExtrapay(ExtrapayVO exVO) throws SQLException;
	
	// 공제

	Map<String, Object> selectDeductionList(SearchCriteria cri) throws SQLException;

	void insertDeduction(DeductionVO dedVO) throws SQLException;

	Map<String, Object> selectDeductionDetail(String ded_no) throws SQLException;

	void modifyDeduction(DeductionVO dedVO) throws SQLException;

	void deleteDeduction(String ded_no) throws SQLException;
	
	// 부서

	Map<String, Object> selectdeptList(SearchCriteria cri) throws SQLException;

	void insertDept(DeptVO deptVO) throws SQLException;

	Map<String, Object> selectDeptDetail(String dept_no) throws SQLException;

	void modifyDept(DeptVO deptVO) throws SQLException;

	void deleteDept(String dept_no) throws SQLException;
	
	// 근태

	Map<String, Object> selectworkList(SearchCriteria cri, String c_no) throws SQLException;

	void insertWork(WorkVO workVO) throws SQLException;

	Map<String, Object> selectWorkDetail(int w_no) throws SQLException;

	void modifyWork(WorkVO workVO) throws SQLException;

	void deleteWork(int w_no) throws SQLException;

	List<ExtrapayVO> getExtrapay(Map<String, String> dataMap) throws SQLException;

	List<ExtrapayVO> getExtrapayList() throws SQLException;

	List<Map<String, Object>> selectExtraPay(int emp_no, String salmonth, int e_sal) throws SQLException;
	
	// 급여
	
	String insertSal(SalVO salVO) throws SQLException;

	void insertSalDetail(SalDetailVO salDetail) throws SQLException;

	Map<String, Object> selectSalList(SearchCriteria cri) throws SQLException, ParseException;

	Map<String, Object> selectSalDetail(String sal_no) throws SQLException;

	void deleteSal(String sal_no_a) throws SQLException;

	List<Map<String, Object>> allEmpList(String c_no, String salmonth) throws SQLException;

	void tr(Map<String, Object> map) throws SQLException;



}
