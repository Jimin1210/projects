package kr.or.dw.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.server.ServerEndpoint;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.FactoryDAO;
import kr.or.dw.vo.FactoryVO;

@Service
public class FactoryServiceImpl implements FactoryService {

	@Autowired
	private FactoryDAO factoryDAO;
	
	@Override
	public Map<String, Object> selectFactoryList(SearchCriteria cri) throws SQLException {

		List<FactoryVO> factoryList = null;
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		factoryList = factoryDAO.selectSearchFactoryList(cri, rowBounds);
		
		// 전체 board 개수
		int totalCount = factoryDAO.selectSearchFactoryListCount(cri);
		
		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("factoryList", factoryList);
		dataMap.put("pageMaker", pageMaker);
				
		return dataMap;
	
	}

}
