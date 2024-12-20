package kr.happyjob.study.managehire.controller.to_be;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
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
import kr.happyjob.study.apply.model.ResumeModel;
import kr.happyjob.study.apply.model.SkillModel;
import kr.happyjob.study.apply.service.ResumeService;
import kr.happyjob.study.company.model.CompanyModel;
import kr.happyjob.study.company.service.CompanyService;
import kr.happyjob.study.managehire.service.ApplicantService;
import kr.happyjob.study.managehire.service.ManagehireService;
import kr.happyjob.study.managepost.model.ApplicantModel;
import kr.happyjob.study.managepost.model.ManagepostModel;

@RestController
@RequestMapping("/api/manage-hire/")
public class ApplicantRestController {
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();
	   
	@Autowired
	private ResumeService resumeService;
	   
	   @Autowired
	   private ApplicantService applicantService;
	   
	   @Autowired
	   private CompanyService companyService;
	   
	   @Autowired
	   private ManagehireService managehireService;
	   
	   @PostMapping("applicant.do")
       public Map<String, Object> applicantInit(HttpSession session) throws Exception{
		   Map<String, Object> resultMap = new HashMap<>();
		   String loginId = (String)session.getAttribute("loginId");
			
			//공고 상세보기에 필요한 데이터 가져오기
//			CompanyModel CDetail = companyService.companyDetailId(loginId); // id로 회사 detail가져옴
			int bizIdx = managehireService.managehireCkIndex(loginId);
			logger.info("bizIdx : " + bizIdx);
			List<ApplicantModel> MDetail = applicantService.managehireDetailBiz(bizIdx);
			 // MDetail이 null인지 확인
//		    if (MDetail == null || MDetail.isEmpty()) {
//		        // null일 경우 다른 페이지로 리다이렉트
//
//		    	return "redirect:/manage-hire/post.do";  // "anotherPage"는 이동하려는 페이지의 URL
//		    }
			
			resultMap.put("MDetail",MDetail);
	       return resultMap;
       }
	   
	   @PostMapping("applicantList.do")
	   public Map<String, Object> applicantList(@RequestBody Map<String,Object> paramMap,HttpSession session,Model model) throws Exception{
		   Map<String, Object> resultMap = new HashMap<>();
//		   String loginId = (String)session.getAttribute("loginId");
		   String loginId = (String) paramMap.get("loginId");
		   //공고 상세보기에 필요한 데이터 가져오기
		   CompanyModel CDetail = companyService.companyDetailId(loginId); // id로 회사 detail가져옴
		   int bizIdx = managehireService.managehireCkIndex(loginId);
		   paramMap.put("bizIdx",bizIdx);
		   ManagepostModel MDetail = managehireService.managehireDetail(paramMap);// 등록한 회사id로 등록한 공고 detail가져옴
		   String postIdxStr = (String) paramMap.get("postIdx");
		   String firstProc = (String) paramMap.get("firstProc");
		   int postIdx = Integer.parseInt(postIdxStr);
		   logger.info("postIdx : "+postIdx);
		   logger.info("procArray : "+ firstProc);
		// keyword에 기본값 설정
		    if (!paramMap.containsKey("keyword") || paramMap.get("keyword") == null || ((String) paramMap.get("keyword")).isEmpty()) {
		        paramMap.put("keyword", "지원완료"); 
		    }
		 // 초기 지원자의 status를 지원완료에서 서류심사중으로 수정
		    applicantService.statusUpdateStartRest(postIdx,firstProc);  
		    List<ApplicantModel> MDetail2 = applicantService.managehireDetailBiz(bizIdx);
		 //페이지네이션
			int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
			int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

			int startSeq = (currentPage - 1) * pageSize;
			paramMap.put("MDetail",MDetail2);
			paramMap.put("startSeq", startSeq);
			paramMap.put("pageSize", pageSize);
			
		   List<ApplicantModel> ApplicantList = applicantService.applicantList(paramMap);
		   int ApplicantCount = applicantService.applicantCount(paramMap);
		   resultMap.put("list",ApplicantList);
		   resultMap.put("count",ApplicantCount);
		   return resultMap;
	   }
	   
	// 합격 불합격에 따른 업데이트
	   @RequestMapping("statusUpdate.do")
	   @ResponseBody
	   public Map<String,String> statusUpdate(@RequestBody Map<String,Object> paramMap) throws Exception{
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
	   public Map<String,String> viewUpdate(@RequestBody Map<String,Object> paramMap) throws Exception{
		   Map<String,String> resultMap = new HashMap<>();
		   int result = applicantService.viewUpdate(paramMap);
		   if(result>0){
			   resultMap.put("result","success");
		   }else{
			   resultMap.put("result","fail");
		   }
		   
		   return resultMap;
	   }
	   
	   @PostMapping("previewResume.do")
		public Map<String,Object> previewResume(@RequestBody Map<String, Object> paramMap, Model model) throws Exception {
		    Map<String,Object> resultMap = new HashMap<>();
			int resIdx = Integer.valueOf(String.valueOf(paramMap.get("resIdx")));
			ResumeModel resumeInfo = resumeService.getResumeInfo(resIdx);
			List<CareerModel> careerInfo = resumeService.getCrrList(paramMap);
			List<EducationModel> eduInfo = resumeService.getEduList(paramMap);
			List<SkillModel> skillInfo = resumeService.getSkillList(paramMap);
			List<CertificationModel> certInfo = resumeService.getCertList(paramMap);
			resultMap.put("resumeInfo", resumeInfo);
			resultMap.put("careerInfo", careerInfo);
			resultMap.put("eduInfo", eduInfo);
			resultMap.put("skillInfo", skillInfo);
			resultMap.put("certInfo", certInfo);
			return resultMap;
		}
	  
	   @PostMapping("attachment-download")
		public ResponseEntity<Resource> downAttach(@RequestBody int resumeNum, HttpServletRequest request)
		        throws Exception {
		    // 이력서 정보를 가져옴
		    ResumeModel result = resumeService.getResumeInfo(resumeNum);
		    String filePath = result.getPhsycalPath();
		    File file = new File(filePath);

		    // 파일이 존재하지 않을 경우 404 상태 반환
		    if (!file.exists()) {
		        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
		    }

		    // 파일을 InputStreamResource로 감싸서 반환
		    FileInputStream fileInputStream = new FileInputStream(file);
		    InputStreamResource resource = new InputStreamResource(fileInputStream);

		    // 파일 이름을 UTF-8로 인코딩
		    String encodedFileName = URLEncoder.encode(result.getFileName(), StandardCharsets.UTF_8.toString())
		            .replaceAll("\\+", "%20");

		    // HTTP 헤더 설정
		    HttpHeaders headers = new HttpHeaders();
		    headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename*=UTF-8''" + encodedFileName);
		    headers.add(HttpHeaders.CONTENT_LENGTH, String.valueOf(file.length()));

		    // MIME 타입 설정
		    String mimeType = request.getServletContext().getMimeType(file.getAbsolutePath());
		    if (mimeType == null) {
		        mimeType = "application/octet-stream";
		    }
		    headers.add(HttpHeaders.CONTENT_TYPE, mimeType);

		    // ResponseEntity를 사용해 파일을 반환
		    return ResponseEntity.ok().headers(headers).body(resource);
		}
}
