package kr.or.dw.vo;

import lombok.Data;

@Data
public class O_DetailVO {

	private int od_no;
	private int o_no;
	private String pr_no;
	private int quantity;
	private int buy_price;
	private int unit_price;
	private String pr_name;
	private String wh_no;
	private String wh_name;
	private String c_name;
	private String lack;
	
}
