package kr.or.dw.user.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import kr.or.dw.user.service.IUserService;
import kr.or.dw.user.service.UserServiceImpl;
import kr.or.dw.web.IAction;

public class UserIdCheckAction implements IAction{

	@Override
	public boolean isRedirect() {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public String process(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		res.setContentType("application/json; charset=utf-8");
		
		String id = req.getParameter("id");
		
		IUserService service = UserServiceImpl.getInstance();
		
		id = service.getUserNick(id);
		
		Gson gson = new Gson();
		String result = null;
		
		if(id == null) {	// 중복되지 않는 경우
			result = gson.toJson("사용가능한 닉네임입니다.");
		}else {	// 중복되는 경우
			result = gson.toJson("중복된 닉네임입니다. 다시 입력해주세요.");
		};
		
		PrintWriter out = res.getWriter();
		out.println(result);
		out.flush();
		
		return null;
	}

}
