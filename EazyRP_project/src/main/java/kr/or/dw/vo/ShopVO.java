package kr.or.dw.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ShopVO {
	private String s_no;
	private String s_name;
	private String sys_reg;
	private String sys_up;
	private Date sys_regdate;
	private Date sys_updatedate;
	private String enabled;
}
