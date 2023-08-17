package kr.or.dw.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberVO {

	
	private int u_no; // 계정번호
	private String id;	
	private String pwd;
	private String name;
	private String gen;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birth;
	private String tel;
	private Date regdate;	// 가입날짜
	private Date last_login; // 마지막로그인
	private String c_no;  // 업체코드
	private String email;                          
	private String addr;
	private int enabled;
	
	public MemberVO() {};
	
	public MemberVO(String id, String pwd, String name,Date birth, String gen, String email, String tel, String addr) {
		this.id = id;
		this.pwd = pwd;
		this.name = name;
		this.birth = birth;
		this.gen = gen;
		this.email = email;
		this.tel = tel;
		this.addr = addr;		
				
	}
	
}
