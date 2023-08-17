package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class OrderVO {
	private String so_no;
	private String sp_no;
	private String reciever;
	private String tel;
	private String addr;
	private int quantity;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date orderdate;
	private String method;
	private String request;
	private String invoice;
	private int delfee;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date delstartdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date delenddate;
	private String failure;
	private String progress;
	private String gb;
	private String enabled;
	private String sys_up;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sys_regdate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sys_updatedate;
	private String sys_reg;
}
