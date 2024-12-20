package kr.happyjob.study.company.controller.as_is;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.board.model.NoticeModel;
import kr.happyjob.study.board.service.NoticeService;
import kr.happyjob.study.company.model.CompanyModel;
import kr.happyjob.study.company.service.CompanyService;
import kr.happyjob.study.managehire.controller.as_is.ManagehireController;
import kr.happyjob.study.managehire.service.ManagehireService;
import kr.happyjob.study.managepost.model.ManagepostModel;

@Controller
@RequestMapping("/company/")
public class CompanyController {
	// Set logger
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   @Autowired 
		private CompanyService companyService;
	   
	   @Autowired
	   public  ManagehireService managehireService;
	   	
	   //회사 등록 페이지
	   @RequestMapping("companyWritePage.do")
       public String companyWritePage() throws Exception{
           return "company/companyWrite";

       }
	   
	   //회사 updatePage
	   @RequestMapping("companyUpdatePage.do")
	   public String companyUpdatePage(HttpSession session,Model model) throws Exception{
		   String loginId = (String)session.getAttribute("loginId");
		   CompanyModel getDetail = companyService.companyDetailId(loginId);
		   model.addAttribute("company",getDetail);
		   return "company/companyUpdate";
		   
	   }
	  
	   
	   // 채용담당자가 회사를 등록하는 컨트롤러
		@RequestMapping("companySave.do")
		@ResponseBody
		public Map<String,String> companySave(@RequestParam Map<String,Object> paramMap, HttpServletRequest req, HttpSession session) throws Exception{
			Map<String,String> resultMap = new HashMap<>();
			
			String loginId = (String)session.getAttribute("loginId");
			//DB에 아이디 존재하는지 체크
			int DbCkId = companyService.companyCkId(loginId);
			
			int result=0;
			// DbCkId ==1 이면 디비에 아이디가 없으니 저장할수있음
			if(DbCkId==1){
				paramMap.put("loginId", loginId);
				result = companyService.companySave(paramMap, req);
				if(result>0){
					resultMap.put("result","success");
				}else{
					resultMap.put("result","fail");
				}
				// DbCkId ==0 이면 디비에 아이디가 있으니 저장할필요가없음
			}else if(DbCkId==0){
				if(result>0){
					resultMap.put("result","success");
				}else{
					resultMap.put("result","fail");
				}
			}
			
			return resultMap;
		}
		
		//채용담당자가 회사를 등록하는 화면  컨트롤러
		
		// 채용담당자가 회사를 수정하는 컨트롤러
		@RequestMapping("companyUpdate.do")
		@ResponseBody
		public Map<String,Object> companyUpdate(@RequestParam Map<String,Object> paramMap, HttpServletRequest req , HttpSession session) throws Exception{
			Map<String,Object> resultMap = new HashMap<>();
			
			String loginId = (String)session.getAttribute("loginId");
			logger.info("controllerUpdate loginId =="+ loginId);
			
			paramMap.put("loginId", loginId);
			int result = companyService.companyUpdate(paramMap, req,loginId);
			logger.info("controllerUpdate result =="+ result);
			if(result>0){
				resultMap.put("result","success");
			}else{
				resultMap.put("result","fail");
			}
			
			return resultMap;
		}
		
		// 채용담당자가 회사를 삭제하는 컨트롤러
		@RequestMapping("companyDelete.do")
		@ResponseBody
		public Map<String,String> companyDelete(@RequestParam Map<String,Object> paramMap,HttpSession session) throws Exception{
			Map<String,String> resultMap = new HashMap<>();
			String loginId = (String)session.getAttribute("loginId");
			
			int bizIdx = managehireService.managehireCkIndex(loginId);
			logger.info("bizIdx : " + bizIdx);
			paramMap.put("bizIdx",bizIdx);
			paramMap.put("startSeq",0); 
			paramMap.put("pageSize",10);
			List<ManagepostModel> Mdetail =managehireService.managehireList(paramMap);
			logger.info("어디까지왔는지 확인 ");
			
			if (Mdetail != null && !Mdetail.isEmpty()) {
				for (int i = 0; i < Mdetail.size(); i++) {
					int postIdx = Mdetail.get(i).getPostIdx();
					logger.info("postIdx반복중 : "+postIdx);
					paramMap.put("postIdx",postIdx);
					managehireService.managehireDelete(paramMap);
				}
		    }
			int result = companyService.companyDelete(paramMap,loginId);
			if(result>0){
				resultMap.put("result","success");
			}else{
				resultMap.put("result","fail");
			}
			
			return resultMap;
		}
		//채용담당자
		@RequestMapping("companyDetail.do")
		public String companyDetail( HttpSession session,Model model) throws Exception {
		    
		    String loginId = (String) session.getAttribute("loginId"); // 세션에서 loginId 가져오기
		    String userType = (String) session.getAttribute("userType"); // 세션에서 userType 가져오기
		    CompanyModel detailValue = null;
		    
		        // 채용 담당자일 경우
		        detailValue = companyService.companyDetailId(loginId); // loginId로 회사 세부 정보 조회
		        logger.info("B타입입니다.");
		    model.addAttribute("userType",userType);
		    model.addAttribute("detail",detailValue);

		    return "company/companyDetail"; // JSON 형태로 응답
		}
		
		//유저,관리자
		@RequestMapping("companyDetailPage.do/{postIdx}/{bizIdx}")
		public String companyDetailPage( HttpSession session,Model model,@PathVariable("bizIdx") int bizIdx,@PathVariable("postIdx") int postIdx) throws Exception {
			
			String loginId = (String) session.getAttribute("loginId"); // 세션에서 loginId 가져오기
			String userType = (String) session.getAttribute("userType"); // 세션에서 userType 가져오기
			CompanyModel detailValue = null;
			detailValue = companyService.companyDetail(bizIdx); // bizIdx로 회사 세부 정보 조회
			model.addAttribute("detail",detailValue);
			
			return "company/companyDetail"; // JSON 형태로 응답
		}
		
		//유저,관리자
		@RequestMapping("companyDetailPage.do/{bizIdx}")
		public String companyDetailPage2( HttpSession session,Model model,@PathVariable("bizIdx") int bizIdx) throws Exception {
					
			String loginId = (String) session.getAttribute("loginId"); // 세션에서 loginId 가져오기
			String userType = (String) session.getAttribute("userType"); // 세션에서 userType 가져오기
			CompanyModel detailValue = null;
			detailValue = companyService.companyDetail(bizIdx); // bizIdx로 회사 세부 정보 조회
			model.addAttribute("detail",detailValue);
					
			return "company/companyDetail"; // JSON 형태로 응답
		}
}
