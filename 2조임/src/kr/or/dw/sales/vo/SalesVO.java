package kr.or.dw.sales.vo;

import java.sql.Date;

public class SalesVO {
	private String a_date;
	private int dailysales;
	private int cnt;
	
	public int getDailysales() {
		return dailysales;
	}
	public void setDailysales(int dailysales) {
		this.dailysales = dailysales;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getA_date() {
		return a_date;
	}
	public void setA_date(String a_date) {
		this.a_date = a_date;
	}
	
}
