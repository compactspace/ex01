package kr.happyjob.study.manageuser.service;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.manageuser.dao.ManageuserDao;
import kr.happyjob.study.manageuser.model.ManageuserModel;

@Service
public class ManageuserServiceImpl implements ManageuserService {
	
	@Autowired
	private ManageuserDao manageuserDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	@Override
	public List<ManageuserModel> applicantList(Map<String, Object> paramMap) throws Exception {
		return manageuserDao.applicantList(paramMap);
	}

	@Override
	public List<ManageuserModel> bizList(Map<String, Object> paramMap) throws Exception {
		return manageuserDao.bizList(paramMap);
	}

	@Override
	public int applicantListCnt(Map<String, Object> paramMap) throws Exception {
		return manageuserDao.applicantListCnt(paramMap);
	}

	@Override
	public int bizListCnt(Map<String, Object> paramMap) throws Exception {
		return manageuserDao.bizListCnt(paramMap);
	}
	
	@Override
	public ManageuserModel manageApplicantDetail(Map<String, Object> paramMap) throws Exception {
		return manageuserDao.applicantManageDetail(paramMap);
	}
	
	@Override
	public int applicantPwReset(Map<String, Object> paramMap) throws Exception {
		return manageuserDao.applicantPwReset(paramMap);
	}
	
	//비밀번호 초기화 + 해시화
	@Override
	public int applicantPwReset1234(Map<String, Object> paramMap) throws Exception {
		String password = "1234";
		logger.info("비밀번호 초기화용 password : " + password);
		
//		//암호화된 비밀번호 저장 변수*
//		String encryptPw = null;
//		//1. 해시 함수를 수행할 객체를 참조 변수 선언*
//		MessageDigest md = null;
//		
//		try {
//			md = MessageDigest.getInstance("SHA-512");
//			byte[] bytes = password.getBytes(StandardCharsets.UTF_8);
//			md.update(bytes);
//			encryptPw = Base64.getEncoder().encodeToString(md.digest());
//
//			logger.info("암호화 전: " + password);
//			logger.info("암호화 후: " + encryptPw);
//			
//			paramMap.put("initPassword", encryptPw);
//
//		}catch(NoSuchAlgorithmException e) {
//			logger.error("Error while hashing password", e);
//			throw new Exception("비밀번호 해시화 실패", e);  // 예외를 던져서 상위 레벨에서 처리하도록 할 수 있음	
//		}
		
		String encryptPw = BCrypt.hashpw(password, BCrypt.gensalt());
		paramMap.put("initPassword", encryptPw);
		logger.info("해시 길이: " + encryptPw.trim().length());
		
		return manageuserDao.applicantPwResetTo1234(paramMap);
	}
	
	@Override
	public int applicantInfoUpdate(Map<String, Object> paramMap) throws Exception {
		return manageuserDao.applicantInfoUpdate(paramMap);
	}
	
	@Override
	public ManageuserModel manageBizDetail(Map<String, Object> paramMap) throws Exception {
		return manageuserDao.bizManageDetail(paramMap);
	}
	
	@Override
	public int bizInfoUpdate(Map<String, Object> paramMap) throws Exception {
		return manageuserDao.bizInfoUpdate(paramMap);
	}

}
