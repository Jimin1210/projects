package kr.or.dw.board.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.board.service.BoardServiceImpl;
import kr.or.dw.board.service.IBoardService;
import kr.or.dw.web.IAction;

public class BoardDeleteAction implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IBoardService service = BoardServiceImpl.getInstance();
		int notice = Integer.parseInt(req.getParameter("notice"));
		int u_no = Integer.parseInt(req.getParameter("u_no"));
		
		service.deleteContent(Integer.parseInt(req.getParameter("num")));
		
		req.setAttribute("notice", notice);
		
		return "/board/board1.do?notice=" + notice + "&u_no=" + u_no;
	}

}
