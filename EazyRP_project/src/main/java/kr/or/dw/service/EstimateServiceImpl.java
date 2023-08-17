package kr.or.dw.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.EstimateDAO;
import kr.or.dw.vo.EstimateVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.WareHouseVO;

@Service
public class EstimateServiceImpl implements EstimateService {
	
	@Autowired
	private EstimateDAO estimateDAO;
	
	@Override
	public Map<String, Object> selectEstimList(SearchCriteria cri) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		List<Map<String, Object>> estimList = estimateDAO.selectEstimList(cri, rowBounds);
		
		int totalCount = estimateDAO.selectSearchEstimateListCount(cri);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("pageMaker", pageMaker);
		dataMap.put("estimList", estimList);

		return dataMap;
	}
	
	@Override
	public Map<String, Object> selectDetail(String est_no) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> est = (Map<String, Object>) estimateDAO.selectDetail(est_no);
		System.out.println(est.get("PR_EXPRICE"));
		System.out.println(est.get("WH_NAME"));
		List<Map<String, Object>> estPr = estimateDAO.forEstimList(est_no);
		
		dataMap.put("estPr",estPr);
		dataMap.put("est", est);
		System.out.println(dataMap.get("est"));
		
		return dataMap;
	}

	@Override
	public void estimateInsert(EstimateVO vo) throws SQLException {
		 estimateDAO.estimateInsert(vo);
		
	}


	@Override
	public List<ProductVO> getProduct(Map<String, String> map) throws SQLException {
		
		List<ProductVO> product = null;
		product = estimateDAO.getProduct(map);
		return product;
	}

	@Override
	public List<ProductVO> getProductList() throws SQLException {
		List<ProductVO> product = null;
		product = estimateDAO.getProductList();
		return product;
	}

	@Override
	public List<WareHouseVO> getWareHouse(Map<String, String> dataMap) throws SQLException {
		
		List<WareHouseVO> warehouse = null;
		warehouse = estimateDAO.getWareHouse(dataMap);
		return warehouse;
		
	}

	@Override
	public List<WareHouseVO> getWareHouseList() throws SQLException {
		List<WareHouseVO> warehouse = null;
		warehouse = estimateDAO.getWareHouseList();
		return warehouse;
		
	}

	@Override
	public String ename(int empno) throws SQLException {
		String ename = estimateDAO.ename(empno);
		
		return ename;
	}

	@Override
	public void insertEstimate(List<EstimateVO> vo) throws SQLException {
		estimateDAO.insertEstimate(vo.get(0));
		String est_no = vo.get(0).getEst_no();
		System.out.println(est_no);
		
		for (EstimateVO est : vo ) {
			est.setEst_no(est_no);
			estimateDAO.insertEstimateDetail(est);
		}
		
	}

	@Override
	public String selectFile(String files) throws SQLException {
		
		String estFile = estimateDAO.selectFile(files); 
		
		return estFile;
	}

	@Override
	public void modifyEstimate(List<EstimateVO> modify, String empno) throws SQLException {
		System.out.println("아");
		String est_no =  modify.get(0).getEst_no();
		String files = modify.get(0).getFiles();
		String realFileName = modify.get(0).getRealFileName();
		Map<String, String> modifyMap = new HashMap<>();
		modifyMap.put("emp_no",empno);
		modifyMap.put("est_no", est_no);
		modifyMap.put("files", files);
		modifyMap.put("realFileName", realFileName);
		System.out.println("왜");
		estimateDAO.modifyEstimate(modifyMap);
		System.out.println("안");
		System.out.println("되");
		System.out.println("냐");
		String c_no = modify.get(0).getC_no();
		System.out.println("아오");
		
		System.out.println("modifyMap = " + modifyMap);
		int a = 4;
		for (EstimateVO est : modify) {
			System.out.println(est.getPr_delete());
			if(est.getPr_delete().equals("d")) {
				System.out.println("삭제");
				estimateDAO.deleteEstimateDetail(est);
			}else {
				System.out.println("수정");
				estimateDAO.modifyEstimateDetail(est);
			}
		}
		
		
	}

	@Transactional
	@Override
	public void deleteEstimate(String est_no) throws SQLException {
			
			estimateDAO.deleteEstimate(est_no);			
			
			estimateDAO.deletUpdateEstimate(est_no);
	
		
	}

	@Override
	public EstimateVO selectEst(String est_no) throws SQLException {
		EstimateVO est = estimateDAO.selectEst(est_no);
		return est;
	}

	
	
	
	
	
}
