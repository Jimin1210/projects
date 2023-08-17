package kr.or.dw.board.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.dw.board.service.BoardServiceImpl;
import kr.or.dw.board.service.IBoardService;
import kr.or.dw.board.vo.BoardVO;
import kr.or.dw.reply.service.IReplyService;
import kr.or.dw.reply.service.ReplyServiceImpl;
import kr.or.dw.reply.vo.ReplyVO;
import kr.or.dw.web.IAction;

public class BoardViewAction implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int bd_no = 0;
		bd_no = Integer.parseInt(req.getParameter("num"));
		int u_no = Integer.parseInt(req.getParameter("u_no"));
		int notice = Integer.parseInt(req.getParameter("notice"));
		IReplyService service = ReplyServiceImpl.getInstance();
		IBoardService boardService = BoardServiceImpl.getInstance();
		BoardVO boardVo = null;
		boardService.updateCount(bd_no);
		
		boardVo = boardService.selectBoardView(bd_no);
		
//		List<ReplyVO> replyList = null;
//		replyList = boardService.selectReplyList(bd_no);
		

		List<ReplyVO> replyList = service.getReplyList(bd_no);
		
		req.setAttribute("replyList", replyList);
		
		req.setAttribute("boardVo", boardVo);
		req.setAttribute("u_no", u_no);
		req.setAttribute("notice", notice);
		
		return "/board/boardView.jsp";
	}

}
