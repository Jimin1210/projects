package kr.or.dw.product.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.product.service.IProductService;
import kr.or.dw.product.service.ProductServiceImpl;
import kr.or.dw.product.vo.ProductVO;
import kr.or.dw.web.IAction;

public class ProductViewAction implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		int cla = Integer.parseInt(req.getParameter("cla"));
		IProductService service = ProductServiceImpl.getInstance();
		List<ProductVO> vo = null;
		
		if(cla == 0) {
			vo = service.getAllProducts();
		} else {
			vo = service.getProducts(cla);
		}
		
		req.setAttribute("vo", vo);
		req.setAttribute("cla", cla);
		
		return "/product/products.jsp";
	}

}
