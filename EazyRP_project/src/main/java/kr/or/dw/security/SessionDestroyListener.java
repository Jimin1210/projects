package kr.or.dw.security;

import java.util.List;

import org.springframework.context.ApplicationListener;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.session.SessionDestroyedEvent;

import kr.or.dw.vo.MemberVO;

public class SessionDestroyListener implements ApplicationListener<SessionDestroyedEvent>{

	@Override
	public void onApplicationEvent(SessionDestroyedEvent event) {
		List<SecurityContext> contexts = event.getSecurityContexts();
		if(!contexts.isEmpty()) {
			for(SecurityContext ctx : contexts) {
				Authentication auth = ctx.getAuthentication();
				
				if(auth != null && auth.getDetails() != null) {
					User user = (User) auth.getDetails();
					
					MemberVO member = user.getMemberVO();
					
					System.out.println("user invalid session : " + member);
				}
			}
		}
	}

}
