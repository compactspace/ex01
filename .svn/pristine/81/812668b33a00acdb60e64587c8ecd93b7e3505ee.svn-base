package kr.happyjob.study.jobs.controller.to_be;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.apply.service.ResumeService;
import kr.happyjob.study.jobs.model.ApplyModel;
import kr.happyjob.study.jobs.service.ApplyService;

@RestController
@RequestMapping("/api/jobs/")
public class ApplyRestController {

	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private ResumeService resumeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
    /**
     * 입사지원 클릭시 유저 정보 부르기
     *    
     * @param session  현재 사용자 세션
     * @return ResponseEntity
     *         - 성공: 지원서 제목,id와 유저 연락처,이메일 정보
     *         - 실패: 에러 메시지와 상태 코드
     */	
	@GetMapping("applyUserResumeDetail.do")
	public Map<String, Object> applyUserResumeDetail(HttpSession session) throws Exception {
		Map<String, Object> paramMap = new HashMap<>();
		Map<String, Object> resultMap = new HashMap<>();
	
		logger.info("applyUserResumeDetail: " + paramMap);

		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId: " + loginId);
		paramMap.put("loginIdx", loginId);
	    resultMap.put("loginId", loginId);
	    
		List<ApplyModel> userResumeList = applyService.ApplyUserResumeDetail(paramMap);
		resultMap.put("userResumeList", userResumeList);
		
		return resultMap;
	}
	
    /**
     * 입사지원 클릭시 입사 지원
     *    
     * @param session  현재 사용자 세션
     * @return ResponseEntity
     *         - 성공: 지원서 제목,id와 유저 연락처,이메일 정보
     *         - 실패: 에러 메시지와 상태 코드
     */		
	@PostMapping("saveApply.do")
	public Map<String, String> saveApply(@RequestBody Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId: " + loginId);
		paramMap.put("loginIdx", loginId);
		
		logger.info("saveApply: " + paramMap);

	    // userIdx 찾기
	    int userIdx = applyService.getUserIdxByLoginId(loginId);
	    paramMap.put("userIdx", userIdx);
		
		//기존에 입사지원한 이력이 있는지 조회(조회할 땐 이력서 번호는 파라미터에서 제외)
		//제외하지 않으면 유저 아이디와 공고 아이디가 있어도 다른 이력서로라면 지원이 가능해짐
		 Map<String, Object> filteredParamMap = new HashMap<>();
		    filteredParamMap.put("loginIdx", paramMap.get("loginIdx"));
		    filteredParamMap.put("postIdx", paramMap.get("postIdx"));
		    filteredParamMap.put("userIdx", paramMap.get("userIdx")); 

		    
		ApplyModel existApply = applyService.selectApplyExist(filteredParamMap);
		
		if(existApply != null){
			logger.info("이미 지원 완료된 공고입니다.");
			resultMap.put("result", "fail");
	        resultMap.put("message", "이미 지원 완료된 공고입니다.");
	        return resultMap; // 실패 응답 반환
		}
		
		// 여기에 resumeIdx에 해당하는 resume 테이블의 모든 값을 그대로 복사하고, idx를 새로 지어서 paramMap의 resumeIdx를 수정해서 아래 saveApply에 집어넣기
		int oldResumeIdx = (int) paramMap.get("resumeIdx");
		Map<String, Object> oldResumeIdxMap = new HashMap<>();
		oldResumeIdxMap.put("resIdx", oldResumeIdx);
		
		int newResumeIdx = resumeService.copyResumeAndGetNewResumeIdx(oldResumeIdxMap);
		paramMap.put("resumeIdx", newResumeIdx);
		
		int result = applyService.saveApply(paramMap);
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
}
