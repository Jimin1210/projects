package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.QualityVO;

@Mapper
public interface QualityDAO {

	List<Map<String, Object>> selectQualityList(@Param("cri") SearchCriteria cri, RowBounds rowBounds, @Param("c_no") String c_no) throws SQLException;

	int selectQualityListCount(@Param("cri") SearchCriteria cri, @Param("c_no") String c_no) throws SQLException;

	Map<String, Object> selectQcDetail(int qc_no) throws SQLException;

	List<Map<String, Object>> forQcList(int qc_no) throws SQLException;

	String ename(int empno) throws SQLException;

	void insertQc(QualityVO qualityVO) throws SQLException;

	int insertQcDetail(QualityVO vo) throws SQLException;

	void modifyQc(Map<String, String> modifyMap) throws SQLException;

	void modifyQcDetail(QualityVO qv) throws SQLException;

	void deleteQcDetail(QualityVO qv) throws SQLException;

	QualityVO qcFileDown(int qc_no) throws SQLException;

	void deleteQc(int qc_no) throws SQLException;

	void deleteUpdateQc(int qc_no) throws SQLException;
	
	
	
	
}
