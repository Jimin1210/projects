package kr.or.dw.sales.dao;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import kr.or.dw.sales.vo.SalesVO;

public interface ISalesDao {

	List<SalesVO> getSales(Map<String, String> paramMap);


}
