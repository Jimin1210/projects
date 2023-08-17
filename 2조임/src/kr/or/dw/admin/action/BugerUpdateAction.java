package kr.or.dw.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.admin.service.AdminServiceImpl;
import kr.or.dw.admin.service.IAdminService;
import kr.or.dw.product.vo.ProductVO;
import kr.or.dw.web.IAction;

public class BugerUpdateAction implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		String img = req.getParameter("img");
		String num = req.getParameter("num");
		int cost = Integer.parseInt(req.getParameter("cost"));
		String p_description =req.getParameter("p_description");
		String gb_view = req.getParameter("gb_view");
		System.out.println(gb_view);
		if(gb_view == null) {
			gb_view = "N";
		}
		
		ProductVO bugerVo = new ProductVO();
		bugerVo.setNum(num);
		bugerVo.setCost(cost);
		bugerVo.setP_description(p_description);
		bugerVo.setGb_view(gb_view);
		bugerVo.setImg(img);
		
		IAdminService service = AdminServiceImpl.getInstance();
		service.bugerUpdate(bugerVo);
		
		return "/admin/BugerMenu.do";
	}
	
}
