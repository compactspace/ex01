package kr.happyjob.study.manageuser.controller.to_be;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.board.model.NoticeModel;
import kr.happyjob.study.manageuser.model.ManageuserModel;
import kr.happyjob.study.manageuser.service.ManageuserService;

@RestController
@RequestMapping("/api/manage-user/")
public class ManageuserRestController {
	
	@Autowired
	private ManageuserService manageuserService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

		// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@RequestMapping("applicantListBody.do")
//	@ResponseBody
	public Map<String, Object> getApplicantListBody(@RequestBody Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		int startSeq = (currentPage - 1) * pageSize;

		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);

		List<ManageuserModel> applicantList = manageuserService.applicantList(paramMap);
		int applicantCnt = manageuserService.applicantListCnt(paramMap);
		
		resultMap.put("applicant", applicantList);
		resultMap.put("applicantCnt", applicantCnt);
		
		return resultMap;
	}
	
	@RequestMapping("bizList.do")
	public Map<String, Object> getBizList(@RequestBody Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap: " + paramMap);
		
		Map<String, Object> resultMap = new HashMap<>();
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		int startSeq = (currentPage - 1) * pageSize;

		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<ManageuserModel> bizList = manageuserService.bizList(paramMap);
		int bizCnt = manageuserService.bizListCnt(paramMap);
		
		resultMap.put("biz", bizList);
		resultMap.put("bizCnt", bizCnt);
		
		return resultMap;
	}
	
	@RequestMapping("applicantManageDetail.do")
	@ResponseBody
	public Map<String, Object> applicantManageDetail(@RequestBody Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		ManageuserModel detailValue = manageuserService.manageApplicantDetail(paramMap);
		resultMap.put("detail", detailValue);
		
		return resultMap;
	}
	
	@RequestMapping("applicantPwReset.do")
	@ResponseBody
	public Map<String, Object> applicantPwReset(@RequestBody Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		int result = manageuserService.applicantPwReset1234(paramMap);
		
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("applicantInfoUpdate.do")
	@ResponseBody
	public Map<String, Object> applicantInfoUpdate(@RequestBody Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int result = manageuserService.applicantInfoUpdate(paramMap);
		
		String loginId = (String)paramMap.get("loginId");
		logger.info("변경대상 유저ID : " + loginId);
		
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
		
	}
	
	@RequestMapping("bizManageDetail.do")
	@ResponseBody
	public Map<String, Object> bizManageDetail(@RequestBody Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		ManageuserModel detailValue = manageuserService.manageBizDetail(paramMap);
		resultMap.put("detail", detailValue);
		
		return resultMap;
	}
	
	@RequestMapping("bizInfoUpdate.do")
	@ResponseBody
	public Map<String, Object> bizInfoUpdate(@RequestBody Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int result = manageuserService.bizInfoUpdate(paramMap);
		
		int bizIdx = (int) paramMap.get("bizIdx");
		logger.info("변경대상 기업회원 사업자번호 : " + bizIdx);
		
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
		
	}

}
