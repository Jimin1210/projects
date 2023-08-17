package kr.or.dw.board.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.dw.board.vo.BoardVO;
import kr.or.dw.board.vo.QABoardVO;
import kr.or.dw.reply.vo.ReplyVO;
import kr.or.dw.util.BuildSqlMapClient;

public class BoardDaoImpl implements IBoardDao{
	
	private static BoardDaoImpl dao;
	private SqlMapClient client;
	
	private BoardDaoImpl() {
		client = BuildSqlMapClient.getSqlMapClient();
	}
	
	public static BoardDaoImpl getInstance() {
		if(dao == null) dao = new BoardDaoImpl();
		return dao;
	}

	@Override
	public List<BoardVO> selectBoardList(Map<String, Object> paramMap) {
		
		List<BoardVO> boardList = null;
		
		try {
			boardList = client.queryForList("board.selectBoardList", paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return boardList;
	}

	@Override
	public int selectBoardCount(int val) {
		int count = 0;
		
		try {
			count = (int) client.queryForObject("board.selectBoardCount", val);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return count;
	}

	@Override
	public int insertContent(BoardVO boardVo) {
		int bd_no = 0;
		
		try {
			bd_no = (int) client.insert("board.insertContent", boardVo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return bd_no;
	}

	@Override
	public BoardVO selectBoardView(int bd_no) {
		BoardVO boardVo = null;
		
		try {
			boardVo = (BoardVO) client.queryForObject("board.selectBoardView", bd_no);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return boardVo;
	}

	@Override
	public int updateContent(BoardVO boardVo) {
		int result = 0;
		
		try {
			result = client.update("board.updateContent", boardVo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public void deleteContent(int bd_no) {
		try {
			client.update("board.deleteContent", bd_no);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void updateCount(int bd_no) {
		try {
			client.update("board.updateCount", bd_no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void insertBoard(BoardVO vo) {
		try {
			client.insert("board.insertBoard", vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void modify(Map<String, Object> map) {
		try {
			client.update("board.modify", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public List<BoardVO> selectBoardList2(int notice) {
		List<BoardVO> vo = null;
		
		try {
			vo = (List<BoardVO>)client.queryForList("board.selectBoardList2", notice);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public List<QABoardVO> selctQA(Map<String, Object> paramMap) {
		List<QABoardVO> vo = null;
		
		try {
			vo = (List<QABoardVO>)client.queryForList("board.selectQA", paramMap);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return vo;
	}

	
}
