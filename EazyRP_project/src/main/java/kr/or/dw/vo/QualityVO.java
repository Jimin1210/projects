package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class QualityVO {
	
	private int qcdetail_no;
	private String content;
	
	private int qc_no;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sys_regdate;
	private String pr_no;
	private int quantity;
	private int emp_no;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date sys_updatedate;
	private String sys_up;
	private String progress;
	private String enabled;
	
	private String files;
	private String realFileName;
	private String pr_delete;
	
}
