 package kr.or.dw.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.command.SearchCriteria2;
import kr.or.dw.service.EstimateService;
import kr.or.dw.service.FactoryService;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.ProcessService;
import kr.or.dw.service.ProductService;
import kr.or.dw.service.RownumService;
import kr.or.dw.service.WhService;
import kr.or.dw.service.WhTransferService;
import kr.or.dw.service.WorkOrderService;
import kr.or.dw.vo.ErrorVO;
import kr.or.dw.vo.EstimateVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.RownumVO;
import kr.or.dw.vo.WhTransferVO;
import kr.or.dw.vo.WhVO;
import kr.or.dw.vo.WorkOrderVO;

@Controller
@RequestMapping("/erp4")
public class HeesungController {

private static final Logger logger = LoggerFactory.getLogger(HeesungController.class);
	
	@Autowired
	private MenuService menuService;
	@Autowired
	private ProcessService processService;
	@Autowired
	private WhService whService;
	@Autowired
	private FactoryService factoryService;
	@Autowired
	private WorkOrderService workOrderService;
	@Autowired
	private EstimateService estimateService;
	@Autowired
	private RownumService rownumService;
	@Autowired
	private WhTransferService whTransferService;
	@Autowired
	private ProductService productService;
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////// 목록 열기
	
	@RequestMapping("/findFactory")
	public ModelAndView findFactory(ModelAndView mnv, SearchCriteria cri) throws SQLException {
		String url = "heesung/findFactory.open";
		
		Map<String, Object> dataMap = factoryService.selectFactoryList(cri);
		
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		return mnv;
	}
	
	@RequestMapping("/findWorkOrder")
	public ModelAndView findWorkOrder(ModelAndView mnv, SearchCriteria cri, HttpSession session) throws SQLException {
		String url = "heesung/findWorkOrder.open";
		
		String c_no = session.getAttribute("c_no").toString();
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("c_no", c_no);
		Map<String, Object> dataMap = workOrderService.selectWorkOrderList(map);
		
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		return mnv;
	}
	
	@RequestMapping("/selectWorkOrderDetail")	// 생산입고 디테일에서 선택한 작업지시서를 상세보기 할 수 있다.
	public ModelAndView selectWorkOrderDetail(ModelAndView mnv, String wo_no) throws SQLException{

		System.out.println("erp4/selectWorkOrderDetail 진입");
		
		Map<String, Object> dataMap = workOrderService.selectWorkOrder(wo_no);
		String url = "heesung/workorder/readOnlyDetail.open";
		
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	
	}
	
	@RequestMapping("/whtSelectWareHouse")	// 창고이동 레지스트, 디테일 페이지에서 선택한 보내는 창고의 재고를 조회할 수 있다.
	public ModelAndView whtSelectWareHouse(ModelAndView mnv, SearchCriteria cri, String wh_no, HttpSession session) throws SQLException {
		
		System.out.println("erp4/whtSelectWareHouse - 진입");
		
		String url = "heesung/whtSelectWareHouse.open";
		
		String c_no = session.getAttribute("c_no").toString();
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("c_no", c_no);
		map.put("wh_no", wh_no);
		Map<String, Object> dataMap = whTransferService.whtSelectWareHouse(map);
		
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		return mnv;
	}
	
	@RequestMapping("/findMakeProduct")	// 생산과 관련된 메뉴에서 만들어질 제품을 선택하는것
	public ModelAndView findProduct(ModelAndView mnv, String pr_name, String c_name, String searchType, String keyword) throws SQLException {
		String url = "heesung/findMakeProduct";
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
			product = productService.getMakeProduct(dataMap);
		} else {
			product = productService.getMakeProductList();
		}
		mnv.setViewName(url);
		mnv.addObject("product", product);
		mnv.addObject("pr_name", pr_name);
		mnv.addObject("c_name", c_name);
		mnv.addObject("searchType", searchType);
		mnv.addObject("keyword", keyword);
		
