package kr.or.dw.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SpriceVO {
	private String sp_no;
	private String sp_name;
	private int sp_in;
	private int sp_ex;
	private String sys_up;
	private String sys_reg;
	private Date sys_regdate;
	private Date sys_updatedate;
	private String enabled;
}
