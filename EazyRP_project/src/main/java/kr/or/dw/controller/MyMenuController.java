package kr.or.dw.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Writer;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
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
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.service.MyMenuService;
import kr.or.dw.vo.CompanyVO;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.NoteVO;

@Controller
@RequestMapping("/mymenu")
public class MyMenuController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyMenuController.class);
	
	@Autowired
	private MyMenuService mymenuService;
	
	@RequestMapping("/communication")
	public ModelAndView loginForm(ModelAndView mnv, HttpSession session) throws SQLException {
		String url = "/mymenu/communication";
		
		mnv.setViewName(url);
		return mnv;
	}
	
	@RequestMapping("/noteRegist")
	public String noteRegist(HttpSession session, NoteVO note, String reply, HttpServletResponse res, MultipartFile file, String fileName) throws SQLException, IOException{
		NoteVO noteVo = new NoteVO();
		System.out.println(note.getReceiver());
		System.out.println(note.getCon());
		System.out.println(fileName);
		if(!fileName.trim().equals("")) {
			UUID uuid = UUID.randomUUID();
			String[] uuids = uuid.toString().split("-");
			
			String uniqueName = uuids[0];
			
			String fileRealName = file.getOriginalFilename();
			String fileExtension = fileRealName.substring(fileRealName.lastIndexOf("."),fileRealName.length());
			noteVo.setRealFileName(fileRealName);
			String uploadFolder = session.getServletContext().getRealPath("/resources/saveFiles/");
			note.setFiles(uniqueName+fileExtension);
			
			
			File saveFile = new File(uploadFolder+uniqueName+fileExtension);  // 적용 후
			
			if(!saveFile.exists()) {
				saveFile.mkdirs();
			}
			
			try {
				file.transferTo(saveFile); // 실제 파일 저장메서드(filewriter 작업을 손쉽게 한방에 처리해준다.)
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		} else {
			noteVo.setRealFileName("");
			note.setFiles("");
		}
		
		int emp_no = note.getReceiver(); // 받는사람 emp_no
		int writer = Integer.parseInt((String) session.getAttribute("emp_no"));
		EmpVO emp = mymenuService.selectEmp(emp_no); // 받는사람 정보
		EmpVO emp2 = mymenuService.selectEmp(writer); // 보낸사람 정보
		
		noteVo.setCon(note.getCon());
		noteVo.setTitle(note.getTitle());
		if(note.getFiles() == null || note.getFiles() == "") {
			noteVo.setFiles("");
		} else {
			noteVo.setFiles(note.getFiles());
		}
		
		if(emp2.getC_no() != null) {
			noteVo.setC_company(emp2.getC_no());
		} else {
			noteVo.setC_company(emp.getC_no());
		}
		noteVo.setCaller(writer);
		
		noteVo.setReceiver(emp_no);
		noteVo.setR_company(emp.getC_no());

		
		mymenuService.sendNote(noteVo);
		if(reply == "1") {
			res.setContentType("text/html; charset=utf-8");
			PrintWriter out = res.getWriter();
			out.println("<script>");
			out.println("alert('답장이 완료되었습니다.')");
			out.println("window.opener.location.reload(true); window.close();");
			out.println("</script>");
			return null;
		} else {
			res.setContentType("text/html; charset=utf-8");
			PrintWriter out = res.getWriter();
			out.println("<script>");
			out.println("alert('전송이 완료되었습니다.')");
			out.println("window.opener.location.reload(true); window.close();");
			out.println("</script>");
			return null;
		}
	}
	
	@RequestMapping("/noteList")
	public ModelAndView noteList(String mymenu, HttpSession session, ModelAndView mnv, String mcode, SearchCriteria cri) throws SQLException{
		String url="";
		if(mymenu == null) {
			url="/mymenu/noteList.page";
		} else {
			url="/mymenu/noteList.mymenu";
		}
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> note = new HashMap<String, Object>();
		String c_no = (String) session.getAttribute("c_no");
		
		dataMap.put("c_no", c_no);
		dataMap.put("cri", cri);
		note = mymenuService.getNoteList(dataMap);
		
		mnv.setViewName(url);
		mnv.addAllObjects(note);
		mnv.addObject("mcode", mcode);
		
		return mnv;
	}
	
	@RequestMapping("/noteList2")
	public ModelAndView noteList2(HttpSession session, ModelAndView mnv, String mcode, SearchCriteria cri) throws SQLException{
		String url="/mymenu/noteList.mymenu";
		Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> note = new HashMap<String, Object>();
		String c_no = (String) session.getAttribute("c_no");
		
		dataMap.put("c_no", c_no);
		dataMap.put("cri", cri);
		note = mymenuService.getNoteList(dataMap);
		
		mnv.setViewName(url);
		mnv.addAllObjects(note);
		mnv.addObject("mcode", mcode);
		
		return mnv;
	}
    
    @RequestMapping("/sendNoteList")
    public ModelAndView sendNoteList(String mymenu, HttpSession session, ModelAndView mnv, String mcode, SearchCriteria cri) throws SQLException{
    	String url="";
    	if(mymenu == null) {
			url="/mymenu/sendNoteList.page";
		} else {
			url="/mymenu/sendNoteList.mymenu";
		}
    	Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> note = new HashMap<String, Object>();
		String c_no = (String) session.getAttribute("c_no");
		
		dataMap.put("c_no", c_no);
		dataMap.put("cri", cri);
		note = mymenuService.getSendNoteList(dataMap);
		System.out.println(note);
		System.out.println("노트리스트");
		mnv.addAllObjects(note);
		mnv.setViewName(url);
		mnv.addObject("mcode", mcode);
		
		return mnv;
	}
    
    @RequestMapping("/sendNoteList2")
    public ModelAndView sendNoteList2(HttpSession session, ModelAndView mnv, String mcode, SearchCriteria cri) throws SQLException{
    	String url="mymenu/sendNoteList.mymenu";
    	Map<String, Object> dataMap = new HashMap<String, Object>();
		Map<String, Object> note = new HashMap<String, Object>();
		String c_no = (String) session.getAttribute("c_no");
		
		dataMap.put("c_no", c_no);
		dataMap.put("cri", cri);
		note = mymenuService.getSendNoteList(dataMap);
		System.out.println(note);
		System.out.println("노트리스트");
		mnv.addAllObjects(note);
		mnv.setViewName(url);
		mnv.addObject("mcode", mcode);
		
		return mnv;
	}
	
	@RequestMapping("/deleteNote")
	public void deleteNote(HttpSession session, int n_no, HttpServletResponse res, String files) throws SQLException, IOException {
		String uploadFolder = session.getServletContext().getRealPath("/resources/saveFiles/");
		File file = new File(uploadFolder + files);
		file.delete();
		mymenuService.deleteNote(n_no);
		
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("alert('삭제되었습니다.')");
		out.println("window.opener.location.reload(true); window.close();");
		out.println("</script>");
	}
	
	@RequestMapping("/replyNote")
	public ModelAndView replyNote(ModelAndView mnv, int caller, String callerName, HttpServletResponse res) throws SQLException, IOException {
		res.setContentType("text/html; charset=utf-8");
		PrintWriter out = res.getWriter();
		out.println("<script>");
		out.println("window.resizeTo(700,1000)");
		out.println("</script>");
		
		String url =  "/mymenu/reply";
		
		mnv.addObject("caller", caller);
		mnv.addObject("callerName", callerName);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/detail")
	public ModelAndView detail(ModelAndView mnv, int n_no, String send) throws SQLException, IOException {
		
		String url = "/mymenu/detail";
		NoteVO note = mymenuService.selectNote(n_no, send);
		
		mnv.setViewName(url);
		mnv.addObject("note", note);
		mnv.addObject("send", send);
		
		return mnv;
	}
	
	@RequestMapping("/findPeople")
	public ModelAndView findPeople(ModelAndView mnv, String searchType, String keyword) throws SQLException {
		String url = "mymenu/findPeople";
		if(searchType == "") {
			searchType = null;
		}
		if(keyword == "") {
			keyword = null;
		}
		List<EmpVO> emp = null;
		Map<String, String> dataMap = new HashMap<>();
		dataMap.put("searchType", searchType);
		dataMap.put("keyword", keyword);
		if(keyword != null){
			emp = mymenuService.getEmp(dataMap);
		} else {
			emp = mymenuService.getEmpList();
		}
		
		mnv.setViewName(url);
		mnv.addObject("emp", emp);
		mnv.addObject("searchType", searchType);
		mnv.addObject("keyword", keyword);
		
		return mnv;
	}

	
	@RequestMapping("/search")
	public ModelAndView search(String mymenu, HttpSession session, ModelAndView mnv, String mcode, String keyword, String searchType) throws SQLException {
		String url="";
    	if(mymenu == null) {
			url="/mymenu/noteList.page";
		} else {
			url="/mymenu/noteList.mymenu";
		}
		
		
		String c_no = (String)session.getAttribute("c_no");
		Map<String, String> valMap = new HashMap<>();
		valMap.put("keyword", keyword);
		valMap.put("searchType", searchType);
		valMap.put("c_no", c_no);
		List<NoteVO> note = null;
		note = mymenuService.searchNote(valMap);
		mnv.addObject("note", note);
		mnv.addObject("keyword", keyword);
		mnv.addObject("searchType", searchType);
		mnv.addObject("mcode", mcode);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	@RequestMapping("/sendSearch")
	public ModelAndView sendSearch(String mymenu, HttpSession session, ModelAndView mnv, String mcode, String keyword, String searchType) throws SQLException {
		String url="";
    	if(mymenu == null) {
			url="/mymenu/sendNoteList.page";
		} else {
			url="/mymenu/sendNoteList.mymenu";
		}
		String c_no = (String)session.getAttribute("c_no");
		Map<String, String> valMap = new HashMap<>();
		valMap.put("keyword", keyword);
		valMap.put("searchType", searchType);
		valMap.put("c_no", c_no);
		List<NoteVO> note = null;
		note = mymenuService.searchNote(valMap);
		mnv.addObject("note", note);
		mnv.addObject("keyword", keyword);
		mnv.addObject("mcode", mcode);
		mnv.addObject("searchType", searchType);
		mnv.setViewName(url);
		
		return mnv;
	}
	

    @RequestMapping("/download")
    public ResponseEntity<FileSystemResource> downloadFile(HttpSession session, @RequestParam("files") String fileName, HttpServletResponse response) throws IOException {
    	String uploadFolder = session.getServletContext().getRealPath("/resources/saveFiles/");
    	String filePath = uploadFolder + fileName;
        File file = new File(filePath);

        if (file.exists()) {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            headers.setContentDispositionFormData("attachment", fileName);

            FileSystemResource resource = new FileSystemResource(file);
            return new ResponseEntity<>(resource, headers, org.springframework.http.HttpStatus.OK);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return null;
        }
    }

}
