package kr.or.dw.product.service;

import java.util.List;

import kr.or.dw.product.vo.ProductVO;

public interface IProductService {

	List<ProductVO> getAllProducts();

	List<ProductVO> getProducts(int cla);

	List<ProductVO> getAllProducts2();

}
