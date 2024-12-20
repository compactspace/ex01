package kr.happyjob.study.mypage.controller.to_be;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.mypage.dao.MypageDao;
import kr.happyjob.study.mypage.model.MypageModel;
import kr.happyjob.study.mypage.service_to_be.MypageService;

@RestController
@RequestMapping("/api/mypage/")
public class MypageRestController {
	
	@Autowired
	private MypageService mypageServiceToBe;
	private MypageDao mypageDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	
	@RequestMapping("userDetail.do")
	@ResponseBody
	public Map<String, Object> userDetailInfo(@RequestBody Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		MypageModel detailValue = mypageServiceToBe.userDetail(paramMap);
		MypageModel chkRegBiz = mypageServiceToBe.chkRegBiz(paramMap);
		
		resultMap.put("detail", detailValue);
		resultMap.put("chkRegBiz", chkRegBiz);
		
		logger.info("biz_idx: " + chkRegBiz.getBizIdx());
		logger.info("detailValue: " + paramMap);
		
		return resultMap;
	}
	
	@RequestMapping("updateUserInfo.do")
	@ResponseBody
	public Map<String, String> updateUserInfo(@RequestBody Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		String loginId = (String)session.getAttribute("loginId");
		Map<String, String> resultMap = new HashMap<>();
		paramMap.put("loginId", loginId);
		logger.info("회원정보 수정대상 ID: " + loginId);
		
		int result = mypageServiceToBe.updateUserInfo(paramMap);
		
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("updatePw.do")
	@ResponseBody
	public Map<String, String> updatePasswd(@RequestBody Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		Map<String, String> resultMap = new HashMap<>();
		
		logger.info("paramMap : " + paramMap);
		String passwd = (String)paramMap.get("passwd");
		String newPasswd = (String)paramMap.get("newPasswd");
		String newPasswdConfirm = (String)paramMap.get("newPasswdConfirm");
		
		paramMap.put("newPasswd", newPasswd);
		
//		MessageDigest md = MessageDigest.getInstance("SHA-512");
//	    byte[] bytes = passwd.getBytes(StandardCharsets.UTF_8);
//	    md.update(bytes);
//	    String hashedOldPassword = Base64.getEncoder().encodeToString(md.digest());
		
		// 1. 현재 비밀번호 맞는지 체크
		MypageModel mypageModel = mypageServiceToBe.userDetail(paramMap);
		boolean isPasswdRight = BCrypt.checkpw(passwd, mypageModel.getPassword());
//		boolean isPasswdRight = hashedOldPassword.equals(mypageModel.getPassword());
		
		if(isPasswdRight == false) { // 현재 비밀번호 일치하지 않음
			resultMap.put("result", "fail1");
			return resultMap;
		}
		
		// 2. 새 비밀번호, 새 비밀번호 확인 맞는지 체크
		if(newPasswd.equals(newPasswdConfirm) == false) { // 새 비밀번호, 새 비밀번호 확인이 서로 다름
			resultMap. put("result", "fail2");
			return resultMap;
		}
		
		// 3 . DB 비밀번호 변경
		int result = mypageServiceToBe.updatePasswd(paramMap);
		
		// 4. 결과 반환
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
		
	}
	
	
	@RequestMapping("deleteUser.do")
	@ResponseBody
	public Map<String, String> deleteUser(@RequestBody Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		
		Map<String, String> resultMap = new HashMap<>();
		
		int result = mypageServiceToBe.deleteUser(paramMap);
		
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

}
