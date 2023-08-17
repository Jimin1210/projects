package kr.or.dw.sales.service;

import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import kr.or.dw.sales.vo.SalesVO;

public interface ISalesService {

	List<SalesVO> getSales(Map<String, String> paramMap);


}
