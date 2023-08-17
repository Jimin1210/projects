package kr.or.dw.user.action;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.dw.user.service.IUserService;
import kr.or.dw.user.service.UserServiceImpl;
import kr.or.dw.user.vo.UserVO;
import kr.or.dw.util.CryptoUtil;
import kr.or.dw.web.IAction;

public class UserLoginAction implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IUserService service = UserServiceImpl.getInstance();
		
		String id = req.getParameter("id");
		String pwd = req.getParameter("pwd");
		List<String> idList = service.idListGet();
		int check = 0;
		int result = 0;
		
		
		for(String a : idList) {
			if(a.equals(id)) {
				check = 1;
				break;
			}
		}
		
		if(check == 0) {
			id = "";
		} else {
			UserVO vo = service.loginUser(id);
		
		
		String cpass = "";
		try {
			cpass = CryptoUtil.sha512(pwd);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		
		
		if(vo != null && (cpass.equals(vo.getPwd()))) {
			result = 1;
			HttpSession session = req.getSession();
			session.setAttribute("userVO", vo);
		};
		
		String nick = service.getUserNick(vo.getNick());
		req.setAttribute("nick", nick);
		}
		req.setAttribute("result", result);
		
		return "/user/userLoginResult.jsp";
	}

}
