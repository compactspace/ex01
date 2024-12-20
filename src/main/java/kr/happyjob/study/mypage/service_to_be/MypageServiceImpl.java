package kr.happyjob.study.mypage.service_to_be;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.login.dao.LoginDao;
import kr.happyjob.study.mypage.dao.MypageDao;
import kr.happyjob.study.mypage.model.MypageModel;

@Service("mypageServiceToBe")
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	private MypageDao mypageDao;
	@Autowired
	private LoginDao loginDao;
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	@Override
	public MypageModel userDetail(Map<String, Object> paramMap) throws Exception {
		return mypageDao.getUserInfo(paramMap);
	}
	
	@Override
	public int deleteUser(Map<String, Object> paramMap) throws Exception {
		
		String loginId = paramMap.get("loginId").toString();
		String inputPassword = paramMap.get("password").toString();
//		
//		//logger.info(" login before password : " + password);
//		//AES 방식 암호화
//		//password = AESCryptoHelper.encode( ComnUtil.AES_KEY, password);
//		
//		//logger.info(" login after password : " + password);
//		
		Map<String, Object> paramMapForPw = new HashMap<>();
		paramMapForPw.put("lgn_Id", loginId);
		Map<String, Object> paramMapForDelete = new HashMap<>();
		paramMapForDelete.put("loginId", loginId);
		
		String storedPassword = loginDao.selectPw(paramMapForPw);
		
		 // 사용자가 존재하지 않으면 null 리턴
	    if (storedPassword == null) {
	        return 0;
	    }
	    
	    try {
	        // 입력된 비밀번호와 저장된 해시된 비밀번호를 비교
	        boolean checkPassword = BCrypt.checkpw(inputPassword, storedPassword);
	        if (!checkPassword) {
	            return 0;
	        }
	    } catch (Exception e) {
	        // 해시 비교 중 에러가 발생하면 null 리턴
	        return 0;
	    }
//		MessageDigest md = MessageDigest.getInstance("SHA-512");
//	    byte[] bytes = password.getBytes(StandardCharsets.UTF_8);
//	    md.update(bytes);
//	    String hashedInputPassword = Base64.getEncoder().encodeToString(md.digest());

//        paramMap.put("password", hashedInputPassword);
		
		return mypageDao.deleteUser_tobe(paramMapForDelete);
	}
	
	@Override
	public int updateUserInfo(Map<String, Object> paramMap) throws Exception {
		return mypageDao.updateUserInfo(paramMap);
	}
	
	@Override
	public int updatePasswd(Map<String, Object> paramMap) throws Exception {
		
		String password = (String) paramMap.get("newPasswd");
		logger.info("파람 맵에서 꺼낸 password : " + password);
		
//		//암호화된 비밀번호 저장 변수*
//		String encryptPw = null;
//
//		//1. 해시 함수를 수행할 객체를 참조 변수 선언*
//		MessageDigest md = null;
//		
//		try {
//
//			md = MessageDigest.getInstance("SHA-512");
//
//			byte[] bytes = password.getBytes(StandardCharsets.UTF_8);
//
//			md.update(bytes);
//			
//			encryptPw = Base64.getEncoder().encodeToString(md.digest());
//
//			logger.info("암호화 전: " + password);
//			logger.info("암호화 후: " + encryptPw);
//			
//			paramMap.put("newPasswd", encryptPw);
//
//		}catch(NoSuchAlgorithmException e) {
//			logger.error("Error while hashing password", e);
//			throw new Exception("비밀번호 해시화 실패", e);  // 예외를 던져서 상위 레벨에서 처리하도록 할 수 있음	
//		}
//		
		String encryptPw = BCrypt.hashpw(password, BCrypt.gensalt());
		paramMap.put("newPasswd", encryptPw);
		logger.info("해시 길이: " + encryptPw.trim().length());
		
		return mypageDao.updatePasswd(paramMap);
		
	}
	
	@Override
	public MypageModel chkRegBiz(Map<String, Object> paramMap) throws Exception {
		return mypageDao.chkRegBiz(paramMap);
	}

}
