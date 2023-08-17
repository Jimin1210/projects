package kr.or.dw.web;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.ResourceBundle;

// uri_mapping.properties 파일에 설정된 uri에 맞는 Action 객체를 가져와서
// 인스턴스를 생성해서 반환하는 역할을 수행하는 클래스
public class URIActionMapper {
	
	// properties의 내용을 읽어와 uri는 키값, action 객체명은 value 값으로 해서
	// 저장될 Map 객체 생성
	private static Map<String, String> actionMap = new HashMap<>();
	
	static {
		// properties 파일을 읽어와 Bundle 객체를 생성한다.
		ResourceBundle rb = ResourceBundle.getBundle("kr.or.dw.web.uri_mapping");
		
		// Bundle 객체의 key값 가져오기
		Enumeration<String> en = rb.getKeys();
		while(en.hasMoreElements()) {
			String key = en.nextElement();	// 키값(uri)
			String value = rb.getString(key).trim();	// value값(Action 객체명)
			// 키값과 value 값을 Map에 저장
			actionMap.put(key, value);
		}
	}
	
	// 인수값으로 주어진 uri에 맞은 Action 객체를 인스턴스화 해서 반환하는 메서드
	public static IAction getAction(String uri) {
		IAction action = null;
		// 해당 URI가 등록되어 있는지 검사
		if(actionMap.containsKey(uri)) {
			try {
				// 문자열로된 Action 객체의 이름을 이용해서 해당 클래스를 메모리에 로딩한다.
				Class cls = Class.forName(actionMap.get(uri));
				
				// 메모리에 로딩된 Action 클래스를 '인스턴스화' 한다. ==> 객체생성
				action = (IAction) cls.newInstance();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (InstantiationException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return action;
	}
	
}
