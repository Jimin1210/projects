package kr.or.dw.user.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.dw.user.service.IUserService;
import kr.or.dw.user.service.UserServiceImpl;
import kr.or.dw.user.vo.UserVO;
import kr.or.dw.web.IAction;

public class ProfileUpdateAction implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IUserService service = UserServiceImpl.getInstance();
		String nick = req.getParameter("nick");
		int picture = Integer.parseInt(req.getParameter("picture"));
		int u_no = Integer.parseInt(req.getParameter("u_no"));
		
		
		HttpSession session = req.getSession();
		
		UserVO userVo = (UserVO)session.getAttribute("userVO");
		userVo.setPicture(picture);
		

		Map<String, Object> map = new HashMap<>();
		map.put("nick", nick);
		map.put("picture", picture);
		map.put("u_no", u_no);
		
		service.updateStatus(map);
		
		session.setAttribute("userVO", userVo);
		
		req.setAttribute("u_no", u_no);
		
		return "/user/main.jsp";
	}

}
