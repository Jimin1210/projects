package kr.or.dw.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.multimap.HashSetValuedHashMap;
import org.apache.commons.io.IOUtils;
import org.apache.tiles.autotag.core.runtime.annotation.Parameter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.service.EmpSalService;
import kr.or.dw.service.ManagementService;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.MerchandiseService;
import kr.or.dw.service.OrderService;
import kr.or.dw.service.ProcessService;
import kr.or.dw.service.ProductService;
import kr.or.dw.service.ShopService;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DeductionVO;
import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.EstimateVO;
import kr.or.dw.vo.ExtrapayVO;
import kr.or.dw.vo.MemberVO;
import kr.or.dw.vo.MenuVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.MyMenuVO;
import kr.or.dw.vo.NoteVO;
import kr.or.dw.vo.OrderVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.SalDetailVO;
import kr.or.dw.vo.SalVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.WorkVO;

@Controller
@RequestMapping("/management")
public class MinjunController2 {
	
	private static final Logger logger = LoggerFactory.getLogger(MinjunController2.class);
	
	@Autowired
	private MenuService menuService;

	@Autowired
	private EmpSalService empsalService;
	
	@Autowired
	private ManagementService managementService;
	
	// EMP(직원) CRUD -----------------------------------------------------------------------------------------
	
