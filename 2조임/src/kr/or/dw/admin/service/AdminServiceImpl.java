package kr.or.dw.admin.service;

import java.util.List;
import java.util.Map;

import kr.or.dw.admin.dao.AdminDaoImpl;
import kr.or.dw.admin.dao.IAdminDao;
import kr.or.dw.admin.vo.CommVO;
import kr.or.dw.admin.vo.ScheduleVO;
import kr.or.dw.admin.vo.adminVO;
import kr.or.dw.product.vo.ProductVO;

public class AdminServiceImpl implements IAdminService{
	
	private IAdminDao dao;
	private static AdminServiceImpl service;
	
	private AdminServiceImpl() {
		dao = AdminDaoImpl.getInstance();
	}
	
	public static AdminServiceImpl getInstance() {
		if(service == null) service = new AdminServiceImpl();
		return service;
	}

	@Override
	public List<adminVO> selectAdminList() {
		
		return dao.selectAdminList();
	}

	@Override
	public adminVO selectAdmin(int u_no) {
		return dao.selectAdmin(u_no);
	}

	@Override
	public void adminUpdate(adminVO adminVo) {
		// TODO Auto-generated method stub
		dao.adminUpdate(adminVo);
	}

	@Override
	public int insertAdminView(adminVO adminVo) {
		// TODO Auto-generated method stub
		return dao.insertAdminView(adminVo);
	}

	@Override
	public void adminDelete(int u_no) {
		dao.adminDelete(u_no);
		
	}

	@Override
	public List<CommVO> selectCommList(int u_no) {
		// TODO Auto-generated method stub
		return dao.selectCommList(u_no);
	}

	@Override
	public List<CommVO> everyCommSelect() {
		// TODO Auto-generated method stub
		return dao.everyCommSelect();
	}

	@Override
	public List<ScheduleVO> scheduleSelect() {
		// TODO Auto-generated method stub
		return dao.scheduleSelect();
	}

	@Override
	public List<ScheduleVO> rangeSelect(Map<String, String> map) {
		
		return dao.rangeSelect(map);
	}

	@Override
	public List<CommVO> getComm(int u_no) {
		return dao.getComm(u_no);
	}

	@Override
	public void bugerUpdate(ProductVO bugerVo) {
		dao.burgerUpdate(bugerVo);
	}

	@Override
	public List<ScheduleVO> scheduleSelect2() {
		return dao.scheduleSelect2();
	}

	@Override
	public List<ScheduleVO> rangeSelect2(Map<String, String> map) {
		return dao.rangeSelect2(map);
	}

	@Override
	public List<ProductVO> InsertBuger(ProductVO vo) {
		return dao.InsertBuger(vo);
	}

	@Override
	public void deleteMenu(String num) {
			dao.deleteMenu(num);
	}





	

	
	
	
	
	
	
}
