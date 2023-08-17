package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.vo.WhTransferVO;
import kr.or.dw.vo.WorkOrderVO;

@Mapper
public interface WhTransferDAO {
	
	List<Map<String, Object>> selectSearchWhTransferList(RowBounds rowBounds, Map<String, Object> map) throws SQLException;
	
	int selectSearchWhTransferListCount(Map<String, Object> map) throws SQLException;
	
	// 보내는 창고 재고 조회
	List<Map<String, Object>> whtSelectWareHouseList(RowBounds rowBounds, Map<String, Object> map) throws SQLException;

	// 보내는 창고 재고 조회
	int whtSelectWareHouseListCount(Map<String, Object> map) throws SQLException;

	void registWhTransfer(WhTransferVO whTransfer) throws SQLException;

	void registWhTransferDetail(WhTransferVO whtDetail) throws SQLException;

	Map<String, Object> selectWhTransfer(String wt_no) throws SQLException;

	List<Map<String, Object>> selectWhTransferDetail(String wt_no) throws SQLException;

	void registProduct(WhTransferVO whtDetail) throws SQLException;

	void minusProduct(WhTransferVO whtDetail) throws SQLException;

	int getAmount(String pr_no) throws SQLException;

	String getWt_no() throws SQLException;

	void insertTr_history(Map<String, Object> map) throws SQLException;

}
