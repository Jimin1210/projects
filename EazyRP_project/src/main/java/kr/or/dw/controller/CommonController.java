package kr.or.dw.controller;

import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.MyMenuDAO;
import kr.or.dw.service.CalendarService;
import kr.or.dw.service.ManagementService;
import kr.or.dw.service.MemberService;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.ProductService;
import kr.or.dw.vo.CalendarVO;
import kr.or.dw.vo.DraftVO;
import kr.or.dw.vo.MemberVO;
import kr.or.dw.vo.MenuVO;
import kr.or.dw.vo.MyMenuVO;
import kr.or.dw.vo.Order2VO;

@Controller
public class CommonController {
	
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private CalendarService calendarService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private MyMenuDAO myMenuDAO;
	
	@GetMapping("/common/loginForm")
	public String loginForm(HttpServletResponse res) throws Exception {
		String url = "/common/loginForm";
		return url;
	}
	
	@RequestMapping("/security/accessDenied")
	public String accessDenied(HttpServletResponse res) throws Exception{
		String url = "security/accessDenied.open";
		
		res.setStatus(302);
		
		return url;
	}
	
	@RequestMapping("/common/LoginTimeOut")
	public void loginTimeOut(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		
		out.println("<script>");
		out.println("alert('세션이 만료되었습니다.\\n다시 로그인하세요!')");
		out.println("location.href='/common/loginForm'");
		out.println("</script>");
		out.close();
	}
	
	@RequestMapping("/common/LoginExpired")
	public void loginExpired(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		
		out.println("<script>");
		out.println("alert('중복 로그인이 확인되었습니다.\\n 다시 로그인하면 다른 장치의 로그인은 해제됩니다!')");
		out.println("location.href='/';");
		out.println("</script>");
		out.close();
	}
	
	@RequestMapping("/common/logout")
	public String logout(HttpServletRequest req) throws Exception {
		HttpSession session = req.getSession(false);
	    if (session != null) {
	        session.invalidate();
	    }
	    return "/common/loginForm";
		
	}
	
