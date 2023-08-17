package kr.or.dw.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.Multipart;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.dao.QualityDAO;
import kr.or.dw.service.QualityService;
import kr.or.dw.vo.EstimateVO;
import kr.or.dw.vo.QualityVO;

@Controller
@RequestMapping("/erp5")
public class QualityController {
	
	private static final Logger logger = LoggerFactory.getLogger(QualityController.class);
	
	@Autowired
	private QualityService qualityService;
	
	@RequestMapping("/quality")
	public ModelAndView qualityMain(String mymenu, HttpSession session,ModelAndView mnv,String murl, String mcode, SearchCriteria cri) throws SQLException {
		String url= "";
		if(mymenu == null) {
			url="jihwan/qulityMain.page";
		} else {
			url="jihwan/qulityMain.mymenu";
		}
		System.out.println("emp session c_no : " + session.getAttribute("c_no").toString());
		String c_no = session.getAttribute("c_no").toString();
		Map<String, Object> dataMap = qualityService.selectQualityList(cri,c_no);
		
		System.out.println(dataMap.get("qualityList"));
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("murl", murl);
		mnv.addAllObjects(dataMap);
		mnv.setViewName(url);
		
		return mnv;		
	}
	
	@RequestMapping("/qualityDetail")
	public ModelAndView qcDetail (ModelAndView mnv, int qc_no) throws SQLException {
		
	Map<String, Object> dataMap = qualityService.selectQcDetail(qc_no);
	
	String url = "jihwan/qualityDetail.open";
	mnv.addAllObjects(dataMap);
	mnv.setViewName(url);
		
	return mnv;
	}
	
	@RequestMapping("/qc_regist")
	public ModelAndView qcRegist(ModelAndView mnv, HttpSession session) throws SQLException{
		int empno = Integer.parseInt(session.getAttribute("emp_no").toString());
		String ename = qualityService.ename(empno);
		
		String url = "jihwan/qc_regist.open";
		mnv.setViewName(url);
		mnv.addObject("empno",empno);
		mnv.addObject("ename", ename);
		
		return mnv;
	}
	
	@RequestMapping("/insertQc")
	public void insertQc(@RequestParam("files")MultipartFile multi, HttpSession session, int[] quantity, int emp_no, String progress, String[] pr_no, String[] pr_name,String[] content, @DateTimeFormat(pattern="yyyy-MM-dd") Date sys_regdate, HttpServletResponse res) throws SQLException, IOException {
		
		List<QualityVO> qualityVO = new ArrayList<QualityVO>();
		
		String filess = "";
		String fileRealName= "";
		
		if(!multi.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			String uniqueName = uuids[0];
			fileRealName = multi.getOriginalFilename();
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
			
			
			
			filess = uniqueName+fileExtension;
			
			
			String uploadFolder = session.getServletContext().getRealPath("/resources/saveJihwan/");
			
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
		
		for(int i=0; i < pr_no.length; i++) {
			QualityVO qc = new QualityVO();
			qc.setEmp_no(emp_no);
			qc.setPr_no(pr_no[i]);
			qc.setQuantity(quantity[i]);
			qc.setSys_regdate(sys_regdate);
			
			if(content.length != 0) {
			qc.setContent(content[i]);
			}
			
			qc.setProgress(progress);
			qualityVO.add(qc);
		}
		
		qualityVO.get(0).setFiles(filess);
		qualityVO.get(0).setRealFileName(fileRealName);
		System.out.println(qualityVO);
		
		qualityService.insertQc(qualityVO);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 등록되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
	}
	

	  @RequestMapping("getFile")
		public ResponseEntity<byte[]> getFile(HttpSession session ,int qc_no) throws Exception{
			InputStream in = null;
			ResponseEntity<byte[]> entity = null;
			
			QualityVO qv = qualityService.qcFileDown(qc_no);
			
			String qcFile = qv.getFiles();
			
			String uploadFolder = session.getServletContext().getRealPath("/resources/saveJihwan/");
			
			try {
				String fileName = qcFile;
				in = new FileInputStream(uploadFolder + File.separator + fileName);
				
				fileName = qv.getRealFileName();
				
				HttpHeaders headers = new HttpHeaders();
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\"" + new String(fileName.getBytes("utf-8"), "ISO-8859-1") + "\"");
				
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			} catch (Exception e) {
				e.printStackTrace();
				entity = new ResponseEntity<byte[]>(HttpStatus.INTERNAL_SERVER_ERROR);
			} finally {
				in.close();
			}
			
			return entity;
		}
		
	
	
	@RequestMapping("/qcmodifyForm")
	public void modifyQc (@RequestParam("files")MultipartFile multi,String fileName,@DateTimeFormat(pattern="yyyy-MM-dd") Date sys_regdate, String[] pr_delete, String progress, int qc_no, int[] qcdetail_no,int emp_no, String[] pr_no, int[] quantity, String[] content, HttpServletResponse res, HttpSession session ) throws SQLException, IOException {
		
		String empno = session.getAttribute("emp_no").toString();
		List<QualityVO> modify = new ArrayList<QualityVO>();
		
		QualityVO qv = qualityService.qcFileDown(qc_no);
		
		String deleteFile = qv.getFiles();
		String filess = "";
		String fileRealName = "";
		
		if(!multi.isEmpty()) {
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			
			String uniqueName = uuids[0];
			
			fileRealName = multi.getOriginalFilename();
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
			
			String uploadFolder = session.getServletContext().getRealPath("/resources/saveJihwan/");
			
			File delete = new File(uploadFolder + deleteFile);
			delete.delete();
			filess = uniqueName+fileExtension;
			
			
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
		
		for(int i=0; i<pr_no.length; i++) {
			QualityVO qv2 = new QualityVO();
			qv2.setContent(content[i]);
			qv2.setPr_no(pr_no[i]);
			qv2.setPr_delete(pr_delete[i]);
			qv2.setEmp_no(emp_no);
			qv2.setSys_regdate(sys_regdate);
			qv2.setQc_no(qc_no);
			qv2.setQcdetail_no(qcdetail_no[i]);
			qv2.setProgress(progress);
			qv2.setQuantity(quantity[i]);
			
			modify.add(qv2);
		}
		
		modify.get(0).setFiles(filess);
		modify.get(0).setRealFileName(fileRealName);
		
	 	System.out.println("modify 시발: " + modify);
		qualityService.modifyQc(modify, empno);
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('성공적으로 수정되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
		
		}
	 
	  	@RequestMapping("qcremove")
	  	public void qcRemove (HttpServletResponse res, int qc_no) throws SQLException, IOException{
	  		
	  		qualityService.qcRemove(qc_no);
	  		res.setContentType("text/html; charset=utf-8");
			PrintWriter out = res.getWriter();
			out.println("<script>");
			out.println("alert('삭제되었습니다.')");
			out.println("window.opener.location.reload(true); window.close();");
			out.println("</script>");
	  	}
	  
	  	
	  	
	  
}	
