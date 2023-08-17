package kr.or.dw.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import kr.or.dw.vo.MemberVO;

public class User implements UserDetails{
	
	private MemberVO member;
	public User(MemberVO member) {
		this.member = member;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
		return roles;
	}

	@Override
	public String getPassword() {
		return member.getPwd();
	}

	@Override
	public String getUsername() {
		return member.getId();
	}

	@Override
	public boolean isAccountNonExpired() {	// 기간제 계정의 경우 기간만료 여부
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {	// 휴면 계정 여부
		return member.getEnabled() == 1;
	}

	@Override
	public boolean isCredentialsNonExpired() {	// 인증정보 만료 여부
		return true;
	}

	@Override
	public boolean isEnabled() {	// 사용 제제 여부
		return member.getEnabled() == 1;
	}
	
	public MemberVO getMemberVO() {
		return this.member;
	}

}
