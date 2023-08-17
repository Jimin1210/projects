package kr.or.dw.sales.dao;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.dw.sales.vo.SalesVO;
import kr.or.dw.user.dao.UserDaoImpl;
import kr.or.dw.util.BuildSqlMapClient;

public class SalesDaoImpl implements ISalesDao{

	private static SalesDaoImpl dao;
	private SqlMapClient client;
	
	private SalesDaoImpl() {
		client = BuildSqlMapClient.getSqlMapClient();
	}
	
	public static SalesDaoImpl getInstance() {
		if(dao == null) {
			dao = new SalesDaoImpl();
		}
		return dao;
	}

	@Override
	public List<SalesVO> getSales(Map<String, String> paramMap) {
		List<SalesVO> vo = null;
		
		try {
			vo = client.queryForList("sales.getSales", paramMap);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return vo;
	}

	

	
	
}
