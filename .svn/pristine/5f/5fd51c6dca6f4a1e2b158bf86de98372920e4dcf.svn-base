package kr.happyjob.study.jobs.controller.to_be;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.company.model.CompanyModel;
import kr.happyjob.study.company.service.CompanyService;
import kr.happyjob.study.jobs.service.JobsService;
import kr.happyjob.study.managepost.model.ManagepostModel;
import kr.happyjob.study.managepost.service.ManagepostService;

@RestController
@RequestMapping("api/jobs/")
public class JobsRestController {
	
	@Autowired
	private ManagepostService managepostService;
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private JobsService jobsService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());

    /**
     * 공고 리스트 가져오기
     *
     * @param paramMap 요청 파라미터
     *                 - currentPage: 현재 페이지 번호
     *                 - pageSize: 한 페이지에 표시할 공고 수
     * @param session  현재 사용자 세션
     * @return ResponseEntity
     *         - 성공: 승인된 공고 리스트와 총 공고 개수
     *         - 실패: 에러 메시지와 상태 코드
     */
	
    @PostMapping("/readPostList.do")
    public ResponseEntity<Map<String, Object>> getPostList(@RequestBody Map<String, Object> paramMap, HttpSession session) {
        Map<String, Object> resultMap = new HashMap<>();

        try {
            // 현재 페이지와 페이지 크기 처리
            int currentPage = Integer.parseInt(paramMap.getOrDefault("currentPage", "1").toString());
            int pageSize = Integer.parseInt(paramMap.getOrDefault("pageSize", "5").toString());
            int startSeq = (currentPage - 1) * pageSize;

            paramMap.put("startSeq", startSeq);
            paramMap.put("pageSize", pageSize);

            // DB에서 데이터 조회
            List<ManagepostModel> approvalList = managepostService.getApprovalList(paramMap);
            int approvalPostCnt = managepostService.approvalPostListCnt(paramMap);

            // 응답 데이터 구성
            resultMap.put("message", "success");
            resultMap.put("approvalList", approvalList);
            resultMap.put("approvalPostCnt", approvalPostCnt);
            resultMap.put("currentPage", currentPage);
            resultMap.put("pageSize", pageSize);

            return new ResponseEntity<>(resultMap, HttpStatus.OK);
        } catch (Exception e) {
            // 에러 응답
        	resultMap.put("message", "error");
        	resultMap.put("error", e.getMessage());
            
            return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    /**
     * 공고 상세 정보 가져오기 
     *
     * @param paramMap 요청 파라미터
     *                 - postIdx: 공고 ID
     *                 - bizIdx: 기업 ID
     * @param session  현재 사용자 세션
     * @return ResponseEntity
     *         - 성공: 공고 상세 정보 및 기업 정보
     *         - 실패: 에러 메시지와 상태 코드
     */
    @PostMapping("/readPostDetailBody.do")
    public ResponseEntity<Map<String, Object>> getPostDetail(@RequestBody Map<String, Object> paramMap, HttpSession session) {
    	Map<String, Object> resultMap = new HashMap<>();
    	
    	try {
    		// 요청 파라미터 검증
            if (!paramMap.containsKey("postIdx")) {
            	resultMap.put("message", "Invalid parameters");
                return new ResponseEntity<>(resultMap, HttpStatus.BAD_REQUEST);
            }
            
//            // 임의값으로 bizIdx 설정
//            if (!paramMap.containsKey("bizIdx")) {
//                paramMap.put("bizIdx", "temp"); // 기본값 설정
//            }

            // 세션에서 로그인 ID 가져오기
            String loginId = (String) session.getAttribute("loginId");
            resultMap.put("loginId", loginId);

            // DB에서 공고 상세 정보 조회
            ManagepostModel postDetail = managepostService.managePostDetailSearchByPostIdx(paramMap);
            if (postDetail == null) {
            	resultMap.put("message", "Post not found");
                return new ResponseEntity<>(resultMap, HttpStatus.NOT_FOUND);
            }

            // postDetail에서 bizIdx 추출 (string으로 변환)
            String bizIdx = postDetail.getBizIdx()+"";
            logger.info("bizIdx : " + bizIdx);
            paramMap.put("bizIdx", bizIdx);
            
            // DB에서 기업 정보 조회
            CompanyModel bizDetail = companyService.companyDetail(paramMap); // 가정된 서비스 메서드
            if (bizDetail == null) {
            	resultMap.put("message", "Company not found");
                return new ResponseEntity<>(resultMap, HttpStatus.NOT_FOUND);
            }

            // loginId에 해당하는 userIdx 가져오기
            int userIdx = (int) session.getAttribute("userIdx");
            paramMap.put("userIdx", userIdx);
            
            // postIdx와 userIdx에 해당하는 scrapIdx가 있는지 확인
            boolean isScraped = jobsService.isScraped(paramMap);
            		
            // postIdx와 userIdx에 해당하는 applyIdx가 있는지 확인
            boolean isApplyed = jobsService.isApplyed(paramMap); 
            
        	Map<String, Object> isClicked = new HashMap<>();

        	isClicked.put("isScraped", isScraped);
        	isClicked.put("isApplyed", isApplyed);
            // 응답 데이터 구성
            resultMap.put("message", "success");
            resultMap.put("postDetail", postDetail);
            resultMap.put("bizDetail", bizDetail);
        	resultMap.put("isClicked", isClicked);
            
            return new ResponseEntity<>(resultMap, HttpStatus.OK);
        } catch (Exception e) {
            // 에러 응답
        	resultMap.put("message", "error");
            resultMap.put("error", e.getMessage());
            return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
    	}
    }

}
