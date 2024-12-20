package kr.happyjob.study.managepost.controller.to_be;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.happyjob.study.managepost.model.ManagepostModel;
import kr.happyjob.study.managepost.service.ManagepostService;

@RestController
@RequestMapping("/api/manage-post")
public class ManagepostRestController {

	@Autowired
	private ManagepostService managepostService;
	
	private final Logger logger = LogManager.getLogger(this.getClass());
	
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
			List<ManagepostModel> pendingList = managepostService.getPendingList(paramMap);
			int pendingPostCnt = managepostService.pendingPostListCnt(paramMap);
			
            List<ManagepostModel> approvalList = managepostService.getApprovalList(paramMap);
            int approvalPostCnt = managepostService.approvalPostListCnt(paramMap);

            // 응답 데이터 구성
            resultMap.put("message", "success");
            
            resultMap.put("pendingList", pendingList);
            resultMap.put("pendingPostCnt", pendingPostCnt);
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
    
	@PostMapping("statusUpdate.do")
	public ResponseEntity<Map<String, String>> updateAppState(@RequestBody Map<String, Object> paramMap) throws Exception {
		Map<String, String> resultMap = new HashMap<>();
		logger.info("updateStatus: " + paramMap);

        try {

		int result = managepostService.updateAppStatus(paramMap);

		if (result > 0) {
			resultMap.put("result", "success");
		} else {
			resultMap.put("result", "fail");
		}

			return new ResponseEntity<>(resultMap, HttpStatus.OK);
        } catch (Exception e) {
            // 에러 응답
        	resultMap.put("message", "error");
        	resultMap.put("error", e.getMessage());
        	
            return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
        }
	}
	
}
