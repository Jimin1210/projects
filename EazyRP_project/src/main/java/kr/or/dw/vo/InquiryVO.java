package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class InquiryVO {
	
	private int inq_no;	// 문의사항 번호
	private String inq_title;	// 제목
	private String inq_con;	// 내용
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date regdate;	// 등록일
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedate;	// 수정일
	private int vcnt;	// 조회수
	private int u_no;	// 문의자 계정번호
	private String sys_up;	// 수정자
	private String sys_reg;	// 최초등록

	
}
