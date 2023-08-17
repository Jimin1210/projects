package kr.or.dw.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.command.SearchCriteria2;
import kr.or.dw.service.ManagementService;
import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.PaVO;

@Controller
@RequestMapping("/pa")
public class PaController {
	
	@Autowired
	private ManagementService managementService;
	
	@RequestMapping("/pa")
	public ModelAndView pa(ModelAndView mnv, String mcode, String mymenu, HttpSession session, SearchCriteria2 cri2, SearchCriteria cri) throws SQLException {
		String url = "";
		if(mymenu == null) {
			url="pa/pa.page";
		} else {
			url="pa/pa.mymenu";
		}
		
		if(cri2.getStartDate().equals("")) {
			LocalDate now = LocalDate.now();
			
			cri2.setStartDate(now.toString());
			cri2.setEndDate(now.toString());
		}
		Map<String, Object> map = new HashMap<>();
		String c_no = (String) session.getAttribute("c_no");
		map.put("cri2", cri2);
		map.put("cri", cri);
		map.put("c_no", c_no);
		
		Map<String, Object> dataMap = new HashMap<>();
		
		dataMap = managementService.getPaList(map);
		System.out.println(dataMap.get("name"));
		mnv.addObject("mcode", mcode);
		mnv.addObject("cri", cri);
		mnv.addObject("cri2", cri2);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/paInsert")
	private ModelAndView paInsert(ModelAndView mnv,HttpSession session) throws SQLException {
		String c_no = (String) session.getAttribute("c_no");
		List<DeptVO> dept = managementService.getDept();
		
		mnv.addObject("dept", dept);
		mnv.addObject("c_no", c_no);
		mnv.setViewName("/pa/paInsert");
		return mnv;
	}
	
	@RequestMapping("/findPeople")
	private ModelAndView findPeople(ModelAndView mnv, HttpSession session, SearchCriteria cri) throws SQLException {
		String c_no = (String) session.getAttribute("c_no");
		List<EmpVO> emp = new ArrayList<>();
		emp = managementService.getEmpList(c_no);
		List<String> dept = managementService.getDeptList(emp);
		
		mnv.addObject("dept", dept);
		mnv.addObject("emp", emp);
		mnv.setViewName("/pa/findPeople");
		return mnv;
	}
	
	@RequestMapping("/paRegist")
	private void paRegist(int[] emp_no, String[] prerank,String[] c_no,String[] predept,String[] predept_no, String padate,
			String[] nextrank, String[] nextdept, String[] pg_no, HttpServletResponse res) throws SQLException, IOException {
		System.out.println(predept);
		System.out.println(nextdept);
		List<PaVO> paList = new ArrayList<>();
		for(int i = 0; i < emp_no.length; i++) {
			PaVO pa = new PaVO();
			pa.setPadate(padate);
			pa.setPg_no(pg_no[i]);
			pa.setEmp_no(emp_no[i]);
			pa.setPredept(predept[i]);
			pa.setC_no(c_no[i]);
			pa.setNextdept(nextdept[i]);
			pa.setPredept(predept[i]);
			pa.setPrerank(prerank[i]);
			pa.setNextrank(nextrank[i]);
			paList.add(pa);
		}
		managementService.paRegist(paList);
		
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('인사 발령 등록이 완료되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	
}
