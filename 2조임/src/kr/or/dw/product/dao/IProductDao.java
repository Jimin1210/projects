package kr.or.dw.product.dao;

import java.util.List;

import kr.or.dw.product.vo.ProductVO;

public interface IProductDao {

	List<ProductVO> getAllProducts();

	List<ProductVO> getProducts(int cla);

	List<ProductVO> getAllProducts2();

}
