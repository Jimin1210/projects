package kr.or.dw.user.service;

import java.util.List;
import java.util.Map;

import kr.or.dw.user.vo.UserVO;

public interface IUserService {
	
	public String getUserNick(String nick);	// 닉네임을 조회하는 메서드

	public int insertUser(UserVO vo);	// 회원 정보를 등록하는 메서드

	public UserVO loginUser(String id);	// 회원 정보를 조회하는 메서드

	public void updateUserPicPath(UserVO vo);	// 회원의 프로필 사진 경로를 수정하는 메서드

	public List<String> idListGet();

	public String getUserId(String id);

	public int getUserNumber(String nick);

	public void updateStatus(Map<String, Object> map);

	public void userDelete(int u_no);
}
