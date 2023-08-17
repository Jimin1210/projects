package kr.or.dw.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.service.ContactService;
import kr.or.dw.service.DeptService;
import kr.or.dw.service.ItemService;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.MerchandiseService;
import kr.or.dw.service.ProcessService;
import kr.or.dw.service.ProductService;
import kr.or.dw.service.ShopService;
import kr.or.dw.service.WarehouseService;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DeptVO;
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
public class DeptController {
	
	private static final Logger logger = LoggerFactory.getLogger(DeptController.class);
	
	@Autowired
	private DeptService deptService;
	
	@RequestMapping("/dept")
	public ModelAndView deptMain(String mymenu, ModelAndView mnv, String mcode, String murl, SearchCriteria cri) throws SQLException{
		String url="";
    	if(mymenu == null) {
			url="inventory/basic/dept.page";
		} else {
			url="inventory/basic/dept.mymenu";
		}
		
		Map<String, Object> dataMap = deptService.selectDeptList(cri);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/deptRegistForm")
	public ModelAndView deptRegistForm(ModelAndView mnv, HttpSession session) throws SQLException {
		String url = "inventory/basic/deptRegistForm";
		
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/registDept")
	public void registDept(DeptVO dept, HttpServletResponse res) throws Exception{
		
		deptService.registDept(dept);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/deptDetail")
	public ModelAndView warehouseDetail (ModelAndView mnv, String dept_no) throws SQLException {
		DeptVO dept = deptService.selectDeptDetail(dept_no);
		String url = "inventory/basic/deptDetail";
		mnv.addObject("dept", dept);
		mnv.setViewName(url);
		return mnv;
	}

	@RequestMapping("/modifyDept")
	public void modifyItem(DeptVO dept, HttpServletResponse res, HttpSession session) throws Exception {		
		
		deptService.modifyDept(dept);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정 되었습니다.')");
		out.println("location.href='deptDetail.do?dept_no=" + dept.getDept_no() + "'");
		out.println("window.opener.location.reload();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteDept")
	public void deleteContact(String dept_no, HttpServletResponse res, HttpSession session) throws Exception{
		
		deptService.deleteDept(dept_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}

}
