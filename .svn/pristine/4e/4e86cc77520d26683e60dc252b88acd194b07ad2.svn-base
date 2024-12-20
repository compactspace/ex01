package kr.happyjob.study.managehire.controller.as_is;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.company.model.CompanyModel;
import kr.happyjob.study.company.service.CompanyService;
import kr.happyjob.study.managehire.service.ApplicantService;
import kr.happyjob.study.managehire.service.ManagehireService;
import kr.happyjob.study.managepost.model.ApplicantModel;
import kr.happyjob.study.managepost.model.ManagepostModel;

@Controller
@RequestMapping("/manage-hire/")
public class ApplicantController {
	
	 private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   @Autowired
	   private ApplicantService applicantService;
	   
	   @Autowired
	   private CompanyService companyService;
	   
	   @Autowired
	   private ManagehireService managehireService;
	   
	 //공고 등록 jsp로 이동
	   @RequestMapping("applicant.do")
       public String applicantInit(HttpSession session,Model model) throws Exception{
		   String loginId = (String)session.getAttribute("loginId");
			
			//공고 상세보기에 필요한 데이터 가져오기
			CompanyModel CDetail = companyService.companyDetailId(loginId); // id로 회사 detail가져옴
			int bizIdx = managehireService.managehireCkIndex(loginId);
			logger.info("bizIdx : " + bizIdx);
			List<ApplicantModel> MDetail = applicantService.managehireDetailBiz(bizIdx);
			 // MDetail이 null인지 확인
		    if (MDetail == null || MDetail.isEmpty()) {
		        // null일 경우 다른 페이지로 리다이렉트

		    	return "redirect:/manage-hire/post.do";  // "anotherPage"는 이동하려는 페이지의 URL
		    }
				model.addAttribute("MDetail",MDetail);
	           return "managehire/applicant";
       }
	   //공고 등록 jsp로 이동
	   @RequestMapping("applicantList.do")
	   public String applicantList(@RequestParam Map<String,Object> paramMap,HttpSession session,Model model) throws Exception{
		   String loginId = (String)session.getAttribute("loginId");
		   //공고 상세보기에 필요한 데이터 가져오기
		   CompanyModel CDetail = companyService.companyDetailId(loginId); // id로 회사 detail가져옴
		   int bizIdx = managehireService.managehireCkIndex(loginId);
		   paramMap.put("bizIdx",bizIdx);
		   ManagepostModel MDetail = managehireService.managehireDetail(paramMap);// 등록한 회사id로 등록한 공고 detail가져옴
		   String postIdxStr = (String) paramMap.get("postIdx");
		   int postIdx = Integer.parseInt(postIdxStr);
		   logger.info("postIdx : "+postIdx);
		// keyword에 기본값 설정
		    if (!paramMap.containsKey("keyword") || paramMap.get("keyword") == null || ((String) paramMap.get("keyword")).isEmpty()) {
		        paramMap.put("keyword", "지원완료"); 
		    }
		 // 초기 지원자의 status를 지원완료에서 서류심사중으로 수정
		    applicantService.statusUpdateStart(postIdx);  
		 //페이지네이션
			int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
			int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

			int startSeq = (currentPage - 1) * pageSize;
			paramMap.put("startSeq", startSeq);
			paramMap.put("pageSize", pageSize);
			
		   List<ApplicantModel> ApplicantList = applicantService.applicantList(paramMap);
		   int ApplicantCount = applicantService.applicantCount(paramMap);
		   model.addAttribute("list",ApplicantList);
		   model.addAttribute("count",ApplicantCount);
		   return "managehire/applicantList";
	   }
	   
	   // 합격 불합격에 따른 업데이트
	   @RequestMapping("statusUpdate.do")
	   @ResponseBody
	   public Map<String,String> statusUpdate(@RequestParam Map<String,Object> paramMap) throws Exception{
		   Map<String,String> resultMap = new HashMap<>();
			int result = applicantService.statusUpdate(paramMap);
			logger.info("controllerUpdate result =="+ result);
			if(result>0){
				resultMap.put("result","success");
			}else{
				resultMap.put("result","fail");
			}
			
			return resultMap;
	   }
	   // 합격 불합격에 따른 업데이트
	   @RequestMapping("viewUpdate.do")
	   @ResponseBody
	   public Map<String,String> viewUpdate(@RequestParam Map<String,Object> paramMap) throws Exception{
		   Map<String,String> resultMap = new HashMap<>();
		   int result = applicantService.viewUpdate(paramMap);
		   if(result>0){
			   resultMap.put("result","success");
		   }else{
			   resultMap.put("result","fail");
		   }
		   
		   return resultMap;
	   }
}
