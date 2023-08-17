package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.dw.vo.MemberVO;

@Mapper
public interface MemberDAO {

	MemberVO selectMemberById(String id) throws SQLException;

	void insertMember(MemberVO member) throws SQLException;

	String selectErank(int u_no) throws SQLException;

	String selectPWFind(MemberVO member) throws SQLException;

	MemberVO selectIDFind(MemberVO member)throws SQLException;

	void updatePwd(@Param("pwd") String pwd, @Param("id") String id) throws SQLException;

	void modProfile(MemberVO member) throws SQLException;

	void deleteUser(int u_no)throws SQLException;

	int getMail(Map<String, String> map) throws SQLException;

	int getMail2(Map<String, String> map) throws SQLException;





}
