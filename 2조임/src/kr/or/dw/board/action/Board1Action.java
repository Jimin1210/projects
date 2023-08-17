package kr.or.dw.board.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.board.service.BoardServiceImpl;
import kr.or.dw.board.service.IBoardService;
import kr.or.dw.board.vo.BoardVO;
import kr.or.dw.board.vo.QABoardVO;
import kr.or.dw.reply.service.IReplyService;
import kr.or.dw.reply.service.ReplyServiceImpl;
import kr.or.dw.reply.vo.ReplyVO;
import kr.or.dw.util.BoardJoinUtil;
import kr.or.dw.web.IAction;

public class Board1Action implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IBoardService service = BoardServiceImpl.getInstance();
		IReplyService replService = ReplyServiceImpl.getInstance();
		int val = Integer.parseInt(req.getParameter("notice"));
		int u_no = Integer.parseInt(req.getParameter("u_no"));
		if(u_no == -1) {
			return "/user/back.jsp";
		} else {
			
			if (val == 5) {
				int notice = Integer.parseInt(req.getParameter("notice"));
				
				Map<String, Object> paramMap = new HashMap<>();
				paramMap.put("notice", notice);
				
				// 게시판 목록을 가져온다.
				/* List<BoardVO> boardList = service.selectBoardList(paramMap); */
				
				List<QABoardVO> QAboard = service.selectQA(paramMap);
				
				req.setAttribute("QAboard", QAboard);
				
				
				req.setAttribute("notice", notice);
				req.setAttribute("u_no", u_no);
				
				
				return "/board/QA.jsp";
			} else { 
		
			// 페이징처리
			Map<String, Integer> pagingConfigMap = null;
			BoardJoinUtil pagination = null;
			String pageParam = req.getParameter("page");	// 사용자가 선택한 페이지 번호
			int page = (pageParam == null ? 1 : Integer.parseInt(pageParam));
			pagination = new BoardJoinUtil();
			int totalCount = service.selectBoardCount(val);
			pagination.setConfig(page, 10, 10, totalCount);
			pagingConfigMap = pagination.getConfig();
			
			// ibatis에서 받을 parameterMap 을 만든다.
			Map<String, Object> paramMap = new HashMap<>();
			paramMap.put("start", pagingConfigMap.get("start"));
			paramMap.put("end", pagingConfigMap.get("end"));
			paramMap.put("val", val);
			
			
			// 게시판 목록을 가져온다.
			List<BoardVO> boardList = service.selectBoardList(paramMap);
			
			req.setAttribute("boardList", boardList);
			req.setAttribute("pagingConfigMap", pagination);
			req.setAttribute("notice", val);
		
			return "/board/board1.jsp";
		}
	}
	}
}
