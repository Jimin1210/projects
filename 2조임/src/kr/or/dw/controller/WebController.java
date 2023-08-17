package kr.or.dw.controller;

import java.io.IOException;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.or.dw.web.IAction;
import kr.or.dw.web.URIActionMapper;

/*
 * 만약, 기존 순수 Servlet 방식으로 모든 URL 들에 매핑될 컨트롤러를 작성했는데,
 * 모든 컨트롤러에 공통적으로 처리할 내용이 추가되어야 한다면 어떻게 할 수 있을까?
 * ==> 모든 컨트롤러에 찾아가서 해당 내용을 추가해야 한다.
 * 대표적으로 로그인과 인증 기능이 이에 해당한다고 볼 수 있다. ==> Front Controller 의 필요성이 여기에 있다.
 * 
 * 내부적으로 여러 Controller 에 대한 매핑정보를 가지고 있다가 이를 처리할 Controller 를 찾아서 처리하게 한 뒤,
 * 결과를 받아서 Servlet 에게 응답을 보내는것.
 */

//모든 요청을 받아서 처리하는 Servlet
public class WebController extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html; charset=utf-8");
		/*
		 * URL ==> http://localhost/servlet02/member/memberList.do
		 * URI ==>				   /servlet02/member/memberList.do
		 * 요청 URI ==>						 /member/memberList.do
		 * ContextPath ==>		   /servlet02
		 */
		
		// 사용자의 요청정보 가져오기
		String uri = req.getRequestURI();
		
		System.out.println("uri = " + uri);
		
		String view = "";	// view 페이지가 저장될 변수
		IAction action = null;
		
		action = URIActionMapper.getAction(uri);
		
		if(uri == null) {
			// 반환할 uri가 없으면 404에러 처리
			res.setStatus(HttpServletResponse.SC_NOT_FOUND);	// 404
		}else {
			// 실행 ==> 작업처리 후 View 페이지를 받는다.
			view = action.process(req, res);
			
			if(view != null) {
				if(action.isRedirect()) {	// 리다이렉트가 true 인 경우
					res.sendRedirect(req.getContextPath() + view);
				}else {	// 포워딩
					RequestDispatcher rd = req.getRequestDispatcher("/WEB-INF/view" + view);
					rd.forward(req, res);
				}
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}
	
	
}
