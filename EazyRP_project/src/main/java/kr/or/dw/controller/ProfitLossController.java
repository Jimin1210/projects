package kr.or.dw.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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
import kr.or.dw.command.SearchCriteria2;
import kr.or.dw.service.ProfitLossService;
import kr.or.dw.vo.ProfitLossVO;
import kr.or.dw.vo.Tr_historyVO;
@Controller
@RequestMapping("/profitLoss")
public class ProfitLossController {

	private static final Logger logger = LoggerFactory.getLogger(ProfitLossController.class);
	
	@Autowired
	private ProfitLossService profitLossService;
	
	@RequestMapping("/profit")
	public ModelAndView profit(String mymenu, ModelAndView mnv,String murl, String mcode, SearchCriteria2 cri2, SearchCriteria cri, HttpSession session) throws SQLException {
		Map<String, Object> plVo = new HashMap<>();
		String c_no = (String) session.getAttribute("c_no");
		System.out.println("날짜````");
		System.out.println(cri2.getStartDate());
		System.out.println(cri2.getEndDate());
		if(cri2.getStartDate().equals("")) {
			LocalDate now = LocalDate.now();
		    LocalDate yearAndMonth = LocalDate.of(now.getYear(), now.getMonthValue(), 1);
		    
		    cri2.setStartDate(yearAndMonth.toString().substring(0, 7));
		    cri2.setEndDate(yearAndMonth.toString().substring(0, 7));
		}
		plVo = profitLossService.getMonthHistorys(c_no, cri, cri2);
		
		mnv.addAllObjects(plVo);
		mnv.addObject("cri2", cri2);
		List<Integer> a = (List<Integer>) plVo.get("amount");
		List<Integer> b = (List<Integer>) plVo.get("amount2");
		int prevAmount = 0;
		int total = 0;
		for(int i = 0; i < a.size(); i++) {
			total += a.get(i);
		}
		for(int i = 0; i < b.size(); i++) {
			prevAmount += b.get(i);
		}
		String url = "";
    	if(mymenu == null) {
			url="/profitLoss/profit.page";
		} else {
			url="/profitLoss/profit.mymenu";
		}
		mnv.setViewName(url);
		mnv.addObject("total", total);
		mnv.addObject("prevAmount", prevAmount);
		mnv.addObject("b",b);
		mnv.addObject("murl", murl);
		mnv.addObject("mcode", mcode);
		return mnv;
	}
	
	@RequestMapping("/dayProfit")
	public ModelAndView dayProfit(String mymenu, String murl, ModelAndView mnv, String mcode, SearchCriteria2 cri2, SearchCriteria cri, HttpSession session) throws SQLException {
		Map<String, Object> plVo = new HashMap<>();
		System.out.println("컨트롤러 엔드데이트임" + cri2.getEndDate());
		String c_no = (String) session.getAttribute("c_no");
		System.out.println("날짜````");
		System.out.println(cri2.getStartDate());
		System.out.println(cri2.getEndDate());
		if(cri2.getStartDate().equals("")) {
			LocalDate now = LocalDate.now();
			
			cri2.setStartDate(now.toString());
			cri2.setEndDate(now.toString());
			
		}
		plVo = profitLossService.getDayHistorys(c_no, cri, cri2);
		List<String> gb = new ArrayList<>();
		List<Tr_historyVO> history = new ArrayList<>();
		history = (List<Tr_historyVO>) plVo.get("list");
		for(int i = 0; i < history.size(); i++) {
			String trgb = history.get(i).getTr_gb();
			if(trgb.equals("s")) {
				gb.add("쇼핑몰 판매");
			} else if(trgb.equals("w")) {
				gb.add("창고 이동");
			} else if(trgb.equals("pb")) {
				gb.add("제품 구매");
			} else if(trgb.equals("b")) {
				gb.add("기타 구매");
			} else if(trgb.equals("o")) {
				gb.add("발주 요청");
			} else if(trgb.equals("e")) {
				gb.add("불량 처리");
			} else if(trgb.equals("p")) {
				gb.add("급여 제공");
			} else if(trgb.equals("a")) {
				gb.add("AS 비용");
			}
		}
		mnv.addObject("gb", gb);
		mnv.addAllObjects(plVo);
		mnv.addObject("cri2", cri2);
		String url = "";
    	if(mymenu == null) {
			url="/profitLoss/dayProfit.page";
		} else {
			url="/profitLoss/dayProfit.mymenu";
		}
		mnv.setViewName(url);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		return mnv;
	}
	
