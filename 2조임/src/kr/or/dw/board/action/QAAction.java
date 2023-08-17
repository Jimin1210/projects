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
import kr.or.dw.web.IAction;

public class QAAction implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int notice = Integer.parseInt(req.getParameter("notice"));
		int u_no = Integer.parseInt(req.getParameter("u_no"));
		if(u_no == -1) {
			return "/user/back.jsp";
		} else {
		
		IBoardService service = BoardServiceImpl.getInstance();
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("val", notice);
		
		// 게시판 목록을 가져온다.
		/* List<BoardVO> boardList = service.selectBoardList(paramMap); */
		
		List<QABoardVO> QAboard = service.selectQA(paramMap);
		
		req.setAttribute("QAboard", QAboard);
		
		
		req.setAttribute("notice", notice);
		req.setAttribute("u_no", u_no);
		
		return "/board/QA.jsp";
		}
	}

}
