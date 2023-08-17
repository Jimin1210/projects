package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class SalDetailVO {
	
	private String saldetail_no;
	private int emp_no;
	private String sal_no;
	private String DED_001;
	private String DED_006;
	private String DED_009;
	private String DED_010;
	private String DED_011;
	private String DED_012;
	private int realsumsal;
}
