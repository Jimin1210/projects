package kr.or.dw.board.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.board.service.BoardServiceImpl;
import kr.or.dw.board.service.IBoardService;
import kr.or.dw.web.IAction;

public class ModifyFormAction implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int num = Integer.parseInt(req.getParameter("num"));
		int notice = Integer.parseInt(req.getParameter("notice"));
		
		req.setAttribute("num", num);
		req.setAttribute("notice", notice);
		
		return "/board/modify.jsp";
	}

}
