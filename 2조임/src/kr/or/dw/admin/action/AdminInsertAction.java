package kr.or.dw.admin.action;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.dw.admin.service.AdminServiceImpl;
import kr.or.dw.admin.service.IAdminService;
import kr.or.dw.admin.vo.adminVO;
import kr.or.dw.util.CryptoUtil;
import kr.or.dw.web.IAction;

public class AdminInsertAction implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		IAdminService service = AdminServiceImpl.getInstance();
		adminVO adminVo = new adminVO();
		// 받아온 값을  adminVo에 셋팅
		BeanUtils bean = new BeanUtils();
		req.setAttribute("adminVo", adminVo);
		
		try {
			bean.populate(adminVo, req.getParameterMap());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		//비밀번호 암호화
		String pass = req.getParameter("pwd");
		try {
			pass = CryptoUtil.sha512(pass);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		adminVo.setPwd(pass);
		
		int result = 0;
		result = service.insertAdminView(adminVo);
		
//		if( req.getParameter("u_no") != null) {
//			int u_no = Integer.parseInt(req.getParameter("u_no"));
//			adminVO adminVo = service.insertAdminView(u_no);			
//			req.setAttribute("title", "입사 처리");
//		}
		
		return "/admin/success.jsp";
	}

}
