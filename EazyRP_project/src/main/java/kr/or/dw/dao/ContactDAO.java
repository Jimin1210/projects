package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;

@Mapper
public interface ContactDAO {

	int selectContactListCount(SearchCriteria cri) throws SQLException;

	List<Map<String, Object>> selectContactList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	List<CompanyVO> getContactList() throws SQLException;

	List<CompanyVO> getSearchContactList(Map<String, String> dataMap) throws SQLException;

	void updateContactGb(String c_no) throws SQLException;

	Map<String, Object> selectContactDetail(String c_no) throws SQLException;

	void modifyContact(CompanyVO contact) throws SQLException;

	void updateAccount(Map<String, String> account) throws SQLException;

	void deleteContact(CompanyVO contact) throws SQLException;

	
}
