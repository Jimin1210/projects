package kr.or.dw.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
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
import kr.or.dw.service.ContactService;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.MerchandiseService;
import kr.or.dw.service.ProcessService;
import kr.or.dw.service.ProductService;
import kr.or.dw.service.ShopService;
import kr.or.dw.service.WarehouseService;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.MenuVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.NoteVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.WareHouseVO;

@Controller
@RequestMapping("/erp4")
public class WarehouseController {
	
	private static final Logger logger = LoggerFactory.getLogger(WarehouseController.class);
	
	@Autowired
	private WarehouseService warehouseService;
	
	@RequestMapping("/warehouse")
	public ModelAndView warehouseMain(String mymenu, ModelAndView mnv, String mcode, String murl, SearchCriteria cri, HttpSession session) throws SQLException{
		String url= "";
		if(mymenu == null) {
			url="inventory/basic/warehouse.page";
		} else {
			url="inventory/basic/warehouse.mymenu";
		}
		
		String c_no = session.getAttribute("c_no").toString();
		
		Map<String, Object> dataMap = warehouseService.selectWarehouseList(cri, c_no);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/warehouseRegistForm")
	public ModelAndView contactRegistForm(ModelAndView mnv, HttpSession session) throws SQLException {
		String url = "inventory/basic/warehouseRegistForm";
		
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/registWarehouse")
	public void registWarehouse(WareHouseVO warehouse, HttpServletResponse res, int emp_no, HttpSession session) throws Exception{
		
		warehouse.setC_no(session.getAttribute("c_no").toString());
		warehouse.setSys_reg(emp_no + "");
		warehouse.setSys_up(emp_no + "");
		
		warehouseService.registWarehouse(warehouse);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/warehouseDetail")
	public ModelAndView warehouseDetail (ModelAndView mnv, String wh_no) throws SQLException {
		Map<String, Object> warehouse = warehouseService.selectWarehouseDetail(wh_no);
		String url = "inventory/basic/warehouseDetail";
		mnv.addObject("warehouse", warehouse);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/findCompany")
	public ModelAndView findCompany(ModelAndView mnv, String searchType, String keyword) throws SQLException {
		String url = "inventory/basic/findCompany";
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<CompanyVO> companyList = null;
		Map<String, String> dataMap = new HashMap<>();
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			companyList = warehouseService.getCompany(dataMap);
		} else {
			companyList = warehouseService.getCompanyList();
		}
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("companyList", companyList);
		
		return mnv;
	}
	
	@RequestMapping("/modifyWarehouse")
	public void modifyWarehouse(WareHouseVO warehouse, HttpServletResponse res, HttpSession session) throws Exception {
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		System.out.println(emp_no);
		warehouse.setSys_reg(emp_no + "");
		warehouse.setSys_up(emp_no + "");
		
		warehouseService.modifyWarehouse(warehouse);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteWarehouse")
	public void deleteContact(String wh_no, HttpServletResponse res, HttpSession session) throws Exception{
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		
		WareHouseVO warehouse = new WareHouseVO();
		
		warehouse.setSys_up(emp_no + "");
		warehouse.setSys_reg(emp_no + "");
		warehouse.setWh_no(wh_no);
		
		warehouseService.deleteWarehouse(warehouse);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}

}
