package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.command.SearchCriteria2;
import kr.or.dw.vo.ErrorVO;
import kr.or.dw.vo.WhVO;
import kr.or.dw.vo.WorkOrderVO;

public interface WorkOrderService {
	Map<String, Object> selectWorkOrderList(Map<String, Object> map) throws SQLException;

	void registWorkOrder(List<WorkOrderVO> woList) throws SQLException;

	Map<String, Object> selectWorkOrder(String wo_no) throws SQLException;

	void workOrderModify(List<WorkOrderVO> woList) throws SQLException;

	void workOrderRemove(String wo_no) throws SQLException;

	void updateBtn(Map<String, Object> map) throws SQLException;

	void insertError(List<WorkOrderVO> woList) throws SQLException;

	void insertProduct(List<WhVO> whList) throws SQLException;

	List<ErrorVO> getErrorList(String c_no, SearchCriteria cri, SearchCriteria2 cri2) throws SQLException;

	void updateWorkOrderProgress(Map<String, Object> map) throws SQLException;
}
