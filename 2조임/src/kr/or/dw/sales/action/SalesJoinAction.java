package kr.or.dw.sales.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.sales.service.ISalesService;
import kr.or.dw.sales.service.SalesServiceImpl;
import kr.or.dw.sales.vo.SalesVO;
import kr.or.dw.web.IAction;

public class SalesJoinAction implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		String date = req.getParameter("a_date");
		
		ISalesService service = SalesServiceImpl.getInstance();
		
		List<SalesVO> vo = null;
		
		req.setAttribute("vo", vo);
		
		return "/sales/salesJoin.jsp";
	}

}