	@RequestMapping("/common/main")
	public ModelAndView index (ModelAndView mnv, HttpSession session, HttpServletRequest req) throws SQLException{
		String url = "/common/main.main";

		Map<String, List<String>> empMap = new HashMap<>();
		List<String> e_nameList = new ArrayList<>();
		List<Integer> emp_noList = new ArrayList<>();
		if(session.getAttribute("c_no") == null || session.getAttribute("c_no").equals("")) {

			session.setAttribute("c_no", "");
			session.setAttribute("emp_no", 0);
			e_nameList.add(0, "업체를 선택해주세요.");
			emp_noList.add(0, 0);
			session.setAttribute("e_nameList", e_nameList);
			session.setAttribute("emp_noList", emp_noList);
			session.setAttribute("empMap", empMap);
		}
		
		List<MenuVO> menuList = menuService.selectMainMenuList();
		Map<String, Object> dataMap = menuService.selectSubMenuList(menuList);
		Map<String, List<MenuVO>> subMenuList = (Map<String, List<MenuVO>>) dataMap.get("subMenuList");
		Map<String, List<MenuVO>> smallMenuList = (Map<String, List<MenuVO>>) dataMap.get("smallMenuList");		

		List<CalendarVO> calendarList = null;
		try {
			calendarList = calendarService.getCalendar();
			req.setAttribute("calendarList", calendarList);
			mnv.addObject("calendarList", calendarList);
			mnv.setViewName(url);
			
			System.out.println(calendarList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		List<DraftVO> draft = menuService.getPayment(emp_no);
		mnv.addObject("draft", draft);
		
		LocalDate today = LocalDate.now();
		List<String> month = new ArrayList<>();
		List<String> month2 = new ArrayList<>();
		for(int i = 12; i >= 1; i--) {
			LocalDate lastMonth = today.minusMonths(i);
	        int lastMonthYear = lastMonth.getYear();
	        int lastMonthMonth = lastMonth.getMonthValue();
	        String insert = lastMonthYear + "-" + (lastMonthMonth < 10 ? "0" : "") +lastMonthMonth;
	        month.add(insert);
		}
		
		for(int i = 12; i >= 1; i--) {
			LocalDate lastMonth = today.minusMonths(i);
	        int lastMonthYear = lastMonth.getYear() - 1;
	        int lastMonthMonth = lastMonth.getMonthValue();
	        String insert = lastMonthYear + "-" + (lastMonthMonth < 10 ? "0" : "") +lastMonthMonth;
	        month2.add(insert);
		}
		List<Order2VO> list = null;
		String c_no = (String) session.getAttribute("c_no");
		list = productService.getOrderList(c_no);
		List<Integer> profit = new ArrayList<>();
		profit = menuService.getProfit(month);
		List<Integer> profit2 = new ArrayList<>();
		profit2 = menuService.getProfit(month2);
		mnv.addObject("month", month);
		System.out.println(month);
		mnv.addObject("profit", profit);
		mnv.addObject("profit2", profit2);
		System.out.println(profit);
		session.setAttribute("menuList", menuList);
		session.setAttribute("subMenuList", subMenuList);
		session.setAttribute("smallMenuList", smallMenuList);
		mnv.addObject("list",list);
		mnv.setViewName(url);	
		
		return mnv;
	}


	@RequestMapping("/common/registerForm")
	public String registerForm(HttpServletResponse res) throws Exception {
		return "/common/registerForm";

	}
	
	@RequestMapping("/common/change")
	public ModelAndView change(ModelAndView mnv,String murl, String mcode, HttpSession session,String selectedC_no, HttpServletRequest req) throws SQLException{
		System.out.println("1");
		String str = req.getRequestURI();
		System.out.println("2");
		String result = str.substring(0, str.indexOf("."));
		System.out.println("왜이러냐");
		System.out.println(result);
		String url = "";
		System.out.println(mcode);
		List<String> e_nameList = new ArrayList<>();
		List<String> emp_noList = new ArrayList<>();
		Map<String, List<String>> empMap = new HashMap<>();
		if(mcode == null || mcode.equals("")) {
			url = "/common/main.do";
		} else {
			String getUrl = menuService.getUrl(mcode);
			String getUrlResult = getUrl.substring(0, getUrl.indexOf("."));
			String modMcode = mcode.substring(0, 3) + "0000";
			System.out.println(modMcode);
			url = getUrl + "?mcode=" + modMcode + "&murl=" + getUrl;
		}
		if(selectedC_no.equals("") || selectedC_no == null) {
			session.setAttribute("c_no", "");
			session.setAttribute("emp_no", 0);
			session.setAttribute("c_name", "");
			e_nameList.add(0, "업체를 선택해주세요.");
			emp_noList.add(0, "0");
			empMap.put("e_nameList", e_nameList);
			empMap.put("emp_noList", emp_noList);
			session.setAttribute("empMap", empMap);
		} else {
			e_nameList = menuService.getE_name(selectedC_no);
			emp_noList = menuService.getEmp_no(selectedC_no);
			empMap.put("e_nameList", e_nameList);
			empMap.put("emp_noList", emp_noList);
			session.setAttribute("empMap", empMap);
		}
		
		System.out.println("url = " + url);
		session.setAttribute("c_no", selectedC_no);
		if(selectedC_no.equals("C000001")) {
			session.setAttribute("c_name", "(주)지민식품");
			session.setAttribute("emp_no", 0);
		} else if(selectedC_no.equals("C000002")) {
			session.setAttribute("c_name", "희성전자");
			session.setAttribute("emp_no", 0);
		} else if(selectedC_no.equals("C000003")) {
			session.setAttribute("c_name", "석준물산");
			session.setAttribute("emp_no", 0);
		} else if(selectedC_no.equals("C000004")) {
			session.setAttribute("c_name", "(주)소라전자");
			session.setAttribute("emp_no", 0);
		} else if(selectedC_no.equals("C000005")) {
			session.setAttribute("c_name", "민준식품");
			session.setAttribute("emp_no", 0);
		} else if(selectedC_no.equals("C000006")) {
			session.setAttribute("c_name", "지환물산");
			session.setAttribute("emp_no", 0);
		}
		
		mnv.setViewName("redirect:" + url);
		mnv.addObject("murl", murl);
		
		return mnv;
		
	}
	
	@RequestMapping("/common/empChange")
	public ModelAndView empChange(ModelAndView mnv, String murl, String mcode, HttpSession session,String selectedEmp, HttpServletRequest req) throws SQLException{
		String url = "";
		if(mcode == null || mcode.equals("")) {
			url = "/common/main.do";
		} else {
			String getUrl = menuService.getUrl(mcode);
			String getUrlResult = getUrl.substring(0, getUrl.indexOf("."));
			String modMcode = mcode.substring(0, 3) + "0000";
			System.out.println(modMcode);
			url = getUrl + "?mcode=" + modMcode + "&murl=" + getUrl;
		}
		String e_name = menuService.selectEname(selectedEmp);
		session.setAttribute("e_name", e_name);
		session.setAttribute("emp_no", selectedEmp);
		mnv.addObject("murl", murl);
		System.out.println("emp번호다 : " + selectedEmp);
		
		mnv.setViewName("redirect:" + url);
		return mnv;
	}
	
	@RequestMapping("/common/myMenuRegist")
	public ResponseEntity<String> myMenuRegist(@RequestBody MyMenuVO mymenu, HttpSession session) throws SQLException {
		ResponseEntity<String> entity = null;
		
		MemberVO member = (MemberVO)session.getAttribute("loginUser");
		
		int u_no = member.getU_no();
				
		try {
			myMenuDAO.registMyMenu(mymenu);
			List<Map<String, Object>> myMenuList = myMenuDAO.selectMyMenuList(u_no);
			session.setAttribute("myMenuList", myMenuList);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	@RequestMapping("/common/myMenuDelete")
	public ResponseEntity<String> myMenuDelete(@RequestBody MyMenuVO mymenu, HttpSession session) throws SQLException {
		ResponseEntity<String> entity = null;
				
		int u_no = mymenu.getU_no();
		try {
			myMenuDAO.deleteMyMenu(mymenu);
			List<Map<String, Object>> myMenuList = myMenuDAO.selectMyMenuList(u_no);
			session.setAttribute("myMenuList", myMenuList);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	}
	
	
}
