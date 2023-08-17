package kr.or.dw.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface IAction {
	// IAction을 Implements 한 클래스에서 View(jsp)를 결정하고 해당 View로
	// redirect 할 것인지 결정하는 메서드
	public boolean isRedirect();
	
	// IAction을 implements 한 클래스의 process()메서드를 호출해서 URI를 기준으로 한
	// 요청처리를 위임하고 View 페이지를 반환한다.
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException;
}
