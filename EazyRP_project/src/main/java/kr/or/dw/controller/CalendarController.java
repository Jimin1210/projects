package kr.or.dw.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.synth.SynthSplitPaneUI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javassist.expr.Instanceof;
import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.service.CalendarService;
import kr.or.dw.vo.CalendarVO;

//일정보기
@Controller
@RequestMapping("/calendar")
public class CalendarController {

	@Autowired
	private CalendarService calendarService;

	@RequestMapping(value = "/start", method = RequestMethod.GET)
	public ModelAndView getCalendarList(ModelAndView mnv, HttpServletRequest request) {
			
			System.out.println("컨트롤러 /calendar/start 진입");
			String url = "common/calendar.open";
			
			List<CalendarVO> calendarList = null;
			try {
				calendarList = calendarService.getCalendar();
				request.setAttribute("calendarList", calendarList);
				mnv.addObject("calendarList", calendarList);
				mnv.setViewName(url);
				System.out.println("1" + calendarList);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return mnv;
		}
		
		@RequestMapping("/regist")
		public void add(CalendarVO calendar, HttpServletRequest req, HttpServletResponse res) throws IOException, SQLException {
			
			System.out.println("컨트롤러 : /calendar/regist 진입");
			calendarService.registCalendar(calendar);

		}
		
		@RequestMapping("/modify")
		@ResponseBody
		public String modify(CalendarVO calendar) throws SQLException, IOException {
			
			System.out.println("컨트롤러 : /calendar/modify 진입");
			
			System.out.println(calendar);
			System.out.println("calendar_no : " + calendar.getCalendar_no());
			System.out.println(calendar.getCalendar_end());
			calendarService.modify(calendar);
			return "SUCCESS";
			
		}
		
		@RequestMapping("/remove")
		@ResponseBody
		public String remove(CalendarVO calendar) throws SQLException {
			
			System.out.println("컨트롤러 /calendar/remove 진입");
			calendarService.remove(calendar);
			return "test";
		}
		
	}
