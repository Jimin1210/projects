package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.SiVO;

@Mapper
public interface SiDAO {

	List<Map<String, Object>> selectSiList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectSearchSiListCount(SearchCriteria cri) throws SQLException;

	Map<String, Object> selectSiDetail(String si_no) throws SQLException;

	List<Map<String, Object>> forSiList(String si_no) throws SQLException;

	String ename(int empno) throws SQLException;

	void insertSi(SiVO siVO) throws SQLException;

	int insertSiDetail(SiVO si) throws SQLException;

	void modifySi(Map<String, String> modifyMap) throws SQLException;

	void deleteSiDetail(SiVO si) throws SQLException;

	void modifySiDetail(SiVO si) throws SQLException;

	void siRemove(String si_no) throws SQLException;

	void siUpdateRemove(String si_no) throws SQLException;
	


	
	
}
