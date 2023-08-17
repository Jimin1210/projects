package kr.or.dw.admin.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.web.IAction;

public class MenuDeleteAction implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("액션");
		String num = req.getParameter("num");
		System.out.println(num);
		req.setAttribute("num", num);
		
		return "/admin/deleteForm.jsp";
	}

}
