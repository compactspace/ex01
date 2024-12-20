package kr.happyjob.study.manageuser.controller.as_is;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.manageuser.model.ManageuserModel;
import kr.happyjob.study.manageuser.service.ManageuserService;
import kr.happyjob.study.mypage.model.MypageModel;

@Controller
@RequestMapping("/manage-user/")
public class ManageuserController {
	
	@Autowired
	private ManageuserService manageuserService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("applicant.do")
	public String init() throws Exception {
		return "manageuser/applicant";
	}
	
	@RequestMapping("biz.do")
	public String biz() throws Exception {
		return "manageuser/biz";
	}
	
	@RequestMapping("applicantList.do")
	public String getApplicantList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap: " + paramMap);
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<ManageuserModel> applicantList = manageuserService.applicantList(paramMap);
		int applicantCnt = manageuserService.applicantListCnt(paramMap);
		
		model.addAttribute("applicant", applicantList);
		model.addAttribute("applicantCnt", applicantCnt);
		
		return "manageuser/applicantList";
	}
	
	@RequestMapping("bizList.do")
	public String getBizList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("paramMap: " + paramMap);
		
		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		int startSeq = (currentPage - 1) * pageSize;
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		List<ManageuserModel> bizList = manageuserService.bizList(paramMap);
		int bizCnt = manageuserService.bizListCnt(paramMap);
		
		model.addAttribute("biz", bizList);
		model.addAttribute("bizCnt", bizCnt);
		
		return "manageuser/bizList";
	}
	
	@RequestMapping("applicantManageDetail.do")
	@ResponseBody
	public Map<String, Object> applicantManageDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		ManageuserModel detailValue = manageuserService.manageApplicantDetail(paramMap);
		resultMap.put("detail", detailValue);
		
		return resultMap;
	}
	
	@RequestMapping("applicantPwReset.do")
	@ResponseBody
	public Map<String, Object> applicantPwReset(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		int result = manageuserService.applicantPwReset(paramMap);
		
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("applicantInfoUpdate.do")
	@ResponseBody
	public Map<String, Object> applicantInfoUpdate(@RequestParam Map<String, Object> paramMap) throws Exception {
		
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
	public Map<String, Object> bizManageDetail(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		ManageuserModel detailValue = manageuserService.manageBizDetail(paramMap);
		resultMap.put("detail", detailValue);
		
		return resultMap;
	}
	
	@RequestMapping("bizInfoUpdate.do")
	@ResponseBody
	public Map<String, Object> bizInfoUpdate(@RequestParam Map<String, Object> paramMap) throws Exception {
		
		Map<String, Object> resultMap = new HashMap<>();
		
		int result = manageuserService.bizInfoUpdate(paramMap);
		
		String bizIdx = (String)paramMap.get("bizIdx");
		logger.info("변경대상 기업회원 사업자번호 : " + bizIdx);
		
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
		
	}
	
}