		return mnv;
	}
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////// process
	
	@RequestMapping("/process")
	public ModelAndView processMain(String murl, String mymenu, String mcode, ModelAndView mnv, SearchCriteria cri) throws SQLException {
		String url="";
    	if(mymenu == null) {
			url="heesung/process/main.page";
		} else {
			url="heesung/process/main.mymenu";
		}
			
		// 공정관리 목록 조회
		Map<String, Object> dataMap = processService.selectProcessList(cri);
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);

		return mnv;
	}
	
	@RequestMapping("/process/registForm")
	public String processRegistForm() {
		String url = "heesung/process/open_regist";
		return url;
	}
	
	@RequestMapping("/process/regist")
	public void processRegist(ProcessVO processVo, HttpServletRequest req, HttpServletResponse res) throws SQLException, IOException {

		System.out.println("erp4/process/regist - 진입");
		
		processService.registProcess(processVo);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/process/detail")
	public ModelAndView processDetail(String pc_code, ModelAndView mnv) throws SQLException {
		String url = "heesung/process/detail";
		
		ProcessVO process = null;
		
		process = processService.selectProcess(pc_code);
		
		mnv.addObject("process", process);
		mnv.setViewName(url);
	
		return mnv;
	}

//	@RequestMapping("/process/modifyForm")
//	public ModelAndView processModifyForm(String pc_code, ModelAndView mnv) throws SQLException {
//		String url = "heesung/process/modify";
//		
//		ProcessVO process = null;
//		
//		process = processService.selectProcess(pc_code);
//		
//		mnv.addObject("process", process);
//		mnv.setViewName(url);
//		
//		return mnv;
//	}

	@RequestMapping("/process/modify")
	public void processModify(ProcessVO process, HttpServletRequest req, HttpServletResponse res) throws IOException, SQLException {

		System.out.println("erp4/process/modify - 진입");
		
		processService.processModify(process);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload();");
		out.println("alert('수정 되었습니다.')");
		out.println("window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/process/remove")
	public void processRemove(String pc_code, HttpServletRequest req, HttpServletResponse res) throws IOException, SQLException {
		System.out.println("컨트롤러 진입");
		processService.processRemove(pc_code);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload();");
		out.println("alert('삭제 되었습니다.')");
		out.println("window.close();");
		out.println("</script>");
	}
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////// wh(생산입고)
	
	@RequestMapping("/wh")
	public ModelAndView wh(String murl, String mymenu, String mcode, ModelAndView mnv, SearchCriteria cri, HttpSession session) throws SQLException {
		
		String url="";
    	if(mymenu == null) {
			url="heesung/wh/main.page";
		} else {
			url="heesung/wh/main.mymenu";
		}
		
		String c_no = session.getAttribute("c_no").toString();
		
//		// 공정관리 목록 조회
//		Map<String, Object> dataMap = whService.selectWhList(cri);
		
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("c_no", c_no);
		
//		// 공정관리 목록 조회
		Map<String, Object> dataMap = whService.selectWhList(map);
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/wh/registForm")
	public ModelAndView whRegistForm(ModelAndView mnv, HttpSession session, RownumVO rownumVo) throws SQLException {
		
		// 생산입고를 등록할때 registForm에서 디테일 리스트들을 추가할때마다 번호를 부여하여 구분하기 위함임
		// 이렇게 하지 않으면 cnt 값이 모두 같기 때문에 findFactory 등을 하였을때 모든 tr의 fac_name 값이 같은걸로 바뀌어 버림
		int rownum = rownumService.selectRownum(rownumVo);
		
		int empno = Integer.parseInt(session.getAttribute("emp_no").toString());
		String ename = estimateService.ename(empno);
		
		String c_no = session.getAttribute("c_no").toString();
		String c_name = session.getAttribute("c_name").toString();
		
		
		String url = "heesung/wh/registForm.open";
		
		mnv.setViewName(url);
		mnv.addObject("rownum", rownum);
		mnv.addObject("empno", empno);	// 사원번호
		mnv.addObject("ename", ename);	// 사원이름
		mnv.addObject("c_no", c_no);	// 회사이름
		mnv.addObject("c_name", c_name);	// 회사번호
		
		return mnv;

	}
	
	@RequestMapping("/wh/regist")
	public void whRegist(HttpServletResponse res, int emp_no,  String wo_no, int wh_total, String[] pr_no, String[] fac_no, String wh_no[], 
		int[] outprice, int[] quantity, int[] total_outprice, HttpSession session, String progress) throws SQLException, IOException {
		
		System.out.println("erp4/wh/regist 컨트롤러 진입");
		

		List<WhVO> whList = new ArrayList<WhVO>();	// 상세 정보들을 만들기 위한 객체
		
		
		String c_no = session.getAttribute("c_no").toString();
		
		System.out.println("pr_no.length : " + pr_no.length);
		
		for(int i = 0; i < pr_no.length; i++) {
			
			System.out.println(i + "번째 시작");
			WhVO wh = new WhVO();
			
			// wh 테이블
			wh.setEmp_no(emp_no);
			wh.setWo_no(wo_no);
			wh.setWh_total(wh_total);
			wh.setC_no(c_no);
			wh.setProgress(progress);
			
			// whdetail 테이블
			wh.setPr_no(pr_no[i]);
			wh.setFac_no(fac_no[i]);
			wh.setWh_no2(wh_no[i]);
			wh.setOutprice(outprice[i]);
			wh.setQuantity(quantity[i]);
			wh.setTotal_outprice(total_outprice[i]);
			
			whList.add(wh);
			
//			// wh 테이블
//			System.out.println(i + "번째 whDetailVo.setEmp_no(emp_no); : " + emp_no);
//			System.out.println(i + "번째 whDetailVo.setWo_no(wo_no); : " + wo_no);
//			System.out.println(i + "번째 whDetailVo.setWh_total(wh_total); : " + wh_total);
//			System.out.println(i + " 번째 whDetailVo.setFiles(filess); : " + filess);
//			System.out.println(i + " 번째 whDetailVo.setC_no(c_no); : " + c_no);
//			System.out.println(i + " 번쨰 whDetailVo.setProgress(progress); : " + progress);
//			// whdetail 테이블
//			System.out.println(i + " 번째 whDetailVo.setPr_no(pr_no[i]); : " + pr_no[i]);
//			System.out.println(i + " 번째 whDetailVo.setFac_no(fac_no[i]); : " + fac_no[i]);
//			System.out.println(i + " 번째 whDetailVo.setWh_no2(wh_no[i]); : " + wh_no[i]);
//			System.out.println(i + " 번째 whDetailVo.setOutprice(outprice[i]); : " + outprice[i]);
//			System.out.println(i + " 번째 whDetailVo.setQuantity(quantity[i]); : " + quantity[i]);
//			System.out.println(i + " 번째 whDetailVo.setTotal_outprice(total_outprice[i]); : " + total_outprice[i]);
//			
//			System.out.println(i + " 번째 whDetailVoList.add(whDetailVo); : " + whList);
			
			System.out.println(i + " 번째 종료");
			
		}

		whService.registWh(whList);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
	}
	
	@RequestMapping("/wh/detail")
	public ModelAndView whDetail(String wh_no, ModelAndView mnv) throws SQLException {
		
		System.out.println("erp4/wh/detail - 진입");
		
		String url = "heesung/wh/detail.open";
		
		Map<String, Object> dataMap = whService.selectWh(wh_no);
		
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
	
		return mnv;
	}
	
	@RequestMapping("/wh/modify")
	public void whModify(HttpServletResponse res, int emp_no,  String wo_no, int wh_total, String[] pr_no, String[] fac_no, String[] wh_no, int[] detail_no,
			int[] outprice, int[] quantity, int[] total_outprice, HttpSession session, String progress, String[] pr_delete, String whNo) throws SQLException, IOException {
		
		System.out.println("erp4/wh/modify - 진입");
		
		List<WhVO> whList = new ArrayList<WhVO>();	// 상세 정보들을 만들기 위한 객체
		
		String c_no = session.getAttribute("c_no").toString();
		
		System.out.println("pr_no.length : " + pr_no.length);
		
		for(int i = 0; i < pr_no.length; i++) {
			
			System.out.println(i + "번째 시작");
			
			WhVO wh = new WhVO();
			
			// wh 테이블
			wh.setWh_no(whNo);
			wh.setEmp_no(emp_no);
			System.out.println(emp_no);
			wh.setWo_no(wo_no);
			wh.setWh_total(wh_total);
			wh.setC_no(c_no);
			wh.setProgress(progress);
			
			// whdetail 테이블
			wh.setDetail_no(detail_no[i]);
			wh.setPr_no(pr_no[i]);
			wh.setFac_no(fac_no[i]);
			wh.setWh_no2(wh_no[i]);
			wh.setOutprice(outprice[i]);
			wh.setQuantity(quantity[i]);
			wh.setTotal_outprice(total_outprice[i]);
			wh.setPr_delete(pr_delete[i]);
			
			whList.add(wh);
		
			System.out.println(i + " 번째 종료");
			
		}

		whService.modifyWh(whList);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
	}
	
	@RequestMapping("/wh/remove")
	public void whRemove(HttpServletResponse res, String whNo) throws SQLException, IOException {
		
		System.out.println("erp4/wh/remove - 진입");
		
		whService.whRemove(whNo);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload();");
		out.println("alert('삭제 되었습니다.')");
		out.println("window.close();");
		out.println("</script>");
		
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////workorder(작업지시서)
	
	@RequestMapping("/workorder")
	public ModelAndView workorder(String murl, String mymenu,ModelAndView mnv, SearchCriteria cri, String mcode, HttpSession session) throws SQLException {
		
		System.out.println("HeesungController - erp4/workorder 진입");
		
		// 페이지 정보와 작업지시서의 정보를 가지고 url에 반환할것이다 url에서는 게시판 형태로 사용자에게 보여준다.
		String url="";
    	if(mymenu == null) {
			url="heesung/workorder/main.page";
		} else {
			url="heesung/workorder/main.mymenu";
		}
		
		String c_no = session.getAttribute("c_no").toString();
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("c_no", c_no);
		Map<String, Object> dataMap = workOrderService.selectWorkOrderList(map);
		
		mnv.setViewName(url);
		mnv.addObject("murl", murl);
		mnv.addObject("mcode", mcode);
		mnv.addAllObjects(dataMap);
		
		return mnv;
	}
	
	@RequestMapping("/workorder/registForm")
	public ModelAndView workorderRegistForm(ModelAndView mnv, HttpSession session) throws SQLException {
		
		System.out.println("HeesungController - erp4/workorder/registForm 진입");
		
		int empno = Integer.parseInt(session.getAttribute("emp_no").toString());
		String ename = estimateService.ename(empno);
		
		String c_no = session.getAttribute("c_no").toString();
		String c_name = session.getAttribute("c_name").toString();
		
		String url = "heesung/workorder/registForm.open";
		
		mnv.setViewName(url);
		mnv.addObject("empno", empno);		// 사원번호
		mnv.addObject("ename", ename);		// 사원이름
		mnv.addObject("c_no", c_no);		// 회사번호
		mnv.addObject("c_name", c_name);	// 회사이름
		
		return mnv;
	}
	
	@RequestMapping("/workorder/regist")
	public void registWorkOrder (HttpServletResponse res, String wo_name, 
		String[] fac_no, @DateTimeFormat(pattern="yyyy-MM-dd")Date deliverydate, String progress, String[] pr_no, int[] quantity, int emp_no, HttpSession session) throws SQLException, IOException {
		
		System.out.println("희성 컨트롤러 erp4/workorder/regist 진입");
		
		String c_no = session.getAttribute("c_no").toString();
		
		List<WorkOrderVO> woList = new ArrayList<WorkOrderVO>();
		
		System.out.println("pr_no.length : " + pr_no);
		
		for(int i = 0; i < pr_no.length; i++) {
			
			WorkOrderVO wo = new WorkOrderVO();

			// workorder 테이블
			wo.setC_no(c_no);
			wo.setWo_name(wo_name);
			wo.setEmp_no(emp_no);
			wo.setDeliverydate(deliverydate);
			wo.setProgress(progress);
			
			// workorderdetail 테이블
			wo.setPr_no(pr_no[i]);
			wo.setFac_no(fac_no[i]);
			wo.setQuantity(quantity[i]);
			
			woList.add(wo);
			
		}
		
		System.out.println("workOrder registService 진입 전");
		
		workOrderService.registWorkOrder(woList);
		
		System.out.println("workOrder registService 진입 후");
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
	}
	
	@RequestMapping("/workorder/detail")
	public ModelAndView workOrderDetail(ModelAndView mnv, String wo_no) throws SQLException {
		
		System.out.println("erp4/workorder/detail 진입");
		
		Map<String, Object> dataMap = workOrderService.selectWorkOrder(wo_no);
		String url = "heesung/workorder/detail.open";
		
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
		
	}
	
	@RequestMapping("/workorder/modify")
	public void workOrderModify(HttpServletResponse res, String wo_name,
		String[] fac_no, @DateTimeFormat(pattern="yyyy-MM-dd")Date deliverydate, 
		String progress, String[] pr_no, int[] quantity, int emp_no, 
		HttpSession session, String wo_no, String[] detail_no,
		String[] pr_delete) throws SQLException, IOException {
		
		System.out.println("erp4/workorder/modify - 진입");
		
		String c_no = session.getAttribute("c_no").toString();
		
		List<WorkOrderVO> woList = new ArrayList<WorkOrderVO>();
		
		for(int i = 0; i < pr_no.length; i++) {
			
			WorkOrderVO wo = new WorkOrderVO();

			// workorder 테이블
			wo.setWo_no(wo_no);
			wo.setC_no(c_no);
			wo.setWo_name(wo_name);
			wo.setEmp_no(emp_no);
			wo.setDeliverydate(deliverydate);
			wo.setProgress(progress);
			
			// workorderdetail 테이블
			System.out.println(i + "번째 detail_no" + detail_no[i]);
			wo.setDetail_no(detail_no[i]);
			wo.setPr_no(pr_no[i]);
			wo.setFac_no(fac_no[i]);
			wo.setQuantity(quantity[i]);
			wo.setPr_delete(pr_delete[i]);
			
			woList.add(wo);
			
		}
		
		workOrderService.workOrderModify(woList);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('수정 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
	}
	
	@RequestMapping("/updateWorkOrderProgress")
	public void updateWorkOrderProgress(String wo_no, int progress, HttpServletResponse res) throws SQLException, IOException {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("wo_no", wo_no);
		map.put("progress", progress + 1);
		
		workOrderService.updateWorkOrderProgress(map);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload();");
		out.println("alert('처리 완료되었습니다.')");
		out.println("window.close();");
		out.println("</script>");
		
	}
	
	@RequestMapping("/updateBtn")
	public void updateBtn(String whNo, int progress, HttpServletResponse res) throws SQLException, IOException {
		Map<String, Object> map = new HashMap<>();
		map.put("wh_no", whNo);
		map.put("progress", progress + 1);
		System.out.println(whNo);
		System.out.println(progress);
		workOrderService.updateBtn(map);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload();");
		out.println("alert('처리 완료되었습니다.')");
		out.println("window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/insertError")
	public ModelAndView insertError(ModelAndView mnv, HttpServletResponse res, int emp_no,  String wo_no, int wh_total, String[] pr_no, String[] fac_no, String[] wh_no, int[] detail_no,
			String[] pr_name, int[] outprice, int[] quantity, int[] total_outprice, HttpSession session, String progress, String[] pr_delete, String whNo) throws SQLException, IOException {
		
		List<WhVO> whList = new ArrayList<WhVO>();
		
		String c_no = session.getAttribute("c_no").toString();
		
		System.out.println("pr_no.length : " + pr_no.length);
		
		for(int i = 0; i < pr_no.length; i++) {
			WhVO wh = new WhVO();
			
			wh.setWh_no(whNo);
			wh.setEmp_no(emp_no);
			System.out.println(emp_no);
			wh.setWo_no(wo_no);
			wh.setWh_total(wh_total);
			wh.setC_no(c_no);
			wh.setProgress(progress);
			wh.setPr_name(pr_name[i]);
			wh.setDetail_no(detail_no[i]);
			wh.setPr_no(pr_no[i]);
			wh.setFac_no(fac_no[i]);
			wh.setWh_no2(wh_no[i]);
			wh.setOutprice(outprice[i]);
			wh.setQuantity(quantity[i]);
			wh.setTotal_outprice(total_outprice[i]);
			wh.setPr_delete(pr_delete[i]);
			
			whList.add(wh);
		}

		session.setAttribute("whList", whList);
		
		Map<String, Object> dataMap = whService.selectWh(whNo);
		
		mnv.addAllObjects(dataMap);
		mnv.setViewName("heesung/wh/error.open");
		return mnv;
	}
	
	@RequestMapping("/insertError2")
	public void insertError2(HttpServletResponse res, String[] fac_no, String[] pr_no, int[] quantity, 
			HttpSession session, String wo_no, String wh_no, String[] pr_name) throws SQLException, IOException {
		List<WorkOrderVO> woList = new ArrayList<WorkOrderVO>();
		String c_no = (String) session.getAttribute("c_no");
		List<WhVO> whList = new ArrayList<WhVO>();
		whList = (List<WhVO>) session.getAttribute("whList");
		
		for(int i = 0; i < pr_no.length; i++) {
			System.out.println(c_no);
			WorkOrderVO wo = new WorkOrderVO();
			wo.setWh_no(wh_no);
			wo.setWo_no(wo_no);
			wo.setPr_name(pr_name[i]);
			wo.setPr_no(pr_no[i]);
			wo.setFac_no(fac_no[i]);
			wo.setQuantity(quantity[i]);
			wo.setC_no(c_no);
			woList.add(wo);
			int a = whList.get(i).getQuantity() - quantity[i];
			whList.get(i).setQuantity(a);
		}
		
		
		workOrderService.insertError(woList);
		workOrderService.insertProduct(whList);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('불량 등록이 완료되었습니다.')");
		out.println("alert('생산입고 처리가 완료되었습니다.')");
		out.println("window.opener.location.reload();");
		out.println("window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/workorder/remove")
	public void workOrderRemove(HttpServletResponse res, String wo_no) throws SQLException, IOException {
		
		System.out.println("erp4/workorder/remove - 진입");
		
		workOrderService.workOrderRemove(wo_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload();");
		out.println("alert('삭제 되었습니다.')");
		out.println("window.close();");
		out.println("</script>");
		
	}
	
	@RequestMapping("/error")
	public ModelAndView error(String mymenu, ModelAndView mnv, String mcode, SearchCriteria2 cri2, SearchCriteria cri, HttpSession session) throws SQLException {
		String c_no = (String) session.getAttribute("c_no");
		List<ErrorVO> error = new ArrayList<>();
		if(cri2.getStartDate().equals("")) {
			LocalDate now = LocalDate.now();

	        int year = now.getYear();
	        int month = now.getMonthValue();
	        int day = now.getDayOfMonth();

	        String today = year + "-" + (month < 10 ? "0" : "") + month + "-" + day;
	        cri2.setStartDate(today);
		    cri2.setEndDate(today);
		}
		error = workOrderService.getErrorList(c_no, cri, cri2);
		int total = 0;
		for(int i = 0; i < error.size(); i++) {
			total += error.get(i).getAmount();
		}
		String url="";
    	if(mymenu == null) {
			url="heesung/wh/errorList.page";
		} else {
			url="heesung/wh/errorList.mymenu";
		}
		mnv.setViewName(url);
		mnv.addObject("total", total);
		mnv.addObject("cri2", cri2);
		mnv.addObject("error", error);
		mnv.addObject("mcode", mcode);
		return mnv;
	}
	
////////////////////////////////////////////////////////////////////////////////////////////////////////////////whTransfer
	
	@RequestMapping("whtransfer")
	public ModelAndView whTransfer(String murl, String mymenu, ModelAndView mnv, SearchCriteria cri, String mcode, HttpSession session) throws SQLException {
		
		System.out.println("HeesungController - erp4/whtransfer - 진입");
		System.out.println(cri.getPage());
		String url="";
    	if(mymenu == null) {
			url="heesung/whtransfer/main.page";
		} else {
			url="heesung/whtransfer/main.mymenu";
		}
		
		String c_no = session.getAttribute("c_no").toString();
		
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("c_no", c_no);
		
		Map<String, Object> dataMap = whTransferService.selectWhTransferList(map);
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
		
	}
	
	@RequestMapping("/whtransfer/registForm")
	public ModelAndView whTransferRegistForm(ModelAndView mnv, HttpSession session) throws SQLException {
		
		int empno = Integer.parseInt(session.getAttribute("emp_no").toString());
		String ename = estimateService.ename(empno);
		
		String c_no = session.getAttribute("c_no").toString();
		String c_name = session.getAttribute("c_name").toString();
		
		String url = "heesung/whtransfer/registForm.open";
		
		mnv.setViewName(url);
		mnv.addObject("empno", empno);		// 사원번호
		mnv.addObject("ename", ename);		// 사원이름
		mnv.addObject("c_no", c_no);		// 회사이름
		mnv.addObject("c_name", c_name);	// 회사번호
		
		return mnv;

	}
	
	@RequestMapping("whtransfer/regist")
	public void whTransferRegist(HttpServletResponse res, HttpSession session, 
					int emp_no, String wh_no, String wh_no2, 
					int total_quantity, String[] pr_no, int[] quantity, String[] pr_name) throws SQLException, IOException {
		
		System.out.println("erp4/whtransfer/regist - 진입");
		
		String c_no = session.getAttribute("c_no").toString();
		
		List<WhTransferVO> whtList = new ArrayList<WhTransferVO>();
		
		System.out.println("pr_no.length : " + pr_no.length);
		
		for(int i = 0; i < pr_no.length; i++) {
			
			WhTransferVO wht = new WhTransferVO();
			
			wht.setC_no(c_no);
			wht.setEmp_no(emp_no);
			wht.setWh_no(wh_no);
			wht.setWh_no2(wh_no2);
			wht.setTotal_quantity(total_quantity);
			
			wht.setPr_no(pr_no[i]);
			wht.setQuantity(quantity[i]);
			wht.setPr_name(pr_name[i]);
			
			whtList.add(wht);
			
		}
		
		whTransferService.registWhTransfer(whtList);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload();");
		out.println("alert('등록 되었습니다.')");
		out.println("window.close();");
		out.println("</script>");
		
	}
	
	@RequestMapping("whtransfer/detail")
	public ModelAndView whTransferDetail(ModelAndView mnv, String wt_no) throws SQLException{
		
		String url = "heesung/whtransfer/detail.open";
		Map<String, Object> dataMap = whTransferService.selectWhTransfer(wt_no);
		
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
		
	}
	
}
