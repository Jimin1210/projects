package kr.or.dw.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.EmpSalDAO;
import kr.or.dw.dao.MerchandiseDAO;
import kr.or.dw.dao.ShopDAO;
import kr.or.dw.dao.SiDAO;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DeductionVO;
import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.ExtrapayVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.SalDetailVO;
import kr.or.dw.vo.SalVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;
import kr.or.dw.vo.WorkVO;


@Service
public class EmpSalServiceImpl implements EmpSalService {

	@Autowired
	private EmpSalDAO empsalDAO;
	
	// EMP
	
	@Override
	public Map<String, Object> selectEmpList(SearchCriteria cri, String c_no) throws SQLException {

		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);	// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.

		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		List<Map<String, Object>> empList = empsalDAO.selectEmpList(cri, rowBounds, c_no);
		// 전체 board 개수
		int totalCount = empsalDAO.selectEmpListCount(cri, c_no);

		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("empList", empList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public Map<String, Object> selectEmpDetail(int emp_no) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		Map<String, Object> emp = (Map<String, Object>) empsalDAO.selectEmpDetail(emp_no);
		
		dataMap.put("emp", emp);
		return dataMap;
	}

	@Override
	public List<CompanyVO> getCompany(Map<String, String> dataMap) throws SQLException {
		
		List<CompanyVO> company = null;
		company = empsalDAO.getCompany(dataMap);
		
		return company;
	}

	@Override
	public List<CompanyVO> getCompanyList() throws SQLException {
		
		List<CompanyVO> company = null;
		company = empsalDAO.getCompanyList();
		
		return company;
	}

	@Override
	public List<DeptVO> getDept(Map<String, String> dataMap) throws SQLException {
		
		List<DeptVO> dept = null;
		dept = empsalDAO.getDept(dataMap);
		
		return dept;
	}

	@Override
	public List<DeptVO> getDeptList() throws SQLException {
		
		List<DeptVO> dept = null;
		dept = empsalDAO.getDeptList();
		
		return dept;
	}
	
	@Override
	public void insertEmp(EmpVO empVO) throws SQLException {
		
		empsalDAO.insertEmp(empVO);
		
	}

	@Override
	public List<EmpVO> getEmp(Map<String, String> dataMap) throws SQLException {
		
		List<EmpVO> emp = null;
		emp = empsalDAO.getEmp(dataMap);
		
		return emp;
	}

	@Override
	public List<EmpVO> getEmpList(String c_no) throws SQLException {
		
		List<EmpVO> emp = null;
		emp = empsalDAO.getEmpList(c_no);
		
		return emp;
	}

	@Override
	public void modifyEmp(EmpVO empVO) throws SQLException {
		
		empsalDAO.modifyEmp(empVO);
		
	}

	@Override
	public void deleteEmp(EmpVO empVO) throws SQLException {
		
		empsalDAO.deleteEmp(empVO);
		
	}
	
	// EXTRAPAY
	
	@Override
	public Map<String, Object> selectExtrapayList(SearchCriteria cri) throws SQLException {
	
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);		// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.

		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		List<Map<String, Object>> extrapayList = empsalDAO.selectExtrapayList(cri, rowBounds);
		// 전체 board 개수
		int totalCount = empsalDAO.selectExtrapayListCount(cri);

		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("extrapayList", extrapayList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public void insertExtrapay(ExtrapayVO exVO) throws SQLException {

		empsalDAO.insertExtrapay(exVO);
		
	}
	
	// DEDUCTION
	
	@Override
	public Map<String, Object> selectExpayDetail(String ep_no) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		Map<String, Object> expay = (Map<String, Object>) empsalDAO.selectExpayDetail(ep_no);
		
		dataMap.put("expay", expay);
		return dataMap;
	}

	@Override
	public void modifyExtrapay(ExtrapayVO exVO) throws SQLException {

		empsalDAO.modifyExtrapay(exVO);
		
	}
	
	@Override
	public void deleteExtrapay(ExtrapayVO exVO) throws SQLException {
		
		empsalDAO.deleteExtrapay(exVO);
		
	}
	
	// Deduction 

