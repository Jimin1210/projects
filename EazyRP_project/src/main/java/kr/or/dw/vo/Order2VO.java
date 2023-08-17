package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Order2VO {
	private String sys_reg;
	private int buy_price;
	private int unit_price;
	private String buy_c_no;
	private String con_c_no;
	private String con_c_name;
	private String dr_no;
	private String title;
	private int quantity;
	private String o_no;
	private String o_name;
	private String o_gb;
	private String sys_regdate;
	private String deliverydate;
	private String receivedate;
	private String progress;
}
