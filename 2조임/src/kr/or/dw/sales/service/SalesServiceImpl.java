package kr.or.dw.sales.service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import kr.or.dw.sales.dao.ISalesDao;
import kr.or.dw.sales.dao.SalesDaoImpl;
import kr.or.dw.sales.vo.SalesVO;
import kr.or.dw.user.dao.UserDaoImpl;

public class SalesServiceImpl implements ISalesService{

	private ISalesDao dao;
	private static SalesServiceImpl service;
	
	private SalesServiceImpl() {
		dao = SalesDaoImpl.getInstance();
	}
	
	public static SalesServiceImpl getInstance() {
		if(service == null) {
			service = new SalesServiceImpl();
		}
		return service;
	}

	@Override
	public List<SalesVO> getSales(Map<String, String> paramMap) {
		return dao.getSales(paramMap);
	}


	
	
	
}
