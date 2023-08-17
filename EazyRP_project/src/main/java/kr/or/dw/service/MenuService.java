package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.vo.DraftVO;
import kr.or.dw.vo.MenuVO;

public interface MenuService {
	
	// 전체 메인 메뉴 목록 조회
	List<MenuVO> selectMainMenuList() throws SQLException;

	Map<String, Object> selectSubMenuList(List<MenuVO> menuList) throws SQLException;

	String getUrl(String mcode) throws SQLException;

	List<String> getE_name(String selectedC_no) throws SQLException;

	List<String> getEmp_no(String selectedC_no) throws SQLException;

	String selectEname(String selectedEmp) throws SQLException;

	List<DraftVO> getPayment(int emp_no) throws SQLException;

	List<Integer> getProfit(List<String> month) throws SQLException;
 
}
