package kr.or.dw.vo;

import lombok.Data;

@Data
public class CalendarVO {
	private int calendar_no;
	private String calendar_title;
	private String calendar_memo;
	private String calendar_start;
	private String calendar_end;
}