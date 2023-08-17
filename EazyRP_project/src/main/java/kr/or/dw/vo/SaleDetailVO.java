package kr.or.dw.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SaleDetailVO {

	private int   amount;
    private String   pr_no;
    private int   quantity;
    private int   s_no;
    private String pr_name;
    private int sheet_no;
	
}
