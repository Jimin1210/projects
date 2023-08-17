package kr.or.dw.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Pro_whVO {
	
	private String wh_no;
	private String wh_name;
	private String wh_gb;
	private String addr;
	private String enabled;
	private String c_no;
	private String pc_code;
	private String sys_up;
	private Date sys_regdate;
	private Date sys_updatedate;
	private String sys_reg;
	private String c_name;
	private String pr_no;
	private String pr_name;
	private String pr_gr;
	private String pr_st;
	private int pr_inprice;
	private int pr_exprice;
	private String pr_class;
	private String img;
	private Date exdate;
	private String sp_no;
	private int quantity;
	
}
