package kr.or.dw.admin.action;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.dw.admin.service.AdminServiceImpl;
import kr.or.dw.admin.service.IAdminService;
import kr.or.dw.admin.vo.adminVO;
import kr.or.dw.web.IAction;

public class UpdateAdminAction implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
	      
	      String pos = req.getParameter("pos");
	      int sal = Integer.parseInt(req.getParameter("sal"));
	      String u_no = req.getParameter("u_no");
	      
	      adminVO adminVo = new adminVO();
	      adminVo.setU_no(Integer.parseInt(u_no));
	      adminVo.setPos(pos);
	      adminVo.setSal(sal);
	      
	      IAdminService service = AdminServiceImpl.getInstance();
	      service.adminUpdate(adminVo);
	      req.setAttribute("u_no", u_no);
	      
	      return "/admin/selectAdmin.do?u_no=" + u_no;
	   }
}