	@Override
	public Map<String, Object> selectDeductionList(SearchCriteria cri) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);		// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.

		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		List<Map<String, Object>> deductionList = empsalDAO.selectDeductionList(cri, rowBounds);
		// 전체 board 개수
		int totalCount = empsalDAO.selectDeductionListCount(cri);

		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("deductionList", deductionList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public void insertDeduction(DeductionVO dedVO) throws SQLException {
		
		empsalDAO.insertDeduction(dedVO);
		
	}

	@Override
	public Map<String, Object> selectDeductionDetail(String ded_no) throws SQLException {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		Map<String, Object> deduction = (Map<String, Object>) empsalDAO.selectDeductionDetail(ded_no);
		
		dataMap.put("deduction", deduction);
		return dataMap;
	}

	@Override
	public void modifyDeduction(DeductionVO dedVO) throws SQLException {

		empsalDAO.modifyDeduction(dedVO);
		
	}

	@Override
	public void deleteDeduction(String ded_no) throws SQLException {

		empsalDAO.deleteDeduction(ded_no);
		
	}
	
	// DEPT

	@Override
	public Map<String, Object> selectdeptList(SearchCriteria cri) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);		// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.

		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		List<Map<String, Object>> deptList = empsalDAO.selectDeptList(cri, rowBounds);
		// 전체 board 개수
		int totalCount = empsalDAO.selectDeptListCount(cri);

		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("deptList", deptList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public void insertDept(DeptVO deptVO) throws SQLException {
		
		empsalDAO.insertDept(deptVO);
		
	}

	@Override
	public Map<String, Object> selectDeptDetail(String dept_no) throws SQLException {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		Map<String, Object> dept = (Map<String, Object>) empsalDAO.selectDeptDetail(dept_no);
		
		dataMap.put("dept", dept);
		return dataMap;
	}

	@Override
	public void modifyDept(DeptVO deptVO) throws SQLException {

		empsalDAO.modifyDept(deptVO);
		
	}

	@Override
	public void deleteDept(String dept_no) throws SQLException {
		
		empsalDAO.deleteDept(dept_no);
		
	}

	// WORK
	
	@Override
	public Map<String, Object> selectworkList(SearchCriteria cri, String c_no) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);		// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.

		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		List<Map<String, Object>> workList = empsalDAO.selectWorkList(cri, rowBounds, c_no);
		// 전체 board 개수
		int totalCount = empsalDAO.selectWorkListCount(cri, c_no);
		
		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("workList", workList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public void insertWork(WorkVO workVO) throws SQLException {
		
		empsalDAO.insertWork(workVO);
		
	}

	@Override
	public Map<String, Object> selectWorkDetail(int w_no) throws SQLException {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		Map<String, Object> work = (Map<String, Object>) empsalDAO.selectWorkDetail(w_no);
		
		dataMap.put("work", work);
		return dataMap;
	}

	@Override
	public void modifyWork(WorkVO workVO) throws SQLException {
		
		empsalDAO.modifyWork(workVO);
		
	}

	@Override
	public void deleteWork(int w_no) throws SQLException {
		
		empsalDAO.deleteWork(w_no);
		
	}

	@Override
	public List<ExtrapayVO> getExtrapay(Map<String, String> dataMap) throws SQLException {

		List<ExtrapayVO> exp = null;
		exp = empsalDAO.getExtrapay(dataMap);
		
		return exp;
	}

	@Override
	public List<ExtrapayVO> getExtrapayList() throws SQLException {

		List<ExtrapayVO> exp = null;
		exp = empsalDAO.getExtrapayList();
		
		return exp;
	}

	@Override
	public List<Map<String, Object>> selectExtraPay(int emp_no, String salmonth, int e_sal) throws SQLException {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("emp_no", emp_no);
		map.put("salmonth", salmonth);
		List<Map<String, Object>> calextrapayList = empsalDAO.selectExtraPay(map);
		
		Double hourSal = Double.parseDouble(e_sal + "") / 365 / 24;
		
		List<Map<String, Object>> extrapayList = new ArrayList<Map<String, Object>>();
		for(Map<String, Object> calextrapay : calextrapayList) {
			System.out.println("아워샐  " + Math.ceil(hourSal));
			
			Double EXTRAPAY = Double.parseDouble(calextrapay.get("WTIME").toString()) * Double.parseDouble(calextrapay.get("CALC").toString()) * Math.ceil(hourSal);
			calextrapay.put("EXTRAPAY", EXTRAPAY);
			extrapayList.add(calextrapay);
		}
		
		return extrapayList;
	}
	
	// Sal
	
	@Override
	public String insertSal(SalVO salVO) throws SQLException {
		empsalDAO.insertSal(salVO);
		
		String sal_no = salVO.getSal_no();
		return sal_no;
	}

	@Override
	public void insertSalDetail(SalDetailVO saldetailVO) throws SQLException {
		empsalDAO.insertSalDetail(saldetailVO);
	}

	@Override
	public Map<String, Object> selectSalList(SearchCriteria cri) throws SQLException, ParseException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);		// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.

		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		List<Map<String, Object>> salList = empsalDAO.selectSalList(cri, rowBounds);
		// 전체 board 개수
		int totalCount = empsalDAO.selectSalListCount(cri);
		
		for(Map<String, Object> sal : salList) {
			String saldate = sal.get("SALDATE").toString();
			String todayfm = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
			SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date formatDate = dtFormat.parse(saldate);
			Date formattoday = dtFormat.parse(todayfm);
			int compare = formatDate.compareTo(formattoday); 
			if(compare <= 0) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("saldate", formatDate);
				map.put("sal_no", sal.get("SAL_NO"));
				map.put("paymentstatus", sal.get("PAYMENTSTATUS"));
				empsalDAO.updateStatus(map);
				sal.put("PAYMENTSTATUS", map.get("paymentstatus"));
			}
			
		}
		
		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("salList", salList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public Map<String, Object> selectSalDetail(String sal_no) throws SQLException {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		Map<String, Object> sal = empsalDAO.selectSalDetail(sal_no);
		List<Map<String, Object>> saldetail = empsalDAO.selectSalDetailDetail(sal_no);
		
		List<List<Map<String, Object>>> CalcExtrapayList = new ArrayList<List<Map<String, Object>>>();
		String salmonth = sal.get("SALMONTH").toString().substring(0, 7);

		for (Map<String, Object> detail : saldetail) {
			int emp_no = Integer.parseInt(detail.get("EMP_NO").toString());
			int e_sal = Integer.parseInt(detail.get("E_SAL").toString());
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("emp_no", emp_no);
			map.put("salmonth", salmonth);
			List<Map<String, Object>> calextrapayList = empsalDAO.selectExtraPay(map);
			
			Double hourSal = Double.parseDouble(e_sal + "") / 365 / 24;
			int monthSal = e_sal / 12;
			detail.put("E_SAL", monthSal);
			for(Map<String, Object> calextrapay : calextrapayList) {
				System.out.println("아워샐  " + Math.ceil(hourSal));
				
				int EXTRAPAY = (int)(Double.parseDouble(calextrapay.get("WTIME").toString()) * Double.parseDouble(calextrapay.get("CALC").toString()) * Math.ceil(hourSal));
				
				calextrapay.put("EXTRAPAY", EXTRAPAY);
			}
			CalcExtrapayList.add(calextrapayList);
		}
		
		dataMap.put("sal", sal);
		dataMap.put("CalcExtrapayList", CalcExtrapayList);
		dataMap.put("saldetail", saldetail);
		
		return dataMap;
	}

	@Override
	public void deleteSal(String sal_no_a) throws SQLException {

		empsalDAO.deleteSal(sal_no_a);
	
	}

	@Override
	public List<Map<String, Object>> allEmpList(String c_no, String salmonth) throws SQLException {
		
		List<Map<String, Object>> empList = empsalDAO.allEmpList(c_no);
		
		for(Map<String, Object> emp : empList) {
			int emp_no = Integer.parseInt(emp.get("EMP_NO").toString());
			int e_sal = Integer.parseInt(emp.get("E_SAL").toString());
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("emp_no", emp_no);
			map.put("e_sal", e_sal);
			map.put("salmonth", salmonth);
			List<Map<String, Object>> calextrapayList = empsalDAO.selectExtraPay(map);
			
			Double hourSal = Double.parseDouble(e_sal + "") / 365 / 24;
			
			List<Map<String, Object>> extrapayList = new ArrayList<Map<String, Object>>();
			for(Map<String, Object> calextrapay : calextrapayList) {
				System.out.println("아워샐  " + Math.ceil(hourSal));
				
				Double EXTRAPAY = Double.parseDouble(calextrapay.get("WTIME").toString()) * Double.parseDouble(calextrapay.get("CALC").toString()) * Math.ceil(hourSal);
				calextrapay.put("EXTRAPAY", EXTRAPAY);
				extrapayList.add(calextrapay);
			}
			emp.put("extrapayList", extrapayList);
			
		}
		System.out.println("sd jklajf lkasjfdsakljfsdalkdjasjd emp : " + empList.get(0).get("extrapayList"));
		
		return empList;
	}

	@Override
	public void tr(Map<String, Object> map) throws SQLException {
		String sal_no = empsalDAO.getSal_no();
		map.put("sal_no", sal_no);
		empsalDAO.tr(map);
	}
	
}
