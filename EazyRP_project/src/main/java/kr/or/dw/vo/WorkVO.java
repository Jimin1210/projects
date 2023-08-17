package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class WorkVO {

	private int w_no;
	private int emp_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date wdate;
	private String ep_no;
	private String wtime;
	private String sys_up;
	private Date sys_regdate;
	private Date sys_updatedate;
	private String sys_reg;

	
}
