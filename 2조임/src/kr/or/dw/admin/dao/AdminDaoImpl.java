package kr.or.dw.admin.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.dw.admin.vo.CommVO;
import kr.or.dw.admin.vo.ScheduleVO;
import kr.or.dw.admin.vo.adminVO;
import kr.or.dw.product.vo.ProductVO;
import kr.or.dw.util.BuildSqlMapClient;

public class AdminDaoImpl implements IAdminDao {
	
	private static AdminDaoImpl dao;
	private SqlMapClient client;
	
	private AdminDaoImpl () {
		client = BuildSqlMapClient.getSqlMapClient();
	}
	
	public static AdminDaoImpl getInstance() {
		if(dao == null) dao = new AdminDaoImpl();
		return dao;
		
	}

	@Override
	public List<adminVO> selectAdminList() {
		List<adminVO> adminList = null;
		
		try {
			adminList = client.queryForList("admin.selectAdminList");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return adminList;
	}

	@Override
	public adminVO selectAdmin(int u_no) {
		adminVO adminVo = null;
		
		try {
			adminVo = (adminVO) client.queryForObject("admin.selectAdmin", u_no);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return adminVo;
	}

	@Override
	public void adminUpdate(adminVO adminVo) {
	
		
		try {
			client.update("admin.adminUpdate", adminVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
			
	}

	@Override
	public int insertAdminView(adminVO adminVo) {
		
		Object result = null;
		int num = 0;
		
		
		try {
			result = client.insert("admin.insertAdminView", adminVo);
			if(result == null ) {
				num = 1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
	
	
	@Override
	public void adminDelete(int u_no) {
		
		try {
			u_no = client.delete("admin.adminDelete", u_no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	@Override
	public List<CommVO> selectCommList(int u_no) {
		List<CommVO> commList = null;
		
		try {
			commList = (List<CommVO>)client.queryForList("admin.selectCommList", u_no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return commList;
	}

	@Override
	public List<CommVO> everyCommSelect() {
		
		List<CommVO> everyCommList = null;
		
		try {
			everyCommList = client.queryForList("admin.everyCommSelect");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return everyCommList;
	}

	@Override
	public List<ScheduleVO> scheduleSelect() {
		
		List<ScheduleVO> scheduleList = null;
		
		try {
			scheduleList = client.queryForList("admin.scheduleSelect");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return scheduleList;
		
	}

	@Override
	public List<ScheduleVO> rangeSelect(Map<String, String> map) {
		
		List<ScheduleVO> scheduleList = null;
		
		try {
			scheduleList = client.queryForList("admin.rangeSelect" ,map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return scheduleList;
	}

	@Override
	public List<CommVO> getComm(int u_no) {
		List<CommVO> vo = null;
		
		try {
			vo = (List<CommVO>) client.queryForList("admin.getComm", u_no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public void burgerUpdate(ProductVO bugerVo) {
		try {
			client.update("admin.burgerUpdate", bugerVo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<ScheduleVO> scheduleSelect2() {
		List<ScheduleVO> vo = null;
		
		try {
			vo = (List<ScheduleVO>)client.queryForList("admin.scheduleSelect2");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public List<ScheduleVO> rangeSelect2(Map<String, String> map) {
		List<ScheduleVO> vo = null;
		
		try {
			vo = (List<ScheduleVO>)client.queryForList("admin.rangeSelect2", map);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public List<ProductVO> InsertBuger(ProductVO vo) {
		List<ProductVO> b_vo = null;
        try {
           b_vo = (List<ProductVO>)client.insert("admin.InsertBuger",vo);
        } catch (SQLException e) {
           // TODO Auto-generated catch block
           e.printStackTrace();
        }
     return b_vo;
	}

	@Override
	public void deleteMenu(String num) {
		try {
			client.delete("admin.deleteMenu", num);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	

	
	
}
