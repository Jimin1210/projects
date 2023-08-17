package kr.or.dw.admin.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.admin.service.AdminServiceImpl;
import kr.or.dw.admin.service.IAdminService;
import kr.or.dw.product.service.IProductService;
import kr.or.dw.product.service.ProductServiceImpl;
import kr.or.dw.product.vo.ProductVO;
import kr.or.dw.web.IAction;

public class BugerViewAction implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		IProductService Pservice = ProductServiceImpl.getInstance();
		IAdminService service = AdminServiceImpl.getInstance();
		System.out.println("test1");
		List<ProductVO> bugerList = null;
		
		bugerList = Pservice.getAllProducts2();
		req.setAttribute("bugerList", bugerList);
		req.setAttribute("title", "메뉴");
		
	
		return "/admin/bugerSelect.jsp";
	}

}
