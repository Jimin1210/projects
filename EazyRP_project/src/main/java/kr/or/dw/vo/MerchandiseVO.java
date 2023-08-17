package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MerchandiseVO {
	private String sp_no;
	private String s_no;
	private String pr_no;
	private int sp_q;
	private int price;
	private String status;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startperiod;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endperiod;
	private String sys_reg;
	private String sys_up;
	private Date sys_regdate;
	private Date sys_updatedate;
	private String enabled;
	private int unitprice;
	
}
