package kr.or.dw.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.dw.command.PageMaker;
import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.WhDAO;
import kr.or.dw.vo.WhVO;

@Service
public class WhServiceImpl implements WhService{
	
	@Autowired WhDAO whDAO;
	
	@Override
	public Map<String, Object> selectWhList(Map<String, Object> map) throws SQLException {
		
		List<WhVO> whList = null;
		
		SearchCriteria cri = (SearchCriteria) map.get("cri");
		
		int offset = cri.getPageStartRowNum();
		int limit = cri.getPerPageNum();
		RowBounds rowBounds = new RowBounds(offset, limit);	// RowBounds : 쿼리에서 페이징 처리된 결과를 알아서 필요한 만큼 가져온다.
		
		// 현재 page 번호에 맞는 리스트를 perPageNum 개수 만큼 가져오기
		whList = whDAO.selectSearchWhList(map, rowBounds);
		
		// 전체 board 갯수
		int totalCount = whDAO.selectSearchWhListCount(map);
		
		// PageMaker 생성
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(totalCount);
		
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("whList", whList);
		dataMap.put("pageMaker", pageMaker);
		
		// 제품의 이름을 담을 객체를 선언한다.
		// 현재 해당하는 생산입고 게시글에서 창고번호를 조회하고 매퍼에서 가져온 창고명을 넣어준다.
		for(int i = 0; i < whList.size(); i++) {
			
			String getWh_no = whList.get(i).getWh_no();
			
			List<String> productName = whDAO.selectProductName(getWh_no); 	// 해당 pr_no 의 pr_name 값을 가져온다.
			List<String> wareHouseName = whDAO.selectWareHouseName(getWh_no);	
			
			String pr_name = "";
			String wh_name = "";
			
			if (wareHouseName.size() <= 1 && productName.size() <= 1) {
				wh_name = wareHouseName.get(0);
				pr_name = productName.get(0);
			} else if (wareHouseName.size() > 1 && productName.size() > 1) {
				wh_name = wareHouseName.get(0) + " 외 " + (wareHouseName.size() - 1) + "건";
				pr_name = productName.get(0) + " 외 " + (productName.size() - 1) + "건";
			} else if (wareHouseName.size() > 1 && productName.size() <= 1) {
				wh_name = wareHouseName.get(0) + " 외 " + (wareHouseName.size() - 1) + "건";
				pr_name = productName.get(0);
			} else if (wareHouseName.size() <= 1 && productName.size() > 1) {
				wh_name = wareHouseName.get(0);
				pr_name = productName.get(0) + " 외 " + (productName.size() - 1) + "건";
			} else {
				System.out.println("productName.size() : " + productName.size());
				System.out.println("wareHouseName.size() : " + wareHouseName.size());
				System.out.println("WhServiceImpl 경우의 수 예외 발생 (Line:71)");
			}
			whList.get(i).setPr_name(pr_name);
			whList.get(i).setWh_name(wh_name);
			
		}

		return dataMap;
	
	}

	@Override
	public void registWh(List<WhVO> whList) throws SQLException {
		
		System.out.println("WhServiceImpl - registWH - 진입");
		
		System.out.println("whDAO.insertWh(whDetailVoList.get(0)); - 전");
		whDAO.insertWh(whList.get(0));
		System.out.println("whDAO.insertWh(whDetailVoList.get(0)); - 후");
		System.out.println("String wh_no = whDetailVoList.get(0).getWh_no(); - 전");
		String wh_no = whList.get(0).getWh_no();
		System.out.println("String wh_no = whDetailVoList.get(0).getWh_no(); - 후");
		
		System.out.println("wh_no : " + wh_no);
		
		for (WhVO wh : whList) {
			wh.setWh_no(wh_no);
			whDAO.insertWhDetail(wh); // 상세게시글을 만들기 위한 다오
		}
								
	}

	@Override
	public Map<String, Object> selectWh(String wh_no) throws SQLException {
		System.out.println("서비스 임플 wh_no : " + wh_no);
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> wh = whDAO.selectWh(wh_no);
		
		List<Map<String, Object>> whDetail = whDAO.selectWhDetail(wh_no);
		
		dataMap.put("wh", wh);
		dataMap.put("whDetail", whDetail);
		
		return dataMap;
	}

	@Override
	public void modifyWh(List<WhVO> whList) throws SQLException {
		
		System.out.println("WhServiceImpl - modifyWh");
		
		WhVO whVo = whList.get(0); // whList.get(0)은 wh_no 이다.
		System.out.println("whList.get(0)는 " + whVo + " 입니다.");
		System.out.println("whDAO.whDetail(whList.get(0)); - 전");
		whDAO.whUpdate(whVo);
		System.out.println("whDAO.whDetail(whList.get(0)); - 후");
		
		for (WhVO wh : whList) {
			if (wh.getPr_delete() != null && wh.getPr_delete().equals("d")) {
				whDAO.deleteWhDetail(wh);
			} else {
				whDAO.modifyWhDetail(wh);
			}
		}
		System.out.println("for 문 끝");
		
		
	}

	@Override
	public void whRemove(String whNo) throws SQLException {
		whDAO.deleteWhDetailList(whNo);
		whDAO.deleteWh(whNo);
	}
	
}
