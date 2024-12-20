package kr.happyjob.study.apply.controller.to_be;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.apply.model.CareerModel;
import kr.happyjob.study.apply.model.CertificationModel;
import kr.happyjob.study.apply.model.EducationModel;
import kr.happyjob.study.apply.model.HistoryModel;
import kr.happyjob.study.apply.model.ResumeModel;
import kr.happyjob.study.apply.model.SkillModel;
import kr.happyjob.study.apply.service.HistoryService;
import kr.happyjob.study.apply.service.ResumeService;
import kr.happyjob.study.board.model.NoticeModel;
import kr.happyjob.study.common.comnUtils.ApiResponseUtil;

@RestController
@RequestMapping("/api/apply")
public class HistoryRestController {
	
	@Autowired
	private HistoryService historyService;
	
	@Autowired
	private ResumeService resumeService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	@PostMapping("historyRest.do")
	public Map<String, Object> getApplyHistory( Model model, HttpSession session) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		Map<String, Object> resultMap = new HashMap<>();
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		paramMap.put("userNm", (String) session.getAttribute("userNm"));
		paramMap.put("userType", (String) session.getAttribute("userType"));

		List<HistoryModel> resultList = historyService.getApplyHistoryList(paramMap);
		resultMap.put("result", resultList);

		return resultMap;
	}
		
//	@PostMapping("historySearchRestTemp.do")
//	@ResponseBody
//	public Map<String, Object> getApplyHistorySearchListByFilter(@RequestBody Map<String, Object> paramMap, Model model,
//			HttpSession session) throws Exception {
//		System.out.println(paramMap);
//		Map<String, Object> resultMap = new HashMap<>();
//		paramMap.put("loginId", (String) session.getAttribute("loginId"));
//		paramMap.put("userNm", (String) session.getAttribute("userNm"));
//		paramMap.put("userType", (String) session.getAttribute("userType"));
//
//		List<HistoryModel> resultList = historyService.getApplyHistoryListByFilterRest(paramMap);
//		resultMap.put("result", resultList);
//
//		return resultMap;
//	}
	
	@PostMapping("historySearchRest.do")
	public Map<String, Object> getApplyHistorySearchListByFilter(@RequestBody Map<String, Object> paramMap, Model model,
			HttpSession session) throws Exception {
		System.out.println(paramMap);
		Map<String, Object> resultMap = new HashMap<>();
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		paramMap.put("userNm", (String) session.getAttribute("userNm"));
		paramMap.put("userType", (String) session.getAttribute("userType"));
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		int startSeq = (currentPage - 1) * pageSize;

		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		int historyCnt = historyService.historyListCnt(paramMap);
		List<HistoryModel> resultList = historyService.getApplyHistoryListByFilterRest(paramMap);
		resultMap.put("historyCnt", historyCnt);
		resultMap.put("result", resultList);
		System.out.println(resultList);

		return resultMap;
	}
	
	@PostMapping("cancleApply.do")
	public ResponseEntity<Map<String, Object>> cancleApply(@RequestBody Map<String, Object> paramMap)
			throws Exception {
		System.out.println("cancleApply paramMap: " + paramMap);
		
		historyService.deleteResume(paramMap);

		int result = historyService.cancleApply(paramMap);
		
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	

}
