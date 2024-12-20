package kr.happyjob.study.board.controller.as_is;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.board.model.FaqModel;
import kr.happyjob.study.board.service.FaqService;

@Controller
@RequestMapping("/board/")
public class FaqController {

	@Autowired
	private FaqService faqService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@RequestMapping("faq.do")
	public String init() throws Exception {
		return "faq/faq";
	}
	
	@RequestMapping("faqList.do")
	public String getFaqeList(Model model, @RequestParam Map<String, Object> paramMap) throws Exception {
		logger.info("faq_paramMap: " + paramMap);

		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));

		int startSeq = (currentPage - 1) * pageSize;
		
		String faq_type = (String) paramMap.get("faq_type");
		logger.info("faq_type: " + faq_type);

		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		paramMap.put("faq_type", faq_type);

		List<FaqModel> faqList = faqService.faqList(paramMap);
		int faqCnt = faqService.faqListCnt(paramMap);
				
		model.addAttribute("faq", faqList);
		model.addAttribute("faqCnt", faqCnt);
		
		return "faq/faqList";
	}
	
	@RequestMapping("faqSave.do")
	@ResponseBody
	public Map<String, String> saveFaq(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveFaq: " + paramMap);

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int result = faqService.saveFaq(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	@RequestMapping("faqUpdate.do")
	@ResponseBody
	public Map<String, String> updateFaq(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("updateFaq: " + paramMap);
		logger.info("faqSeq: " + paramMap.get("faqSeq"));

		int result = faqService.updateFaq(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("faqDelete.do")
	@ResponseBody
	public Map<String, String> deteleFaq(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveFaq: " + paramMap);

		int result = faqService.deleteFaq(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

	@RequestMapping("faqDetail.do")
	@ResponseBody
	public Map<String, Object> faqDetail(@RequestParam Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		logger.info("faqDetail: " + paramMap);

		FaqModel detailValue = faqService.faqDetail(paramMap);
		resultMap.put("detail", detailValue);

		return resultMap;
	}
	
}