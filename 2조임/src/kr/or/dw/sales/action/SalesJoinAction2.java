package kr.or.dw.sales.action;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import kr.or.dw.sales.service.ISalesService;
import kr.or.dw.sales.service.SalesServiceImpl;
import kr.or.dw.sales.vo.SalesVO;
import kr.or.dw.util.SalesJoinUtil;
import kr.or.dw.web.IAction;

public class SalesJoinAction2 implements IAction{

	@Override
	public boolean isRedirect() {
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		ISalesService service = SalesServiceImpl.getInstance();

		BeanUtils bean = new BeanUtils();
		Map<String, String> salesConfigMap = null;
		List<SalesVO> vo = null;
		SalesJoinUtil join = new SalesJoinUtil();
		
		try {
			bean.populate(vo, req.getParameterMap());
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}

		String start = req.getParameter("start");
		String end = req.getParameter("end");
		join.setConfig(start, end);
		salesConfigMap = join.getConfig();
		
		Map<String, String> parmaMap = new HashMap<>();
		parmaMap.put("start", salesConfigMap.get("start"));
		parmaMap.put("end", salesConfigMap.get("end"));
		
		vo = service.getSales(parmaMap);
		
		req.setAttribute("vo", vo);
		req.setAttribute("start", start);
		req.setAttribute("end", end);
		req.setAttribute("title", "매출 조회");
		
		
		return "/sales/money.jsp";
	}

}
