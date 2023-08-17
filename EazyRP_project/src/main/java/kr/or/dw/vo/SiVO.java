package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SiVO {
	
	private String si_no;
	private String sidetail_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sys_regdate;
	private int emp_no;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date shipdate;
	private String progress;
	private String enabled;
	private String wh_no;
	private int quantity;
	private String files;
	private String fc_no;
	private String sys_up;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sys_updatedate;
	private String e_name;
	private String fc_name;
	private String wh_name;
	private String pr_name;
	private String pr_no;
	private String content;
	private String pr_delete;
	
}
