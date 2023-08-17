package kr.or.dw.service;

import java.sql.SQLException;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.AsVO;

public interface AsService {

	Map<String, Object> selectAsList(Map<String, Object> map ) throws SQLException;

	void registAs(AsVO asVO) throws SQLException;

	Map<String, Object> selectAsDetail(String as_no) throws SQLException;

	void modifyAs(AsVO asVO) throws SQLException;

	void removeAs(AsVO asVO)throws SQLException;

	void insertError(AsVO asVO)throws SQLException;

	void tr(AsVO asVO) throws SQLException;


}
