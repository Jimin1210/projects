package kr.or.dw.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.service.OrderSaleService;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.SaleDetailVO;
import kr.or.dw.vo.SsheetVO;

@Controller
@RequestMapping("/erp4")
public class OrderSheetController {
	
	@Autowired
	private OrderSaleService orderSaleService;
	
	private static final Logger logger = LoggerFactory.getLogger(OrderSheetController.class);
	
	@RequestMapping("/sale")
	public ModelAndView sale(String mymenu, ModelAndView mnv, String mcode, String murl,HttpSession session, SearchCriteria cri) throws SQLException  {
		String url = "";
    	if(mymenu == null) {
			url="jihwan/productSale.page";
		} else {
			url="jihwan/productSale.mymenu";
		}
		String c_no = (String) session.getAttribute("c_no");
		Map<String, Object> dataMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		dataMap.put("c_no", c_no);
		dataMap.put("cri", cri);
		
		map = orderSaleService.selectSaleList(dataMap);
		mnv.addObject("searchType", cri.getSearchType());
		mnv.addObject("keyword", cri.getKeyword());
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(map);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/saleDetail")
	public ModelAndView saleDetail (ModelAndView mnv,String sheet_no, HttpSession session) throws SQLException  {
		String url = "/jihwan/saleDetail.open";
		
		List<SaleDetailVO> saledetail = orderSaleService.getSaleDetail(sheet_no);
		SsheetVO sheet = orderSaleService.getSheet(sheet_no);
		
		mnv.addObject("saledetail" , saledetail);
		mnv.addObject("sheet", sheet);
		mnv.setViewName(url);
		
		return mnv;
		
	}
	
	@RequestMapping("/productSaleRegist")
	public ModelAndView productSaleRegist(ModelAndView mnv, HttpSession session) {
		mnv.addObject("empno", session.getAttribute("emp_no"));
		mnv.addObject("ename", session.getAttribute("e_name"));
		mnv.setViewName("/jihwan/productSaleRegist");
		
		return mnv;
	}
	
	@RequestMapping("/productSaleRegistForm")
	public void productSaleRegistForm(HttpServletResponse res, HttpSession session, SsheetVO sheet, String[] pr_no, int[] quantity, String pr_name,int[] amount) throws SQLException, IOException {
		sheet.setCon_c_no((String)session.getAttribute("c_no"));
		sheet.setPr_name(pr_name);
		sheet.setBuy_c_no("");
		int sheet_no = orderSaleService.insertProductSale(sheet);
		
		List<SaleDetailVO> detail = new ArrayList<SaleDetailVO>();
		
		for(int i=0; i< pr_no.length; i++) {
			SaleDetailVO vo = new SaleDetailVO();
			vo.setAmount(amount[i]);
			vo.setPr_no(pr_no[i]);
			vo.setQuantity(quantity[i]);
			vo.setSheet_no(sheet_no);
			detail.add(i, vo);
		}
		orderSaleService.insertProductDetail(detail);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('판매 내역 추가가 완료되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
	}
	
	@RequestMapping("/saleremove")
	public void saleRemove (String sheet_no, HttpServletResponse res) throws SQLException, IOException  {
		
		orderSaleService.saleRemove(sheet_no);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	
	
}
