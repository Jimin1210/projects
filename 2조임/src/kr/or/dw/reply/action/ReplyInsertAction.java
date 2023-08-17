package kr.or.dw.reply.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.dw.reply.service.IReplyService;
import kr.or.dw.reply.service.ReplyServiceImpl;
import kr.or.dw.reply.vo.ReplyVO;
import kr.or.dw.web.IAction;

public class ReplyInsertAction implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IReplyService service = ReplyServiceImpl.getInstance();
		
		int num = Integer.parseInt(req.getParameter("num"));
		String content = req.getParameter("content");
		int u_no = Integer.parseInt(req.getParameter("u_no"));
		int notice = Integer.parseInt(req.getParameter("notice"));
		
		Map<String, Object> map = new HashMap<>();
		
		
		map.put("num", num);
		map.put("content", content);
		map.put("u_no", u_no);
		map.put("notice", notice);
		
		service.insertReply(map);
		
		
		req.setAttribute("notice", notice);
		req.setAttribute("num", num);
		req.setAttribute("u_no", u_no);
			return "/board/replSuccess.jsp";
	}

}
