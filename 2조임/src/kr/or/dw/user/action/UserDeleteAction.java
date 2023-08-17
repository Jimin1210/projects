package kr.or.dw.user.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.user.service.IUserService;
import kr.or.dw.user.service.UserServiceImpl;
import kr.or.dw.web.IAction;

public class UserDeleteAction implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IUserService service = UserServiceImpl.getInstance();
		int u_no = Integer.parseInt(req.getParameter("u_no"));
		
		service.userDelete(u_no);
		
		return "/user/deleteSuccess.jsp";
	}

}
