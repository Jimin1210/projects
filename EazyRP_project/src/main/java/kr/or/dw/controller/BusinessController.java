package kr.or.dw.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLClientInfoException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.collect.Sets.SetView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.EstimateDAO;
import kr.or.dw.service.EstimateService;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.MyMenuService;
import kr.or.dw.service.SiService;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.EstimateVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.SiVO;
import kr.or.dw.vo.WareHouseVO;

@Controller
@RequestMapping("/erp4")
public class BusinessController {
	
	private static final Logger logger = LoggerFactory.getLogger(BusinessController.class);
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private EstimateService estimateService;
	
	@Autowired
	private SiService siService;
	
	@Autowired
	private MyMenuService mymenuService;
	
	@RequestMapping("/estimate")
	public ModelAndView main(String mymenu, ModelAndView mnv, String mcode, String murl, SearchCriteria cri) throws SQLException {
		String url="";
		System.out.println("1");
    	if(mymenu == null) {
			url="jihwan/main.page";
		} else {
			url="jihwan/main.mymenu";
		}
		System.out.println("22");
		Map<String, Object> dataMap = estimateService.selectEstimList(cri);
		
		mnv.addObject("murl", murl);
		mnv.addObject("mcode", mcode);
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);

		return mnv;
	}
	
	@RequestMapping("/estimate_regist")
	public ModelAndView esti(ModelAndView mnv ,HttpSession session) throws SQLException{
		int empno = Integer.parseInt(session.getAttribute("emp_no").toString());
		String ename = estimateService.ename(empno);
		String url = "jihwan/estimate_regist.open";
		mnv.setViewName(url);
		mnv.addObject("empno",empno);
		mnv.addObject("ename",ename);
		return mnv;
	}

	@RequestMapping("/estimateDetail")
	public ModelAndView estDetail (ModelAndView mnv ,String est_no) throws SQLException {
		
		Map<String, Object> dataMap = estimateService.selectDetail(est_no);
		String url = "jihwan/estimateDetail.open";
		mnv.addAllObjects(dataMap);
//		Map<String, Object> est2 = (Map<String, Object>) dataMap.get("est");
//		mnv.addObject("est2",est2);
		mnv.setViewName(url);
		return mnv;
	}
	
	

	
	@RequestMapping("/findPeople")
	public ModelAndView findPeople(ModelAndView mnv, String searchType, String keyword) throws SQLException {
		String url = "mymenu/findPeople";
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<EmpVO> emp = null;
		Map<String, String> dataMap = new HashMap<>();
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			emp = mymenuService.getEmp(dataMap);
		} else {
			emp = mymenuService.getEmpList();
		}
		
		mnv.setViewName(url);
		mnv.addObject("emp", emp);
		mnv.addObject("searchType", searchType);
		mnv.addObject("keyword", keyword);
		
		return mnv;
	}

	
	@RequestMapping("/findProduct")
	public ModelAndView findProduct(ModelAndView mnv, String pr_name, String c_name, String searchType, String keyword) throws SQLException {
		String url = "jihwan/findProduct";
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<ProductVO> product = null;
		Map<String, String> dataMap = new HashMap<>();
		dataMap.put("pr_name", pr_name);
		dataMap.put("c_name", c_name);
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			product = estimateService.getProduct(dataMap);
		} else {
			product = estimateService.getProductList();
		}
		mnv.setViewName(url);
		mnv.addObject("product", product);
		mnv.addObject("pr_name", pr_name);
		mnv.addObject("c_name", c_name);
		mnv.addObject("searchType", searchType);
		mnv.addObject("keyword", keyword);
		
		return mnv;
	}
	
	@RequestMapping("/findWareHouse")
	public ModelAndView findWareHouse(ModelAndView mnv, String searchType, String keyword) throws SQLException {
		String url = "jihwan/findWareHouse";

		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<WareHouseVO> warehouse = null;
		Map<String, String> dataMap = new HashMap<>();
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			warehouse = estimateService.getWareHouse(dataMap);
			System.out.println(warehouse.get(0).getWh_name());
		} else {
			warehouse = estimateService.getWareHouseList();
		}
		
		mnv.setViewName(url);
		mnv.addObject("warehouse",warehouse );
		mnv.addObject("searchType", searchType);
		mnv.addObject("keyword", keyword);
		
		return mnv;
	}
	
	@RequestMapping("/insertEstimate")
	public void insertEstimate (@RequestParam("files")MultipartFile multi,String progress, HttpSession session, String fileName, int emp_no, String[] pr_no, String fc_no, String[] wh_no, int[] quantity, int[] amount,  HttpServletResponse res) throws Exception {
		
		List<EstimateVO> vo = new ArrayList<EstimateVO>();
		
		String filess = "";
		String fileRealName = "";
		if(!multi.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String uniqueName = uuids[0];
			fileRealName = multi.getOriginalFilename();
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
			
			
			
			filess = uniqueName+fileExtension;
			
			
			String uploadFolder = session.getServletContext().getRealPath("/resources/saveJihwan/");
			
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
		
		for(int i= 0; i < pr_no.length; i++) {
			EstimateVO est = new EstimateVO();
			est.setEmp_no(emp_no);
			est.setPr_no(pr_no[i]);
			est.setFc_no(fc_no);
			est.setWh_no(wh_no[i]);
			est.setAmount(amount[i]);
			est.setQuantity(quantity[i]);
			est.setProgress(progress);
			vo.add(est);	
		}
		
		vo.get(0).setFiles(filess);
		vo.get(0).setRealFileName(fileRealName);
		
		estimateService.insertEstimate(vo);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
		
	}
	
	@RequestMapping("getFile")
	public ResponseEntity<byte[]> getFile(HttpSession session ,String est_no) throws Exception{
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		EstimateVO est = estimateService.selectEst(est_no);
		
		String estFile = est.getFiles();
		
		String uploadFolder = session.getServletContext().getRealPath("/resources/saveJihwan/");
		
		try {
			String fileName = estFile;
			in = new FileInputStream(uploadFolder + File.separator + fileName);
			
			fileName = est.getRealFileName();
			
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("utf-8"), "ISO-8859-1") + "\"");
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
		} finally {
			in.close();
		}
		
		return entity;
	}
	
	@Autowired
	private EstimateDAO estimateDAO;
	
	@RequestMapping("modifyForm")
	public void estimateModify(@RequestParam("files")MultipartFile multi,String progress, String fileName, String[] pr_delete, String est_no, int[] estdetail_no, int emp_no, String[] pr_no, String fc_no, String[] wh_no, int[] quantity, int[] amount,  HttpServletResponse res, HttpSession session) throws Exception {

		List<EstimateVO> modify = new ArrayList<EstimateVO>();
		EstimateVO est = estimateService.selectEst(est_no);
		
		String deleteFile = est.getFiles();
		String empno = session.getAttribute("emp_no").toString();
		String filess = "";
		String fileRealName = "";
		if(!multi.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			
			String uniqueName = uuids[0];
			
			fileRealName = multi.getOriginalFilename();
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
			
			String uploadFolder = session.getServletContext().getRealPath("/resources/saveJihwan/");
			
			File delete = new File(uploadFolder + deleteFile);
			delete.delete();
			filess = uniqueName+fileExtension;
			
			
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
		
		
		for(int i= 0; i < pr_no.length; i++) {
			EstimateVO est2 = new EstimateVO();
			
			est2.setEmp_no(emp_no);
			est2.setPr_no(pr_no[i]);
			est2.setFc_no(fc_no);
			est2.setWh_no(wh_no[i]);
			est2.setAmount(amount[i]);
			est2.setProgress(progress);
			est2.setQuantity(quantity[i]);
			est2.setEstdetail_no(estdetail_no[i]);
			est2.setEst_no(est_no);
			est2.setPr_delete(pr_delete[i]);
			modify.add(est2);	
			
		}
		
		
		modify.get(0).setFiles(filess);
		modify.get(0).setRealFileName(fileRealName);
		
		
		estimateService.modifyEstimate(modify, empno);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
				
	}
	
	@RequestMapping("remove")
	public void remove (String est_no, HttpServletRequest req, HttpServletResponse res) throws IOException, SQLException {
		
		estimateService.deleteEstimate(est_no);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	
//	----------------------------------------------------------------------------------------
	
	@RequestMapping("/siSelect")
	public ModelAndView siSel(String mymenu, ModelAndView mnv ,String mcode,String murl, SearchCriteria cri) throws SQLException {
		String url="";
    	if(mymenu == null) {
			url="jihwan/siSelect.page";
		} else {
			url="jihwan/siSelect.mymenu";
		}
    	
		Map<String, Object> dataMap = siService.selectSiList(cri);
		mnv.setViewName(url);
		mnv.addObject("murl", murl);
		mnv.addObject("cri",cri);
		mnv.addObject("mcode",mcode);
		mnv.addAllObjects(dataMap);
		return mnv;
	}
	
	@RequestMapping("/siDetail")
	public ModelAndView siDetail (ModelAndView mnv ,String si_no) throws SQLException {
		
		Map<String, Object> dataMap = siService.selectSiDetail(si_no);
		String url = "jihwan/siDetail.open";
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/si_regist")
	public ModelAndView siRegist(ModelAndView mnv,  HttpSession session) throws SQLException {
		int empno = Integer.parseInt(session.getAttribute("emp_no").toString());
		String ename = siService.ename(empno);
		System.out.println(ename);
		String url = "jihwan/si_regist.open";
		mnv.setViewName(url);
		mnv.addObject("empno",empno);
		mnv.addObject("ename",ename);
		return mnv;
	}
	
	@RequestMapping("/insertSi")
	public void insertSi(int emp_no, String[] pr_no, String[] pr_name,String progress, int[] quantity, String wh_no, String[] content, @DateTimeFormat(pattern="yyyy-MM-dd") Date shipdate, HttpServletResponse res) throws IOException, SQLException {
		
		List<SiVO> siVO = new ArrayList<SiVO>();
		
		System.out.println(emp_no);
		for(int i= 0; i < pr_no.length; i++) {
			SiVO si = new SiVO();
			si.setEmp_no(emp_no);
			si.setPr_no(pr_no[i]);
			si.setWh_no(wh_no);
			si.setQuantity(quantity[i]);
			if(content.length != 0) {				
				si.setContent(content[i]);
			}
			si.setShipdate(shipdate);
			si.setProgress(progress);
			siVO.add(si);	
		}
		
		siService.insertSi(siVO);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/simodifyForm")
	public void siModify(String[] pr_delete,String si_no, String progress,String[] sidetail_no, int emp_no, String[] pr_no, String wh_no, int[] quantity, @DateTimeFormat(pattern="yyyy-MM-dd") Date shipdate, String[] content, HttpServletResponse res, HttpSession session) throws SQLException, IOException {
		
		List<SiVO> modify = new ArrayList<SiVO>();
		String empno = session.getAttribute("emp_no").toString();
		
		
		for(int i= 0; i < pr_no.length; i++) {
			SiVO si = new SiVO();
			System.out.println("첫번째" + si_no);
			si.setSi_no(si_no);
			System.out.println("두번째" + sidetail_no[i]);
			si.setSidetail_no(sidetail_no[i]);
			si.setPr_no(pr_no[i]);
			si.setEmp_no(emp_no);
			si.setWh_no(wh_no);
			si.setQuantity(quantity[i]);
			si.setShipdate(shipdate);
			si.setPr_delete(pr_delete[i]);
			if(content.length != 0) {
				si.setContent(content[i]);
			}
			si.setProgress(progress);
			modify.add(si);
		}
		
		siService.modifySi(modify, empno); 
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
	}
	
	
	@RequestMapping("/siremove")
	public void siRemove (String si_no, HttpServletRequest req, HttpServletResponse res) throws IOException, SQLException {
		
		siService.siRemove(si_no);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
// -----------------------------------------------------------------------------------------------------------
	
	
	
	
}
