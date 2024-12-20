package kr.happyjob.study.managehire.controller.as_is;

import java.io.File;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.company.model.CompanyModel;
import kr.happyjob.study.company.service.CompanyService;
import kr.happyjob.study.jobs.service.ScrapService;
import kr.happyjob.study.managehire.service.ApplicantService;
import kr.happyjob.study.managehire.service.ManagehireService;
import kr.happyjob.study.managepost.model.ApplicantModel;
import kr.happyjob.study.managepost.model.ManagepostModel;

@Controller
@RequestMapping("/manage-hire/")
public class ManagehireController {
	
	
	   private final Logger logger = LogManager.getLogger(this.getClass());

	   // Get class name for logger
	   private final String className = this.getClass().toString();
	   
	   @Autowired
	   private ManagehireService managehireService;
	   
	   @Autowired
	   private CompanyService companyService;
	   //fk 로 묶여있어 삭제하기위해 가져옴
	   @Autowired
		private ScrapService scrapService;
	   
	   @Autowired
	   private ApplicantService applicantService;
	  
	   //공고 등록 jsp로 이동
	   @RequestMapping("post.do")
       public String managehirePage() throws Exception{
			return "managehire/managehire";
       }
	   
	   //공고 등록 jsp로 이동
	   @RequestMapping("managehireDetail.do/{postIdx}/{bizIdx}")
	   public String managehireDetail(@PathVariable("postIdx") int postIdx,@PathVariable("bizIdx") int bizIdx,Model model,HttpSession session) throws Exception{
		   		Map<String,Object> paramMap = new HashMap<>();
		   		paramMap.put("postIdx",postIdx);
		   		paramMap.put("bizIdx",bizIdx);
		   		CompanyModel CDetail = companyService.companyDetail(bizIdx);
		   		ManagepostModel MDetail = managehireService.managehireDetail(paramMap);
		   		String managehirePage="";
			   // 날짜를 나눠줌 start ~ end date로
			   String dateRange = MDetail.getEndDate();
			   String[] dates = dateRange.split(" ~ ");
			
			   model.addAttribute("CDetail",CDetail); // 회사 detail
			   model.addAttribute("MDetail",MDetail); // 공고 detail
			   
			   model.addAttribute("startDate", dates[0].trim()); // 공고 detail
			   model.addAttribute("endDate", dates[1].trim()); // 공고 detail
			   
			   //만약 기간이 만료가 된 게시글이면 write창으로 가게하고 삭제
			   SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH");
			   Date endDate = sdf.parse(dates[1].trim());
			   Date now = new Date();
			   
			   //CompanyDetail에서 돌아오깅기위해 session에 저장
			   if (session.getAttribute("postIdx") != null) {
				    session.removeAttribute("postIdx");
				}
			   session.setAttribute("postIdx", postIdx);
			   
			   Map<String, String> resultMap = new HashMap<>();
			   
			   if (endDate.compareTo(now) < 0) {
				   // 만료된 경우 삭제 처리
				   Map<String, Object> paramMap1 = new HashMap();
				   paramMap1.put("postIdx",postIdx);
				   paramMap1.put("bizIdx",bizIdx);
				   scrapService.updateScrap(paramMap1);
				   int result = managehireService.managehireDelete(paramMap1);
				   managehirePage = "managehire/managehire";
				   //resultMap.put("result", result > 0 ? "notExpired" : "fail");
			   } else {
				   // 만료되지 않은 경우 처리
				   resultMap.put("result", "fail");
			   }
			   managehirePage="managehire/managehireDetail";
		   
		   return managehirePage;
	   }
	   
	   @RequestMapping("managehireWritePage.do")
	   public String managehireWritePage() throws Exception{	
		   return "managehire/managehireWrite";
	   }
	   
	   //공고 수정 jsp로 이동
	   @RequestMapping("managehireUpdatePage.do/{postIdx}/{bizIdx}")
	   public String managehireUpdatePage(Model model, HttpSession session,@PathVariable("postIdx") int postIdx,@PathVariable("bizIdx") int bizIdx) throws Exception{
		   Map<String,Object> paramMap = new HashMap<>();
		   paramMap.put("postIdx", postIdx);
		   paramMap.put("bizIdx", bizIdx);
		   ManagepostModel manageDetail = managehireService.managehireDetail(paramMap);
			model.addAttribute("detail",manageDetail);
			
			// 날짜를 나눠줌 start ~ end date로
			String dateRange = manageDetail.getEndDate();
			
			// 시작과 종료 날짜 분리
			String[] dates = dateRange.split(" ~ ");
			SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy.MM.dd HH");
			SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

			// 각각을 변환
			Date startDateObj = originalFormat.parse(dates[0]);
			Date endDateObj = originalFormat.parse(dates[1]);

			String formattedStartDate = targetFormat.format(startDateObj);
			String formattedEndDate = targetFormat.format(endDateObj);

			// JSP로 전달
			
			model.addAttribute("postIdx", postIdx);
			model.addAttribute("bizIdx", bizIdx);
			model.addAttribute("startDate", formattedStartDate);
			model.addAttribute("endDate", formattedEndDate);
			
		   return "managehire/managehireUpdate";
		   
	   }
	   
