package kr.or.dw.user.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.dw.user.vo.UserVO;
import kr.or.dw.util.BuildSqlMapClient;

public class UserDaoImpl implements IUserDao{
	
	private static UserDaoImpl dao;
	private SqlMapClient client;
	
	private UserDaoImpl() {
		client = BuildSqlMapClient.getSqlMapClient();
	}
	
	public static UserDaoImpl getInstance() {
		if(dao == null) dao = new UserDaoImpl();
		return dao;
	}
	
	@Override
	public String getUserNick(String nick) {
		String userNick = null;
		
		try {
			userNick = (String)client.queryForObject("user.getUserNick", nick);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return userNick;
	}

	@Override
	public int insertUser(UserVO vo) {
		int result = 0;
		
		try {
			result = (int) client.insert("user.insertUser", vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public UserVO loginUser(String id) {
		UserVO vo = null;
		
		try {
			vo = (UserVO) client.queryForObject("user.loginUser", id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public void updateUserPicPath(UserVO vo) {
		try {
			client.update("user.updateUserPicPath", vo);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<String> idListGet() {
		List<String> id = null;
		
		try {
			id = (List<String>) client.queryForList("user.idListGet");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return id;
	}

	@Override
	public String getUserId(String id) {
		String getId = "";
		
		try {
			getId = (String)client.queryForObject("user.getUserId", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return getId;
	}

	@Override
	public int getUserNumber(String nick) {
		int val = 0;
		
		try {
			val = (int) client.queryForObject("user.getUserNumber", nick);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}

	@Override
	public void updateStatus(Map<String, Object> map) {
		try {
			client.update("user.updateStatus", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public void userDelete(int u_no) {
		try {
			client.update("user.deleteUser", u_no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
