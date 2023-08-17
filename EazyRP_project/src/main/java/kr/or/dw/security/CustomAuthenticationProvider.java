package kr.or.dw.security;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;

import kr.or.dw.dao.MemberDAO;
import kr.or.dw.vo.MemberVO;

public class CustomAuthenticationProvider implements AuthenticationProvider{
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public Authentication authenticate(Authentication auth) throws AuthenticationException {
		String login_id = (String) auth.getPrincipal();	// 로그인 시도한 ID를 가져온다.
		String login_pwd = (String) auth.getCredentials();	// 로그인 시도한 PASSWORD 를 가져온다.
		
		MemberVO member = null;
		
		try {
			member = memberDAO.selectMemberById(login_id);
		} catch (SQLException e) {
			throw new AuthenticationServiceException("Internal server error !!"); 
		}
		
		if(member != null && login_pwd.equals(member.getPwd())) {	// 로그인 성공
			if(member.getEnabled()==0) {
				throw new DisabledException("정지된 계정입니다. \\n관리자에게 문의하세요.");
			}
			
			User authUser = new User(member);
			
			// 스프링 시큐리티 내부 클래스로 인증 토큰 생성한다.
			UsernamePasswordAuthenticationToken result =
					new UsernamePasswordAuthenticationToken(authUser.getUsername(), authUser.getPassword(), authUser.getAuthorities());
			// 전달할 내용을 설정한 후
			result.setDetails(authUser);
			// 리턴. default-target-url 로 전송된다.
			return result;
		}else {	// 로그인 실패
			throw new BadCredentialsException("Bad ID or Password");
		}
		
	}

	@Override
	public boolean supports(Class<?> auth) {
		// UsernamePasswordAuthenticationToken 리턴할 때 파라미터와 같은 레퍼런스인지 비교를 하고 리턴을 한다.
		// default-target-url로 전송된다.
		return auth.equals(UsernamePasswordAuthenticationToken.class);
	}

}
