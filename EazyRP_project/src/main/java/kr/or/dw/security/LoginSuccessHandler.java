package kr.or.dw.security;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import kr.or.dw.dao.MyMenuDAO;
import kr.or.dw.vo.MemberVO;
import kr.or.dw.vo.MyMenuVO;

public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler{
	
	@Autowired
	private MyMenuDAO myMenuDAO;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		// 위의 authentication 은 AuthenticationProvider 에서 넘어온 Token
		
		User user = (User) authentication.getDetails();
		
		MemberVO member = user.getMemberVO();
		HttpSession session = request.getSession();
		session.setAttribute("loginUser", member);
		
		try {
			List<Map<String, Object>> myMenuList = myMenuDAO.selectMyMenuList(member.getU_no());
			session.setAttribute("myMenuList", myMenuList);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		super.onAuthenticationSuccess(request, response, authentication);
	}
	
	
	
}
