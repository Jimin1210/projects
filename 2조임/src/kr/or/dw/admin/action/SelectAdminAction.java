package kr.or.dw.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.admin.service.AdminServiceImpl;
import kr.or.dw.admin.service.IAdminService;
import kr.or.dw.admin.vo.adminVO;
import kr.or.dw.web.IAction;

public class SelectAdminAction implements IAction {

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int u_no = 0;
		u_no = Integer.parseInt(req.getParameter("u_no"));
		IAdminService adminService = AdminServiceImpl.getInstance();
		
		adminVO adminVo = null;
		adminVo = adminService.selectAdmin(u_no);
		
		

		req.setAttribute("adminVo", adminVo);
		req.setAttribute("title", "직원 직급 수정");
		
	
		return "/update/joinUser.jsp";
	}
	
}
