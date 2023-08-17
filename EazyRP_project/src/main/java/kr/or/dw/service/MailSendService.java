package kr.or.dw.service;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.stereotype.Service;

public interface MailSendService {

	String joinEmail(String email);

	int getMail(Map<String, String> map) throws SQLException;

	int getMail2(Map<String, String> map) throws SQLException;

}
