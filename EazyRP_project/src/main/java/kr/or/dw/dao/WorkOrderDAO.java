package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.ErrorVO;
import kr.or.dw.vo.WhVO;
import kr.or.dw.vo.WorkOrderVO;

@Mapper
public interface WorkOrderDAO {
	
	List<WorkOrderVO> selectSearchWorkOrderList(RowBounds rowBounds, Map<String, Object> map) throws SQLException;
	
	int selectSearchWorkOrderListCount(Map<String, Object> map) throws SQLException;
	
	// 담당자 이름 가져오기
	List<String> selectEName(int getEmp_no) throws SQLException;

	String selectWono(int wono) throws SQLException;

	void insertWorkOrder(WorkOrderVO woList) throws SQLException;

	void insertWorkOrderDetail(WorkOrderVO wo) throws SQLException;

	Map<String, Object> selectWorkOrder(String wo_no) throws SQLException;

	List<Map<String, Object>> selectWorkOrderDetail(String wo_no) throws SQLException;

	void workOrderUpdate(WorkOrderVO woVo) throws SQLException;
	
	void deleteWorkOrderDetail(WorkOrderVO wo) throws SQLException;

	void modifyWorkOrderDetail(WorkOrderVO wo) throws SQLException;

	void deleteWorkOrder(String wo_no) throws SQLException;

	void deleteWorkOrderDetailList(String wo_no) throws SQLException;

	void updateBtn(Map<String, Object> map) throws SQLException;

	int getPrice(String pr_no) throws SQLException;

	void insertError(WorkOrderVO workOrderVO) throws SQLException;

	void insertTr(Map<String, Object> map) throws SQLException;

	void insertProduct(WhVO vo) throws SQLException;

	int getProduct(WhVO vo) throws SQLException;

	void updateProduct(WhVO vo) throws SQLException;

	List<ErrorVO> getErrorList(Map<String, Object> dataMap, RowBounds rowBounds) throws SQLException;

	void updateWorkOrderProgress(Map<String, Object> map) throws SQLException;


}
