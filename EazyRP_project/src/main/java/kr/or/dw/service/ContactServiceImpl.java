package kr.or.dw.service;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.ContactDAO;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.EmpVO;



@Service
public class ContactServiceImpl implements ContactService {
	
	@Autowired
	private ContactDAO contactDAO;

	@Override
	public Map<String, Object> selectContactList(SearchCriteria cri) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<Map<String, Object>> contactList = contactDAO.selectContactList(cri, rowBounds);
		int totalCount = contactDAO.selectContactListCount(cri);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("contactList", contactList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
		
	}

	@Override
	public List<CompanyVO> getContact(Map<String, String> dataMap) throws SQLException {
		List<CompanyVO> contactList = null;
		contactList = contactDAO.getSearchContactList(dataMap);
		
		return contactList;
	}

	@Override
	public List<CompanyVO> getContactList() throws SQLException {
		List<CompanyVO> contactList = null;
		contactList = contactDAO.getContactList();
		
		return contactList;
	}

	@Override
	public void registContact(String c_no) throws SQLException {
		contactDAO.updateContactGb(c_no);
	}

	@Override
	public Map<String, Object> selectContactDetail(String c_no) throws SQLException {
		Map<String, Object> contact = contactDAO.selectContactDetail(c_no);
		return contact;
	}

	@Override
	public void modifyContact(CompanyVO contact) throws SQLException {
		contactDAO.modifyContact(contact);
	}

	@Override
	public void updateAccount(Map<String, String> account) throws SQLException {
		contactDAO.updateAccount(account);
		
	}

	@Override
	public void deleteContact(CompanyVO contact) throws SQLException {
		contactDAO.deleteContact(contact);
		
	}

	

	
	
}
