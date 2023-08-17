package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.OrderVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.SiVO;

public interface OrderService {

	Map<String, Object> selectOrderList(SearchCriteria cri) throws SQLException;
	
	List<ProductVO> getProduct1(Map<String, String> dataMap) throws SQLException;

	List<ProductVO> getProductList1() throws SQLException;

	void insertOrder(OrderVO orderVO) throws SQLException;

	Map<String, Object> selectDetail(String so_no) throws SQLException;

	void minusQuantity(OrderVO orderVO, String c_no) throws SQLException;

	void modifyOrder(OrderVO orderVO) throws SQLException;

	void plusQuantity(OrderVO orderVO) throws SQLException;
}
