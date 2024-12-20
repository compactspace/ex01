package kr.happyjob.study.login.service;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.AESCryptoHelper;
import kr.happyjob.study.common.comnUtils.ComnUtil;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
/*import kr.happyjob.study.common.comnUtils.AESCryptoHelper;
import kr.happyjob.study.common.comnUtils.ComnUtil;*/
import kr.happyjob.study.login.dao.LoginDao;
import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.login.model.UserInfoModel;
import kr.happyjob.study.login.model.UsrMnuAtrtModel;
import kr.happyjob.study.login.model.UsrMnuChildAtrtModel;

@Service("loginService")
public class LoginServiceImpl implements LoginService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@Autowired
	private LoginDao loginDao;
	
	/** 사용자 로그인 체크*/
	public String checkLogin(Map<String, Object> paramMap) throws Exception {
		return loginDao.checkLogin(paramMap);
	}
	
//	/** 사용자 로그인 */
	/*react*/
	public LgnInfoModel loginProc(Map<String, Object> paramMap) throws Exception {
		String loginId = paramMap.get("lgn_Id").toString();
		String inputPassword = paramMap.get("pwd").toString();
//		
//		//logger.info(" login before password : " + password);
//		//AES 방식 암호화
//		//password = AESCryptoHelper.encode( ComnUtil.AES_KEY, password);
//		
//		//logger.info(" login after password : " + password);
//		
		Map<String, Object> paramMapForPw = new HashMap<>();
		paramMapForPw.put("lgn_Id", loginId);
		
		String storedPassword = loginDao.selectPw(paramMapForPw);
		
		 // 사용자가 존재하지 않으면 null 리턴
	    if (storedPassword == null) {
	        return null;
	    }
	    
	    try {
	        // 입력된 비밀번호와 저장된 해시된 비밀번호를 비교
	        boolean checkPassword = BCrypt.checkpw(inputPassword, storedPassword);
	        logger.info("*** hashpassword - inputPassword: " + BCrypt.hashpw(inputPassword, BCrypt.gensalt()));
	        logger.info("*** hashpassword - storedPassword: " + storedPassword);
	        if (!checkPassword) {
	            return null;
	        }
	    } catch (Exception e) {
	        // 해시 비교 중 에러가 발생하면 null 리턴
	        return null;
	    }
		 
		 return loginDao.selectLoginInfo(paramMapForPw);
	}
	
	
	
	
	/**  사용자 메뉴 권한 */
	public List<UsrMnuAtrtModel> listUsrMnuAtrt(Map<String, Object> paramMap) throws Exception {	
		return loginDao.listUsrMnuAtrt(paramMap);
	}
	

	/**  사용자 자식 메뉴 권한 */
	public List<UsrMnuChildAtrtModel> listUsrChildMnuAtrt(Map<String, Object> paramMap) throws Exception{
		return loginDao.listUsrChildMnuAtrt(paramMap);

	}
	
//	/*기존 코드*/
//	/**사용자 회원가입*/
//	@Override
//	public int registerUser(Map<String, Object> paramMap) throws Exception {
//		int ret = loginDao.registerUser(paramMap);
//		return ret;
//	}
	
	/**사용자 회원가입*/
	@Override
	public int registerUser(Map<String, Object> paramMap) throws Exception {
		String password = (String) paramMap.get("password");
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
//			paramMap.put("password", encryptPw);
//
//		}catch(NoSuchAlgorithmException e) {
//			logger.error("Error while hashing password", e);
//			throw new Exception("비밀번호 해시화 실패", e);  // 예외를 던져서 상위 레벨에서 처리하도록 할 수 있음	
//		}
		
		 // Bcrypt를 사용한 비밀번호 암호화 (자동 솔트 추가)
	    String encryptPw = BCrypt.hashpw(password, BCrypt.gensalt());

	    logger.info("암호화 전: " + password);
	    logger.info("암호화 후: " + encryptPw);

	    // 암호화된 비밀번호를 paramMap에 저장
	    paramMap.put("password", encryptPw);
	    logger.info("해시 길이: " + encryptPw.trim().length());
	    
		int ret = loginDao.registerUser(paramMap);
		return ret;

	}

	
