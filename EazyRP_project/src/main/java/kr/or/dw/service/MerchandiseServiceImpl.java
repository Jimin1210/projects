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
import kr.or.dw.dao.EstimateDAO;
import kr.or.dw.dao.MerchandiseDAO;
import kr.or.dw.dao.ProcessDAO;
import kr.or.dw.dao.ProductDAO;
import kr.or.dw.dao.SiDAO;
import kr.or.dw.vo.EstimateVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.SiVO;


@Service
public class MerchandiseServiceImpl implements MerchandiseService {
	
	@Autowired
	private MerchandiseDAO merchandiseDAO;

	@Autowired
	private EstimateDAO estimateDAO;

	@Override
	public Map<String, Object> selectMerchandiseList(SearchCriteria cri) throws SQLException {
		
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);		// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.

		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
//		merchandiseList = merchandiseDAO.selectMerchandiseList(cri, rowBounds);
		List<Map<String, Object>> merchandiseList = merchandiseDAO.selectMerchandiseList(cri, rowBounds);
		// 전체 board 개수
		int totalCount = merchandiseDAO.selectMerchandiseListCount(cri);

		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("merchandiseList", merchandiseList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public List<ProductVO> getProduct(Map<String, String> dataMap) throws SQLException {
		List<ProductVO> product = null;
		product = estimateDAO.getProduct(dataMap);
		
		return product;
	}

	@Override
	public List<ProductVO> getProductList() throws SQLException {
		List<ProductVO> product = null;
		product = estimateDAO.getProductList();
		
		return product;
	}

	@Override
	public void insertMerchandise(MerchandiseVO mchVO) throws SQLException {
		
		merchandiseDAO.insertMerchandise(mchVO);
		
	}

	@Override
	public Map<String, Object> selectDetail(String sp_no) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		Map<String, Object> merchandise = (Map<String, Object>) merchandiseDAO.selectDetail(sp_no);
		
		dataMap.put("merchandise", merchandise);
		
		return dataMap;
	}

	@Override
	public void modifyMerchandise(MerchandiseVO mchVO) throws SQLException {
		
		merchandiseDAO.modifyMerchandise(mchVO);
		
	}

	@Override
	public void deleteMerchandise(MerchandiseVO mchVO) throws SQLException {

		merchandiseDAO.deleteMerchandise(mchVO);
		
	}

	@Override
	public List<Map<String, Object>> getMerchandise(Map<String, String> dataMap) throws SQLException {
		
		List<Map<String, Object>> merchandise = null;
		merchandise = merchandiseDAO.getMerchandise(dataMap);
		
		return merchandise;
	}

	@Override
	public List<Map<String, Object>> getMerchandiseList() throws SQLException {
		
		List<Map<String, Object>> merchandise = null;
		merchandise = merchandiseDAO.getMerchandiseList();
		
		return merchandise;
	}

	
	
}
