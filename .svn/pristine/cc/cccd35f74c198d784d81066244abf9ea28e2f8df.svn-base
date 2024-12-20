package kr.happyjob.study.company.controller.to_be;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.common.comnUtils.ApiResponseUtil;
import kr.happyjob.study.company.model.CompanyModel;
import kr.happyjob.study.company.service.CompanyService;
import kr.happyjob.study.managehire.service.ManagehireService;
import kr.happyjob.study.managepost.model.ManagepostModel;

@RestController
@RequestMapping("/api/company/")
public class CompanyRestController {
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
   
	@Autowired 
	private CompanyService companyService;
	   
	@Autowired
	public ManagehireService managehireService;
	
	
	/**
	 * 상세 보기 (유저/관리자)
	 * @param bizIdx 회사 시퀀스(seq) 번호
	 */
	@PostMapping("companyDetailPage")
	public ResponseEntity<Map<String, Object>> companyDetailPage(@RequestBody Map<String, Object> paramMap, HttpSession session) throws Exception {
		int bizIdx = Integer.parseInt(String.valueOf(paramMap.get("bizIdx")));
		String loginId = (String) session.getAttribute("loginId");
		String userType = (String) session.getAttribute("userType");
		CompanyModel result = companyService.companyDetail(bizIdx);
		
		return ApiResponseUtil.createResponse("success", result, HttpStatus.OK);
	}
	
	/**
	 * 회사 정보 처음 등록 (채용 담당자)
	 */
	@PostMapping("companyInsert")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> companyInsert(@RequestParam Map<String,Object> paramMap, HttpServletRequest req, HttpSession session) 
			throws Exception{
		String loginId = (String)session.getAttribute("loginId");
		int userIdx = (int) session.getAttribute("userIdx");
		String status = "";
		int result = 0;
		
		// 아이디 존재 여부 확인
		int DbCkId = companyService.companyCkId(loginId);
		
		// 저장 가능
		if (DbCkId == 1) {
			paramMap.put("loginId", loginId);
			paramMap.put("userIdx", userIdx);
			result = companyService.companySave(paramMap, req);
			
			if (result > 0) {
				status = "success";
			} else {
				status = "fail";
			}
		} 
		// 저장 불가
		else if (DbCkId == 0) {
			status = "idAlready";
		}
		
		return ApiResponseUtil.createResponse(status, result, HttpStatus.OK);
	}
	
	
	/**
	 * 회사 정보 수정 (채용 담당자)
	 */
	@PostMapping("companyUpdate")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> companyUpdate(@RequestParam Map<String, Object> paramMap, HttpServletRequest req, 
			MultipartHttpServletRequest multifile, HttpSession session) throws Exception{
		String loginId = (String)session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		int result = companyService.companyUpdate(paramMap, req, loginId);
		
		if (result>0) {
			return ApiResponseUtil.createResponse("success", result, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", result, HttpStatus.OK);
		}
	}
	
	/**
	 * 회사 삭제 (채용 담당자)
	 */
	@PostMapping("companyDelete")
	public ResponseEntity<Map<String, Object>> companyDelete(@RequestParam Map<String,Object> paramMap, HttpSession session) 
			throws Exception{
		String loginId = (String)session.getAttribute("loginId");
		int bizIdx = managehireService.managehireCkIndex(loginId);
		paramMap.put("bizIdx", bizIdx);
		paramMap.put("startSeq", 0); 
		paramMap.put("pageSize", 10);
		
		List<ManagepostModel> Mdetail = managehireService.managehireList(paramMap);
		
		if (Mdetail != null && !Mdetail.isEmpty()) {
			for (int i = 0; i < Mdetail.size(); i++) {
				int postIdx = Mdetail.get(i).getPostIdx();
				paramMap.put("postIdx", postIdx);
				managehireService.managehireDelete(paramMap);
			}
	    }
		
		int result = companyService.companyDelete(paramMap,loginId);
		
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", result, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", result, HttpStatus.OK);
		}
	}
	
}
