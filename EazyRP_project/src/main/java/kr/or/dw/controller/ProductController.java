package kr.or.dw.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.aspose.cells.Cell;
import com.aspose.cells.Cells;
import com.aspose.cells.LoadOptions;
import com.aspose.cells.Workbook;
import com.aspose.cells.Worksheet;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.ProductDAO;
import kr.or.dw.service.ProductService;
import kr.or.dw.vo.BsheetVO;
import kr.or.dw.vo.BuyDetailVO;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.DraftVO;
import kr.or.dw.vo.O_DetailVO;
import kr.or.dw.vo.Order2VO;
import kr.or.dw.vo.Pro_whVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.WareHouseVO;

@Controller
@RequestMapping("/product")
public class ProductController {

	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ProductDAO productDAO;
	
	@RequestMapping("/productBuy")
	public ModelAndView productBuy(String mymenu, ModelAndView mnv,String murl, String mcode, HttpSession session, SearchCriteria cri) throws SQLException {
		String url = "";
    	if(mymenu == null) {
			url="/product/productBuy.page";
		} else {
			url="/product/productBuy.mymenu";
		}
		String c_no = (String) session.getAttribute("c_no");
		Map<String, Object> dataMap = new HashMap<>();
		Map<String, Object> map = new HashMap<>();
		dataMap.put("c_no", c_no);
		dataMap.put("cri", cri);
		
		map = productService.getB_sheet(dataMap);
		mnv.addObject("searchType", cri.getSearchType());
		mnv.addObject("keyword", cri.getKeyword());
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(map);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/findCompany")
	public ModelAndView findCompany(ModelAndView mnv, SearchCriteria cri) throws SQLException {
		List<CompanyVO> company = productService.getCompanyList(cri);
		
		mnv.addObject("company", company);
		mnv.setViewName("/product/findCompany");
		return mnv;
	}
	
	@RequestMapping("/productBuyRegist")
	public ModelAndView productBuyRegist(ModelAndView mnv, HttpSession session) {

		mnv.addObject("empno", session.getAttribute("emp_no"));
		mnv.addObject("ename", session.getAttribute("e_name"));
		mnv.setViewName("/product/productBuyRegist");
		return mnv;
	}
	
	@RequestMapping("/productBuyRegistFrom")
	public void productBuyRegistFrom(HttpServletResponse res, HttpSession session, BsheetVO sheet, String[] pr_no, String pr_name, int[] quantity, int[] amount) throws SQLException, IOException {
		sheet.setBuy_c_no((String)session.getAttribute("c_no"));
		sheet.setPr_name(pr_name);
		sheet.setCon_c_no("");
		int sheet_no = productService.insertProductBuy(sheet);
		
		List<BuyDetailVO> detail = new ArrayList<BuyDetailVO>();

		
		for(int i = 0; i < pr_no.length; i++) {
			BuyDetailVO vo = new BuyDetailVO();
			vo.setAmount(amount[i]);
			vo.setPr_no(pr_no[i]);
			vo.setQuantity(quantity[i]);
			vo.setSheet_no(sheet_no);
			detail.add(i, vo);
			System.out.println(i + "번째 추가 " + vo);
		}
		productService.insertProductDetail(detail);
		productService.Tr_History(sheet_no, detail);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('구매 내역 추가가 완료되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
	}
	
	@RequestMapping("/buyDetail")
	public ModelAndView buyDetail(ModelAndView mnv, String sheet_no, HttpSession session) throws SQLException {
		String url = "/product/buyDetail";
		
		List<BuyDetailVO> detailVo = productService.getBuyDetail(sheet_no);
		BsheetVO sheetVo = productService.getSheet(sheet_no);
		
		mnv.addObject("sheet", sheetVo);
		mnv.addObject("detail", detailVo);
		mnv.setViewName(url);
		return mnv;
	}
	
	
	
	
	@RequestMapping("/productOrder")
	public ModelAndView productOrder(String mymenu, ModelAndView mnv,String murl, String mcode, SearchCriteria cri, HttpSession session) throws SQLException {
		String url = "";
    	if(mymenu == null) {
			url="/product/productOrder.page";
		} else {
			url="/product/productOrder.mymenu";
		}
		System.out.println(cri.getSearchType());
		System.out.println(cri.getKeyword());
		String c_no = (String) session.getAttribute("c_no");
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("cri", cri);
		dataMap.put("c_no", c_no);
		dataMap.put("order", "N");
		Map<String, Object> map = new HashMap<>();
		System.out.println("1번");
		map = productService.allOrderList(dataMap);
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(map);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/orderDetail")
	public ModelAndView orderDetail(ModelAndView mnv, String o_no, String orders) throws SQLException {
		List<O_DetailVO> detail = productService.getOrderDetail(o_no);
		Order2VO order = productService.selectOrder(o_no);
		String c_no = order.getBuy_c_no();
		String c_name = productService.getC_name(c_no);
		mnv.addObject("order", order);
		mnv.addObject("detail", detail);
		mnv.addObject("length", detail.size());
		
		String del = "Y";
		for(int i = 0; i < detail.size(); i++) {
			if(detail.get(i).getLack().equals("Y")) {
				del = "N";
			}
		}
		if(orders.equals("Y")) {
			mnv.setViewName("/product/orderDetail");
		} else if(orders.equals("N")) {
			mnv.addObject("c_name", c_name);
			mnv.addObject("del",del);
			mnv.setViewName("/product/orderDetail2");
		}
		return mnv;
	}
	
	@RequestMapping("/orderRegist")
	public ModelAndView orderRegist(ModelAndView mnv, HttpSession session) throws SQLException {
		String c_no = (String) session.getAttribute("c_no");
		List<DraftVO> draft = productService.getOrderDraft(c_no);
		String e_name = (String) session.getAttribute("e_name");
		
		mnv.addObject("e_name", e_name);
		mnv.addObject("draft", draft);
		mnv.setViewName("/product/orderRegist");
		return mnv;
	}
	
	@RequestMapping("/document")
	public ModelAndView document(ModelAndView mnv, String dr_no, HttpSession session) throws SQLException {
		String fileName = productService.getFileName(dr_no);
		
		String uploadPath = session.getServletContext().getRealPath("/resources/documents/"); // 파일 경로
				
		String saveFile = (uploadPath+fileName); // 파일경로 + 파일이름
        List<String> data = new ArrayList<>();
		try {
            // 엑셀 파일 로드
            LoadOptions loadOptions = new LoadOptions();
            Workbook workbook = new Workbook(saveFile, loadOptions);

            // 첫 번째 시트 가져오기
            Worksheet worksheet = workbook.getWorksheets().get(0);

            // 모든 행을 반복하여 데이터를 2차원 List에 저장
            Cells cells = worksheet.getCells();
            int maxRow = cells.getMaxDataRow() + 1;
            int maxColumn = cells.getMaxDataColumn() + 1;
            for (int row = 0; row < maxRow; row++) {
                for (int column = 0; column < maxColumn; column++) {
                    // 각 셀의 데이터를 문자열로 변환하여 2차원 리스트에 추가
                    Cell cell = cells.get(row, column);
                    if(cell.getStringValue().equals("") || cell.getStringValue() == null) {
                    } else {
                    	data.add((String)cell.getStringValue());
                    }
                }
            }
            // 데이터 확인
                for (int i = 0; i < data.size(); i++) {
                    System.out.println(i + "번쨰 = " + data.get(i));
                    System.out.println(i + "번쨰 타입 = "+ data.get(i).getClass());
                }

            // Clean up resources
            workbook.dispose();
        } catch (Exception e) {
            e.printStackTrace();
        }
		Map<String, List<String>> data2 = new HashMap<>();
		List<String> name = new ArrayList<>();
		List<String> quantity = new ArrayList<>();
		int a = 1;
		for(int i = 15; i < data.size(); i++) {
			if(data.get(i).trim().equals("금액 총 합계  :")) {
				break;
			}
			if(i % 2 == 1 && a % 2 == 1) {
				name.add(data.get(i));
				a++;
			} else if (i % 2 == 1 && a % 2 == 0) {
				quantity.add(data.get(i));
				a++;
			}
		}
		List<ProductVO> product = new ArrayList<>();
		System.out.println(data.get(9));
		String c_no = productService.getC_no(data.get(9));
		System.out.println(c_no);
		product = productService.getContents(name, c_no);
		String c_no2 = (String) session.getAttribute("c_no");
		List<DraftVO> draft = productService.getOrderDraft(c_no2);
		data2.put("name", name);
		data2.put("quantity", quantity);
		int totalBuy = 0;
		int totalUnit = 0;
		System.out.println(product);
		for(int i = 0; i < product.size(); i++) {
			System.out.println(product.get(i).getPr_exprice());
		}
		for(int i = 0; i < product.size(); i++){
			int buy = product.get(i).getPr_exprice();
			product.get(i).setPr_exprice(buy * Integer.parseInt(quantity.get(i)));
			System.out.println("왜안돼냐고3");
			totalBuy += product.get(i).getPr_exprice();
			int unit = product.get(i).getPr_inprice();
			product.get(i).setPr_inprice(unit * Integer.parseInt(quantity.get(i)));
			totalUnit += product.get(i).getPr_inprice();
		}
		mnv.addObject("draft", draft);
		mnv.addObject("dr_no", dr_no);
		mnv.addObject("c_no", c_no);
		mnv.addObject("product", product);
		mnv.addObject("quantity", quantity);
		mnv.addObject("totalBuy", totalBuy);
		mnv.addObject("totalUnit", totalUnit);
		mnv.addObject("name", name);
		mnv.addObject("data", data);
		mnv.addAllObjects(data2);
		mnv.setViewName("/product/orderRegist");
		return mnv;
	}
	
	@RequestMapping("/findWareHouse")
	public ModelAndView findWareHouse(ModelAndView mnv, String pr_name, int quantity) throws SQLException {
		List<Pro_whVO> whList = new ArrayList<>();
		whList = productService.getWhList(pr_name);
		
		mnv.addObject("whList", whList);
		mnv.addObject("quantity", quantity);
		mnv.setViewName("/product/findWareHouse");
		return mnv;
	}
	
	@RequestMapping("/orderRegistForm")
	public void orderRegistForm(HttpServletResponse res, HttpSession session, Order2VO order, String[] pr_no, int[] quantity, int[] buy_price2, int[] unit_price2, String[] pr_name, String[] wh_no, String[] lack) throws SQLException, IOException {
		String c_no = (String) session.getAttribute("c_no");
		String e_name = (String) session.getAttribute("e_name");
		order.setBuy_c_no(c_no);
		order.setSys_reg(e_name);
		if(pr_name.length > 1) {
			order.setO_name(pr_name[0] + " 외 " + (pr_name.length - 1) + '건');
		} else {
			order.setO_name(pr_name[0]);
		}
		
		int o_no = productService.orderRegist(order);
		
		List<O_DetailVO> detail = new ArrayList<>();
		for(int i = 0; i < pr_no.length; i++) {
			O_DetailVO vo = new O_DetailVO();
			
			vo.setO_no(o_no);
			vo.setPr_no(pr_no[i]);
			vo.setQuantity(quantity[i]);
			vo.setBuy_price(buy_price2[i]);
			vo.setUnit_price(unit_price2[i]);
			vo.setWh_no(wh_no[i]);
			vo.setLack(lack[i]);
			
			detail.add(vo);
			System.out.println(vo);
		}
		
		productService.insertOrderDetail(detail);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('발주 요청이 완료되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
		
	}
	
	@RequestMapping("/orderCancel")
	public void orderCancel(HttpServletResponse res, int o_no, String dr_no) throws SQLException, IOException {
		productService.orderCancel(o_no, dr_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('발주 요청이 취소되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/orderList")
	public ModelAndView orderList(String mymenu, ModelAndView mnv,String murl, String mcode, HttpSession session, SearchCriteria cri) throws SQLException {
		System.out.println(cri.getSearchType());
		System.out.println(cri.getKeyword());
		String c_no = (String) session.getAttribute("c_no");
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("cri", cri);
		dataMap.put("c_no", c_no);
		dataMap.put("order", "Y");
		Map<String, Object> map = new HashMap<>();
		map = productService.allOrderList(dataMap);
		
		mnv.addAllObjects(map);
		mnv.addObject("murl", murl);
		mnv.addObject("mcode", mcode);
		String url = "";
    	if(mymenu == null) {
			url="/product/orderList.page";
		} else {
			url="/product/orderList.mymenu";
		}
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/receipt")
	public void receipt(int o_no, HttpSession session, HttpServletResponse res) throws SQLException, IOException {
		productDAO.receipt(o_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/delivery")
	public void delevery(int o_no, HttpSession session, HttpServletResponse res) throws SQLException, IOException {
		productDAO.delivery(o_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/receive")
	public void receive(String o_no, HttpSession session, HttpServletResponse res) throws SQLException, IOException {
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		productService.receive(o_no,emp_no);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	
	
}
