package kr.happyjob.study.mypage.controller.as_is;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.mypage.dao.MypageDao;
import kr.happyjob.study.mypage.model.MypageModel;
import kr.happyjob.study.mypage.service_as_is.MypageService;

@Controller
@RequestMapping("/mypage/")
public class MypageController {
	
	@Autowired
	private MypageService mypageService;
	private MypageDao mypageDao;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("update.do")
	public String init() throws Exception {
		return "mypage/mypage";
	}
	
	@RequestMapping("userDetail.do")
	@ResponseBody
	public Map<String, Object> userDetailInfo(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId : " + loginId);
		paramMap.put("loginId", loginId);
		
		Map<String, Object> resultMap = new HashMap<>();
		MypageModel detailValue = mypageService.userDetail(paramMap);
		MypageModel chkRegBiz = mypageService.chkRegBiz(paramMap);
		
		resultMap.put("detail", detailValue);
		resultMap.put("chkRegBiz", chkRegBiz);
		
		logger.info("biz_idx: " + chkRegBiz.getBizIdx());
		logger.info("detailValue: " + paramMap);
		
		return resultMap;
	}
	
	@RequestMapping("modify.do")
	public Map<String, Object> userModifyInfo(){
		return null;

	}
	
	@RequestMapping("updatePw.do")
	@ResponseBody
	public Map<String, String> updatePasswd(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		Map<String, String> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		
		String passwd = (String)paramMap.get("passwd");
		String newPasswd = (String)paramMap.get("newPasswd");
		String newPasswdConfirm = (String)paramMap.get("newPasswdConfirm");
		
		paramMap.put("loginId", loginId);
		paramMap.put("newPasswd", newPasswd);
		
		// 1. 현재 비밀번호 맞는지 체크
		MypageModel mypageModel = mypageService.userDetail(paramMap);
		boolean isPasswdRight = passwd.equals(mypageModel.getPassword());
		
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
		int result = mypageService.updatePasswd(paramMap);
		
		// 4. 결과 반환
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
		
	}
	
	@RequestMapping("updateUserInfo.do")
	@ResponseBody
	public Map<String, String> updateUserInfo(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		String loginId = (String)session.getAttribute("loginId");
		Map<String, String> resultMap = new HashMap<>();
		paramMap.put("loginId", loginId);
		logger.info("회원정보 수정대상 ID: " + loginId);
		
		int result = mypageService.updateUserInfo(paramMap);
		
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	
	
	@RequestMapping("withdraw.do")
	public String withdraw() throws Exception {
		return "mypage/withdraw";
	}
	
	@RequestMapping("deleteUser.do")
	@ResponseBody
	public Map<String, String> deleteUser(@RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		
		String loginId = (String)session.getAttribute("loginId");
		logger.info("탈퇴유저 ID: " + loginId);
		
		Map<String, String> resultMap = new HashMap<>();
		
		paramMap.put("loginId", loginId);
		
		int result = mypageService.deleteUser(paramMap);
		
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
}
