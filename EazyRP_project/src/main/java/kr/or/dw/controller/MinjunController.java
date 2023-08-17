package kr.or.dw.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.MerchandiseService;
import kr.or.dw.service.OrderService;
import kr.or.dw.service.ProcessService;
import kr.or.dw.service.ProductService;
import kr.or.dw.service.ShopService;
import kr.or.dw.vo.MenuVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.NoteVO;
import kr.or.dw.vo.OrderVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;

@Controller
@RequestMapping("/erp5")
public class MinjunController {
	
	private static final Logger logger = LoggerFactory.getLogger(MinjunController.class);
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private MerchandiseService merchandiseService;
	
	@Autowired
	private ShopService shopService;

	@Autowired
	private OrderService orderService;
	
	// Shop CRUD -----------------------------------------------------------------------------------------
	
	@RequestMapping("/shop")
	public ModelAndView shopMain(String mymenu, String murl, ModelAndView mnv, String mcode, SearchCriteria cri) throws SQLException{
		String url = "";
    	if(mymenu == null) {
			url="/minjun/shop.page";
		} else {
			url="/minjun/shop.mymenu";
		}
		Map<String, Object> dataMap = shopService.selectShopList(cri);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}

	
	@RequestMapping("/shopRegistForm")
	public String shopRegistForm() {
		String url = "minjun/shop_regist";
		return url;
	}
	
