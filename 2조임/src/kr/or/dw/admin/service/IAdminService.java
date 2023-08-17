package kr.or.dw.admin.service;

import java.util.List;
import java.util.Map;

import kr.or.dw.admin.vo.CommVO;
import kr.or.dw.admin.vo.ScheduleVO;
import kr.or.dw.admin.vo.adminVO;
import kr.or.dw.product.vo.ProductVO;

public interface IAdminService {

	List<adminVO> selectAdminList();

	/**
	 * 해당하는 관리자의 객체를 불러온다.
	 * @param u_no
	 * @return adminVO
	 */
	adminVO selectAdmin(int u_no);
	
	
	/**
	 * 관리자 직위를 수정함
	 * @param vo
	 * @return
	 */
	
	void adminUpdate(adminVO adminVo);
	
	
int insertAdminView(adminVO adminVo);
	
	
	
	/**
	 * 직원을 삭제함
	
	 */
	void adminDelete(int u_no);

	
	
	/**
	 * 회원의 급여정보를 불러올수있음
	 * @param u_no
	 * @return
	 */
	List<CommVO> selectCommList(int u_no);
	
	
	/**
	 * 회원들의 급여정보를 모두 불러옴
	 * @return
	 */
	List<CommVO> everyCommSelect();
	
	
	/**
	 * 회원의 스케줄을 불러옴
	 * @return
	 */
	List<ScheduleVO> scheduleSelect();

	
	/**
	 * 회원의 스케줄 범위를 조정함
	 * @param map
	 */

	List<ScheduleVO> rangeSelect(Map<String, String> map);

	List<CommVO> getComm(int u_no);

	void bugerUpdate(ProductVO bugerVo);

	List<ScheduleVO> scheduleSelect2();

	List<ScheduleVO> rangeSelect2(Map<String, String> map);

	List<ProductVO> InsertBuger(ProductVO vo);

	void deleteMenu(String num);


	

	

}
