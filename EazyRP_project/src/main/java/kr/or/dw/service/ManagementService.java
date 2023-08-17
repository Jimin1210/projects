package kr.or.dw.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import kr.or.dw.vo.DeptVO;
import kr.or.dw.vo.DraftGbVO;
import kr.or.dw.vo.DraftVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.PaVO;
import kr.or.dw.vo.PlVO;

public interface ManagementService {

	Map<String, Object> getAllDraft(Map<String, Object> dataMap) throws SQLException;

	void documentRegist(DraftVO draft) throws SQLException;

	DraftVO selectDraft(String dr_no) throws SQLException;

	PlVO getPl(String pl_no) throws SQLException;

	List<String> getRank(PlVO pl) throws SQLException;

	void updateDraft(Map<String, String> dataMap) throws SQLException;

	void failDraft(Map<String, String> dataMap) throws SQLException;

	String getE_name(int emp_no) throws SQLException;

	DraftVO getDraft(String dr_no) throws SQLException;

	void documentModify(DraftVO draft) throws SQLException;

	String getFileName(String dr_no) throws SQLException;

	void deleteDocument(String dr_no) throws SQLException;

	List<PlVO> getAllPl(String c_no) throws SQLException;

	void insertPayLine(PlVO pl) throws SQLException;

	List<EmpVO> getEmp(Map<String, String> dataMap) throws SQLException;

	List<EmpVO> getEmpList(String c_no) throws SQLException;

	void deletePayLine(String pl_no) throws SQLException;

	void modifyPayLine(PlVO pl) throws SQLException;

	List<DraftGbVO> getDraftGb() throws SQLException;

	String getImgFiles(int a) throws SQLException;

	Map<String, Object> getPaList(Map<String, Object> map) throws SQLException;

	List<DeptVO> getDept() throws SQLException;

	List<String> getDeptList(List<EmpVO> emp) throws SQLException;

	void paRegist(List<PaVO> paList) throws SQLException;


}
