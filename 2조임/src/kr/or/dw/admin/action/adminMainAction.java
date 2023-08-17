package kr.or.dw.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.dw.admin.service.AdminServiceImpl;
import kr.or.dw.admin.service.IAdminService;
import kr.or.dw.admin.vo.CommVO;
import kr.or.dw.admin.vo.adminVO;
import kr.or.dw.user.vo.UserVO;
import kr.or.dw.web.IAction;

public class adminMainAction implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IAdminService service = AdminServiceImpl.getInstance();
		HttpSession session = req.getSession();
		List<CommVO> everyCommList = null;
		UserVO vo = (UserVO)session.getAttribute("userVO");
		int u_no = vo.getU_no();
		String pos = vo.getPos();
		
		IAdminService adminService = AdminServiceImpl.getInstance();
		List<adminVO> adminList = null;
		adminList = adminService.selectAdminList();
		
		if(pos.equals("알바")) {
		everyCommList = service.getComm(u_no);
			
		req.setAttribute("everyCommList", everyCommList);
		req.setAttribute("title", "급여 조회");
		return "/comm/commEverySelect.jsp";
		} else {

		req.setAttribute("adminList", adminList);
		req.setAttribute("title", "직원 조회");
		
		return "/admin/admin.jsp";
		}
	}

}
