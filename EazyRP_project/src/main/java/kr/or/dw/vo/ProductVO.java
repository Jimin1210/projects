package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ProductVO {
	private String pr_no;
	private String pr_name;
	private String c_no;
	private String pr_gr;
	private String pr_st;
	private int pr_inprice;
	private int pr_exprice;
	private String pr_class;
	private String img;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date exdate;
	private String sp_no;
	private int quantity;
	private String wh_no;
	private String sys_up;
	private String sys_reg;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_regdate;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_updatedate;
	private String c_name;
	private String wh_name;

}
