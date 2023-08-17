package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;

import kr.or.dw.vo.CalendarVO;

public interface CalendarService {
	
	List<CalendarVO> getCalendar() throws SQLException;

	void registCalendar(CalendarVO calendar) throws SQLException;

	void modify(CalendarVO calendar) throws SQLException;

	void remove(CalendarVO calendar) throws SQLException;
	
}