	@RequestMapping("/emp")
	public ModelAndView empMain(String mymenu, String murl, ModelAndView mnv, String mcode, EmpVO empVO, SearchCriteria cri, HttpSession session) throws SQLException {
		String url = "";
    	if(mymenu == null) {
			url="/minjun2/emp.page";
		} else {
			url="/minjun2/emp.mymenu";
		}
		System.out.println("emp session c_no : " + session.getAttribute("c_no").toString());
		String c_no = session.getAttribute("c_no").toString();
		Map<String, Object> dataMap = empsalService.selectEmpList(cri, c_no);
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/empDetail")
	public ModelAndView empDetail(ModelAndView mnv ,int emp_no) throws SQLException {
		
		Map<String, Object> dataMap = empsalService.selectEmpDetail(emp_no);
		
		String url = "minjun2/emp_detail.open";
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/empRegistForm")
	public ModelAndView shopRegistForm(ModelAndView mnv, HttpSession session) {
		String url = "minjun2/emp_regist";
		String c_no = session.getAttribute("c_no").toString();
		
		mnv.addObject("c_no", c_no);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/insertEmp")
	public void insertEmp(@RequestParam("files")MultipartFile multi, EmpVO empVO, HttpServletResponse res, HttpSession session) throws Exception {
		
		String fileName = "";
		
		if(!multi.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			
			String uniqueName = uuids[0];
			
			String fileRealName = multi.getOriginalFilename();
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
			String uploadFolder = session.getServletContext().getRealPath("/resources/stamp/");
			
			fileName = uniqueName+fileExtension;
			
			File saveFile = new File(uploadFolder+uniqueName+fileExtension);  // 적용 후
			
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}
			
			try {
				multi.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		String c_no = session.getAttribute("c_no").toString();
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		empVO.setSys_reg(emp_no + "");
		empVO.setSys_up(emp_no + "");
		empVO.setStampimg(fileName);
		empVO.setC_no(c_no);
		empsalService.insertEmp(empVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/modifyEmp.do")
	public void modifyEmp (EmpVO empVO, HttpServletResponse res, HttpSession session, /*Integer emp_no,*/ String oldPicture, String uploadPicture, @RequestParam("files")MultipartFile multi) throws SQLException , Exception {
		
		String fileName = oldPicture;
		
		empVO.setStampimg(fileName);
		System.out.println("asdfnkjasdf");
		if(!(oldPicture.equals(uploadPicture) || uploadPicture.equals("") || uploadPicture == null) ) {	
			if(!multi.isEmpty()) {
				UUID uuid = UUID.randomUUID();
				String[] uuids = uuid.toString().split("-");
				
				String uniqueName = uuids[0];
				
				String fileRealName = multi.getOriginalFilename();
				String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
				String uploadFolder = session.getServletContext().getRealPath("/resources/stamp/");
				
				fileName = uniqueName+fileExtension;
				
				File saveFile = new File(uploadFolder+uniqueName+fileExtension);
				if(!saveFile.exists()) {
					saveFile.mkdirs();
				}
				try {
					multi.transferTo(saveFile);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				if(!oldPicture.equals("")) {
					File oldFile = new File(uploadFolder, oldPicture);
					if(oldFile.exists()) {
						oldFile.delete();
					};
				};
			};
			empVO.setStampimg(fileName);
		} else if (uploadPicture.equals("") || uploadPicture == null) {
			String uploadFolder = "C:\\upload\\EmpStamp\\";
			File oldFile = new File(uploadFolder, oldPicture);
			if(oldFile.exists()) {
				oldFile.delete();
			};
			
			empVO.setStampimg("");
		}
		
		int SSemp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		
//		empVO.setEmp_no(emp_no);
		empVO.setSys_up(SSemp_no + "");
		
		
		empsalService.modifyEmp(empVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteEmp.do")
	public void deleteEmp (EmpVO empVO, HttpServletResponse res, HttpSession session, Integer emp_no) throws SQLException , Exception {
		int SSemp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		empVO.setEmp_no(emp_no);
		empVO.setSys_up(SSemp_no + "");
		System.out.println("modifyEmp emp_no : " + emp_no);
		
		empsalService.deleteEmp(empVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/findCompany")
	public ModelAndView findCompany(ModelAndView mnv, String searchType, String keyword) throws SQLException {
		String url = "minjun2/findCompany";
		
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		
		List<CompanyVO> company = null;
		Map<String, String> dataMap = new HashMap<>();
		
	
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		
		if(keyword != null){
			company = empsalService.getCompany(dataMap);
		} else {
			company = empsalService.getCompanyList();
		}
		
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("company", company);
		
		return mnv;
	}
	
	@RequestMapping("/findDept")
	public ModelAndView findDept(ModelAndView mnv, String searchType, String keyword) throws SQLException {
		String url = "minjun2/findDept";
		
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		
		List<DeptVO> dept = null;
		Map<String, String> dataMap = new HashMap<>();
		
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		
		if(keyword != null){
			dept = empsalService.getDept(dataMap);
		} else {
			dept = empsalService.getDeptList();
		}
		
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("dept", dept);
		
		return mnv;
	}
	
	@RequestMapping("/findEmp")
	public ModelAndView findEmp(ModelAndView mnv, String searchType, String keyword, String c_no, HttpSession session) throws SQLException {
		String url = "minjun2/findEmp";
		
		
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<EmpVO> emp = null;
		Map<String, String> dataMap = new HashMap<>();
		c_no = (String) session.getAttribute("c_no");
		
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		dataMap.put("c_no", c_no);
		if(keyword != null){
			emp = empsalService.getEmp(dataMap);
		} else {
				emp = empsalService.getEmpList(c_no);
		}
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("emp", emp);
		
		return mnv;
	}
	
	@RequestMapping("/findExtrapay")
	public ModelAndView findExtrapay(ModelAndView mnv, String searchType, String keyword, HttpSession session) throws SQLException {
		String url = "minjun2/findExtrapay";
		
		
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<ExtrapayVO> exp = null;
		Map<String, String> dataMap = new HashMap<>();
		
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			
			exp = empsalService.getExtrapay(dataMap);
		} else {
			
			exp = empsalService.getExtrapayList();
		}
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("exp", exp);
		
		return mnv;
	}
	
	@RequestMapping("/getPicture")
	public ResponseEntity<byte[]> getPicture(String picture, HttpSession session) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String imgPath = session.getServletContext().getRealPath("/resources/stamp/");
		
		if (picture != null || picture != "") {
			try {
				in = new FileInputStream(new File(imgPath, picture));
				
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
			}finally {
				in.close();
			}
		}
		
		return entity;
	}
	
	// Extrapay(수당) CRUD -----------------------------------------------------------------------------------------
	
	@RequestMapping("/extrapay")
	public ModelAndView extrapayMain(String mymenu, String murl, ModelAndView mnv, String mcode,SearchCriteria cri, HttpSession session) throws SQLException {
		String url = "";
    	if(mymenu == null) {
			url="/minjun2/extrapay.page";
		} else {
			url="/minjun2/extrapay.mymenu";
		}
		
		Map<String, Object> dataMap = empsalService.selectExtrapayList(cri);
		
		System.out.println("extrapay dataMap : " + dataMap);
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/extrapayRegistForm")
	public String extrapayRegistForm() {
		String url = "minjun2/extrapay_regist";
		return url;
	}
	
	@RequestMapping("/insertExtrapay")
	public void insertExtrapay(ExtrapayVO exVO, HttpServletResponse res, HttpSession session) throws Exception {
		System.out.println("insertExtrapay exVO : " + exVO);
		empsalService.insertExtrapay(exVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/extrapayDetail")
	public ModelAndView extrapayDetail(ModelAndView mnv ,String ep_no) throws SQLException {
		
		Map<String, Object> dataMap = empsalService.selectExpayDetail(ep_no);
		
		String url = "minjun2/extrapay_detail.open";
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/modifyExtrapay.do")
	public void modifyExtrapay (ExtrapayVO exVO, HttpServletResponse res, HttpSession session, String ep_no) throws SQLException , Exception {
		exVO.setEp_no(ep_no);
		
		empsalService.modifyExtrapay(exVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteExtrapay.do")
	public void deleteExtrapay (ExtrapayVO exVO, HttpServletResponse res, HttpSession session, String ep_no) throws SQLException , Exception {
		exVO.setEp_no(ep_no);
		
		empsalService.deleteExtrapay(exVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	// DEDUCTION(공제) CRUD -----------------------------------------------------------------------------------------
	
	@RequestMapping("/deduction")
	public ModelAndView deductionMain(String mymenu, String murl, ModelAndView mnv, String mcode,SearchCriteria cri, HttpSession session) throws SQLException {
		String url = "";
    	if(mymenu == null) {
			url="/minjun2/deduction.page";
		} else {
			url="/minjun2/deduction.mymenu";
		}
		
		Map<String, Object> dataMap = empsalService.selectDeductionList(cri);
		
		System.out.println("deduction dataMap : " + dataMap);
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/deductionRegistForm")
	public String deductionRegistForm() {
		String url = "minjun2/deduction_regist";
		return url;
	}
	
	@RequestMapping("/insertDeduction")
	public void insertDeduction(DeductionVO dedVO, HttpServletResponse res, HttpSession session) throws Exception {
		System.out.println("insertDeduction dedVO : " + dedVO);
		empsalService.insertDeduction(dedVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deductionDetail")
	public ModelAndView deductionDetail(ModelAndView mnv ,String ded_no) throws SQLException {
		
		Map<String, Object> dataMap = empsalService.selectDeductionDetail(ded_no);
		
		String url = "minjun2/deduction_detail.open";
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/modifyDeduction.do")
	public void modifyDeduction (DeductionVO dedVO, HttpServletResponse res, HttpSession session, String ded_no) throws SQLException , Exception {
		dedVO.setDed_no(ded_no);
		
		empsalService.modifyDeduction(dedVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteDeduction.do")
	public void deleteDeduction (DeductionVO dedVO, HttpServletResponse res, HttpSession session, String ded_no) throws SQLException , Exception {
		dedVO.setDed_no(ded_no);
		
		empsalService.deleteDeduction(ded_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	// DEPT(부서) CRUD -----------------------------------------------------------------------------------------
	
	@RequestMapping("/dept")

	public ModelAndView deptMain(String mymenu, String murl, ModelAndView mnv, String mcode,SearchCriteria cri, HttpSession session) throws SQLException {

		String url = "";
    	if(mymenu == null) {
			url="/minjun2/dept.page";
		} else {
			url="/minjun2/dept.mymenu";
		}
		
		Map<String, Object> dataMap = empsalService.selectdeptList(cri);
		
		System.out.println("dept dataMap : " + dataMap);
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/deptRegistForm")
	public String deptRegistForm() {
		String url = "minjun2/dept_regist";
		return url;
	}
	
	@RequestMapping("/insertDept")
	public void insertDept(DeptVO deptVO, HttpServletResponse res, HttpSession session) throws Exception {
		System.out.println("insertDept deptVO : " + deptVO);
		empsalService.insertDept(deptVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deptDetail")
	public ModelAndView deptDetail(ModelAndView mnv ,String dept_no) throws SQLException {
		
		Map<String, Object> dataMap = empsalService.selectDeptDetail(dept_no);
		
		String url = "minjun2/dept_detail.open";
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/modifyDept.do")
	public void modifyDept (DeptVO deptVO, HttpServletResponse res, HttpSession session, String dept_no) throws SQLException , Exception {
		
		deptVO.setDept_no(dept_no);
		System.out.println("modfiyDept deptVO : " + deptVO);
		empsalService.modifyDept(deptVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteDept.do")
	public void deleteDept (DeptVO deptVO, HttpServletResponse res, HttpSession session, String dept_no) throws SQLException , Exception {
		deptVO.setDept_no(dept_no);
		
		empsalService.deleteDept(dept_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	// WORK(근태) CRUD -----------------------------------------------------------------------------------------
	
	@RequestMapping("/work")
	public ModelAndView workMain(String mymenu, ModelAndView mnv, String mcode,SearchCriteria cri, HttpSession session) throws SQLException {
		String url = "";
    	if(mymenu == null) {
			url="/minjun2/work.page";
		} else {
			url="/minjun2/work.mymenu";
		}
		String c_no = (String) session.getAttribute("c_no");
		System.out.println("work c_no : " + c_no);
		Map<String, Object> dataMap = empsalService.selectworkList(cri, c_no);
		
		System.out.println("work dataMap : " + dataMap);
		
		mnv.addObject("mcode", mcode);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/workRegistForm")
	public ModelAndView workRegistForm(ModelAndView mnv, HttpSession session) {
		String c_no = (String) session.getAttribute("c_no");
		String url = "minjun2/work_regist";
		
		mnv.addObject("c_no", c_no);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/insertWork")
	public void insertWork(WorkVO workVO, HttpServletResponse res, HttpSession session) throws Exception {
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		workVO.setSys_reg(emp_no + "");
		workVO.setSys_up(emp_no + "");
		
		empsalService.insertWork(workVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/workDetail")
	public ModelAndView workDetail(ModelAndView mnv ,int w_no) throws SQLException {
		
		Map<String, Object> dataMap = empsalService.selectWorkDetail(w_no);
		
		String url = "minjun2/work_detail.open";
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/modifyWork.do")
	public void modifyWork (WorkVO workVO, HttpServletResponse res, HttpSession session, int w_no) throws SQLException , Exception {
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		System.out.println("modifyWork wdate : " + workVO.getWdate());
		workVO.setSys_reg(emp_no + "");
		workVO.setSys_up(emp_no + "");
		workVO.setW_no(w_no);
		System.out.println("modifyWork workVO : " + workVO);
		empsalService.modifyWork(workVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteWork.do")
	public void deleteWork (WorkVO workVO, HttpServletResponse res, HttpSession session, int w_no) throws SQLException , Exception {
		workVO.setW_no(w_no);
		
		empsalService.deleteWork(w_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	// SAL(급여) CRUD -----------------------------------------------------------------------------------------
	
	@RequestMapping("/sal")
	public ModelAndView salMain (String mymenu, String murl, ModelAndView mnv, String mcode,SearchCriteria cri, HttpSession session) throws SQLException, ParseException {
		String url = "/minjun2/sal.page";
    	if(mymenu == null) {
			url="/minjun2/sal.page";
		} else {
			url="/minjun2/sal.mymenu";
		}
		String c_no = (String) session.getAttribute("c_no");
		
		Map<String, Object> dataMap = empsalService.selectSalList(cri);
		
		mnv.addAllObjects(dataMap);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/salDetail")
	public ModelAndView salDetail(ModelAndView mnv ,String sal_no, SearchCriteria cri) throws SQLException {
		
		Map<String, Object> dataMap = empsalService.selectSalDetail(sal_no);
		Map<String, Object> dataMap2 = empsalService.selectExtrapayList(cri);
		Map<String, Object> dataMap3 = empsalService.selectDeductionList(cri);
		
		String url = "minjun2/sal_detail.open";
		mnv.addAllObjects(dataMap);
		mnv.addAllObjects(dataMap2);
		mnv.addAllObjects(dataMap3);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/salRegistForm")
	public ModelAndView salRegistForm(ModelAndView mnv, HttpSession session,SearchCriteria cri) throws SQLException {
		String c_no = (String) session.getAttribute("c_no");
		String url = "minjun2/sal_regist";

		Map<String, Object> dataMap = empsalService.selectExtrapayList(cri);
		Map<String, Object> dataMap2 = empsalService.selectDeductionList(cri);
		
		
		
		mnv.addAllObjects(dataMap);
		mnv.addAllObjects(dataMap2);
		mnv.addObject("c_no", c_no);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/registSal.do")
	public void registSal (HttpSession session, HttpServletResponse res, SalVO salVO, int[] emp_no, String[] sal_no, int[] realsumsal, String[] DED_001,
						   String[] DED_006, String[] DED_009, String[] DED_010, String[] DED_011, String[] DED_012, int[] sumExtrapay) throws Exception {
		int sys_reg = Integer.parseInt(session.getAttribute("emp_no").toString());
		String c_no = (String) session.getAttribute("c_no");
		salVO.setSys_reg(sys_reg + "");
		salVO.setSys_up(sys_reg + "");
		int amount = 0;
		String sal_no2 = empsalService.insertSal(salVO);
		Map<String, Object> map = new HashMap<>();
		for(int i= 0; i < emp_no.length; i++) {
			SalDetailVO salDetail = new SalDetailVO();
			
			salDetail.setDED_001(DED_001[i]);
			salDetail.setDED_006(DED_006[i]);
			salDetail.setDED_009(DED_009[i]);
			salDetail.setDED_010(DED_010[i]);
			salDetail.setDED_011(DED_011[i]);
			salDetail.setDED_012(DED_012[i]);
			salDetail.setEmp_no(emp_no[i]);
			salDetail.setRealsumsal(realsumsal[i]);
			salDetail.setSal_no(sal_no2);
			amount += sumExtrapay[i];
			empsalService.insertSalDetail(salDetail);
		}
		map.put("amount", amount);
		map.put("c_no", c_no);
		map.put("emp_no", sys_reg);
		empsalService.tr(map);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
		
	}
	
	@ResponseBody
	@RequestMapping("/calextrapay")
	public ResponseEntity<List<Map<String, Object>>> calextrapayRegist(@RequestBody Map<String, Object> map, HttpSession session) throws SQLException {
				System.out.println("map : " + map);
				ResponseEntity<List<Map<String, Object>>> entity = null;
				int emp_no = Integer.parseInt(map.get("emp_no").toString());
				String salmonth = map.get("salmonth").toString();
				int e_sal = Integer.parseInt(map.get("e_sal").toString());
				List<Map<String, Object>> extrapayList = empsalService.selectExtraPay(emp_no, salmonth, e_sal);
				
				System.out.println(extrapayList);
		try {
			entity = new ResponseEntity<List<Map<String, Object>>>(extrapayList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Map<String, Object>>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping("/addAllEmp")
	public ResponseEntity<List<Map<String, Object>>> addAllEmp(@RequestBody Map<String, Object> map, HttpSession session) throws SQLException {
		ResponseEntity<List<Map<String, Object>>> entity = null;
		
		List<Map<String, Object>> empList = null;
		String c_no = (String) session.getAttribute("c_no");
		String salmonth = map.get("salmonth").toString();
		empList = empsalService.allEmpList(c_no, salmonth);		
		
		try {
			entity = new ResponseEntity<List<Map<String, Object>>>(empList, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<List<Map<String, Object>>>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		return entity;
	} 
	
	@RequestMapping("/deleteSal.do")
	public void deleteSal (HttpServletResponse res, HttpSession session, String sal_no_a) throws SQLException , Exception {
		
		empsalService.deleteSal(sal_no_a);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
}
