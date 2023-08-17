package kr.or.dw.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.command.SearchCriteria2;
import kr.or.dw.dao.WorkOrderDAO;
import kr.or.dw.vo.ErrorVO;
import kr.or.dw.vo.WhVO;
import kr.or.dw.vo.WorkOrderVO;

@Service
public class WorkOrderServiceImpl implements WorkOrderService{

	@Autowired
	private WorkOrderDAO workOrderDAO;
	
	@Override
	public Map<String, Object> selectWorkOrderList(Map<String, Object> map) throws SQLException {
		
		List<WorkOrderVO> woList = null;
		SearchCriteria cri = (SearchCriteria) map.get("cri");
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		woList = workOrderDAO.selectSearchWorkOrderList(rowBounds, map);
		
		// 전체 board 개수
		int totalCount = workOrderDAO.selectSearchWorkOrderListCount(map);
		
		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("woList", woList);
		dataMap.put("pageMaker", pageMaker);
		
		// 제품의 이름을 담을 객체를 선언한다.
		// 현재 해당하는 생산입고 게시글에서 창고번호를 조회하고 매퍼에서 가져온 창고명을 넣어준다.
		for(int i = 0; i < woList.size(); i++) {
			
			int getEmp_no = woList.get(i).getEmp_no();
			List<String> eName = workOrderDAO.selectEName(getEmp_no);
			
			woList.get(i).setE_name(eName.get(i));
		
		}
		
		return dataMap;
		
	}
	
	@Override
	public void registWorkOrder(List<WorkOrderVO> woList) throws SQLException {
		
		workOrderDAO.insertWorkOrder(woList.get(0));	// woList의 get 0번째는 wo_no 이다. (wo_no_seq로 시퀀서 등록되어있음)
		
		System.out.println("insertWorkOrder 완료");

		String wo_no = woList.get(0).getWo_no();
		
		for (WorkOrderVO wo : woList) {
			wo.setWo_no(wo_no);
			workOrderDAO.insertWorkOrderDetail(wo);
		}
		
		System.out.println("insertWorkOrderDetail 완료");
		
	}

	@Override
	public Map<String, Object> selectWorkOrder(String wo_no) throws SQLException {

		System.out.println("workOrderServiceImpl.selectWorkOrderDetail - 진입");
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> wo = (Map<String, Object>) workOrderDAO.selectWorkOrder(wo_no);
		
		List<Map<String, Object>> woDetail = workOrderDAO.selectWorkOrderDetail(wo_no);
		
		dataMap.put("wo", wo);
		dataMap.put("woDetail", woDetail);

		return dataMap;

	}

	@Override
	public void workOrderModify(List<WorkOrderVO> woList) throws SQLException {
		
		System.out.println("WorkOrderServiceImpl - workOrderModify 진입");
		
		WorkOrderVO woVo = woList.get(0);
		
		System.out.println("WorkOrderVO woVo = woList.get(0)는 " + woVo + " 입니다.");
		workOrderDAO.workOrderUpdate(woVo);
		System.out.println("현재 메소드는 workOrderModify 입니다.");
		
		for (WorkOrderVO wo : woList) {
			if (wo.getPr_delete() != null && wo.getPr_delete().equals("d")) {
				workOrderDAO.deleteWorkOrderDetail(wo);
			} else {
				workOrderDAO.modifyWorkOrderDetail(wo);
			}
		}
		
		System.out.println("WorkOrderServiceImpl - workOrderModify 완료");
		
	}

	@Override
	public void workOrderRemove(String wo_no) throws SQLException {
		System.out.println("WorkOrderServiceImpl - workOrderRemove - 진입");
		workOrderDAO.deleteWorkOrderDetailList(wo_no);
		System.out.println("workOrderDAO.deleteWorkOrderDetailList(wo_no) - 성공");
		workOrderDAO.deleteWorkOrder(wo_no);
		System.out.println("workOrderDAO.deleteWorkOrder(wo_no) - 성공");
	}

	@Override
	public void updateBtn(Map<String, Object> map) throws SQLException {
		workOrderDAO.updateBtn(map);
	}

	@Override
	public void insertError(List<WorkOrderVO> woList) throws SQLException {
		int total = 0;
		int quantity = 0;
		for(int i = 0; i < woList.size(); i ++) {
			if(woList.get(i).getQuantity() != 0) {
				int amount = workOrderDAO.getPrice(woList.get(i).getPr_no());
				amount = amount * woList.get(i).getQuantity();
				woList.get(i).setAmount(amount);
				total += amount;
				quantity += woList.get(i).getQuantity();
				workOrderDAO.insertError(woList.get(i));
			}
		}
		Map<String, Object> map = new HashMap<>();
		map.put("wh_no", woList.get(0).getWh_no());
		map.put("progress", 2);
		map.put("total", total);
		map.put("quantity", quantity);
		map.put("c_no", woList.get(0).getC_no());
		workOrderDAO.updateBtn(map);
		total = total * -1;
		map.remove("total");
		map.put("total", total);
		workOrderDAO.insertTr(map);
	}

	@Override
	public void insertProduct(List<WhVO> whList) throws SQLException {
		for(int i = 0; i < whList.size(); i++) {
			WhVO vo = whList.get(i);
			int a = workOrderDAO.getProduct(vo);
			if(a == 0) {
				workOrderDAO.insertProduct(vo);
			} else {
				workOrderDAO.updateProduct(vo);
			}
		}
	}

	@Override
	public List<ErrorVO> getErrorList(String c_no, SearchCriteria cri, SearchCriteria2 cri2) throws SQLException {
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		
		dataMap.put("keyword", cri.getKeyword());
		dataMap.put("searchType", cri.getSearchType());
		dataMap.put("cri", cri);
		dataMap.put("c_no", c_no);
		dataMap.put("cri2", cri2);
		
		List<ErrorVO> list = workOrderDAO.getErrorList(dataMap, rowBounds);
		
		return list;
	}

	@Override
	public void updateWorkOrderProgress(Map<String, Object> map) throws SQLException {
		workOrderDAO.updateWorkOrderProgress(map);
	}

}
