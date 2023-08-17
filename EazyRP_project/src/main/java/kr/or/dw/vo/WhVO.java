package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class WhVO {
	
	private String wh_no;			// 생산입고코드
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_regdate;		// 등록일자
	private int emp_no;				// 사원번호
	private String enabled;			// 사용구분
	private String wh_no2;			// 창고코드(제품+업체)
	private int quantity;			// 수량
	private String files;			// 첨부파일
	private int outprice;			// 외주비단가
	private String wo_no;			// 작업지시서 번호
	private String sys_up;			// 수정자
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sys_updatedate;	// 수정일
	private String sys_reg;			// 최초등록자
	private int wh_total;			// 총합계
	private String progress;		// 진행상황
	private String c_no;			// 업체번호

	private String pr_no;			// 제품번호
	private String pr_name;			// 제품명
	private String fac_no;			// 공장번호
	private int total_outprice;		// 외주비합계
	private int detail_no;			// 상세번호
	private String e_name;			// 사원이름
	private String wh_name;			// 창고이름
	private String wo_name;			// 작업지시서 이름
	private String pr_delete;		// 디테일에서 tr 구분자
	
}
