package kr.or.dw.vo;

import lombok.Data;

@Data
public class ErrorVO {
	
	private String er_no;
	private String sys_regdate;
	private int emp_no;
	private int quantity;
	private String wo_no;
	private int amount;
	private String c_no;
	private String pr_no;
	private String fac_no;
	private String pr_name;
	private String fac_name;
	private int pr_inprice;
	
}