	@RequestMapping("/insertShop")
	public void insertShop (ShopVO shopVO, HttpServletResponse res, HttpSession session) throws Exception {
			
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		
		shopVO.setSys_reg(emp_no + "");
		shopVO.setSys_up(emp_no + "");
		
		shopService.insertShop(shopVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/shopDetail")
	public ModelAndView shopDetail (ModelAndView mnv ,String s_no) throws SQLException {
		Map<String, Object> dataMap = shopService.selectShop(s_no);
		String url = "minjun/shop_detail.open";
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/deleteShop.do")
	public void deleteShop (ShopVO shopVO, HttpServletResponse res, String s_no) throws SQLException , Exception {
		shopVO.setS_no(s_no);
		shopService.deleteShop(shopVO);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/modifyShop.do")
	public void modifyShop(ShopVO shopVO, HttpServletResponse res, HttpSession session, String s_no) throws SQLException , Exception {
		shopVO.setS_no(s_no);
		shopService.modifyShop(shopVO);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/findShop")
	public ModelAndView findShop(ModelAndView mnv, String s_name, String searchType, String keyword) throws SQLException {
		String url = "minjun/findShop";
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<ShopVO> shop = null;
		Map<String, String> dataMap = new HashMap<>();
		dataMap.put("s_name", s_name);
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			shop = shopService.getShop(dataMap);
		} else {
			shop = shopService.getShopList();
		}
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("shop", shop);
		
		return mnv;
	}
	
	// Merchandise CRUD -----------------------------------------------------------------------------------------
	
	@RequestMapping("/merchandise")
	public ModelAndView merchandiseMain(String mymenu, String murl, String mcode, ModelAndView mnv, SearchCriteria cri) throws SQLException {
		String url = "";
    	if(mymenu == null) {
			url="/minjun/merchandise.page";
		} else {
			url="/minjun/merchandise.mymenu";
		}
		
		//상품 조회
		Map<String, Object> dataMap = merchandiseService.selectMerchandiseList(cri);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/merchandiseSearch")
	public ModelAndView search(String mymenu, ModelAndView mnv, String mcode, String keyword, String searchType) throws SQLException {
		String url = "";
    	if(mymenu == null) {
			url="/minjun/merchandise.page";
		} else {
			url="/minjun/merchandise.mymenu";
		}
		Map<String, String> valMap = new HashMap<>();
		valMap.put("keyword", keyword);
		valMap.put("searchType", searchType);
		List<NoteVO> note = null;
		
		mnv.addObject("note", note);
		mnv.addObject("keyword", keyword);
		mnv.addObject("searchType", searchType);
		mnv.addObject("mcode", mcode);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/merchandiseRegistForm")
	public String merchandiseRegistForm() {
		String url = "minjun/merchandise_regist";
		return url;
	}
	
	@RequestMapping("/insertMerchandise")
	public void insertMerchandise (MerchandiseVO mchVO, HttpServletResponse res, HttpSession session) throws Exception {
		
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		
		mchVO.setSys_reg(emp_no + "");
		mchVO.setSys_up(emp_no + "");
		
		merchandiseService.insertMerchandise(mchVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/merchandiseDetail")
	public ModelAndView merchandiseDetail (ModelAndView mnv ,String sp_no, String s_no, String pr_no) throws SQLException {
		Map<String, Object> dataMap = merchandiseService.selectDetail(sp_no);
		String url = "minjun/merchandise_detail.open";
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/modifyMerchandise.do")
	public void modifyMerchandise (MerchandiseVO mchVO, HttpServletResponse res, HttpSession session, String sp_no, String s_no, String pr_no) throws SQLException , Exception {
		
		String todayfm = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date formattoday = dtFormat.parse(todayfm);
		mchVO.setSp_no(sp_no);
		mchVO.setS_no(s_no);
		mchVO.setPr_no(pr_no);
		if(mchVO.getStatus().equals("판매중지")) {
			mchVO.setEndperiod(formattoday);
		}
		
		merchandiseService.modifyMerchandise(mchVO);
		
		
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteMerchandise.do")
	public void deleteMerchandise (MerchandiseVO mchVO, HttpServletResponse res, String sp_no) throws SQLException , Exception {
		mchVO.setSp_no(sp_no);
		
		merchandiseService.deleteMerchandise(mchVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	

	@RequestMapping("/findProduct")
	public ModelAndView findProduct(ModelAndView mnv, String pr_no,String pr_name, String c_name, String searchType, String keyword) throws SQLException {
		String url = "minjun/findProduct";
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
		dataMap.put("pr_no", pr_no);
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			product = merchandiseService.getProduct(dataMap);
		} else {
			product = merchandiseService.getProductList();
		}
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("product", product);
		
		return mnv;
	}
	
	
	// ORDER CRUD -----------------------------------------------------------------------------------------
	
	@RequestMapping("/order.do")
	public ModelAndView orderMain(String mymenu, String murl, String mcode, ModelAndView mnv, SearchCriteria cri) throws SQLException {
		String url = "";
    	if(mymenu == null) {
			url="/minjun/order.page";
		} else {
			url="/minjun/order.mymenu";
		}
		
		//주문 조회
		Map<String, Object> dataMap = orderService.selectOrderList(cri);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}

	@RequestMapping("/orderRegistForm")
	public String orderRegistForm() {
		String url = "minjun/order_regist";
		return url;
	}
	
	@RequestMapping("/insertOrder")
	public void insertOrder (OrderVO orderVO, HttpServletResponse res, HttpSession session) throws Exception {
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		orderVO.setSys_reg(emp_no + "");
		orderVO.setSys_up(emp_no + "");
		System.out.println("insertOrder orderVO : " + orderVO);
		
		orderService.insertOrder(orderVO);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/findMerchandise")
	public ModelAndView findMerchandise(ModelAndView mnv, String sp_no, String s_name, String pr_name, String searchType, String keyword) throws SQLException {
		String url = "minjun/findMerchandise";
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<Map<String, Object>> merchandise = null;
		Map<String, String> dataMap = new HashMap<>();
		
		dataMap.put("sp_no", sp_no);
		dataMap.put("s_name", s_name);
		dataMap.put("pr_name", pr_name);
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		
		if(keyword != null){
			merchandise = merchandiseService.getMerchandise(dataMap);
		} else {
			merchandise = merchandiseService.getMerchandiseList();
		}
		
		dataMap.put("sp_no", sp_no);
		dataMap.put("s_name", s_name);
		dataMap.put("pr_name", pr_name);
		mnv.setViewName(url);
		mnv.addObject("searchType", searchType);
		mnv.addObject("keyword", keyword);
		mnv.addObject("merchandise", merchandise);
		
		return mnv;
	}
	
	@RequestMapping("/orderDetail")
	public ModelAndView orderDetail (ModelAndView mnv ,String sp_no, String pr_no, String so_no) throws SQLException {
		
		Map<String, Object> dataMap = orderService.selectDetail(so_no);
		String url = "minjun/order_detail.open";
		
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/modifyOrder.do")
	public void modifyOrder (OrderVO orderVO, HttpServletResponse res, HttpSession session, String so_no, String sp_no, String oldprogress) throws SQLException , Exception {
		String todayfm = new SimpleDateFormat("yyyy-MM-dd").format(new Date(System.currentTimeMillis()));
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date formattoday = dtFormat.parse(todayfm);

		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());

		orderVO.setSys_up(emp_no + "");
		orderVO.setSo_no(so_no);
		orderVO.setSp_no(sp_no);
		
		if(orderVO.getProgress().equals("배송완료")) {
			orderVO.setDelenddate(formattoday);
		}
		
		String c_no = (String) session.getAttribute("c_no");
		if(orderVO.getProgress().equals("배송완료")) {
			orderService.minusQuantity(orderVO, c_no);
		}else if(orderVO.getProgress().equals("반품")){
			orderService.plusQuantity(orderVO);
		} else if (orderVO.getProgress().equals(oldprogress)) {
			
		};
		orderService.modifyOrder(orderVO);
		
		System.out.println("modifyOrder orderVO : " + orderVO );
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}


}