	@RequestMapping("/tr_history")
	public ModelAndView tr_history(String mymenu, ModelAndView mnv,String murl, String mcode, SearchCriteria2 cri2, SearchCriteria cri, HttpSession session) throws SQLException {
		Map<String, Object> plVo = new HashMap<>();
		String c_no = (String) session.getAttribute("c_no");
		System.out.println("날짜````");
		System.out.println(cri2.getStartDate());
		System.out.println(cri2.getEndDate());
		if(cri2.getStartDate().equals("")) {
			LocalDate now = LocalDate.now();
			
			cri2.setStartDate(now.toString());
			cri2.setEndDate(now.toString());
			
		}
		plVo = profitLossService.getHistorys(c_no, cri, cri2);
		List<String> gb = new ArrayList<>();
		List<Tr_historyVO> history = new ArrayList<>();
		history = (List<Tr_historyVO>) plVo.get("list");
		for(int i = 0; i < history.size(); i++) {
			String trgb = history.get(i).getTr_gb();
			if(trgb.equals("s")) {
				gb.add("쇼핑몰 판매");
			} else if(trgb.equals("w")) {
				gb.add("창고 이동");
			} else if(trgb.equals("pb")) {
				gb.add("제품 구매");
			} else if(trgb.equals("b")) {
				gb.add("기타 구매");
			} else if(trgb.equals("o")) {
				gb.add("발주 요청");
			} else if(trgb.equals("e")) {
				gb.add("불량 처리");
			} else if(trgb.equals("p")) {
				gb.add("급여 제공");
			} else if(trgb.equals("a")) {
				gb.add("AS 비용");
			}
		}
		mnv.addObject("gb", gb);
		mnv.addAllObjects(plVo);
		mnv.addObject("cri2", cri2);
		String url = "";
    	if(mymenu == null) {
			url="/profitLoss/tr_history.page";
		} else {
			url="/profitLoss/tr_history.mymenu";
		}
		mnv.setViewName(url);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		return mnv;
	}
	
