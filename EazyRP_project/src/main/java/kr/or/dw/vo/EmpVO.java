package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class EmpVO {

	private int emp_no;
	private String e_rank;
	private String e_tel;
	private String e_name;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date e_hd;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date e_dd;
	private String c_no;
	private int e_sal;
	private String e_email;
	private String e_bank;
	private String e_account;
	private String e_tenure;
	private String enabled;
	private String dept_no;
	private int emp_no2;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date e_sva;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date e_eva;
	private int u_no;
	private String sys_up;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sys_regdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sys_updatedate;
	private String sys_reg;
	private String stampimg;
	private String dname;
	private String c_name;
	
	
	
}
