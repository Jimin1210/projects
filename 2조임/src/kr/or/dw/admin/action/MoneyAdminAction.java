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

public class MoneyAdminAction implements IAction {

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
//		IAdminService moneyService = AdminServiceImpl.getInstance();
//		
//		List<adminVO> moneyList = null;
		
//		moneyList = moneyService.
		
		req.setAttribute("title", "매출 조회");

		return "/sales/money.jsp";
	}

}
