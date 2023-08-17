package kr.or.dw.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.MyMenuVO;
import kr.or.dw.vo.NoteVO;

@Mapper
public interface MyMenuDAO {

	public List<EmpVO> getEmpList() throws SQLException;

	public List<EmpVO> getSelectEmpList(String name) throws SQLException;

	public List<EmpVO> getSelectEmpListCno(String c_name) throws SQLException;

	public List<EmpVO> getEmp(Map<String, String> map) throws SQLException;

	public EmpVO selectEmp(int emp_no) throws SQLException;

	public void sendNote(NoteVO noteVo) throws SQLException;

	public NoteVO selectNote(int n_no) throws SQLException;

	public void readableUpdate(int n_no) throws SQLException;

	public void deleteNote(int n_no) throws SQLException;

	public List<NoteVO> searchNote(Map<String, String> valMap) throws SQLException;

	public List<NoteVO> getSendNoteList(Map<String, Object> dataMap, RowBounds rowBounds) throws SQLException;

	public List<NoteVO> getNoteList(Map<String, Object> dataMap, RowBounds rowBounds) throws SQLException;

	public int selectSearchNoteListCount(Map<String, Object> dataMap) throws SQLException;

	public List<Map<String, Object>> selectMyMenuList(int u_no) throws SQLException;

	public void registMyMenu(MyMenuVO mymenu) throws SQLException;

	public void deleteMyMenu(MyMenuVO mymenu) throws SQLException;

	public int selectSendSearchNoteListCount(Map<String, Object> dataMap2) throws SQLException;
	

}
