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
import kr.or.dw.dao.ProcessDAO;
import kr.or.dw.dao.ProductDAO;
import kr.or.dw.dao.SiDAO;
import kr.or.dw.vo.BsheetVO;
import kr.or.dw.vo.BuyDetailVO;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DraftVO;
import kr.or.dw.vo.NoteVO;
import kr.or.dw.vo.O_DetailVO;
import kr.or.dw.vo.Order2VO;
import kr.or.dw.vo.Pro_whVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.SiVO;
import kr.or.dw.vo.WareHouseVO;


@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductDAO productDAO;

	@Override
	public Map<String, Object> selectProductList(SearchCriteria cri) throws SQLException {
		
		List<ProductVO> productList = null;
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);		// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.

		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		productList = productDAO.selectSearchProductList(cri, rowBounds);
		
		// 전체 board 개수
		int totalCount = productDAO.selectSearchProductListCount(cri);

		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("productList", productList);
		dataMap.put("pageMaker", pageMaker);
		
		return dataMap;
				
	}

	@Override
	public Map<String, Object> getB_sheet(Map<String, Object> dataMap) throws SQLException {
		SearchCriteria cri = (SearchCriteria) dataMap.get("cri");
		String c_no = (String) dataMap.get("c_no");
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		Map<String, Object> dataMap2 = new HashMap<String, Object>();
		
		dataMap2.put("keyword", cri.getKeyword());
		dataMap2.put("searchType", cri.getSearchType());
		dataMap2.put("cri", cri);
		dataMap2.put("c_no", c_no);
		List<BsheetVO> note = productDAO.getB_sheet(dataMap2, rowBounds);
		
		int totalCount = productDAO.selectSearchNoteListCount(dataMap2);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);

		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("note", note);
		map.put("pageMaker", pageMaker);
		
		return map;
	}

	@Override
	public BsheetVO getSheet(String sheet_no) throws SQLException {
		return productDAO.getSheet(sheet_no);
	}

	@Override
	public List<BuyDetailVO> getBuyDetail(String sheet_no) throws SQLException {
		return productDAO.getBuyDetail(sheet_no);
	}

	@Override
	public List<CompanyVO> getCompanyList(SearchCriteria cri) throws SQLException {
		return productDAO.getCompanyList(cri);
	}

	@Override
	public int insertProductBuy(BsheetVO sheet) throws SQLException {
		productDAO.insertProductBuy(sheet);
		
		int sheet_no = productDAO.insertSheetNo();
		
		return sheet_no;
	}

	@Override
	public void insertProductDetail(List<BuyDetailVO> detail) throws SQLException {
		for(BuyDetailVO vo : detail) {
			productDAO.insertProductDetail(vo);
		}
		
	}

	@Override
	public Map<String, Object> allOrderList(Map<String, Object> dataMap) throws SQLException {
		List<Order2VO> list = null;
		SearchCriteria cri = (SearchCriteria) dataMap.get("cri");
		String c_no = (String) dataMap.get("c_no");
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		list = productDAO.allOrderList(dataMap, rowBounds);
		String order = (String) dataMap.get("order");
		
		if(cri.getSearchType().equals("p") || cri.getSearchType().equals("pcw")) {
			List<String> pr_no = productDAO.getPr_no(cri);
			String pr_no1 = pr_no.get(0);
			List<String> sno = productDAO.getSheet_no(pr_no1, pr_no);
			for(String sheet : sno) {
				Order2VO insert = productDAO.insertOrderList(sheet, c_no);
				list.add(insert);
			}
		}
		int totalCount = list.size();
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		List<String> c_name = new ArrayList<>();
		for(int i = 0; i < list.size(); i++) {
			String c_no2 = list.get(i).getBuy_c_no();
			String c_name2 = productDAO.getC_name(c_no2);
			c_name.add(c_name2);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_name", c_name);
		map.put("list", list);
		map.put("pageMaker", pageMaker);
		
		return map;
	}

	@Override
	public List<O_DetailVO> getOrderDetail(String o_no) throws SQLException {
		return productDAO.getOrderDetail(o_no);
	}

	@Override
	public Order2VO selectOrder(String o_no) throws SQLException {
		return productDAO.selectOrder(o_no);
	}

	@Override
	public List<DraftVO> getOrderDraft(String c_no) throws SQLException {
		return productDAO.getOrderDraft(c_no);
	}

	@Override
	public String getFileName(String dr_no) throws SQLException {
		return productDAO.getFileName(dr_no);
	}

	@Override
	public List<ProductVO> getContents(List<String> name, String c_no) throws SQLException {
		List<ProductVO> list = new ArrayList<>();
		Map<String, String> map = new HashMap<>();
		map.put("c_no", c_no);
		System.out.println("name.size() = " + name.size());
		System.out.println(name);
		for(int i = 0; i < name.size(); i++) {
			map.put("name", name.get(i));
			ProductVO product = productDAO.getContent(map);
			map.remove("name");
			
			list.add(product);
		}
		return list;
	}

	@Override
	public String getC_no(String c_name) throws SQLException {
		return productDAO.getC_no(c_name);
	}

	@Override
	public List<Pro_whVO> getWhList(String pr_name) throws SQLException {
		return productDAO.getWhList(pr_name);
	}

	@Override
	public int orderRegist(Order2VO order) throws SQLException {
		System.out.println("기안문업데이트한다");
		productDAO.draftUpdate(order.getDr_no());
		System.out.println("발주요청사항등록한다");
		productDAO.orderRegist(order);
		System.out.println("번호갖고온다");
		int o_no = productDAO.getO_no();
		System.out.println("갖고온 번호다 : " + o_no);
		return o_no;
	}

	@Override
	public void insertOrderDetail(List<O_DetailVO> detail) throws SQLException {
		System.out.println("디테일사항 for문 돌린다");
		for(int i = 0; i < detail.size(); i++) {
			System.out.println("디테일사항 등록한다");
			productDAO.insertOrderDetail(detail.get(i));
		}
	}

	@Override
	public void orderCancel(int o_no, String dr_no) throws SQLException {
		productDAO.removeDetail(o_no);
		productDAO.removeOrder(o_no);
		productDAO.draftOrder(dr_no);
	}

	@Override
	public String getC_name(String c_no) throws SQLException {
		return productDAO.getC_name(c_no);
	}

	@Override
	public void receive(String o_no, int emp_no) throws SQLException {
		productDAO.receive(o_no);
		List<O_DetailVO> detail = productDAO.getOrderDetail(o_no);
		int quantity = 0;
		for(int i = 0; i < detail.size(); i++) {
			productDAO.consumptionProduct(detail.get(i));
			quantity += detail.get(i).getQuantity();
		}
		Order2VO order = productDAO.selectOrder(o_no);
		int amount = order.getBuy_price() * -1;
		Map<String, Object> map = new HashMap<>();
		map.put("amount", amount);
		map.put("order", order);
		map.put("emp_no", emp_no);
		map.put("quantity", quantity);
		map.put("buy", order.getBuy_price());
		productDAO.tr_History2(map);
	}

	@Override
	public void Tr_History(int sheet_no, List<BuyDetailVO> detail) throws SQLException {
		BsheetVO sheet = productDAO.getSheet(sheet_no+"");
		System.out.println("sheet = " + sheet);
		Map<String, Object> map = new HashMap<>();
		map.put("sheet", sheet);
		int amount = 0;
		int quantity = 0;
		for(int i = 0; i < detail.size(); i++) {
			amount += detail.get(i).getAmount();
			quantity += detail.get(i).getQuantity();
		}
		amount = amount * -1;
		map.put("amount", amount);
		System.out.println("amount = " + amount);
		map.put("quantity", quantity);
		System.out.println("quantity = " + quantity);
		productDAO.tr_History(map);
	}

	@Override
	public List<Order2VO> getOrderList(String c_no) throws SQLException {
		return productDAO.getOrderList(c_no);
	}

	// 생산을 목적으로 선택하는 제품들의 목록(희성이꼬)
	@Override
	public List<ProductVO> getMakeProduct(Map<String, String> map) throws SQLException{
		List<ProductVO> product = null;
		product = productDAO.getMakeProduct(map);
		return product;
	}

	// 생산을 목적으로 선택하는 제품들의 목록(희성이꼬)
	@Override
	public List<ProductVO> getMakeProductList() throws SQLException{
		List<ProductVO> product = null;
		product = productDAO.getMakeProductList();
		return product;
	} 
	
}
