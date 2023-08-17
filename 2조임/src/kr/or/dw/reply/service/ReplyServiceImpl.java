package kr.or.dw.reply.service;

import java.util.List;
import java.util.Map;

import kr.or.dw.reply.dao.IReplyDao;
import kr.or.dw.reply.dao.ReplyDaoImpl;
import kr.or.dw.reply.vo.ReplyVO;

public class ReplyServiceImpl implements IReplyService{

	private IReplyDao dao;
	private static ReplyServiceImpl service;
	
	private ReplyServiceImpl() {
		dao = ReplyDaoImpl.getInstance();
	}
	
	public static ReplyServiceImpl getInstance() {
		if(service == null) service = new ReplyServiceImpl();
		return service;
	}

	@Override
	public void insertReply(Map<String, Object> map) {
		dao.insertReply(map);
	}

	@Override
	public List<ReplyVO> getReplyList(int num) {
		return dao.getReplyList(num);
	}

}
