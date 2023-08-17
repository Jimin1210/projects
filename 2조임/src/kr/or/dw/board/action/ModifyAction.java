package kr.or.dw.board.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.dw.board.service.BoardServiceImpl;
import kr.or.dw.board.service.IBoardService;
import kr.or.dw.board.vo.BoardVO;
import kr.or.dw.user.vo.UserVO;
import kr.or.dw.web.IAction;

public class ModifyAction implements IAction{

	@Override
	public boolean isRedirect() {
		return true;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IBoardService service = BoardServiceImpl.getInstance();
		Map<String, Object> map = new HashMap<>();
		HttpSession session = req.getSession();
		UserVO vo = (UserVO) session.getAttribute("userVO");
		int notice = Integer.parseInt(req.getParameter("notice"));
		
		
		String title = req.getParameter("title");
		int num = Integer.parseInt(req.getParameter("num"));
		String content = req.getParameter("content");

		
		System.out.println(title);
		System.out.println(content);
		System.out.println(num);
		
		map.put("title", title);
		map.put("content", content);
		map.put("num", num);
		req.setAttribute("notice", notice);
		service.modify(map);
		
		return "/board/boardView.do?num=" + num + "&u_no=" + vo.getU_no() + "&notice=" + notice;
	}

}
