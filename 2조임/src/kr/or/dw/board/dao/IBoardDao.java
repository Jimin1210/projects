package kr.or.dw.board.dao;

import java.util.List;
import java.util.Map;

import kr.or.dw.board.vo.BoardVO;
import kr.or.dw.board.vo.QABoardVO;

public interface IBoardDao {

	List<BoardVO> selectBoardList(Map<String, Object> paramMap);

	int selectBoardCount(int val);

	int insertContent(BoardVO boardVo);

	BoardVO selectBoardView(int bd_no);

	int updateContent(BoardVO boardVo);

	void deleteContent(int bd_no);

	void updateCount(int bd_no);

	void insertBoard(BoardVO vo);

	void modify(Map<String, Object> map);

	List<BoardVO> selectBoardList2(int notice);

	List<QABoardVO> selctQA(Map<String, Object> paramMap);

}
