package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.dw.vo.CalendarVO;

@Mapper
public interface CalendarDAO {
	
	List<CalendarVO> getCalendar() throws SQLException;

	void insertCalendar(CalendarVO calendar) throws SQLException;

	void updateCalendar(CalendarVO calendar) throws SQLException;

	void deleteCalendar(CalendarVO calendar) throws SQLException;

}