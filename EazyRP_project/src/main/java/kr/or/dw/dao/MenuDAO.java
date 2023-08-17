package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import kr.or.dw.vo.DraftVO;
import kr.or.dw.vo.MenuVO;

@Mapper
public interface MenuDAO {
	
	List<MenuVO> selectMainMenuList() throws SQLException;

	List<MenuVO> selectSubMenuList(String mcode) throws SQLException;

	String getURL(String mcode) throws SQLException;

	List<String> getE_name(String selectedC_no) throws SQLException;

	List<String> getEmp_no(String selectedC_no)throws SQLException;

	String selectEname(String selectedEmp) throws SQLException;

	List<DraftVO> getPayment(int emp_no) throws SQLException;

	int getAmount(String month) throws SQLException;

	

}
