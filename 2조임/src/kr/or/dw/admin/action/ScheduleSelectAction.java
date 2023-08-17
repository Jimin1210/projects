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

public class ScheduleSelectAction implements IAction {

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		IAdminService service = AdminServiceImpl.getInstance();
		
		HttpSession session = req.getSession();
		UserVO vo = (UserVO)session.getAttribute("userVO");

		String start = req.getParameter("start_date");
		String end = req.getParameter("end_date");
		

		if (start != null && end != null) {
			Map<String, String> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);

			List<ScheduleVO> scheduleList = null;
			if(vo.getPos().equals("알바")) {
				scheduleList = service.rangeSelect2(map);
			} else {
				scheduleList = service.rangeSelect(map);
			}
			req.setAttribute("scheduleList", scheduleList);
			req.setAttribute("title", "직원 날짜 범위");
		}

		return "/shedule/sheduleSelect.jsp";
	}

}
