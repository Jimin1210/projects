package kr.or.dw.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.ProcessDAO;
import kr.or.dw.vo.ProcessVO;

public class ProcessServiceImpl implements ProcessService{

	@Autowired
	private ProcessDAO processDAO;
	
	
	@Override
	public void registProcess(ProcessVO processVo) throws SQLException {
		processDAO.insertProcess(processVo);
	}

	@Override
	public Map<String, Object> selectProcessList(SearchCriteria cri) throws SQLException {

		List<ProcessVO> processList = null;
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);		// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.
		
		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		processList = processDAO.selectSearchProcessList(cri, rowBounds);
		
		// 전체 board 개수
		int totalCount = processDAO.selectSearchProcessListCount(cri);
		
		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("processList", processList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public ProcessVO selectProcess(String pc_code) throws SQLException {
		ProcessVO process = processDAO.selectProcess(pc_code);

		return process;
	}

	@Override
	public void processRemove(String pc_code) throws SQLException {
		processDAO.deleteProcess(pc_code);
	}

	@Override
	public void processModify(ProcessVO process) throws SQLException {
		processDAO.updateProcess(process);
	}

}
