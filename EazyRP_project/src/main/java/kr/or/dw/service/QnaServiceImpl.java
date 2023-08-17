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
import kr.or.dw.dao.QnaDAO;
import kr.or.dw.vo.InquiryVO;



@Service
public class QnaServiceImpl implements QnaService {
	
	@Autowired
	private QnaDAO qnaDAO;

	@Override
	public Map<String, Object> selectQnaList(SearchCriteria cri, int u_no) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		Map<String, Object> map = new HashMap<>();
		map.put("cri", cri);
		map.put("u_no", u_no);
		List<Map<String, Object>> qnaList = qnaDAO.selectQnaList(rowBounds, map);
		int totalCount = qnaDAO.selectQnaListCount(map);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("qnaList", qnaList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public void insertQna(InquiryVO qna) throws SQLException {
		qnaDAO.insertQna(qna);
		
	}

	@Override
	public void remove(int inq_no) throws SQLException {
		qnaDAO.deleteQna(inq_no);
		
	}

	@Override
	public void modifyQna(InquiryVO inquiry) throws SQLException {
		qnaDAO.modifyQna(inquiry);
	}


	

	
	
}
