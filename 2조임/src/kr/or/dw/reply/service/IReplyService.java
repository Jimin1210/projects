package kr.or.dw.reply.service;

import java.util.List;
import java.util.Map;

import kr.or.dw.reply.vo.ReplyVO;

public interface IReplyService {

	void insertReply(Map<String, Object> map);

	List<ReplyVO> getReplyList(int num);

}
