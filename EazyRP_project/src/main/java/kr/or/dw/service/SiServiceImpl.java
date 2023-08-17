package kr.or.dw.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.SiDAO;
import kr.or.dw.vo.SiVO;


@Service
public class SiServiceImpl implements SiService {
	
	@Autowired
	private SiDAO siDAO;

	@Override
	public Map<String, Object> selectSiList(SearchCriteria cri) throws SQLException {
		

		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		
		List<Map<String, Object>> siList = siDAO.selectSiList(cri, rowBounds);
		
		int totalCount = siDAO.selectSearchSiListCount(cri);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("pageMaker", pageMaker);
		dataMap.put("siList", siList);

		return dataMap;
		
	}

	@Override
	public Map<String, Object> selectSiDetail(String si_no) throws SQLException {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> si = (Map<String, Object>) siDAO.selectSiDetail(si_no);
		
		List<Map<String, Object>> siList = siDAO.forSiList(si_no);
		
		dataMap.put("si", si);
		dataMap.put("siList", siList);
		
		return dataMap;
	}

	@Override
	public String ename(int empno) throws SQLException {
		String ename = siDAO.ename(empno);
		return ename;
	}

	@Transactional
	@Override
	public void insertSi(List<SiVO> siVO) throws SQLException {
		siDAO.insertSi(siVO.get(0));
		String si_no = siVO.get(0).getSi_no();
		
		for (SiVO si : siVO) {
			si.setSi_no(si_no);
			int result = siDAO.insertSiDetail(si);
			if(result < 0) break;
		}
	}

	@Override
	public void modifySi(List<SiVO> modify, String empno) throws SQLException {
		
		String si_no = modify.get(0).getSi_no();
		
		Map<String, String> modifyMap = new HashMap<>();
		modifyMap.put("emp_no", empno);
		modifyMap.put("si_no", si_no);
		
		siDAO.modifySi(modifyMap);
		
		 
		
		for (SiVO si : modify) {
			if(si.getPr_delete() != null && si.getPr_delete().equals("y")) {
				siDAO.deleteSiDetail(si);
			}else {
				siDAO.modifySiDetail(si);
			}
		}
		
	}
	
	@Transactional
	@Override
	public void siRemove(String si_no) throws SQLException {
		siDAO.siRemove(si_no);
		siDAO.siUpdateRemove(si_no);
	} 
	
	
	
}
