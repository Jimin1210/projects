package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class WorkOrderVO {
	private String wo_no;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_regdate;
	private int emp_no;
	private String progress;
	private String enabled;
	private String wh_no;
//	private int quantity;
	private String files;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date deliverydate;
	private String sys_up;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_updatedate;
	private String sys_reg;
	private String supplier;
	private String wo_name;
	private String c_no;	// 회사번호
	private int amount;
	private String e_name;
	private String pr_name;
	// workorderdetail
	private int quantity;	// 수량
	private String pr_no;	// 제품번호
	private String detail_no;
	private String fac_no;
	private String pr_delete;
	
}
