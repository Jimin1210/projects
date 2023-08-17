package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.dao.CalendarDAO;
import kr.or.dw.vo.CalendarVO;

@Service("calendarService")
public class CalendarServiceImpl implements CalendarService {

	@Autowired
	private CalendarDAO calendarDAO;
	
	@Override
	public List<CalendarVO> getCalendar() throws SQLException {
		List<CalendarVO> result = null;
		try {
			result = calendarDAO.getCalendar();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result; 
	}

	@Override
	public void registCalendar(CalendarVO calendar) throws SQLException {
		calendarDAO.insertCalendar(calendar);
	}

	@Override
	public void modify(CalendarVO calendar) throws SQLException {
		calendarDAO.updateCalendar(calendar);
	}

	@Override
	public void remove(CalendarVO calendar) throws SQLException {
		calendarDAO.deleteCalendar(calendar);
	}
	
}