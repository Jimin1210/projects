package kr.or.dw.vo;

import lombok.Data;

@Data
public class ProfitLossVO {
	
	private int pl_no;
	private String c_no;
	private String pl_date;
	private int amount;
	private int loss;
	private int sale;
	private int profit;
	private int totalProfit;
	
}
