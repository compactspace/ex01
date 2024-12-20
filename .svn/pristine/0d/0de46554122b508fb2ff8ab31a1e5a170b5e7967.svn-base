package kr.happyjob.study.jobs.controller.to_be;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.jobs.model.ScrapModel;
import kr.happyjob.study.jobs.service.JobsService;
import kr.happyjob.study.jobs.service.ScrapService;

@RestController
@RequestMapping("api/jobs/")
public class ScrapRestController {
	
	@Autowired
	private ScrapService scrapService;
	
	@Autowired
	private JobsService jobsService;
		
	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	// Get class name for logger
	private final String className = this.getClass().toString();
	
    /**
     * 스크랩 리스트 가져오기 
     *
     * @param paramMap 요청 파라미터
     *                 - currentPage: 현재 페이지 번호
     *                 - pageSize: 한 페이지에 표시할 공고 수
     * @param session  현재 사용자 세션
     * @return ResponseEntity
     *         - 성공: 스크랩 리스트
     *         - 실패: 에러 메시지와 상태 코드
     */
	@PostMapping("readScrapList.do")
	public ResponseEntity<Map<String, Object>> getScrapList(@RequestBody Map<String, Object> paramMap, HttpSession session) throws Exception {
		logger.info("readScrabList paramMap: " + paramMap);

		Map<String, Object> resultMap = new HashMap<>();

		   try {
		        // 현재 페이지와 페이지 크기 처리
		        int currentPage = Integer.parseInt(paramMap.getOrDefault("currentPage", "1").toString());
		        int pageSize = Integer.parseInt(paramMap.getOrDefault("pageSize", "5").toString());
		        int startSeq = (currentPage - 1) * pageSize;

		        paramMap.put("startSeq", startSeq);
		        paramMap.put("pageSize", pageSize);

		        // 세션에서 로그인 ID 가져오기
		        String loginId = (String) session.getAttribute("loginId");
		        paramMap.put("loginId", loginId);
		        resultMap.put("loginId", loginId);
		        logger.info("loginId: " + loginId);

	            // loginId에 해당하는 userIdx 가져오기
	            int userIdx = (int) session.getAttribute("userIdx");
	            paramMap.put("userIdx", userIdx);	
	            
	            // postIdx와 userIdx에 해당하는 applyIdx가 있는지 확인
	            
	            // 스크랩 리스트 및 개수 조회
		        if (startSeq < 0 || pageSize <= 0) {
		            throw new IllegalArgumentException("Invalid pagination parameters");
		        }
		        
		        List<ScrapModel> scrapList = scrapService.scrapList(paramMap);
		        
		        for (int i = 0; i < scrapList.size(); i++){
		        	int postIdx = scrapList.get(i).getPostIdx();
		        	paramMap.put("postIdx",postIdx);
		            boolean isApplyed = jobsService.isApplyed(paramMap); 

		        	scrapList.get(i).setIsApplyed(isApplyed);
		        }
		        int scrapCnt = scrapService.scrapListCnt(paramMap);
	        	
		        // 응답 데이터 구성
		        resultMap.put("message", "success");
		        resultMap.put("scrapList", scrapList);
		        resultMap.put("scrapCnt", scrapCnt);
		        resultMap.put("currentPage", currentPage);
		        resultMap.put("pageSize", pageSize);
		        
		        return new ResponseEntity<>(resultMap, HttpStatus.OK);

		    } catch (Exception e) {
		        // 예외 처리 및 에러 응답
		        logger.error("Error in getScrapList: ", e);
		        resultMap.put("message", "error");
		        resultMap.put("error", e.getMessage());
		        return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
		    }
	}
	
    /**
     * 스크랩 추가하기
     *
     * @param paramMap 요청 파라미터
     *                 - postIdx: 현재 공고 번호
     * @param session  현재 사용자 세션
     * @return ResponseEntity
     *         - 성공: 성공 메세지
     *         - 실패: 에러 메시지와 상태 코드
     */	
	@PostMapping("saveScrap.do")
	public Map<String, String> saveScrap(@RequestBody Map<String, Object> paramMap, HttpSession session)
			throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("saveScrap: " + paramMap);

		// 기존 코드가  loginId를 idx로 써서 기존 코드 안바꾸려고 idx로 함 loginId임
        String loginId = (String) session.getAttribute("loginId");
        int userIdx = (int) session.getAttribute("userIdx");
        
        paramMap.put("loginIdx", loginId);
        logger.info("loginId: " + loginId);

        paramMap.put("userIdx", userIdx);
        logger.info("paramMap: " + paramMap);
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

    /**
     * 스크랩 삭제하기
     *
     * @param paramMap 요청 파라미터
     *                 - scrapIdx: 스크랩 번호
     * @param session  현재 사용자 세션
     * @return ResponseEntity
     *         - 성공: 성공 메세지
     *         - 실패: 에러 메시지와 상태 코드
     */	
	@PostMapping("deleteScrap.do")
	public Map<String, String> deleteScrap(@RequestBody Map<String, Object> paramMap, HttpServletRequest req,
			HttpSession session) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		String loginId = (String) session.getAttribute("loginId");
		paramMap.put("loginId", loginId);
		
		logger.info(paramMap);
		
		@SuppressWarnings("unchecked")
		List<Integer> scrapIdxList = (List<Integer>) paramMap.get("scrapIdxList");
		
		int result = scrapService.deleteScrapList(scrapIdxList);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

		return resultMap;
	}

//	//공고가 삭제될 때 먼저 스크랩 데이터에서 
//	//해당 공고 아이디를 가진 스크랩 데이터의 공고 아이디를
//	// 0으로 전환
//	//스크랩 추가
//	@RequestMapping("updateScrap.do")
//	@ResponseBody
//	public Map<String, String> updateScrap(@RequestParam Map<String, Object> paramMap, HttpSession session)
//			throws Exception {
//		Map<String, String> resultMap = new HashMap<>();
//			logger.info("updateScrap: " + paramMap);
//
//		int result = scrapService.updateScrap(paramMap);
//			if (result > 0) {
//				resultMap.put("result", "success");
//			} else {
//				resultMap.put("result", "fail");
//			}
//			
//		return resultMap;
//	}	
}
