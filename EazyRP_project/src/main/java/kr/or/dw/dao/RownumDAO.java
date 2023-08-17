package kr.or.dw.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.dw.vo.RownumVO;

@Mapper
public interface RownumDAO {

	int selectRownum(RownumVO rownumVo);

}
