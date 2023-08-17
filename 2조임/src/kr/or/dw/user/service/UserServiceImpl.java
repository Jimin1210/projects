package kr.or.dw.user.service;

import java.util.List;
import java.util.Map;

import kr.or.dw.user.dao.IUserDao;
import kr.or.dw.user.dao.UserDaoImpl;
import kr.or.dw.user.vo.UserVO;

public class UserServiceImpl implements IUserService{

	private IUserDao dao;
	private static UserServiceImpl service;
	
	private UserServiceImpl() {
		dao = UserDaoImpl.getInstance();
	}
	
	public static UserServiceImpl getInstance() {
		if(service == null) service = new UserServiceImpl();
		return service;
	}
	
	@Override
	public String getUserNick(String nick) {
		return dao.getUserNick(nick);
	}

	@Override
	public int insertUser(UserVO vo) {
		return dao.insertUser(vo);
	}

	@Override
	public UserVO loginUser(String id) {
		return dao.loginUser(id);
	}

	@Override
	public void updateUserPicPath(UserVO vo) {
		dao.updateUserPicPath(vo);
	}

	@Override
	public List<String> idListGet() {
		return dao.idListGet();
	}

	@Override
	public String getUserId(String id) {
		return dao.getUserId(id);
	}

	@Override
	public int getUserNumber(String nick) {
		return dao.getUserNumber(nick);
	}

	@Override
	public void updateStatus(Map<String, Object> map) {
		dao.updateStatus(map);
	}

	@Override
	public void userDelete(int u_no) {
		dao.userDelete(u_no);
	}

}
