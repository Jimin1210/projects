package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;

import javax.swing.Spring;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.ProcessVO;

@Mapper
public interface ProcessDAO {
	void insertProcess(ProcessVO processVo) throws SQLException;

	List<ProcessVO> selectSearchProcessList(SearchCriteria cri, RowBounds rowBounds) throws SQLException;

	int selectSearchProcessListCount(SearchCriteria cri) throws SQLException;

	ProcessVO selectProcess(String pc_code) throws SQLException;

	void deleteProcess(String pc_code) throws SQLException;

	void updateProcess(ProcessVO process) throws SQLException;

}
