package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class WhTransferVO {
	
	private String wt_no;
	private String wh_no2;
	private String wh_no;
	private int total_quantity;
	private int emp_no;
	private String progress;
	private String sys_up;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_regdate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_updatedate;
	
	private String c_no; 
	
	private String pr_no;
	private int quantity;
	private String pr_name;
	
}
