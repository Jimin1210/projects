package kr.or.dw.admin.action;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.dw.admin.service.AdminServiceImpl;
import kr.or.dw.admin.service.IAdminService;
import kr.or.dw.product.vo.ProductVO;
import kr.or.dw.web.IAction;

public class BugerInsertAction implements IAction {

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		ProductVO vo = new ProductVO();
		
		BeanUtils bean = new BeanUtils();
	    try {
			bean.populate(vo, req.getParameterMap());
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(vo);
		IAdminService service = AdminServiceImpl.getInstance();
		List<ProductVO> bugerVo = null;
		bugerVo = service.InsertBuger(vo);
		
		return "/admin/BugerMenu.do";
	}

}
