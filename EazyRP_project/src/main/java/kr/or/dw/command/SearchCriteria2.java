package kr.or.dw.command;

import lombok.Data;

@Data
public class SearchCriteria2 {
	private String searchType1 = "all";
	private String searchType2 = "all";
	private String startDate = "";
	private String endDate = "";
	
	public SearchCriteria2() {};
	
	public SearchCriteria2(String searchType1, String searchType2, String startDate, String endDate) {
		super();
		if(searchType1 != null && !searchType1.equals("")) this.searchType1 = searchType1;
		if(searchType2 != null && !searchType2.equals("")) this.searchType2 = searchType2;
		if(startDate != null) this.startDate = startDate;
		if(endDate != null) this.endDate = endDate;
	}
	
	
	
	
}
