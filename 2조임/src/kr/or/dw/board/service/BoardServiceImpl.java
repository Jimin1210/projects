package kr.or.dw.board.service;

import java.util.List;
import java.util.Map;

import kr.or.dw.board.dao.BoardDaoImpl;
import kr.or.dw.board.dao.IBoardDao;
import kr.or.dw.board.vo.BoardVO;
import kr.or.dw.board.vo.QABoardVO;

public class BoardServiceImpl implements IBoardService{
	
	private IBoardDao dao;
	private static BoardServiceImpl service;
	
	private BoardServiceImpl() {
		dao = BoardDaoImpl.getInstance();
	}
	
	public static BoardServiceImpl getInstance() {
		if(service == null) service = new BoardServiceImpl();
		return service;
	}

	@Override
	public List<BoardVO> selectBoardList(Map<String, Object> paramMap) {
		return dao.selectBoardList(paramMap);
	}

	

	@Override
	public int insertContent(BoardVO boardVo) {
		return dao.insertContent(boardVo);
	}

	@Override
	public BoardVO selectBoardView(int bd_no) {
		return dao.selectBoardView(bd_no);
	}

	@Override
	public int updateContent(BoardVO boardVo) {
		return dao.updateContent(boardVo);
	}

	@Override
	public void deleteContent(int bd_no) {
		dao.deleteContent(bd_no);
	}


	@Override
	public int selectBoardCount(int val) {
		return dao.selectBoardCount(val);
	}

	@Override
	public void updateCount(int bd_no) {
		dao.updateCount(bd_no);
	}

	@Override
	public void insertBoard(BoardVO vo) {
		dao.insertBoard(vo);
	}

	@Override
	public void modify(Map<String, Object> map) {
		dao.modify(map);
	}

	@Override
	public List<BoardVO> selectBoardList2(int notice) {
		return dao.selectBoardList2(notice);
	}

	@Override
	public List<QABoardVO> selectQA(Map<String, Object> paramMap) {
		return dao.selctQA(paramMap);
	}



}
