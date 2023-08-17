package kr.or.dw.service;

import java.sql.SQLException;

import kr.or.dw.vo.MemberVO;

public interface MemberService {

	MemberVO selectMemberById(String id)throws SQLException;

	void register(MemberVO member) throws SQLException;

	String pwFind(MemberVO member) throws SQLException;

	MemberVO idFind(MemberVO member) throws SQLException;

	void pwRenew(String pwd, String id) throws SQLException;

	void modProfile(MemberVO member) throws SQLException;

	void delete(int u_no) throws SQLException;







}
