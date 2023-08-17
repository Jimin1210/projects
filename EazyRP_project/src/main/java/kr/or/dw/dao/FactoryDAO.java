package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.FactoryVO;

@Mapper
public interface FactoryDAO {

	List<FactoryVO> selectSearchFactoryList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectSearchFactoryListCount(SearchCriteria cri) throws SQLException;
	
}
