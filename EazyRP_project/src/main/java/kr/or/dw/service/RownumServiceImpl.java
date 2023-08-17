package kr.or.dw.service;

import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.dao.RownumDAO;
import kr.or.dw.vo.RownumVO;

@Service
public class RownumServiceImpl implements RownumService{
	
	@Autowired RownumDAO rownumDAO;

	@Override
	public int selectRownum(RownumVO rownumVo) throws SQLException {
		int rownum = rownumDAO.selectRownum(rownumVo);
		return rownum;
	}
	
}
