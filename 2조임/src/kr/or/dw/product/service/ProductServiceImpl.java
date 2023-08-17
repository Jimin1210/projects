package kr.or.dw.product.service;

import java.util.List;

import kr.or.dw.product.dao.IProductDao;
import kr.or.dw.product.dao.ProductDaoImpl;
import kr.or.dw.product.vo.ProductVO;

public class ProductServiceImpl implements IProductService{

	private IProductDao dao;
	private static ProductServiceImpl service;
	
	private ProductServiceImpl() {
		dao = ProductDaoImpl.getInstance();
	}
	
	public static ProductServiceImpl getInstance() {
		if(service == null) service = new ProductServiceImpl();
		return service;
	}

	@Override
	public List<ProductVO> getAllProducts() {
		return dao.getAllProducts();
	}

	@Override
	public List<ProductVO> getProducts(int cla) {
		return dao.getProducts(cla);
	}

	@Override
	public List<ProductVO> getAllProducts2() {
		return dao.getAllProducts2();
	}
	
}
