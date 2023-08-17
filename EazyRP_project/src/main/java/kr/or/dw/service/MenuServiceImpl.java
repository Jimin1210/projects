package kr.or.dw.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.dao.MenuDAO;
import kr.or.dw.vo.DraftVO;
import kr.or.dw.vo.MenuVO;

@Service
public class MenuServiceImpl implements MenuService{
	
	@Autowired
	private MenuDAO menuDAO;	// == MenuDAOImpl.getInstance();
	
	@Override
	public List<MenuVO> selectMainMenuList() throws SQLException {
		
		List<MenuVO> menuList = menuDAO.selectMainMenuList();
		
		return menuList;
	}

	@Override
	public Map<String, Object> selectSubMenuList(List<MenuVO> menuList) throws SQLException{
		
		Map<String, List<MenuVO>> subMenuList = new HashMap<String, List<MenuVO>>();
		Map<String, List<MenuVO>> smallMenuList = new HashMap<String, List<MenuVO>>();
		
		for(MenuVO menu : menuList) {
			String mcode = menu.getMcode();
			List<MenuVO> subMenu = menuDAO.selectSubMenuList(mcode);
			subMenuList.put(mcode, subMenu);
			for(MenuVO smenu : subMenu) {
				mcode = smenu.getMcode();
				List<MenuVO> smallMenu = menuDAO.selectSubMenuList(mcode);
				smallMenuList.put(mcode, smallMenu);
			}
		}	
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("subMenuList", subMenuList);
		dataMap.put("smallMenuList", smallMenuList);
		
		return dataMap;
	}

	@Override
	public String getUrl(String mcode) throws SQLException {
		String url = menuDAO.getURL(mcode);
		
		return url;
	}

	@Override
	public List<String> getE_name(String selectedC_no) throws SQLException {
		List<String> e_name = menuDAO.getE_name(selectedC_no);
		
		return e_name;
	}

	@Override
	public List<String> getEmp_no(String selectedC_no) throws SQLException {
		List<String> emp_no = menuDAO.getEmp_no(selectedC_no);
		
		return emp_no;
	}

	@Override
	public String selectEname(String selectedEmp) throws SQLException {
		String ename = menuDAO.selectEname(selectedEmp);
		return ename;
	}

	@Override
	public List<DraftVO> getPayment(int emp_no) throws SQLException {
		return menuDAO.getPayment(emp_no);
	}

	@Override
	public List<Integer> getProfit(List<String> month) throws SQLException {
		List<Integer> profit = new ArrayList<>();
		for(int i = 0; i < month.size(); i++) {
			int a = menuDAO.getAmount(month.get(i));
			profit.add(a);
		}
		
		return profit;
	}


}
