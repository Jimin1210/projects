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
import kr.or.dw.service.BasicFactoryService;
import kr.or.dw.service.ContactService;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.MerchandiseService;
import kr.or.dw.service.ProcessService;
import kr.or.dw.service.ProductService;
import kr.or.dw.service.ShopService;
import kr.or.dw.service.WarehouseService;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.FactoryVO;
import kr.or.dw.vo.MenuVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.NoteVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.WareHouseVO;

@Controller
@RequestMapping("/erp4")
public class FactoryController {
	
	private static final Logger logger = LoggerFactory.getLogger(FactoryController.class);
	
	@Autowired
	private BasicFactoryService basicFactoryService;
	
	@RequestMapping("/factory")
	public ModelAndView factoryMain(String mymenu, ModelAndView mnv, String mcode, String murl, SearchCriteria cri, HttpSession session) throws SQLException{
		String url="";
    	if(mymenu == null) {
			url="inventory/basic/factory.page";
		} else {
			url="inventory/basic/factory.mymenu";
		}
    	String c_no = session.getAttribute("c_no").toString();
		Map<String, Object> dataMap = basicFactoryService.selectFactoryList(cri, c_no);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/factoryRegistForm")
	public ModelAndView factoryRegistForm(ModelAndView mnv, HttpSession session) throws SQLException {
		String url = "inventory/basic/factoryRegistForm";
		
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/registFactory")
	public void registFactory(FactoryVO factory, HttpServletResponse res) throws Exception{
		
		basicFactoryService.registFactory(factory);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/factoryDetail")
	public ModelAndView factoryDetail (ModelAndView mnv, String fac_no) throws SQLException {
		Map<String, Object> factory = basicFactoryService.selectFactoryDetail(fac_no);
		String url = "inventory/basic/factoryDetail";
		mnv.addObject("factory", factory);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/findProcess")
	public ModelAndView findProcess(ModelAndView mnv, String searchType, String keyword) throws SQLException {
		String url = "inventory/basic/findProcess";
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<ProcessVO> processList = null;
		Map<String, String> dataMap = new HashMap<>();
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			processList = basicFactoryService.getProcess(dataMap);
		} else {
			processList = basicFactoryService.getProcessList();
		}
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("processList", processList);
		
		return mnv;
	}
	
	@RequestMapping("/modifyFactory")
	public void modifyFactory(FactoryVO factory, HttpServletResponse res, HttpSession session) throws Exception {
		
		basicFactoryService.modifyFactory(factory);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteFactory")
	public void deleteFactory(String fac_no, HttpServletResponse res, HttpSession session) throws Exception{
		
		basicFactoryService.deleteFactory(fac_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}

}
