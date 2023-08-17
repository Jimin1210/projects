package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.AsVO;

@Mapper
public interface AsDAO {

	List<Map<String, Object>> selectAsList(Map<String, Object> map ,RowBounds rowBounds) throws SQLException;

	int selectAsListCount(Map<String, Object> map ) throws SQLException;

	void asRegist(AsVO asVO) throws SQLException;

	Map<String, Object> selectAsDetail(String as_no) throws SQLException;

	void modifyAs(AsVO asVO) throws SQLException;

	void removeAs(AsVO asVO)throws SQLException;

	void tr(AsVO asVO) throws SQLException;

	String getAs_no() throws SQLException;

	void insertError(AsVO asVO) throws SQLException;

	
}
