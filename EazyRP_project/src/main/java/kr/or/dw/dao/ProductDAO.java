package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.BsheetVO;
import kr.or.dw.vo.BuyDetailVO;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DraftVO;
import kr.or.dw.vo.NoteVO;
import kr.or.dw.vo.O_DetailVO;
import kr.or.dw.vo.Order2VO;
import kr.or.dw.vo.Pro_whVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.SiVO;
import kr.or.dw.vo.WareHouseVO;

@Mapper
public interface ProductDAO {

	List<ProductVO> selectSearchProductList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectSearchProductListCount(SearchCriteria cri) throws SQLException;

	List<BsheetVO> getB_sheet(Map<String, Object> dataMap2, RowBounds rowBounds) throws SQLException;

	int selectSearchNoteListCount(Map<String, Object> dataMap2) throws SQLException;

	List<BuyDetailVO> getBuyDetail(String sheet_no) throws SQLException;

	BsheetVO getSheet(String sheet_no) throws SQLException;

	List<CompanyVO> getCompanyList(SearchCriteria cri) throws SQLException;

	void insertProductBuy(BsheetVO sheet) throws SQLException;

	int insertSheetNo() throws SQLException;

	void insertProductDetail(BuyDetailVO vo) throws SQLException;

	List<String> getSheet_no(String pr_no1, List<String> pr_no) throws SQLException;

	List<String> getPr_no(SearchCriteria cri) throws SQLException;

	Order2VO insertOrderList(String sheet, String c_no) throws SQLException;

	int orderCount(Map<String, Object> dataMap) throws SQLException;

	List<O_DetailVO> getOrderDetail(String o_no) throws SQLException;

	Order2VO selectOrder(String o_no) throws SQLException;

	List<DraftVO> getOrderDraft(String c_no) throws SQLException;

	String getFileName(String dr_no) throws SQLException;

	ProductVO getContent(Map<String, String> map) throws SQLException;

	String getC_no(String c_name) throws SQLException;

	List<Pro_whVO> getWhList(String pr_name) throws SQLException;

	void orderRegist(Order2VO order) throws SQLException;

	int getO_no() throws SQLException;

	void insertOrderDetail(O_DetailVO detail) throws SQLException;

	void draftUpdate(String dr_no) throws SQLException;

	void removeDetail(int o_no) throws SQLException;

	void removeOrder(int o_no) throws SQLException;

	void draftOrder(String dr_no) throws SQLException;

	String getC_name(String c_no2) throws SQLException;

	void receipt(int o_no) throws SQLException;

	void delivery(int o_no) throws SQLException;

	void receive(String o_no) throws SQLException;

	void consumptionProduct(O_DetailVO o_DetailVO) throws SQLException;

	void tr_History(Map<String, Object> map) throws SQLException;

	List<Order2VO> allOrderList(Map<String, Object> dataMap, RowBounds rowBounds) throws SQLException;

	void tr_History2(Map<String, Object> map) throws SQLException;

	List<Order2VO> getOrderList(String c_no) throws SQLException;

	// 생산을 목적으로 선택하는 제품들의 목록(희성이꼬)
	List<ProductVO> getMakeProduct(Map<String, String> map) throws SQLException;
	// 생산을 목적으로 선택하는 제품들의 목록(희성이꼬)
	List<ProductVO> getMakeProductList() throws SQLException;


	
}
