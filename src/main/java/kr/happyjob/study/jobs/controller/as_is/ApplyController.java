package kr.happyjob.study.jobs.controller.as_is;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.jobs.model.ApplyModel;
import kr.happyjob.study.jobs.service.ApplyService;

@Controller
@RequestMapping("/jobs/")
public class ApplyController {
	
	@Autowired
	private ApplyService applyService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	//입사지원 페이지
	// 입사지원 관련 데이터의 디테일이 아니라 입사지원 화면에 출력할 페이지 디테일
	@RequestMapping("applyBizPostDetail.do")
	@ResponseBody
	public Map<String, Object> applyBizPostDetail(@RequestParam Map<String, Object> paramMap, 
			HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		logger.info("applyBizPostDetail: " + paramMap);

		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId: " + loginId);
	    resultMap.put("loginId", loginId);
	    
	    ApplyModel bizPostDetail = applyService.ApplyBizPostDetail(paramMap);
		resultMap.put("bizPostDetail", bizPostDetail);
		
	   return resultMap;
	}
	
	//입사지원 페이지
		// 입사지원 관련 데이터의 디테일이 아니라 입사지원 화면에 출력할 페이지 디테일
		@RequestMapping("applyUserResumeDetail.do")
		@ResponseBody
		public Map<String, Object> applyUserResumeDetail(@RequestParam Map<String, Object> paramMap, 
				HttpSession session) throws Exception {
			Map<String, Object> resultMap = new HashMap<>();
			logger.info("applyUserResumeDetail: " + paramMap);

			String loginId = (String) session.getAttribute("loginId");
			logger.info("loginId: " + loginId);
		    resultMap.put("loginId", loginId);
		    
			List<ApplyModel> userResumeList = applyService.ApplyUserResumeDetail(paramMap);
			resultMap.put("userResumeList", userResumeList);
			
			return resultMap;
		}
	
	
	//입사지원
	@RequestMapping("saveApply.do")
	@ResponseBody
	public Map<String, String> saveApply(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveApply: " + paramMap);
		
		//기존에 입사지원한 이력이 있는지 조회(조회할 땐 이력서 번호는 파라미터에서 제외)
		//제외하지 않으면 유저 아이디와 공고 아이디가 있어도 다른 이력서로라면 지원이 가능해짐
		 Map<String, Object> filteredParamMap = new HashMap<>();
		    filteredParamMap.put("userIdx", paramMap.get("userIdx"));
		    filteredParamMap.put("loginIdx", paramMap.get("loginIdx"));
		    filteredParamMap.put("postIdx", paramMap.get("postIdx"));
		    
		ApplyModel existApply = applyService.selectApplyExist(filteredParamMap);
		
		if(existApply != null){
			logger.info("이미 지원 완료된 공고입니다.");
			resultMap.put("result", "fail");
	        resultMap.put("message", "이미 지원 완료된 공고입니다.");
	        return resultMap; // 실패 응답 반환
		}
		int result = applyService.saveApply(paramMap);
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}

}
