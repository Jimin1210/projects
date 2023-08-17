package kr.or.dw.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class EstimateVO {
	
	private int estdetail_no;
	private String est_no;
	private String wh_no;
	private int emp_no;
	private String fc_no;
	private int amount;
	private String progress;
	private int quantity;
	private String files;
	private String pr_no;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date regdate;
	private String c_no;
	private String realFileName;
	private String pr_delete;
	
	
}   

