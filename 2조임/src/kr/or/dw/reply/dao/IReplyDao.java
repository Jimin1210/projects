package kr.or.dw.reply.dao;

import java.util.List;
import java.util.Map;

import kr.or.dw.reply.vo.ReplyVO;

public interface IReplyDao {

	void insertReply(Map<String, Object> map);

	List<ReplyVO> getReplyList(int num);

}
