package kr.or.dw.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.service.ContactService;
import kr.or.dw.service.ItemService;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.MerchandiseService;
import kr.or.dw.service.ProcessService;
import kr.or.dw.service.ProductService;
import kr.or.dw.service.ShopService;
import kr.or.dw.service.WarehouseService;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.MenuVO;
import kr.or.dw.vo.MerchandiseVO;
import kr.or.dw.vo.NoteVO;
import kr.or.dw.vo.ProcessVO;
import kr.or.dw.vo.ProductVO;
import kr.or.dw.vo.ShopVO;
import kr.or.dw.vo.WareHouseVO;

@Controller
@RequestMapping("/erp4")
public class ItemController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	@Autowired
	private ItemService itemService;
	
	@RequestMapping("/item")
	public ModelAndView itemMain(String mymenu, ModelAndView mnv, String mcode, String murl, SearchCriteria cri, HttpSession session) throws SQLException{
		String url="";
    	if(mymenu == null) {
			url="inventory/basic/item.page";
		} else {
			url="inventory/basic/item.mymenu";
		}
    	String c_no = session.getAttribute("c_no").toString();
		Map<String, Object> dataMap = itemService.selectItemList(cri, c_no);
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/itemRegistForm")
	public ModelAndView contactRegistForm(ModelAndView mnv, HttpSession session) throws SQLException {
		String url = "inventory/basic/itemRegistForm";
		
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/registItem")
	public void registItem(@RequestParam("files")MultipartFile multi, ProductVO product, HttpServletResponse res, int emp_no) throws Exception{
		
		String fileName = "";
		
		if(!multi.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			
			String uniqueName = uuids[0];
			
			String fileRealName = multi.getOriginalFilename();
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
			String uploadFolder = "C:\\upload\\product\\";
			
			fileName = uniqueName+fileExtension;
			
			File saveFile = new File(uploadFolder+uniqueName+fileExtension);  // 적용 후
			
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}
			
			try {
				multi.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
//		if(product.getExdate() == null) {
//			String strDate = "99991231";
//			SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMdd");
//			Date formatDate = dtFormat.parse(strDate);
//			product.setExdate(formatDate);
//		}
		
		product.setSys_reg(emp_no + "");
		product.setSys_up(emp_no + "");
		product.setImg(fileName);
		
		itemService.registItem(product);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/itemDetail")
	public ModelAndView warehouseDetail (ModelAndView mnv, String pr_no) throws SQLException {
		Map<String, Object> product = itemService.selectProductDetail(pr_no);
		String url = "inventory/basic/itemDetail";
		mnv.addObject("product", product);
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/findWarehouseToitem")
	public ModelAndView findCompany(ModelAndView mnv, String searchType, String keyword) throws SQLException {
		String url = "inventory/basic/findWarehouse";
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<Map<String, Object>> warehouseList = null;
		Map<String, String> dataMap = new HashMap<>();
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			warehouseList = itemService.getWarehouse(dataMap);
		} else {
			warehouseList = itemService.getWarehouseList();
		}
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("warehouseList", warehouseList);
		
		return mnv;
	}
	
	@RequestMapping("/findSprice")
	public ModelAndView findSprice(ModelAndView mnv, String searchType, String keyword) throws SQLException {
		String url = "inventory/basic/findSprice";
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<Map<String, Object>> spriceList = null;
		Map<String, String> dataMap = new HashMap<>();
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			spriceList = itemService.getSprice(dataMap);
		} else {
			spriceList = itemService.getSpriceList();
		}
		mnv.setViewName(url);
		mnv.addAllObjects(dataMap);
		mnv.addObject("spriceList", spriceList);
		
		return mnv;
	}
	
	@RequestMapping("/getPicture")
	public ResponseEntity<byte[]> getPicture(String picture) throws Exception {
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String imgPath = "C:\\upload\\product\\";
		
		if (picture != null || picture != "") {
			try {
				in = new FileInputStream(new File(imgPath, picture));
				
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), HttpStatus.CREATED);
			} catch (FileNotFoundException e) {
				e.printStackTrace();
				entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
			}finally {
				in.close();
			}
		}
		
		return entity;
	}
	
	@RequestMapping("/modifyItem")
	public void modifyItem(ProductVO product, HttpServletResponse res, HttpSession session, String oldPicture, String uploadPicture, @RequestParam("files")MultipartFile multi) throws Exception {
		
		String fileName = oldPicture;
		
		product.setImg(fileName);
		
		if(!(oldPicture.equals(uploadPicture) || uploadPicture.equals("") || uploadPicture == null) ) {	
			if(!multi.isEmpty()) {
				UUID uuid = UUID.randomUUID();
				String[] uuids = uuid.toString().split("-");
				
				String uniqueName = uuids[0];
				
				String fileRealName = multi.getOriginalFilename();
				String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."), fileRealName.length());
				String uploadFolder = "C:\\upload\\product\\";
				
				fileName = uniqueName+fileExtension;
				
				File saveFile = new File(uploadFolder+uniqueName+fileExtension);
				if(!saveFile.exists()) {
					saveFile.mkdirs();
				}
				try {
					multi.transferTo(saveFile);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				if(!oldPicture.equals("")) {
					File oldFile = new File(uploadFolder, oldPicture);
					if(oldFile.exists()) {
						oldFile.delete();
					};
				};
			};
			product.setImg(fileName);
		} else if (uploadPicture.equals("") || uploadPicture == null) {
			String uploadFolder = "C:\\upload\\product\\";
			File oldFile = new File(uploadFolder, oldPicture);
			if(oldFile.exists()) {
				oldFile.delete();
			};
			
			product.setImg("");
		}
		
		System.out.println("vo입니당" + product);
		
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());

		product.setSys_reg(emp_no + "");
		product.setSys_up(emp_no + "");
		
		
		itemService.modifyItem(product);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정 되었습니다.')");
		out.println("location.href='itemDetail.do?pr_no=" + product.getPr_no() + "'");
		out.println("window.opener.location.reload();");
		out.println("</script>");
	}
	
	@RequestMapping("/deleteItem")
	public void deleteContact(String pr_no, HttpServletResponse res, HttpSession session, String oldPicture) throws Exception{
		
		String uploadFolder = "C:\\upload\\product\\";
		File oldFile = new File(uploadFolder, oldPicture);
		if(oldFile.exists()) {
			oldFile.delete();
		};
		
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		
		ProductVO product = new ProductVO();
		
		product.setSys_up(emp_no + "");
		product.setSys_reg(emp_no + "");
		product.setPr_no(pr_no);
	
		itemService.deleteProduct(product);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 삭제 되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}

}
