package kr.or.dw.admin.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.or.dw.admin.service.AdminServiceImpl;
import kr.or.dw.admin.service.IAdminService;
import kr.or.dw.admin.vo.ScheduleVO;
import kr.or.dw.user.vo.UserVO;
import kr.or.dw.web.IAction;

public class ScheduleAction implements IAction {

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		IAdminService service = AdminServiceImpl.getInstance();
		List<ScheduleVO> scheduleList = null;
		HttpSession session = req.getSession();
		UserVO vo = (UserVO)session.getAttribute("userVO");
		
		if(vo.getPos().equals("알바")) {
			
			scheduleList = service.scheduleSelect2();
			req.setAttribute("scheduleList", scheduleList);
			req.setAttribute("title", "직원 스케줄");
		} else {
		scheduleList = service.scheduleSelect();
		
		req.setAttribute("scheduleList", scheduleList);
		req.setAttribute("title", "직원 스케줄");
		}
		return "/shedule/sheduleSelect.jsp";
	}

}
