package kr.happyjob.study.managepost.controller.as_is;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.board.model.NoticeModel;
import kr.happyjob.study.company.model.CompanyModel;
import kr.happyjob.study.company.service.CompanyService;
import kr.happyjob.study.managepost.model.ManagepostModel;
import kr.happyjob.study.managepost.service.ManagepostService;

@Controller
@RequestMapping("/manage-post/")
public class ManagepostController {
	
	@Autowired
	private ManagepostService managepostService;
	
	@Autowired
	private CompanyService companyService;
	
	// Set logger
		private final Logger logger = LogManager.getLogger(this.getClass());
		// Get class name for logger
		private final String className = this.getClass().toString();

	
	 //채용 공고 관리
    //공고 심사
	@RequestMapping("/approval.do")
	public String getPendingPost() throws Exception {
            return "manage-post/post-list";
	}
	
	//채용공고 관리
		//공고 보기(승인된 공고만 보기)
		@RequestMapping("/post.do")
		public String getApprovalPost() throws Exception {
			return "manage-post/post-list";
		}
	
		//승인 공고 보류 공고 각자 불러오고 url 파람으로 받아서 다시 모델로 던져주자
		@RequestMapping("/readPostList.do")
		public String getPostList(Model model, @RequestParam Map<String, Object> paramMap, 
				HttpServletRequest request, HttpSession session) throws Exception {
			logger.info("paramMap: " + paramMap);

			int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
			int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
			int startSeq = (currentPage - 1) * pageSize;
			//	String url = (String) paramMap.get("url");
			// 공통 ajax 함수에 추가한 callAjaxSendUrl함수를 통해 헤더에 전달받은 url 받기
			 String url = request.getHeader("Request-URL"); 
			logger.info("url: " + url);
			
			paramMap.put("startSeq", startSeq);
			paramMap.put("pageSize", pageSize);
			
			String loginId = (String) session.getAttribute("loginId");
			model.addAttribute("loginId", loginId);
			logger.info("loginId: " + loginId);
			
			List<ManagepostModel> pendingList = managepostService.getPendingList(paramMap);
			int pendingPostCnt = managepostService.pendingPostListCnt(paramMap);
	        model.addAttribute("pendingList", pendingList);
			model.addAttribute("pendingPostCnt", pendingPostCnt);
			
			List<ManagepostModel> approvalList = managepostService.getApprovalList(paramMap);
			int approvalPostCnt = managepostService.approvalPostListCnt(paramMap);
			model.addAttribute("approvalList", approvalList);
			model.addAttribute("approvalPostCnt", approvalPostCnt);
	        model.addAttribute("url", url);
	        
			return "manage-post/post-listValue";
		}
		
	//채용공고 관리
	//공고 상세 페이지 가기
		@RequestMapping("/{postIdx}/{bizIdx}")
		public String getPostDetail(@PathVariable("postIdx") int postIdx, 
				@PathVariable("bizIdx") int bizIdx, Model model, HttpSession session) 
				throws Exception {
			
			logger.info("postIdx: " + postIdx);
			logger.info("bizIdx: " + bizIdx);
			 if (session.getAttribute("postIdx") != null) {
				    session.removeAttribute("postIdx");
				}
			   session.setAttribute("postIdx", postIdx);
	
			model.addAttribute("postIdx", postIdx);
		    model.addAttribute("bizIdx", bizIdx);
		    
		  return "manage-post/managepostDetail";
		}
	
		//공고 상세 페이지 데이터
	@RequestMapping("managePostDetail.do")
	@ResponseBody
	public Map<String, Object> managepostDetail(@RequestParam Map<String, Object> paramMap, 
			HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		logger.info("managePostDetail: " + paramMap);

		String loginId = (String) session.getAttribute("loginId");
		logger.info("loginId: " + loginId);
		resultMap.put("loginId", loginId);
		
		ManagepostModel detailValue = managepostService.managePostDetail(paramMap);
			
//		String dateRange =detailValue.getEndDate();
//	    String[] dates = dateRange.split(" ~ ");
//	    logger.info("dateRange:" + dateRange);
//		logger.info("dates[0].trim() :" + dates[0].trim());
//		logger.info("dates[1].trim() :" + dates[1].trim());
		logger.info("paramMap: " + paramMap);
		logger.info("detailValue: " + detailValue);
//		logger.info("startDate : " + detailValue.getStartDate());
	    resultMap.put("startDate", detailValue.getStartDate()); // 공고 detail
	    resultMap.put("endDate", detailValue.getEndDate()); // 공고 detail
		resultMap.put("postDetail", detailValue);
		logger.info("postDetail: " + detailValue);

		CompanyModel detailValue2 = companyService.companyDetail(paramMap);
	    String bizName = detailValue2.getBizName();
	    logger.info("bizName: " + bizName);
	    logger.info("bizDetail: " + detailValue2);
	    resultMap.put("bizDetail", detailValue2);
	    
		return resultMap;
	}
	
	@RequestMapping("statusUpdate.do")
	@ResponseBody
	public Map<String, String> updateNotice(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("updateStatus: " + paramMap);

		int result = managepostService.updateAppStatus(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}
	
}
