package kr.or.dw.board.service;

import java.util.List;
import java.util.Map;

import kr.or.dw.board.vo.BoardVO;
import kr.or.dw.board.vo.QABoardVO;
import kr.or.dw.reply.vo.ReplyVO;
public interface IBoardService {

	List<BoardVO> selectBoardList(Map<String, Object> paramMap);

	int selectBoardCount(int val);

	int insertContent(BoardVO boardVo);

	BoardVO selectBoardView(int bd_no);

	int updateContent(BoardVO boardVo);

	void deleteContent(int parseInt);

	void updateCount(int bd_no);

	void insertBoard(BoardVO vo);

	void modify(Map<String, Object> map);

	List<BoardVO> selectBoardList2(int notice);

	List<QABoardVO> selectQA(Map<String, Object> paramMap);


}
