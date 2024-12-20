package kr.happyjob.study.apply.controller.as_is;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.apply.model.HistoryModel;
import kr.happyjob.study.apply.service.HistoryService;
import kr.happyjob.study.common.comnUtils.ApiResponseUtil;

/**
 * 지원 이력 관리 기능을 담당하는 컨트롤러 사용자의 지원 내역 조회, 필터링, 취소 기능을 제공
 */
@Controller
@RequestMapping("/apply/")
public class HistoryController {

	@Autowired
	private HistoryService historyService;

	private final Logger logger = LogManager.getLogger(this.getClass());

	private final String className = this.getClass().toString();

	/**
	 * 지원 내역 기본 페이지로 이동
	 * 
	 * @param model
	 *            - 조회 결과를 전달할 Model 객체
	 * @param session
	 *            - 사용자 세션에서 로그인 정보 가져오기
	 * @return 지원 이력 페이지 뷰 이름
	 */
	@GetMapping("history.do")
	public String getApplyHistory(Model model, HttpSession session) throws Exception {
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		paramMap.put("userNm", (String) session.getAttribute("userNm"));
		paramMap.put("userType", (String) session.getAttribute("userType"));
		List<HistoryModel> resultList = historyService.getApplyHistoryList(paramMap);
		model.addAttribute("result", resultList);

		return "/apply/historyMain";
	}

	/**
	 * 필터 조건에 따라 지원 내역을 조회
	 * 
	 * @param paramMap
	 *            - 필터 조건을 담은 파라미터 맵
	 * @return 지원 이력 페이지 뷰 이름
	 */
	@GetMapping("searchHistory.do")
	public String getApplyHistoryListByFilter(@RequestParam Map<String, String> paramMap, Model model,
			HttpSession session) throws Exception {
		paramMap.put("loginId", (String) session.getAttribute("loginId"));
		paramMap.put("userNm", (String) session.getAttribute("userNm"));
		paramMap.put("userType", (String) session.getAttribute("userType"));

		List<HistoryModel> resultList = historyService.getApplyHistoryListByFilter(paramMap);
		model.addAttribute("result", resultList);

		return "/apply/historyMain";
	}

	/**
	 * 지원 취소 요청을 처리
	 * 
	 * @param paramMap
	 *            - 지원 ID를 포함한 파라미터 맵
	 * @return 지원 취소 결과를 포함한 응답 엔티티
	 */
	@PostMapping("cancleApply.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> cancleApply(@RequestParam Map<String, Object> paramMap)
			throws Exception {
		int result = historyService.cancleApply(paramMap);
		if (result > 0) {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("success", null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
