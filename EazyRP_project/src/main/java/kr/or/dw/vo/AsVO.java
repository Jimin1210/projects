package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class AsVO {
	
	
	private String as_no; // A/S 코드
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_regdate; // 등록일자
	private int emp_no;	// 사원번호
	private int progress;	// 진행상태
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date repairdate;	// 수리예정일
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date compldate;	// 완료일
	private String sys_up;	// 수정자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_updatedate;	//수정일
	private String sys_reg;	//최초등록자
	private int asprice;	//수리비용
	private String content;
	private String e_name;
	private String c_no;
	
}
