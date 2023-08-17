package kr.or.dw.product.dao;

import java.sql.SQLException;
import java.util.List;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.dw.product.vo.ProductVO;
import kr.or.dw.util.BuildSqlMapClient;


public class ProductDaoImpl implements IProductDao{

	private static ProductDaoImpl dao;
	private SqlMapClient client;
	
	private ProductDaoImpl() {
		client = BuildSqlMapClient.getSqlMapClient();
	}
	
	public static ProductDaoImpl getInstance() {
		if(dao == null) dao = new ProductDaoImpl();
		return dao;
	}

	@Override
	public List<ProductVO> getAllProducts() {
		List<ProductVO> vo = null;
		
		try {
			vo = (List<ProductVO>)client.queryForList("product.getAllProducts2");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return vo;
	}

	@Override
	public List<ProductVO> getProducts(int cla) {
		List<ProductVO> vo = null;
		
		try {
			vo = (List<ProductVO>)client.queryForList("user.getProducts", cla);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return vo;

	}

	@Override
	public List<ProductVO> getAllProducts2() {
List<ProductVO> vo = null;
		
		try {
			vo = (List<ProductVO>)client.queryForList("product.getAllProducts");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
}
