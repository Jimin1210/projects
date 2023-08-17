package kr.or.dw.service;

import java.sql.SQLException;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.InquiryVO;

public interface QnaService {

	Map<String, Object> selectQnaList(SearchCriteria cri, int u_no) throws SQLException;

	void insertQna(InquiryVO qna) throws SQLException;

	void remove(int inq_no) throws SQLException;

	void modifyQna(InquiryVO inquiry) throws SQLException;



}
