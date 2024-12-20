package kr.happyjob.study.jobs.controller.as_is;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.jobs.model.ScrapModel;
import kr.happyjob.study.jobs.service.ScrapService;

@Controller
@RequestMapping("/jobs/")
public class ScrapController {
	
	@Autowired
	private ScrapService scrapService;
		
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	
	@RequestMapping("scrap.do")
	public String init() throws Exception {
			
		return "job/scrap-list";
	}
	
	@RequestMapping("scrapList.do")
	public String getScrapList(Model model, @RequestParam Map<String, Object> paramMap, HttpSession session) throws Exception {
		logger.info("paramMap: " + paramMap);

		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		int startSeq = (currentPage - 1) * pageSize;

		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		
		String loginId = (String) session.getAttribute("loginId");
		model.addAttribute("loginId", loginId);
		logger.info("loginId: " + loginId);

        // 일단 스크랩 리스트
		List<ScrapModel> scrapList = scrapService.scrapList(paramMap);
		logger.info("scrapList: " + scrapList);
		int scrapCnt = scrapService.scrapListCnt(paramMap);     
		
		model.addAttribute("scrapList", scrapList); // 아예 전체
		model.addAttribute("scrapCnt", scrapCnt);
			
		return "job/scrap-listValue";
	}
	
	
	
	//스크랩 추가
	@RequestMapping("saveScrap.do")
	@ResponseBody
	public Map<String, String> saveScrap(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveScrap: " + paramMap);
		
		ScrapModel existScrap = scrapService.selectScrapExist(paramMap);

		if(existScrap != null){
			logger.info("이미 존재하는 스크랩 정보입니다.");
			resultMap.put("result", "fail");
	        resultMap.put("message", "이미 존재하는 스크랩입니다.");
	        return resultMap; // 실패 응답 반환
		}
		int result = scrapService.saveScrap(paramMap);
		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		
		return resultMap;
	}
	
	@RequestMapping("deleteScrap.do")
	@ResponseBody
	public Map<String, String> deleteScrap(@RequestParam Map<String, Object> paramMap, HttpServletRequest req,
			HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int result = scrapService.deleteScrap(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	//공고가 삭제될 때 먼저 스크랩 데이터에서 
	//해당 공고 아이디를 가진 스크랩 데이터의 공고 아이디를
	// 0으로 전환
	//스크랩 추가
	@RequestMapping("updateScrap.do")
	@ResponseBody
	public Map<String, String> updateScrap(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, String> resultMap = new HashMap<>();
			logger.info("updateScrap: " + paramMap);

		int result = scrapService.updateScrap(paramMap);
			if (result > 0) {
				resultMap.put("result", "success");
			} else {
				resultMap.put("result", "fail");
			}
			
		return resultMap;
	}	
}
