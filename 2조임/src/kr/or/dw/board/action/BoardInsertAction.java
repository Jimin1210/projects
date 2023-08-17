package kr.or.dw.board.action;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.dw.board.service.BoardServiceImpl;
import kr.or.dw.board.service.IBoardService;
import kr.or.dw.board.vo.BoardVO;
import kr.or.dw.web.IAction;

public class BoardInsertAction implements IAction{

	@Override
	public boolean isRedirect() {
		return true;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IBoardService service = BoardServiceImpl.getInstance();
		String title = req.getParameter("title");
		System.out.println(title);
		int u_no = Integer.parseInt(req.getParameter("u_no"));
		int notice = Integer.parseInt(req.getParameter("notice"));
		
		BoardVO vo = new BoardVO();
		BeanUtils bean = new BeanUtils();
		try {
			bean.populate(vo, req.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		service.insertBoard(vo);
		
		return "/board/board1.do?notice=" + notice + "&u_no=" + u_no;
	}

}
