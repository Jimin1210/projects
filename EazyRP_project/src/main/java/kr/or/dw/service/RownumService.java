package kr.or.dw.service;

import java.sql.SQLException;

import kr.or.dw.vo.RownumVO;

public interface RownumService {
	int selectRownum(RownumVO rownumVo) throws SQLException;
}
