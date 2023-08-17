package kr.or.dw.user.action;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.dw.user.service.IUserService;
import kr.or.dw.user.service.UserServiceImpl;
import kr.or.dw.user.vo.UserVO;
import kr.or.dw.util.CryptoUtil;
import kr.or.dw.web.IAction;

public class UserInsertAction implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		UserVO vo = new UserVO();
		
		BeanUtils bean = new BeanUtils();
		
		try {
			bean.populate(vo, req.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}

		
		// 비밀번호 암호화
		String user_pwd = req.getParameter("pwd");
		try {
			user_pwd = CryptoUtil.sha512(user_pwd);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		vo.setPwd(user_pwd);

		IUserService service = UserServiceImpl.getInstance();
		service.insertUser(vo);
		String nick = vo.getNick();
		req.setAttribute("nick", nick);
		
		return "/user/joinSuccess.jsp";
	}

}
