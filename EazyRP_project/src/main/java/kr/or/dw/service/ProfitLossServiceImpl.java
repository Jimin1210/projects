package kr.or.dw.service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.temporal.TemporalAdjusters;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.command.SearchCriteria2;
import kr.or.dw.dao.ProfitLossDAO;
import kr.or.dw.vo.ProfitLossVO;
import kr.or.dw.vo.Tr_historyVO;



@Service
public class ProfitLossServiceImpl implements ProfitLossService {
	
	@Autowired
	private ProfitLossDAO profitLossDAO;

	@Override
	public Map<String, Object> getHistorys(String c_no, SearchCriteria cri, SearchCriteria2 cri2) throws SQLException {
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		dataMap.put("keyword", cri.getKeyword());
		dataMap.put("searchType", cri.getSearchType());
		dataMap.put("cri", cri);
		dataMap.put("c_no", c_no);
		dataMap.put("cri2", cri2);
		List<Tr_historyVO> list = profitLossDAO.getHistory(dataMap, rowBounds);
		
		int totalCount = profitLossDAO.getTotalCount(dataMap);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setSys_regdate(list.get(i).getSys_regdate().substring(0, 10));
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("pageMaker", pageMaker);
		
		return map;
	}

	@Override
	public void insertProfitLoss(List<Map<String, Object>> list) throws SQLException {
		for(int i = 0; i < list.size(); i++) {
			profitLossDAO.insertProfitLoss(list.get(i));
		}
	}

	@Override
	public Map<String, Object> getDayHistorys(String c_no, SearchCriteria cri, SearchCriteria2 cri2)
			throws SQLException {
		Map<String, Object> dataMap = new HashMap<>();
		int total = 0;
		dataMap.put("keyword", cri.getKeyword());
		dataMap.put("searchType", cri.getSearchType());
		dataMap.put("cri", cri);
		dataMap.put("c_no", c_no);
		dataMap.put("cri2", cri2);
		List<Tr_historyVO> list = profitLossDAO.getDayHistory(dataMap);
		for(int i = 0; i < list.size(); i++) {
			total = total + list.get(i).getAmount();
			list.get(i).setSys_regdate(list.get(i).getSys_regdate().substring(0, 10));
		}
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("스타트데이트다" + cri2.getStartDate());
		System.out.println("엔드데이트다" + cri2.getEndDate());
		int prev = Integer.parseInt(cri2.getStartDate().substring(5, 7)) - 1;
		
		
		System.out.println("prev다" + prev);
		String prevMonth = "";
		String prevMonth2 = "";
		if(prev == 0) {
			prev = 12;
			prevMonth2 = (Integer.parseInt(cri2.getEndDate().substring(0, 4)) - 1) + (prev < 10 ? "0" : "") + prev + cri2.getEndDate().substring(7, 10);
			prevMonth = (Integer.parseInt(cri2.getStartDate().substring(0, 4)) - 1) + (prev < 10 ? "0" : "") + prev + cri2.getStartDate().substring(7, 10);
		} else {
			prevMonth = cri2.getStartDate().substring(0, 4) + (prev < 10 ? "0" : "") + prev + cri2.getStartDate().substring(7, 10);
			prevMonth2 = cri2.getEndDate().substring(0, 4) + (prev < 10 ? "0" : "") + prev + cri2.getEndDate().substring(7, 10);
		}
		System.out.println(prevMonth);
		Map<String, String> maps = new HashMap<>();
		maps.put("prevMonth", prevMonth);
		maps.put("prevMonth2", prevMonth2);
		List<Integer> prevTotal = profitLossDAO.getPrevMontTotal(maps);
		int prevAmount = 0;
		for(int i = 0; i < prevTotal.size(); i++) {
			prevAmount += prevTotal.get(i);
		}
		prevAmount = total - prevAmount;
		map.put("prevAmount",prevAmount);
		map.put("list", list);
		map.put("total", total);
		
		return map;
	}

	@Override
	public Map<String, Object> getMonthHistorys(String c_no, SearchCriteria cri, SearchCriteria2 cri2)
			throws SQLException {
        String startDateStr = cri2.getStartDate().substring(0, 7);
        String endDateStr = cri2.getEndDate().substring(0, 7);
        
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        YearMonth startYearMonth = YearMonth.parse(startDateStr, formatter);
        YearMonth endYearMonth = YearMonth.parse(endDateStr, formatter);

        List<Integer> amount = new ArrayList<>();
        List<Integer> amount2 = new ArrayList<>();
        List<Integer> amount3 = new ArrayList<>();
        List<String> month = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        
        for (YearMonth yearMonth = startYearMonth; !yearMonth.isAfter(endYearMonth); yearMonth = yearMonth.plusMonths(1)) {
            int selectedYear = yearMonth.getYear();
            int selectedMonth = yearMonth.getMonthValue();

            YearMonth prevYearMonth = yearMonth.minusYears(1);
            
            LocalDate startOfMonth = yearMonth.atDay(1);
            LocalDate endOfMonth = startOfMonth.with(TemporalAdjusters.lastDayOfMonth());
            
            LocalDate startOfPrevYearMonth = prevYearMonth.atDay(1);
            LocalDate endOfPrevYearMonth = startOfPrevYearMonth.with(TemporalAdjusters.lastDayOfMonth());
            
            // 날짜 범위를 이용하여 월별 데이터를 가져오는 작업
            Map<String, String> day = new HashMap<>();
            day.put("start", startOfMonth.toString());
            day.put("end", endOfMonth.toString());
            
            List<Tr_historyVO> list = profitLossDAO.getMonthHistory(day);
            
            int b = 0;
            for (Tr_historyVO history : list) {
                b += history.getAmount();
            }
            
            // 이전 년도 월별 데이터를 가져오는 작업
            Map<String, String> day2 = new HashMap<>();
            day2.put("start", startOfPrevYearMonth.toString());
            day2.put("end", endOfPrevYearMonth.toString());
            
            List<Tr_historyVO> list2 = profitLossDAO.getMonthHistory(day2);
            
            int c = 0;
            for (Tr_historyVO history : list2) {
                c += history.getAmount();
            }
            
            amount.add(b);
            amount2.add(b - c);
            amount3.add(c);
            month.add(yearMonth.format(formatter));
        }
			
		map.put("amount", amount);
		map.put("amount2", amount2);
		map.put("amount3", amount3);
		map.put("month", month);
	
		return map;
	}

	@Override
	public List<Tr_historyVO> getDetail(String month) throws SQLException {
		String[] parts = month.split("-");
        int year = Integer.parseInt(parts[0]);
        int selectedMonth = Integer.parseInt(parts[1]);

        YearMonth yearMonth = YearMonth.of(year, selectedMonth);
        LocalDate start = yearMonth.atDay(1);
        LocalDate end = yearMonth.atEndOfMonth();
        Map<String, String> map = new HashMap<>();
        map.put("start", start.toString());
        map.put("end", end.toString());
		List<Tr_historyVO> list = new ArrayList<>();
		list = (profitLossDAO.getMonthHistory(map));
		
		return list;
	}


	
}
