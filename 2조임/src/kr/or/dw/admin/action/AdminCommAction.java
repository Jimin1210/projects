package kr.or.dw.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.admin.service.AdminServiceImpl;
import kr.or.dw.admin.service.IAdminService;
import kr.or.dw.admin.vo.CommVO;
import kr.or.dw.web.IAction;

public class AdminCommAction implements IAction {

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		int u_no = 0;
		System.out.println("test1");
		u_no = Integer.parseInt(req.getParameter("u_no"));
		System.out.println("test2");
		IAdminService service = AdminServiceImpl.getInstance();
		System.out.println("test3");
		System.out.println(u_no);
		List<CommVO> commList = service.selectCommList(u_no);
		
		req.setAttribute("commList", commList);
		req.setAttribute("title", "급여");
		
		return "/comm/commSelect.jsp";
	}

}