//	/**loginID 중복체크* - 기존 코드*/
//	@Override
//	public int check_loginId(UserInfoModel model) throws Exception {
//		int result = loginDao.check_loginId(model);
//		return result;
//	}
	
	/**loginID 중복체크*/
	@Override
	public int check_loginId(Map<String, Object> paramMap) throws Exception {
		int result = loginDao.check_loginId(paramMap);
		return result;
	}
	
	@Override
	public int check_email(UserInfoModel model) throws Exception {
		int result = loginDao.check_email(model);
		return result;
	}

	/** 사용자 ID 찾기 */
	public String selectFindId(Map<String, Object> paramMap) throws Exception{
		return loginDao.selectFindId(paramMap);
	}
	
	/** 사용자 ID Cnt 찾기 */
	public int selectFindIdCnt(Map<String, Object> paramMap) throws Exception{
		return loginDao.selectFindIdCnt(paramMap);
	}

	/** 사용자 PW 찾기 */
	public LgnInfoModel selectFindPw(Map<String, Object> paramMap) throws Exception{
/*		String password = paramMap.get("pwd").toString();
		//AES 방식 암호화
		password = AESCryptoHelper.encode( ComnUtil.AES_KEY, password);
		paramMap.put("pwd", password);*/
		return loginDao.selectFindPw(paramMap);
	}
	/** 사용자 PW 찾기 ID 체크*/
	@Override
	public LgnInfoModel registerIdCheck(Map<String, Object> paramMap) throws Exception {
	
		return loginDao.registerIdCheck(paramMap);
	}

	
	/** 사용자 비밀번호 찾기 비번 바꿔주기 */
	public int updatePw(Map<String, Object> paramMap) throws Exception{
		
		String password = (String) paramMap.get("pw");
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
		String encryptPw = BCrypt.hashpw(password, BCrypt.gensalt());
			paramMap.put("pw", encryptPw);
			logger.info("해시 길이: " + encryptPw.trim().length());
//
//		}catch(NoSuchAlgorithmException e) {
//			logger.error("Error while hashing password", e);
//			throw new Exception("비밀번호 해시화 실패", e);  // 예외를 던져서 상위 레벨에서 처리하도록 할 수 있음	
//		}
		
		return loginDao.updatePw(paramMap);
	};
	

	/** 사용자 PW Cnt찾기 ID 체크*/
	@Override
	public int selectFindPwCnt(Map<String, Object> paramMap) throws Exception{
		return loginDao.selectFindPwCnt(paramMap);
	};
	
/*	*//** select박스 은행 목록*//*
	@Override
	public List<LgnInfoModel> selectBankList() {
		List<LgnInfoModel> list = loginDao.selectBankList();
		return list;
	}*/

	/* 이력서파일 업로드 */
	

	
	@Override
	public void insertFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;

	
		// D:\\FileRepository\\ 밑에 F200330 이런식으로 폴더생성하기위해 가져옴.
		// properties에서 가져오는방법
		String dirPath = LoginDao.getDirectory(); 
		paramMap.put("dirPath", dirPath);
		
		// 파일 저장
		String itemFilePath = dirPath+ File.separator; // 업로드 실제 경로 조립 (문자열생성)
		FileUtilCho fileUtil = new FileUtilCho(multipartHttpServletRequest, "D:\\FileRepository", "/serverfile", itemFilePath);
		Map<String, Object> fileInfo = fileUtil.uploadFiles(); // 실제 업로드 처리
		
		// 데이터 저장
		try {
				
				paramMap.put("fileInfo", fileInfo);
				LoginDao.insertResume(paramMap);
				//cmntBbsDao.saveCmntBbsAtmtFil(paramMap);
			
		} catch(Exception e) {
			// 파일 삭제
			fileUtil.deleteFiles(fileInfo);
			throw e;
		}
		
		
	}
	
	@Override
	public void insertResume(Map<String, Object> paramMap) {
		LoginDao.insertResume(paramMap);
		
	}

	


}
