package kr.or.dw.service;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.QualityDAO;
import kr.or.dw.vo.QualityVO;
import oracle.sql.DATE;

@Service
public class QualityServiceImpl implements QualityService{
	
	@Autowired
	private QualityDAO qualityDAO;
	
	@Override
	public Map<String, Object> selectQualityList(SearchCriteria cri, String c_no) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<Map<String, Object>> qualityList = qualityDAO.selectQualityList(cri, rowBounds, c_no);
		
		int totalCount = qualityDAO.selectQualityListCount(cri, c_no);
		
		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("qualityList", qualityList);
		dataMap.put("pageMaker", pageMaker);
		
		
		return dataMap;
	}

	@Override
	public Map<String, Object> selectQcDetail(int qc_no) throws SQLException {
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> qc = qualityDAO.selectQcDetail(qc_no);
		
		List<Map<String, Object>> qcList = qualityDAO.forQcList(qc_no);
		
		dataMap.put("qc", qc);
		dataMap.put("qcList", qcList);
		
		return dataMap;
	}

	@Override
	public String ename(int empno) throws SQLException {
		String ename = qualityDAO.ename(empno);
		return ename;
	}
	
	@Transactional
	@Override
	public void insertQc(List<QualityVO> qualityVO) throws SQLException {
		
		qualityDAO.insertQc(qualityVO.get(0));
		int qc_no = qualityVO.get(0).getQc_no();
		
		for (QualityVO vo : qualityVO) {
			vo.setQc_no(qc_no);
			System.out.println("나는:" + qc_no);
			int result = qualityDAO.insertQcDetail(vo);
			if (result < 0) break;
		}
		
	}
	
	@Transactional
	@Override
	public void modifyQc(List<QualityVO> modify, String empno) throws SQLException {
		
		int emp_no = modify.get(0).getEmp_no();
		int qc_no = modify.get(0).getQc_no();
		String files = modify.get(0).getFiles();
		String realFileName = modify.get(0).getRealFileName();
		String progress = modify.get(0).getProgress();
		Date sys_regdate = modify.get(0).getSys_regdate();
		String sys_up = modify.get(0).getSys_up();
		
		
		Map<String, String> modifyMap = new HashMap<>();
		modifyMap.put("emp_no", empno);
		modifyMap.put("qc_no", Integer.toString(qc_no));
		modifyMap.put("files", files);
		modifyMap.put("progress", progress);
		modifyMap.put("realFileName", realFileName);
		modifyMap.put("emp_no", Integer.toString(emp_no));
		modifyMap.put("sys_up", sys_up);
		
		qualityDAO.modifyQc(modifyMap);
		
		for (QualityVO qv : modify) {
			if(qv.getPr_delete() != null && qv.getPr_delete().equals("y")) {
				qualityDAO.deleteQcDetail(qv);
			}else {
				qualityDAO.modifyQcDetail(qv);	
			}			
		}
	
	}

	@Override
	public QualityVO qcFileDown(int qc_no) throws SQLException {
		QualityVO qv = qualityDAO.qcFileDown(qc_no);
		return qv;
	}
	
	@Transactional
	@Override
	public void qcRemove(int qc_no) throws SQLException {
		qualityDAO.deleteQc(qc_no);
		
		qualityDAO.deleteUpdateQc(qc_no);
		
	}
	
}