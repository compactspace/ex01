package kr.happyjob.study.managehire.controller.to_be;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import kr.happyjob.study.common.comnUtils.ApiResponseUtil;
import kr.happyjob.study.managehire.model.NewPostModel;
import kr.happyjob.study.managehire.service.ManagehireService;
import kr.happyjob.study.managepost.model.ManagepostModel;

@RestController
@RequestMapping("/api/manage-hire/")
public class ManageHireRestController {

	@Autowired
	private ManagehireService manageHireService;

   private final Logger logger = LogManager.getLogger(this.getClass());

	/**
	 * 기업이 등록한 공고 리스트 가져오기
	 *
	 *@param loginId
	 *			     유저 ID (고유 식별자)
	 * @return 공고 리스트 (List 형태로 반환)
	 */
	@PostMapping("post-list")
	public ResponseEntity<Map<String, Object>> getHirePostListByLoginId(@RequestBody Map<String, Object> paramMap)
			throws Exception {
		System.out.println(paramMap);
		List<ManagepostModel> resultList = manageHireService.getHirePostListByLoginId(paramMap);
		return ApiResponseUtil.createResponse("success", resultList, HttpStatus.OK);
	}

	/**
	 * 공고 상세보기
	 * 
	 * @param bizIdx
	 *            기업 ID (고유 식별자)
	 * @param postIdx
	 *            공고 ID (고유 식별자)
	 * @return 공고상제정보 {@link ManagepostModel} 형태로 반환
	 */
	@PostMapping("post-detail")
	public ResponseEntity<Map<String, Object>> getHirePostDetailBySeq(@RequestBody Map<String, Object> paramMap)
			throws Exception {
		ManagepostModel postDetail = manageHireService.managehireDetail(paramMap);
		return ApiResponseUtil.createResponse("success", postDetail, HttpStatus.OK);
	}

	/**
	 * 새로운 채용공고를 등록.
	 *
	 * @param postModel
	 *            공고의 세부 정보가 포함된 JSON 데이터 ( {@link ManagepostModel} 객체로 매핑됨)
	 * @param files
	 *            공고와 함께 업로드된 파일 (Multipart 형식의 파일)
	 * @return 공고 등록 성공/실패 여부를 포함한 {@link ResponseEntity} 객체
	 */
	@PostMapping("post-new")
	public ResponseEntity<Map<String, Object>> createHirePost(
			@RequestPart(value = "postContent", required = true) Map<String, Object> text,
			@RequestPart(value = "attachFile", required = false) MultipartFile[] files) throws Exception {

		logger.info("text.get(\"BizIdx\"): " + text.get("bizIdx"));
		logger.info("text.get(\"loginId\"): " + text.get("loginId"));

	    int bizIdx = manageHireService.getBizIdxByLoginId(text.get("loginId").toString());

	    text.put("bizIdx", bizIdx);	    
	    
	    logger.info("bizIdx : " + bizIdx);
		
		int postIdx = manageHireService.createHirePost(text, files);
		// TODO Implement the method in the service layer
	    if (postIdx > 0) {
	        Map<String, Object> response = new HashMap<>();
	        response.put("result", "success");
	        response.put("message", "공고가 성공적으로 등록되었습니다.");
	        response.put("postIdx", postIdx); // postIdx 추가
	        return new ResponseEntity<>(response, HttpStatus.OK);
	    } else {
	        Map<String, Object> response = new HashMap<>();
	        response.put("result", "fail");
	        response.put("message", "공고 등록에 실패했습니다.");
	        return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}

	/**
	 * 채용공고 수정 처리
	 * 
	 * @param postModel
	 *            공고의 세부 정보가 포함된 JSON 데이터 ( {@link ManagepostModel} 객체로 매핑됨)
	 * @param files
	 *            공고와 함께 업로드된 파일 (Multipart 형식의 파일)
	 * @return 공고 등록 성공/실패 여부를 포함한 {@link ResponseEntity} 객체
	 */
	@PostMapping("post-update")
	public ResponseEntity<Map<String, Object>> updateHirePost(
			@RequestPart(value = "postContent", required = true) Map<String, Object> text,
			@RequestPart(value = "attachFile", required = false) MultipartFile[] files) throws Exception {

		int updateResult = manageHireService.updateHirePost(text, files);

		// TODO Implement the method in the service layer
		if (updateResult > 0) {
			return ApiResponseUtil.createResponse("success", "공고가 성공적으로 수정되었습니다.", HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", "공고 수정에 실패했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	/**
	 * 채용공고 삭제 처리
	 * 
	 * @param postIdx
	 *            삭제할 공고의 고유 식별자
	 * @return 공고 삭제 성공/실패 여부를 포함한 {@link ResponseEntity} 객체
	 */
	
	@PostMapping("deleteHirePost/{postIdx}")
	public ResponseEntity<Map<String, Object>> deleteHirePost(@PathVariable("postIdx") Long postIdx,
			@RequestBody Map<String,Object> paramMap) throws Exception  {
		
		
		paramMap.put("postIdx", postIdx);
		
		int deleteResult = manageHireService.managehireDelete(paramMap);
		
	    if (deleteResult > 0) {
	        return ApiResponseUtil.createResponse("success", "공고가 성공적으로 삭제되었습니다.", HttpStatus.OK);
	    } else {
	        return ApiResponseUtil.createResponse("fail", "공고 삭제에 실패했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	@PostMapping("deleteAttachment/{postIdx}")
	public ResponseEntity<Map<String, Object>> deleteAttachment(@PathVariable("postIdx") Long postIdx,
			@RequestBody Map<String, Object> paramMap,
			HttpSession session) throws Exception  {
		
		paramMap.put("postIdx", postIdx);
		
        String loginId = (String) session.getAttribute("loginId");

	    int bizIdx = manageHireService.getBizIdxByLoginId(loginId);

	    paramMap.put("bizIdx", bizIdx);	    
		
		int deleteResult = manageHireService.delelteAttachment(paramMap);
		
	    if (deleteResult > 0) {
	        return ApiResponseUtil.createResponse("success", "공고가 성공적으로 삭제되었습니다.", HttpStatus.OK);
	    } else {
	        return ApiResponseUtil.createResponse("fail", "공고 삭제에 실패했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	/**
	 * 채용공고 마감 처리
	 * 
	 * @param postIdx
	 *            공고 ID (고유 식별자)
	 * @return 공고 등록 성공/실패 여부를 포함한 {@link ResponseEntity} 객체
	 */
	@PostMapping("post-close")
	public ResponseEntity<Map<String, Object>> closeHirePost(@RequestBody Map<String, Object> paramMap)
			throws Exception {
		int closeResult = 0;
		// TODO Implement the method in the service layer
		if (closeResult > 0) {
			return ApiResponseUtil.createResponse("success", "공고가 성공적으로 마감되었습니다.", HttpStatus.OK);
		} else {
			return ApiResponseUtil.createResponse("fail", "공고 마감에 실패했습니다.", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
