package kr.or.dw.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class CryptoUtil {
	
	// byte 배열을 Hex(16진수) 문자열로 변환하는 메서드
	public static String byteToHexString(byte[] data) {
		StringBuffer sb = new StringBuffer();
		for(byte b : data) {
			// 16진수 2자리의 문자열로 만든다.
			// (b & 0xFF) ==> 0a ==> a
			// (b & 0xFF) + 0x100 ==> 10a
			sb.append( Integer.toHexString((b & 0xFF) + 0x100).substring(1));
		};
		
		return sb.toString();
	}
	
	// 문자열을 MD5 방식으로 암호화하는 메서드
	// MD5 (message-digest algorithm)는 콘텐츠 검증 및 디지털 서명뿐만 아니라
	// 메시지 인증에 사용되는 해시 알고리즘.
	// MD5 는 보낸 파일과 받은 파일이 일치하는지 확인하는 해시 함수를 기반으로 한다.
	// 이전에는 MD5가 데이터 암호화에 사용되었지만, 현재는 주로 인증에 사용된다.
	public static String md5(String msg) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("MD5");
		md.update(msg.getBytes());
		return CryptoUtil.byteToHexString(md.digest());
	}
	
	// [Secure Hash Algorithm]
	/*
	 * SHA는 MD5를 수정한 버전이고 데이터 및 인증서를 해시하는데 사용한다.
	 * 입력 데이터를 비트 연산, 모듈러 합 및 압축 함수를 사용하여 알아보기 힘든 더 작은 형태로 줄인다.
	 * SHA 이름의 예로는 SHA-1, SHA-2, SHA-256, SHA-512, SHA-224, SHA-384가 있지만
	 * 실제로는 SHA-1 및 SHA-2의 두 가지 유형이 있다.(SHA-3도 있음)
	 */
	
	// 문자열을 SHA-256방식으로 암호화하는 메서드
	public static String sha256(String msg) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(msg.getBytes());
		return CryptoUtil.byteToHexString(md.digest());
	}
	
	// 문자열을 SHA-512방식으로 암호화하는 메서드
	public static String sha512(String msg) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		md.update(msg.getBytes());
		return CryptoUtil.byteToHexString(md.digest());
	}
	
}
