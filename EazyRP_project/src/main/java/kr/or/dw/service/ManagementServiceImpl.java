package kr.or.dw.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.command.SearchCriteria2;
import kr.or.dw.dao.ManagementDAO;
import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.DraftGbVO;
import kr.or.dw.vo.DraftVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.PaVO;
import kr.or.dw.vo.PlVO;
import kr.or.dw.vo.Tr_historyVO;

@Service
public class ManagementServiceImpl implements ManagementService{

	@Autowired
	private ManagementDAO managementDAO;
	
	@Override
	public Map<String, Object> getAllDraft(Map<String, Object> dataMap) throws SQLException {
		List<DraftVO> draft = null;
		SearchCriteria cri = (SearchCriteria) dataMap.get("cri");
		System.out.println(dataMap.get("emp_no"));
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		Map<String, Object> dataMap2 = new HashMap<String, Object>();
		dataMap2.put("keyword", cri.getKeyword());
		dataMap2.put("searchType", cri.getSearchType());
		dataMap2.put("cri", cri);
		int totalCount = 0;
		if(dataMap.get("regist").equals("N")) {
			draft = managementDAO.getAllDraft(dataMap, rowBounds);
			totalCount = managementDAO.getDraftCount(dataMap);
		} else {
			draft = managementDAO.getRegistDraft(dataMap, rowBounds);
			totalCount = managementDAO.getRegistDraftCount(dataMap);
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		dataMap.put("keyword", cri.getKeyword());
		dataMap.put("searchType", cri.getSearchType());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("draft", draft);
		map.put("pageMaker", pageMaker);
		
		return map;
	}

	@Override
	public void documentRegist(DraftVO draft) throws SQLException {
		managementDAO.documentRegist(draft);
	}

	@Override
	public DraftVO selectDraft(String dr_no) throws SQLException {
		DraftVO draft = null;
		
		draft = managementDAO.selectDraft(dr_no);
		return draft;
	}

	@Override
	public PlVO getPl(String pl_no) throws SQLException {
		PlVO pl = null;
		pl = managementDAO.getPl(pl_no);
		
		return pl;
	}

	@Override
	public List<String> getRank(PlVO pl) throws SQLException {
		List<String> rank = managementDAO.getRank(pl);
		
		return rank;
	}

	@Override
	public void updateDraft(Map<String, String> dataMap) throws SQLException {
		String no = "";
		String pl_progress = dataMap.get("pl_progress");
		if(pl_progress.equals("0")) {
			no = "1";
		} else if(pl_progress.equals("1")) {
			no = "2";
		} else if(pl_progress.equals("2")) {
			no = "3";
		}
		dataMap.put("no", no);
		System.out.println(no);
		System.out.println(pl_progress);
		managementDAO.updateDraft(dataMap);
	}

	@Override
	public void failDraft(Map<String, String> dataMap) throws SQLException {
		String no = "";
		String pl_progress = dataMap.get("pl_progress");
		if(pl_progress.equals("0")) {
			no = "1fail";
		} else if(pl_progress.equals("1")) {
			no = "2fail";
		} else if(pl_progress.equals("2")) {
			no = "3fail";
		}
		System.out.println(no);
		System.out.println(pl_progress);
		dataMap.put("no", no);
		managementDAO.failDraft(dataMap);
	}

	@Override
	public String getE_name(int emp_no) throws SQLException {
		String ename = managementDAO.getE_name(emp_no);
		return ename;
	}

	@Override
	public DraftVO getDraft(String dr_no) throws SQLException {
		DraftVO draft = managementDAO.getDraft(dr_no);
		
		return draft;
	}

	@Override
	public void documentModify(DraftVO draft) throws SQLException {
		managementDAO.documentModify(draft);
	}

	@Override
	public String getFileName(String dr_no) throws SQLException {
		String fileName = managementDAO.getFileName(dr_no);
		
		return fileName;
	}

	@Override
	public void deleteDocument(String dr_no) throws SQLException {
		managementDAO.deleteDocument(dr_no);
	}

	@Override
	public List<PlVO> getAllPl(String c_no) throws SQLException {
		return managementDAO.getAllPl(c_no);
	}

	@Override
	public void insertPayLine(PlVO pl) throws SQLException {
		managementDAO.insertPayLine(pl);
	}

	@Override
	public List<EmpVO> getEmp(Map<String, String> dataMap) throws SQLException {
		List<EmpVO> emp = managementDAO.getEmp(dataMap);
		return emp;
	}

	@Override
	public List<EmpVO> getEmpList(String c_no) throws SQLException {
		List<EmpVO> emp = managementDAO.getEmpList(c_no);
		return emp;
	}

	@Override
	public void deletePayLine(String pl_no) throws SQLException {
		managementDAO.deletePayLine(pl_no);
	}

	@Override
	public void modifyPayLine(PlVO pl) throws SQLException {
		managementDAO.modifyPayLine(pl);
	}

	@Override
	public List<DraftGbVO> getDraftGb() throws SQLException {
		return managementDAO.getDraftGb();
	}

	@Override
	public String getImgFiles(int a) throws SQLException {
		return managementDAO.getImgFile(a);
	}

	@Override
	public Map<String, Object> getPaList(Map<String, Object> map) throws SQLException {
		SearchCriteria cri = (SearchCriteria) map.get("cri");
		SearchCriteria2 cri2 = (SearchCriteria2) map.get("cri2");
		String c_no = (String) map.get("c_no");
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		dataMap.put("keyword", cri.getKeyword());
		dataMap.put("searchType", cri.getSearchType());
		dataMap.put("cri", cri);
		dataMap.put("c_no", c_no);
		dataMap.put("cri2", cri2);
		List<PaVO> list = managementDAO.getHistory(dataMap, rowBounds);
		List<String> name = managementDAO.getNames(dataMap, rowBounds);
		int totalCount = list.size();
				
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		for(int i = 0; i < list.size(); i++) {
			list.get(i).setSys_regdate(list.get(i).getSys_regdate().substring(0, 10));
		}
		
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("name", name);
		map2.put("list", list);
		map2.put("pageMaker", pageMaker);
		
		return map2;
	}

	@Override
	public List<DeptVO> getDept() throws SQLException {
		return managementDAO.getDept();
	}

	@Override
	public List<String> getDeptList(List<EmpVO> emp) throws SQLException {
		List<String> dept = new ArrayList<>();
		for(int i = 0; i < emp.size(); i++) {
			String dname = managementDAO.getDname(emp.get(i).getEmp_no());
			dept.add(dname);
		}
		
		return dept;
	}

	@Override
	public void paRegist(List<PaVO> paList) throws SQLException {
		for(int i = 0; i < paList.size(); i++) {
			managementDAO.paRegist(paList.get(i));
			if(paList.get(i).getPg_no().equals("pa_001")) {
				managementDAO.updateDept(paList.get(i));
			} else {
				managementDAO.updateRank(paList.get(i));
			}
		}
		
	}


}
