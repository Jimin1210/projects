package kr.or.dw.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.or.dw.command.SearchCriteria;
import kr.or.dw.service.MailSendService;
import kr.or.dw.service.MemberService;
import kr.or.dw.service.MenuService;
import kr.or.dw.service.QnaService;
import kr.or.dw.vo.EmpVO;
import kr.or.dw.vo.InquiryVO;
import kr.or.dw.vo.MemberVO;

@Component
@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MenuService menuService;
	
	@Autowired
	private MemberService memberService;

	@Autowired
	private QnaService qnaService;
	
	@Autowired
	private MailSendService mailService;
	
	@RequestMapping("/mypage")
	public ModelAndView index(String mymenu, ModelAndView mnv, String mcode, HttpSession session) throws SQLException{
		String url = "";
    	if(mymenu == null) {
			url="/common/userProfile.page";
		} else {
			url="/common/userProfile.mymenu";
		}
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");		
		System.out.println(member);
		mnv.addObject("member", member);
		
		mnv.addObject("mcode", mcode);
		mnv.setViewName(url);
		return mnv;
	}
	@RequestMapping("/qna")
	public ModelAndView qna (String mymenu, SearchCriteria cri, ModelAndView mnv, String mcode, HttpSession session) throws Exception {
		String url = "";
    	if(mymenu == null) {
			url="/common/inquiryForm.page";
		} else {
			url="/common/inquiryForm.mymenu";
		}
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		int u_no = member.getU_no();

		Map<String, Object> dataMap = qnaService.selectQnaList(cri, u_no);
		
		
		mnv.addObject("mcode", mcode);
		mnv.addAllObjects(dataMap);
		
		List<InquiryVO> vo = (List<InquiryVO>) dataMap.get("qnaList");
		
		
		System.out.println(vo);
		
		mnv.setViewName(url);
		
		return mnv;
		
	}
	
	@RequestMapping("/qnaRegist")
	public ModelAndView qnaRegist (SearchCriteria cri, ModelAndView mnv, String mcode, String inq_con, HttpSession session) throws Exception {
		
		mcode="M010200";
		
		String getUrl = menuService.getUrl(mcode);
		String getUrlResult = getUrl.substring(0, getUrl.indexOf("."));
		String url = getUrl + "?mcode=M010000";			
		
		int u_no = 0;
		
		if(session.getAttribute("loginUser") != null) {
			MemberVO member = (MemberVO) session.getAttribute("loginUser");
			u_no = member.getU_no();
		}
		
		int emp_no = Integer.parseInt(session.getAttribute("emp_no").toString());
		
		InquiryVO qna = new InquiryVO();
		qna.setInq_con(inq_con);
		qna.setU_no(u_no);
		qna.setSys_reg(emp_no + "");
		qna.setSys_up(emp_no + "");
		
		qnaService.insertQna(qna);
		
		mnv.setViewName("redirect:" + url);		
		
		return mnv;
		
	}
	
	@RequestMapping("/modify")
	public ModelAndView modify (InquiryVO inquiry, String mcode, ModelAndView mnv)throws Exception{	
	
		String url = "/common/modify";
		
		qnaService.modifyQna(inquiry);
		
		mnv.addObject("mcode", mcode);
		mnv.setViewName(url);
		
		return mnv;
	}

	//Q&A 삭제 
	@RequestMapping("/remove")
	public ModelAndView remove (int inq_no, String mcode, ModelAndView mnv) throws Exception {
		
		String url = "/common/remove";
		
		qnaService.remove(inq_no);
		
		mnv.addObject("mcode", mcode);
		mnv.setViewName(url);
		
		return mnv;
		
	}
	
	// 아이디 중복확인
	@RequestMapping("/idCheck") 
	public ResponseEntity<String> idCheck(String id, HttpServletRequest req) throws Exception{
		
		ResponseEntity<String> entity = null;
		
		try {
			MemberVO member = memberService.selectMemberById(id);
			entity = new ResponseEntity<String>(member == null ? id : "", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return entity;
	};


	
	
	//회원가입 페이지 이동

		@GetMapping("/registerForm")
		public void registerForm() {}
		
		//이메일 인증
		@GetMapping("/mailCheck")
		@ResponseBody
		public String mailCheck(String email) throws Exception{
			return mailService.joinEmail(email);
					
		};
		
	@RequestMapping("/mailChecked")
	@ResponseBody
	public String mail(String email, String name) throws SQLException {
	    System.out.println(email);
	    System.out.println(name);
	    Map<String, String> map = new HashMap<>();
	    map.put("email", email);
	    map.put("name", name);
	    int a = mailService.getMail(map);
	    System.out.println(a);
	    return Integer.toString(a); // int 값을 문자열로 변환하여 반환
	}
	
	@RequestMapping("/mailChecked2")
	@ResponseBody
	public String mail2(String email, String id) throws SQLException {
	    System.out.println(email);
	    Map<String, String> map = new HashMap<>();
	    map.put("email", email);
	    map.put("id", id);
	    int a = mailService.getMail2(map);
	    System.out.println(a);
	    return Integer.toString(a); // int 값을 문자열로 변환하여 반환
	}
	
	// 회원가입 
	@RequestMapping("/register")
	public String register(MemberVO member, String domainselect, HttpServletRequest req, HttpServletResponse res) throws Exception{
		member.setEmail(member.getEmail()+ domainselect);
		memberService.register(member);
		
		  res.setContentType("text/html; charset=utf-8");
	      PrintWriter out = res.getWriter();
	      out.println("<script>");
	      out.println("alert('회원가입이 정상적으로 되었습니다.');");
	      out.println("</script>");
	      
	      return "/common/loginForm";
	}
	
	// 아이디 찾기 
	@RequestMapping("/IDfindForm")
	public String IDfindForm(HttpServletResponse res) throws Exception {

		String url = "/common/IDfindForm";
		return url;
	}
	
	@RequestMapping("/IDfind")
	public void IDfind(MemberVO member, HttpServletResponse res) throws SQLException, IOException {
		MemberVO status = memberService.idFind(member);
		
		res.setContentType("text/html; charset=utf-8");
	    PrintWriter out = res.getWriter();
		if(status == null || status.equals("")) {	
		  out.println("<script>");
		  out.println("alert('회원님의 이름 또는 이메일를 다시 확인해주세요.');");
		  out.println("location.href='/common/IDfindForm';");
		  out.println("</script>");
		}else {
	      out.println("<script>");
	      out.println("alert('회원님의 ID는 " + status.getId() + " 입니다.');");
	      out.println("location.href='/common/loginForm';");
	      out.println("</script>");
		}
		
	}
	
	//비밀번호 찾기 
	@RequestMapping("/PWfindForm")
	public String PWfindForm() {
		return "/common/PWfindForm";
	}

	@RequestMapping("/PWfind")
	public ModelAndView PWfind(MemberVO member, HttpServletRequest req, HttpServletResponse res, ModelAndView mnv) throws Exception {
		String status2 = memberService.pwFind(member);
		
		if(status2 == null || status2.equals("")) {
			mnv.setViewName("/common/PWfindForm");
		} else {			
			mnv.addObject("id", member.getId());
			mnv.setViewName("/common/PWrenew");
		}
		
		return mnv;
	}
	// 새로운 비밀번호 설정
	@RequestMapping("/PWrenew")
	public ModelAndView PWrenew (ModelAndView mnv, String pwd, String id) throws Exception{
		String url = "/common/loginForm";
		
		memberService.pwRenew(pwd, id);		
		mnv.setViewName(url);
		
		return mnv;
	}
	
	//개인정보 수정
	@RequestMapping("/modProfileForm")
	public ModelAndView modProfile(String mymenu, String mcode, ModelAndView mnv) throws Exception {		
		String url = "";
    	if(mymenu == null) {
			url="/common/modProfile.page";
		} else {
			url="/common/modProfile.mymenu";
		}
		
		mnv.addObject("mcode", mcode);		
		mnv.setViewName(url);
		
		return mnv;
	}	

	// 개인정보 조회
	@RequestMapping("/modProfile")
	public ModelAndView Profile(String mymenu, MemberVO member, HttpSession session, String mcode, ModelAndView mnv) throws Exception {
		String url = "";
    	if(mymenu == null) {
			url="/common/userProfile.page";
		} else {
			url="/common/userProfile.mymenu";
		}
	
		
		MemberVO mem = (MemberVO) session.getAttribute("loginUser");
		String id = mem.getId();
		member.setId(id);
		mem.setAddr(member.getAddr());
		mem.setEmail(member.getEmail());
		mem.setTel(member.getTel());
		
		memberService.modProfile(member);
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("member", mem);
		mnv.setViewName(url);
		session.removeAttribute("loginUser");
		session.setAttribute("loginUser", mem);
		
		return mnv;
	}
	
	// 회원정보 수정에서 비밀번호 변경
	@RequestMapping("/repwdForm")
	public ModelAndView repwdForm(String mymenu, String mcode, ModelAndView mnv, HttpSession session) throws Exception {
		String url = "";
	    MemberVO emp = (MemberVO) session.getAttribute("loginUser");
	    String email = emp.getEmail();
    	if(mymenu == null) {
			url="/common/repwdForm.page";
		} else {
			url="/common/repwdForm.mymenu";
		}
		
		mnv.addObject("mcode", mcode);		
		mnv.setViewName(url);
		mnv.addObject("email", email);
		return mnv;
	}

	
	@RequestMapping("/repwd")
	public ModelAndView repwd (String mymenu, ModelAndView mnv, String mcode, String pwd, HttpSession session,  HttpServletResponse res) throws Exception{
		String url = "";
    	if(mymenu == null) {
			url="/common/userProfile.page";
		} else {
			url="/common/userProfile.mymenu";
		}
				
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		String id = member.getId(); 
		
		memberService.pwRenew(pwd, id);		
		
		mnv.addObject("mcode", mcode);
		mnv.addObject("member", member);
		mnv.setViewName(url);
		
		return mnv;
	}
	
	
	//회원탈퇴 
	@RequestMapping("/delete")
	public String delete(HttpSession session )throws Exception {
		String url = "/common/loginForm";
		
		MemberVO member = (MemberVO) session.getAttribute("loginUser");
		int u_no = member.getU_no(); 
		
		memberService.delete(u_no);
	
	
		return url;
	}

}
