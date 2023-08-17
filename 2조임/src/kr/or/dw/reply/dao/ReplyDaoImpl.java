package kr.or.dw.reply.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.dw.reply.vo.ReplyVO;
import kr.or.dw.util.BuildSqlMapClient;

public class ReplyDaoImpl implements IReplyDao{

	
	private static ReplyDaoImpl dao;
	private SqlMapClient client;
	
	private ReplyDaoImpl() {
		client = BuildSqlMapClient.getSqlMapClient();
	}
	
	public static ReplyDaoImpl getInstance() {
		if(dao == null) dao = new ReplyDaoImpl();
		return dao;
	}

	@Override
	public void insertReply(Map<String, Object> map) {
		
		try {
			client.insert("board.insertReply", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<ReplyVO> getReplyList(int num) {
		List<ReplyVO> vo = null;
		
		try {
			vo = (List<ReplyVO>)client.queryForList("board.getReplyList", num);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	


}
