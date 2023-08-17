package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;

public interface ContactService {

	Map<String, Object> selectContactList(SearchCriteria cri) throws SQLException;

	List<CompanyVO> getContact(Map<String, String> dataMap) throws SQLException;

	List<CompanyVO> getContactList() throws SQLException;

	void registContact(String c_no) throws SQLException;

	Map<String, Object> selectContactDetail(String c_no) throws SQLException;

	void modifyContact(CompanyVO contact) throws SQLException;

	void updateAccount(Map<String, String> account) throws SQLException;

	void deleteContact(CompanyVO contact) throws SQLException;

	


}
