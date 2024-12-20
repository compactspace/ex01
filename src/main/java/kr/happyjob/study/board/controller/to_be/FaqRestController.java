package kr.happyjob.study.board.controller.to_be;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.board.model.FaqModel;
import kr.happyjob.study.board.service.FaqService;

@RestController
@RequestMapping("/api/board/")
public class FaqRestController {
	
	@Autowired
	private FaqService faqService;
	
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("faqListBody.do")
	public Map<String, Object> getFaqeListBody(@RequestBody Map<String, Object> paramMap) throws Exception {

		Map<String, Object> resultMap = new HashMap<>();
		
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
				
		resultMap.put("faq", faqList);
		resultMap.put("faqCnt", faqCnt);
		
		return resultMap;
	}
	
	@RequestMapping("faqListJson.do")
	public Map<String, Object> getFaqeListJson(@RequestParam Map<String, Object> paramMap) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();

		int currentPage = Integer.valueOf((String) paramMap.get("currentPage"));
		int pageSize = Integer.valueOf((String) paramMap.get("pageSize"));
		int startSeq = (currentPage - 1) * pageSize;
		
		String faq_type = (String) paramMap.get("faq_type");

		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		paramMap.put("faq_type", faq_type);

		List<FaqModel> faqList = faqService.faqList(paramMap);
		int faqCnt = faqService.faqListCnt(paramMap);
				
		resultMap.put("faq", faqList);
		resultMap.put("faqCnt", faqCnt);
		
		return resultMap;
	}
	
	@RequestMapping("faqDetailBody.do")
	public Map<String, Object> faqDetailBody(@RequestBody Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		logger.info("faqDetail: " + paramMap);

		FaqModel detailValue = faqService.faqDetail(paramMap);
		resultMap.put("detail", detailValue);

		return resultMap;
	}
	
	@RequestMapping("faqSavePart.do")
	public Map<String, String> saveFaqPart(@RequestPart Map<String, Object> text)
			throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveFaq: " + text);

		int result = faqService.saveFaq(text);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}
		return resultMap;
	}
	
	@RequestMapping("faqUpdatePart.do")
	public Map<String, String> updateFaqPart(@RequestPart Map<String, Object> text) throws Exception {
		
		Map<String, String> resultMap = new HashMap<>();
		int result = faqService.updateFaq(text);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}
	
	@RequestMapping("faqDeleteBody.do")
	public Map<String, String> deteleFaqBody(@RequestBody Map<String, Object> paramMap) throws Exception {
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

}
