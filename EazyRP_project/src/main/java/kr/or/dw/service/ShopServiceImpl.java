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
import kr.or.dw.dao.MerchandiseDAO;
import kr.or.dw.dao.ShopDAO;
import kr.or.dw.dao.SiDAO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;


@Service
public class ShopServiceImpl implements ShopService {
	
	@Autowired
	private ShopDAO shopDAO;
	
	@Autowired
	private MerchandiseDAO merchandiseDAO;
	
	@Override
	public List<ShopVO> getShop(Map<String, String> dataMap) throws SQLException {
		List<ShopVO> shop = null;
		shop = shopDAO.getShop(dataMap);
		return shop;
	}

	@Override
	public List<ShopVO> getShopList() throws SQLException {
		List<ShopVO> shop = null;
		shop = shopDAO.getShopList();
		return shop;
	} 
	
	// ShopMenu 부분
	
	@Override
	public Map<String, Object> selectShopList(SearchCriteria cri) throws SQLException {
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);		// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.
		
		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		List<Map<String, Object>> shopList = shopDAO.selectShopList(cri, rowBounds);
		// 전체 board 개수
		int totalCount = shopDAO.selectShopListCount(cri);
		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("shopList", shopList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
	}

	@Override
	public void insertShop(ShopVO shopVO) throws SQLException {
		
		shopDAO.insertShop(shopVO);
		
	}

	@Override
	public Map<String, Object> selectShop(String s_no) throws SQLException {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		Map<String, Object> shop = (Map<String, Object>) shopDAO.selectDetail(s_no);
		dataMap.put("shop", shop);
		
		return dataMap;
	}

	@Override
	public void deleteShop(ShopVO shopVO) throws SQLException {
		
		merchandiseDAO.deleteShopMerchandise(shopVO);
		shopDAO.deleteShop(shopVO);
	}

	@Override
	public void modifyShop(ShopVO shopVO) throws SQLException {
		
		shopDAO.modifyShop(shopVO);
		
	} 
	
}