	@RequestMapping("regbtn")
	public void regBtn(HttpServletResponse res) throws SQLException, IOException {
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i = 0; i < 1000; i ++) {
			Map<String, Object> map = new HashMap<>();
			int random2 = (int) (Math.random()*12) + 1;
			int c = 0;
			if(random2 == 1 || random2 == 3 || random2 == 5 || random2 == 7 || random2 == 8) {
				c = 30;
			} else if (random2 == 4 || random2 == 6) {
				c = 29;
			} else if(random2 == 2) {
				c = 27;
			}
			int z = (int) (Math.random()*2);
			int year = 0;
			if(z == 1) {
				year = 2020;
			} else {
				year = 2021;
			}
			String date1 = String.format(year + "-%02d-", random2);
			int random1 = (int) (Math.random()*c) + 1;
			String date = String.format(date1 + "%02d", random1);
			map.put("date", date);
			System.out.println(date);
			

			int b = (int) (Math.random()*2);
			int saleprice = (int) (Math.random()*100) * 10000;
			int unitprice = (int) (Math.random()*100) * 10000;
			if(saleprice < unitprice) {
				int a = saleprice;
				saleprice = unitprice;
				unitprice = a;
			}
			int amount = saleprice - unitprice;
			if(amount < 200000) {
				saleprice = (int) (Math.random()*100) * 10000;
				unitprice = (int) (Math.random()*100) * 10000;
				if(saleprice < unitprice) {
					int a = saleprice;
					saleprice = unitprice;
					unitprice = a;
				}
				amount = saleprice - unitprice;
			}
			System.out.println(amount);
			int g = (int) (Math.random()*8);
			String gb = "";
			switch(g){
				case 0: gb = "s"; 
				saleprice = saleprice * 4;
				unitprice = unitprice * 4;
				amount = amount * 4;
				break;
				case 1: gb = "w";
				if(b == 0) {
					amount = amount * -1;
				}
				break;
				case 2: gb = "pb"; 
				amount = amount * -1;
				break;
				case 3: gb = "b"; 
				saleprice = saleprice / 10;
				unitprice = unitprice / 10;
				amount = amount / 10;
				amount = amount * -1;
				break;
				case 4: gb = "o"; 
				amount = amount * -1;
				break;
				case 5: gb = "e"; 
				saleprice = saleprice / 10;
				unitprice = unitprice / 10;
				amount = amount / 10;
				amount = amount * -1;
				break;
				case 6: gb = "p"; 
				amount = amount * -1;
				break;
				case 7: gb = "a"; 
				break;
			}

			map.put("saleprice", saleprice);

			map.put("unitprice", unitprice);
			
			map.put("amount", amount);
			map.put("gb", gb);
			System.out.println(gb);
			int quantity = (int) (Math.random() * 500);
			map.put("quantity", quantity);
			System.out.println(quantity);
			list.add(map);
		}
		profitLossService.insertProfitLoss(list);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('ㅇㅋ')");
		out.println("history.go(-1);");
		out.println("</script>");
		
	}
	
	@RequestMapping("/openMonth")
	public ModelAndView openMonth(String month, ModelAndView mnv) throws SQLException {
		
		List<Tr_historyVO> history = profitLossService.getDetail(month);
		
		YearMonth yearMonth = YearMonth.parse(month);
		int year = Integer.parseInt(month.toString().substring(0, 4)) - 1;
		int mon = Integer.parseInt(month.toString().substring(5, 7));
        String display = yearMonth.getYear() + "년 " + yearMonth.getMonth().getDisplayName(TextStyle.FULL, Locale.KOREAN);
        YearMonth yearMonth2 = YearMonth.of(year, mon);

        // 해당 년월의 시작일 구하기
        LocalDate startDate = yearMonth2.atDay(1);

        // 해당 년월의 마지막일 구하기
        LocalDate endDate = yearMonth2.atEndOfMonth();
        String prevYear = year + "-" + (mon < 10 ? "0" : "") + mon;
        List<Tr_historyVO> history2 = profitLossService.getDetail(prevYear);
        System.out.println(prevYear);
		int s_total = 0;
		int w_total = 0;
		int pb_total = 0;
		int b_total = 0;
		int o_total = 0;
		int e_total = 0;
		int p_total = 0;
		int a_total = 0;
		int amount = 0;
		Map<String, Integer> total = new HashMap<>();
		for(int i = 0; i < history.size(); i++) {
			if(history.get(i).getTr_gb().equals("s")) {
				s_total += history.get(i).getAmount();
			} else if(history.get(i).getTr_gb().equals("w")) {
				w_total+= history.get(i).getAmount();
			} else if(history.get(i).getTr_gb().equals("pb")) {
				pb_total+= history.get(i).getAmount();
			} else if(history.get(i).getTr_gb().equals("b")) {
				b_total+= history.get(i).getAmount();
			} else if(history.get(i).getTr_gb().equals("o")) {
				o_total+= history.get(i).getAmount();
			} else if(history.get(i).getTr_gb().equals("e")) {
				e_total+= history.get(i).getAmount();
			} else if(history.get(i).getTr_gb().equals("p")) {
				p_total+= history.get(i).getAmount();
			} else if(history.get(i).getTr_gb().equals("a")) {
				a_total+= history.get(i).getAmount();
			}
			amount += history.get(i).getAmount();
		}
		total.put("s", s_total);
		total.put("w", w_total);
		total.put("pb", pb_total);
		total.put("b", b_total);
		total.put("o", o_total);
		total.put("e", e_total);
		total.put("p", p_total);
		total.put("a", a_total);
		mnv.addObject("amount", amount);
		
		s_total = 0;
		 w_total = 0;
		 pb_total = 0;
		 b_total = 0;
		 o_total = 0;
		 e_total = 0;
		 p_total = 0;
		 a_total = 0;
		 amount = 0;
		for(int i = 0; i < history2.size(); i++) {
			if(history2.get(i).getTr_gb().equals("s")) {
				s_total += history2.get(i).getAmount();
			} else if(history2.get(i).getTr_gb().equals("w")) {
				w_total+= history2.get(i).getAmount();
			} else if(history2.get(i).getTr_gb().equals("pb")) {
				pb_total+= history2.get(i).getAmount();
			} else if(history2.get(i).getTr_gb().equals("b")) {
				b_total+= history2.get(i).getAmount();
			} else if(history2.get(i).getTr_gb().equals("o")) {
				o_total+= history2.get(i).getAmount();
			} else if(history2.get(i).getTr_gb().equals("e")) {
				e_total+= history2.get(i).getAmount();
			} else if(history2.get(i).getTr_gb().equals("p")) {
				p_total+= history2.get(i).getAmount();
			} else if(history2.get(i).getTr_gb().equals("a")) {
				a_total+= history2.get(i).getAmount();
			}
			amount += history2.get(i).getAmount();
		}
		total.put("s2", s_total);
		total.put("w2", w_total);
		total.put("pb2", pb_total);
		total.put("b2", b_total);
		total.put("o2", o_total);
		total.put("e2", e_total);
		total.put("p2", p_total);
		total.put("a2", a_total);
        mnv.addObject("start", startDate);
        mnv.addObject("end", endDate);
		mnv.addObject("amount2", amount);
		mnv.addAllObjects(total);
		mnv.addObject("month", display);
		mnv.addObject("history", history);
		mnv.setViewName("/profitLoss/detail");
		return mnv;
	}
	
}
