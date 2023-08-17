package kr.or.dw.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class SalesJoinUtil {
	
	private Map<String, String> config = new HashMap<>();
	
	public Map<String, String> getConfig(){
		return config;
	}
	
	public void setConfig(String start, String end) {
		
		config.put("start", start);
		config.put("end", end);
		
		
	}
	
}
