package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SalVO {
	
	private String sal_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date saldate;
	private String totalamount;
	private String sys_up;
	private Date sys_regdate;
	private Date sys_updatedate;
	private String sys_reg;
	@DateTimeFormat(pattern = "yyyy-MM")
	private Date salmonth;
	private String paymentstatus;
	
}
