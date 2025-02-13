package kr.happyjob.study.board.controller.to_be;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.board.model.FaqModel;
import kr.happyjob.study.board.model.NoticeModel;
import kr.happyjob.study.board.model.QnaModel;
import kr.happyjob.study.board.service.QnaService;

@RestController
@RequestMapping("/api/board/")
public class QnaRestController {
	
	@Autowired
	private QnaService qnaService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@RequestMapping("qnaListBody.do") 
	public Map<String, Object> getQnaListBody(@RequestBody Map<String, Object> paramMap, HttpSession session) throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		
		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);

		int currentPage = Integer.valueOf( paramMap.get("currentPage").toString());
		int pageSize = Integer.valueOf( paramMap.get("pageSize").toString());
		int startSeq = (currentPage - 1) * pageSize;
		
		String qna_type = (String) paramMap.get("qna_type");
		String requestType = (String) paramMap.get("requestType");
		
		paramMap.put("startSeq", startSeq);
		paramMap.put("pageSize", pageSize);
		paramMap.put("qna_type", qna_type);

		List<QnaModel> qnaList;
		if ("my".equals(requestType)) {
			qnaList = qnaService.qnaMyList(paramMap); 
		} else {
			qnaList = qnaService.qnaList(paramMap); 
		}
		int qnaCnt = qnaService.qnaListCnt(paramMap);

		resultMap.put("qna", qnaList);
		resultMap.put("qnaCnt", qnaCnt);
		
		return resultMap;
	}
	
	@RequestMapping("qnaDetailFileBody.do")
	public Map<String, Object> qnaDetailFileBody(@RequestBody Map<String, Object> paramMap)
			throws Exception {
		Map<String, Object> resultMap = new HashMap<>();
		logger.info("qnaDetail: " + paramMap);

		QnaModel detailValue = qnaService.qnaDetailFile(paramMap);
//		String userType = (String) session.getAttribute("userType");		logger.info("유저타입 =====>  " + userType);
//		
//		// 관리자인 경우 비밀번호 확인 없이 바로 성공 처리
//		if ("M".equals(userType)) {
//	        resultMap.put("result", "success");
//	        resultMap.put("detail", detailValue);
//	    } else {
//	    	// 그 외 사용자의 경우 비밀번호 확인
//	    	if(detailValue != null && detailValue.getPassword().equals(paramMap.get("password"))){
//				resultMap.put("result", "success");
//				resultMap.put("detail", detailValue);
//				logger.info("detailValue========="+detailValue);
//				} else {
//				resultMap.put("result", "fail");
//			}
//	    }
		
		resultMap.put("result", "success");
		resultMap.put("detail", detailValue);
		return resultMap;
	}
	
	@RequestMapping("qnaSaveFileForm.do")
	public Map<String, String> qnaSaveFileForm(@RequestPart(value="file", required=false) MultipartFile[] files,
			@RequestPart(value="text", required=false) Map<String, Object> text) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		int result = qnaService.qnaSaveFileForm(files, text);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}
	
	@RequestMapping("qnaUpdateFileForm.do")
	public Map<String, String> qnaUpdateFileForm(
			@RequestPart(value = "file", required = false) MultipartFile[] files,
			@RequestPart(value = "text", required = false) Map<String, Object> text) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("file: " + files);
		logger.info("text: " + text);

		int result = qnaService.qnaUpdateFileForm(files, text);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}
	
	@RequestMapping("qnaDeleteBody.do")
	public Map<String, String> qnaDeleteBody(@RequestBody Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		int result = qnaService.deleteFileQna(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}
	
	
	
	
	
	
	

}