	   // 채용담당자가 채용공고등록
		@RequestMapping("managehireSave.do")
		@ResponseBody
		public Map<String,String> managehireSave(@RequestParam Map<String,Object> paramMap, HttpServletRequest req, HttpSession session) throws Exception{
			Map<String,String> resultMap = new HashMap<>();
			
			String loginId = (String)session.getAttribute("loginId");
			//DB에 회사를 등록했는지 체크
			int bizIdx = managehireService.companyCkId(loginId);
			logger.info("bizIdx ===="+bizIdx);
			int result=0;
			// DbCkId >=1 이면 디비에 회사를 등록을 했으니 채용공고를 올릴수있다.
			if(bizIdx>=1){
					paramMap.put("bizIdx", bizIdx);
					result = managehireService.managehireSave(paramMap, req);
					resultMap.put("result","success");
			// DbCkId ==0 이면 디비에 아이디가 없으면 회사를 등록후 채용공고를 올릴수있다.
			}else if(bizIdx==0){
					resultMap.put("result","fail");
			}
			
			return resultMap;
		}
		// 채용담당자가 채용공고수정
		@RequestMapping("managehireUpdate.do")
		@ResponseBody
		public Map<String,String> managehireUpdate(@RequestParam Map<String,Object> paramMap, HttpServletRequest req,HttpSession session) throws Exception{
			Map<String,String> resultMap = new HashMap<>();
			String loginId = (String)session.getAttribute("loginId");
			int bizIdx = managehireService.managehireCkIndex(loginId);
			paramMap.put("bizIdx", bizIdx);
			int result = managehireService.managehireUpdate(paramMap,bizIdx, req);
			logger.info("controllerUpdate result =="+ result);
			if(result>0){
				resultMap.put("result","success");
			}else{
				resultMap.put("result","fail");
			}
			
			return resultMap;
		}
		
		// 채용담당자가 공고를 삭제하는 컨트롤러
		@RequestMapping("managehireDelete.do")
		@ResponseBody
		public Map<String, String> managehireDelete(@RequestParam Map<String,Object> paramMap, HttpSession session) throws Exception {
			Map<String, String> resultMap = new HashMap<>();
			
			int result = managehireService.managehireDelete(paramMap);
			if (result > 0) {
				resultMap.put("result", "success");
			} else {
				resultMap.put("result", "fail");
			}
	
			return resultMap;
		}
		
		
		// 다운로드
		@RequestMapping("managehireDownload.do")
		public void noticeDownload(@RequestParam Map<String,Object> paramMap, HttpServletResponse res) throws Exception {
			ManagepostModel Managepost = managehireService.managehireDetail(paramMap);

			String filePath = Managepost.getPhsycalPath();
			byte bytes[] = FileUtils.readFileToByteArray(new File(filePath));

			res.setContentType("application/octet-stream");
			res.setContentLength(bytes.length);
			res.setHeader("Content-Disposition",
					"attachment; fileName=\"" + URLEncoder.encode(Managepost.getFileName(), "UTF-8") + "\";");
			res.setHeader("Content-Transfer-Encoding", "binary");
			res.getOutputStream().write(bytes);
			res.getOutputStream().flush();
			res.getOutputStream().close();
		}
		
		 //공고 등록 jsp로 이동
		   @RequestMapping("managehireList.do")
		   public String managehireList(@RequestParam Map<String,Object> paramMap,HttpSession session,Model model) throws Exception{
			   String loginId = (String)session.getAttribute("loginId");
			   int bizIdx = managehireService.managehireCkIndex(loginId);
			   paramMap.put("bizIdx",bizIdx);
			   
			   /*
			   ////////////
			   List<ApplicantModel> MDetail = applicantService.managehireDetailBiz(bizIdx);
		   		String managehirePage="";
		   		
			   // 날짜를 나눠줌 start ~ end date로
		   		for (int i = 0; i < MDetail.size(); i++) {
		   		    // MDetail.get(i)로 리스트의 각 항목에 접근
		   			String dateRange = MDetail.get(i).getEndDate();
				   String[] dates = dateRange.split(" ~ ");
				   
				 //만약 기간이 만료가 된 게시글이면 write창으로 가게하고 삭제
				   SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH");
				   Date endDate = sdf.parse(dates[1].trim());
				   Date now = new Date();
				   
				   
				   Map<String, String> resultMap = new HashMap<>();
				   
				   if (endDate.compareTo(now) < 0) {
					   // 만료된 경우 삭제 처리
					   Map<String, Object> paramMap1 = new HashMap();
					   paramMap1.put("postIdx",MDetail.get(i).getPostIdx());
					   paramMap1.put("bizIdx",bizIdx);
					   scrapService.updateScrap(paramMap1);
					   int result = managehireService.managehireDelete(paramMap1);
					   managehirePage = "managehire/managehire";
					   //resultMap.put("result", result > 0 ? "notExpired" : "fail");
				   } else {
					   // 만료되지 않은 경우 처리
					   resultMap.put("result", "fail");
				   }
		   		    
		   		}
		   		*/
			   
			 //페이지네이션
				int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
				int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

				int startSeq = (currentPage - 1) * pageSize;
				paramMap.put("startSeq", startSeq);
				paramMap.put("pageSize", pageSize);
				List<ManagepostModel> MList = managehireService.managehireList(paramMap);
			   int managehireCount = managehireService.managehireCount(paramMap);
			   model.addAttribute("bizIdx",bizIdx);
			   model.addAttribute("MList",MList);
			   model.addAttribute("MCount",managehireCount);
			   return "managehire/managehireList";
		   }
		   
		
}
